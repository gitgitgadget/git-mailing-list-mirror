From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Sun, 24 Feb 2008 20:08:47 -0800
Message-ID: <7vwsotoey8.fsf@gitster.siamese.dyndns.org>
References: <200802202203.m1KM37aR012221@mi1.bluebottle.com>
 <alpine.LSU.1.00.0802202221130.17164@racer.site>
 <7v4pc316gq.fsf@gitster.siamese.dyndns.org>
 <76718490802201726t677b1498ma3bdb3dbf25dd781@mail.gmail.com>
 <alpine.LFD.1.00.0802201735030.7833@woody.linux-foundation.org>
 <alpine.LNX.1.00.0802202351400.19024@iabervon.org>
 <7vk5kyyirk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 05:10:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTUfH-0007WT-Sl
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 05:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbYBYEJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 23:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbYBYEJH
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 23:09:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbYBYEJF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 23:09:05 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C8AC1F28;
	Sun, 24 Feb 2008 23:09:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BA60E1F1D; Sun, 24 Feb 2008 23:08:51 -0500 (EST)
In-Reply-To: <7vk5kyyirk.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 20 Feb 2008 21:34:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74990>

Junio C Hamano <gitster@pobox.com> writes:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>
>> [url "rewritten"]
>> 	insteadOf = "original"
>
> That's much clearer than anything I've seen in this thread which
> one is the one you cannot use yourself and which one is what you
> have to use to get it to work.

Although I am willing to step in when they need help, I usually
try not to finish up other people's patches, especially when I
know they are capable.

But I wanted to take 'next' into a shape as close to the -rc1 as
possible early, so here is my stab at it.  This will be in 'next'
tonight.

The patch is relative to your:

    Date: Wed, 20 Feb 2008 13:43:53 -0500 (EST)
    Subject: [PATCH 2/2] Add support for url aliases in config files
    Message-ID: <alpine.LNX.1.00.0802201337060.19024@iabervon.org>

aka

    http://article.gmane.org/gmane.comp.version-control.git/74535

based on the earlier discussions.

 * The first hunk to Documentation/config.txt which was a
   leftover from the previous round is dropped.

 * Fixed s/host/url/ in Documentation/config.txt, which was also
   a leftover from the previous round.

 * The result is undefined if you have this:

	[url "foo"]
        	insteadOf = "baz"
	[url "bar"]
        	insteadOf = "baz"

   I tried to clarify the handling of this misconfiguration by
   rewording, but I do not know how successful I was.

 * s/aka/insteadOf/ everywhere.

---

 Documentation/config.txt |   10 +++-------
 Documentation/urls.txt   |   14 +++++++-------
 remote.c                 |   24 ++++++++++++------------
 t/t5516-fetch-push.sh    |    8 ++++----
 4 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 44f4c4b..2981389 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -646,11 +646,6 @@ help.format::
 	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
 	the default. 'web' and 'html' are the same.
 
-host.<name>.rewritebase::
-	Additional base URLs which refer to this host. If a URL
-	matches this, any access to it will use the URL formed with
-	the corresponding base URL instead of the given URL.
-
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy'
 	environment variable (see linkgit:curl[1]).  This can be overridden
@@ -891,7 +886,7 @@ tar.umask::
 	archiving user's umask will be used instead.  See umask(2) and
 	linkgit:git-archive[1].
 
-url.<base>.aka::
+url.<base>.insteadOf::
 	Any URL that starts with this value will be rewritten to
 	start, instead, with <base>. In cases where some site serves a
 	large number of repositories, and serves them with multiple
@@ -900,7 +895,8 @@ url.<base>.aka::
 	equivalent URLs and have git automatically rewrite the URL to
 	the best alternative for the particular user, even for a
 	never-before-seen repository on the site. The effect of
-	having multiple aka values match is undefined.
+	having multiple `insteadOf` values from different
+	`<base>` match to an URL is undefined.
 
 user.email::
 	Your email address to be recorded in any newly created commits.
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 0115af7..fa34c67 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -53,17 +53,17 @@ configuration section of the form:
 
 ------------
 	[url "<actual url base>"]
-		aka = <other url base>
+		insteadOf = <other url base>
 ------------
 
-If you have a section:
+For example, with this:
 
 ------------
-	[host "git://git.host.xz/"]
-		aka = host.xz:/path/to/
-		aka = work:
+	[url "git://git.host.xz/"]
+		insteadOf = host.xz:/path/to/
+		insteadOf = work:
 ------------
 
 a URL like "work:repo.git" or like "host.xz:/path/to/repo.git" will be
-rewritten in any context that takes a URL to be
-"git://git.host.xz/repo.git".
+rewritten in any context that takes a URL to be "git://git.host.xz/repo.git".
+
diff --git a/remote.c b/remote.c
index f8ee38e..0012954 100644
--- a/remote.c
+++ b/remote.c
@@ -4,9 +4,9 @@
 
 struct rewrite {
 	const char *base;
-	const char **aka;
-	int aka_nr;
-	int aka_alloc;
+	const char **instead_of;
+	int instead_of_nr;
+	int instead_of_alloc;
 };
 
 static struct remote **remotes;
@@ -33,13 +33,13 @@ static const char *alias_url(const char *url)
 	for (i = 0; i < rewrite_nr; i++) {
 		if (!rewrite[i])
 			continue;
-		for (j = 0; j < rewrite[i]->aka_nr; j++) {
-			if (!prefixcmp(url, rewrite[i]->aka[j])) {
+		for (j = 0; j < rewrite[i]->instead_of_nr; j++) {
+			if (!prefixcmp(url, rewrite[i]->instead_of[j])) {
 				char *ret = malloc(strlen(rewrite[i]->base) -
-						   strlen(rewrite[i]->aka[j]) +
+						   strlen(rewrite[i]->instead_of[j]) +
 						   strlen(url) + 1);
 				strcpy(ret, rewrite[i]->base);
-				strcat(ret, url + strlen(rewrite[i]->aka[j]));
+				strcat(ret, url + strlen(rewrite[i]->instead_of[j]));
 				return ret;
 			}
 		}
@@ -154,10 +154,10 @@ static struct rewrite *make_rewrite(const char *base, int len)
 	return ret;
 }
 
-static void add_aka(struct rewrite *rewrite, const char *aka)
+static void add_instead_of(struct rewrite *rewrite, const char *instead_of)
 {
-	ALLOC_GROW(rewrite->aka, rewrite->aka_nr + 1, rewrite->aka_alloc);
-	rewrite->aka[rewrite->aka_nr++] = aka;
+	ALLOC_GROW(rewrite->instead_of, rewrite->instead_of_nr + 1, rewrite->instead_of_alloc);
+	rewrite->instead_of[rewrite->instead_of_nr++] = instead_of;
 }
 
 static void read_remotes_file(struct remote *remote)
@@ -282,10 +282,10 @@ static int handle_config(const char *key, const char *value)
 		if (!subkey)
 			return 0;
 		rewrite = make_rewrite(name, subkey - name);
-		if (!strcmp(subkey, ".aka")) {
+		if (!strcmp(subkey, ".insteadof")) {
 			if (!value)
 				return config_error_nonbool(key);
-			add_aka(rewrite, xstrdup(value));
+			add_instead_of(rewrite, xstrdup(value));
 		}
 	}
 	if (prefixcmp(key,  "remote."))
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4ffe2a1..9023ba0 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -100,12 +100,12 @@ test_expect_success 'fetch with wildcard' '
 	)
 '
 
-test_expect_success 'fetch with aka' '
+test_expect_success 'fetch with insteadOf' '
 	mk_empty &&
 	(
 		TRASH=$(pwd) &&
 		cd testrepo &&
-		git config url./$TRASH/.aka trash/
+		git config url./$TRASH/.insteadOf trash/
 		git config remote.up.url trash/. &&
 		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
@@ -143,10 +143,10 @@ test_expect_success 'push with wildcard' '
 	)
 '
 
-test_expect_success 'push with aka' '
+test_expect_success 'push with insteadOf' '
 	mk_empty &&
 	TRASH=$(pwd) &&
-	git config url./$TRASH/.aka trash/ &&
+	git config url./$TRASH/.insteadOf trash/ &&
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
