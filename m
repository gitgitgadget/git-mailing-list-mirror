From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Sun, 24 Feb 2008 22:22:36 -0800
Message-ID: <7vfxvho8r7.fsf@gitster.siamese.dyndns.org>
References: <200802202203.m1KM37aR012221@mi1.bluebottle.com>
 <alpine.LSU.1.00.0802202221130.17164@racer.site>
 <7v4pc316gq.fsf@gitster.siamese.dyndns.org>
 <76718490802201726t677b1498ma3bdb3dbf25dd781@mail.gmail.com>
 <alpine.LFD.1.00.0802201735030.7833@woody.linux-foundation.org>
 <alpine.LNX.1.00.0802202351400.19024@iabervon.org>
 <7vk5kyyirk.fsf@gitster.siamese.dyndns.org>
 <7vwsotoey8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802242319200.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 07:23:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTWkU-0006nz-L7
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 07:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759839AbYBYGXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 01:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759729AbYBYGW7
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 01:22:59 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759591AbYBYGW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 01:22:58 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C6EC02C4D;
	Mon, 25 Feb 2008 01:22:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3B6612C4C; Mon, 25 Feb 2008 01:22:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74993>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Thanks; that's exactly what I would have done (assuming I didn't miss 
> places like last time). Except that it should say that it's still 
> undefined if you use:
>
>         [url "foo"]
>                 insteadOf = "baz"
>         [url "bar"]
>                 insteadOf = "baz/sub"
>
> in that you can't predict whether "baz/sub/a" will be "bar/a" or 
> "foo/sub/a". This is actually what I'm most concerned about, since there 
> is actually a logical expectation (the one that matches more will be used 
> in preference to the less specific one), but that's not implemented. 
> Someday, we'll probably want to implement it, and that'll change the 
> behavior of this particular case.

I'd say that that is a reasonable expectation, and it would be
fair to say that if we have it, the topic will be in 1.5.5 and
otherwise it won't.

This might be a bit over-engineered, but should do the job.

---
 Documentation/config.txt |    5 +--
 remote.c                 |   54 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2981389..57b9b99 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -894,9 +894,8 @@ url.<base>.insteadOf::
 	methods, this feature allows people to specify any of the
 	equivalent URLs and have git automatically rewrite the URL to
 	the best alternative for the particular user, even for a
-	never-before-seen repository on the site. The effect of
-	having multiple `insteadOf` values from different
-	`<base>` match to an URL is undefined.
+	never-before-seen repository on the site.  When more than one
+	insteadOf strings match a given URL, the longest match is used.
 
 user.email::
 	Your email address to be recorded in any newly created commits.
diff --git a/remote.c b/remote.c
index 0012954..1f83696 100644
--- a/remote.c
+++ b/remote.c
@@ -2,9 +2,14 @@
 #include "remote.h"
 #include "refs.h"
 
+struct counted_string {
+	size_t len;
+	const char *s;
+};
 struct rewrite {
 	const char *base;
-	const char **instead_of;
+	size_t baselen;
+	struct counted_string *instead_of;
 	int instead_of_nr;
 	int instead_of_alloc;
 };
@@ -30,21 +35,32 @@ static char buffer[BUF_SIZE];
 static const char *alias_url(const char *url)
 {
 	int i, j;
+	char *ret;
+	struct counted_string *longest;
+	int longest_i;
+
+	longest = NULL;
+	longest_i = -1;
 	for (i = 0; i < rewrite_nr; i++) {
 		if (!rewrite[i])
 			continue;
 		for (j = 0; j < rewrite[i]->instead_of_nr; j++) {
-			if (!prefixcmp(url, rewrite[i]->instead_of[j])) {
-				char *ret = malloc(strlen(rewrite[i]->base) -
-						   strlen(rewrite[i]->instead_of[j]) +
-						   strlen(url) + 1);
-				strcpy(ret, rewrite[i]->base);
-				strcat(ret, url + strlen(rewrite[i]->instead_of[j]));
-				return ret;
+			if (!prefixcmp(url, rewrite[i]->instead_of[j].s) &&
+			    (!longest ||
+			     longest->len < rewrite[i]->instead_of[j].len)) {
+				longest = &(rewrite[i]->instead_of[j]);
+				longest_i = i;
 			}
 		}
 	}
-	return url;
+	if (!longest)
+		return url;
+
+	ret = malloc(rewrite[longest_i]->baselen +
+		     (strlen(url) - longest->len) + 1);
+	strcpy(ret, rewrite[longest_i]->base);
+	strcpy(ret + rewrite[longest_i]->baselen, url + longest->len);
+	return ret;
 }
 
 static void add_push_refspec(struct remote *remote, const char *ref)
@@ -137,27 +153,33 @@ static struct rewrite *make_rewrite(const char *base, int len)
 	int i;
 
 	for (i = 0; i < rewrite_nr; i++) {
-		if (len ? (!strncmp(base, rewrite[i]->base, len) &&
-			   !rewrite[i]->base[len]) :
-		    !strcmp(base, rewrite[i]->base))
+		if (len
+		    ? (len == rewrite[i]->baselen &&
+		       !strncmp(base, rewrite[i]->base, len))
+		    : !strcmp(base, rewrite[i]->base))
 			return rewrite[i];
 	}
 
 	ALLOC_GROW(rewrite, rewrite_nr + 1, rewrite_alloc);
 	ret = xcalloc(1, sizeof(struct rewrite));
 	rewrite[rewrite_nr++] = ret;
-	if (len)
+	if (len) {
 		ret->base = xstrndup(base, len);
-	else
+		ret->baselen = len;
+	}
+	else {
 		ret->base = xstrdup(base);
-
+		ret->baselen = strlen(base);
+	}
 	return ret;
 }
 
 static void add_instead_of(struct rewrite *rewrite, const char *instead_of)
 {
 	ALLOC_GROW(rewrite->instead_of, rewrite->instead_of_nr + 1, rewrite->instead_of_alloc);
-	rewrite->instead_of[rewrite->instead_of_nr++] = instead_of;
+	rewrite->instead_of[rewrite->instead_of_nr].s = instead_of;
+	rewrite->instead_of[rewrite->instead_of_nr].len = strlen(instead_of);
+	rewrite->instead_of_nr++;
 }
 
 static void read_remotes_file(struct remote *remote)
