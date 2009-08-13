From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] port --ignore-unmatch to "git add"
Date: Thu, 13 Aug 2009 12:36:13 -0700
Message-ID: <7vy6pna4lu.fsf@alter.siamese.dyndns.org>
References: <200908121726.52121.luke-jr@utopios.org>
 <1250133624-2272-1-git-send-email-luke-jr+git@utopios.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Dashjr <luke-jr+git@utopios.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:36:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbg66-0004ja-0i
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 21:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbZHMTgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 15:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbZHMTgR
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 15:36:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbZHMTgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 15:36:16 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C75DC28894;
	Thu, 13 Aug 2009 15:36:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 95A5228892; Thu, 13 Aug 2009
 15:36:14 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 921542AE-8840-11DE-BCAB-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125860>

Luke Dashjr <luke-jr+git@utopios.org> writes:

> "git rm" has a --ignore-unmatch option that is also applicable to "git add"
> and may be useful for persons wanting to ignore unmatched arguments, but not
> all errors.
>
> Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>

Chould you refresh my memory a bit?

In what circumstance is "rm --ignore-unmatch" useful to begin with?
A similar question for "add --ignore-unmatch".

Now the obligatory design level question is behind us, let's take a brief
look at the codde.

> +static int ignore_unmatch = 0;

Drop " = 0" and let the language initialize this to zero.

>  static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
>  {
> @@ -63,7 +64,7 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
>  	fill_pathspec_matches(pathspec, seen, specs);
>  
>  	for (i = 0; i < specs; i++) {
> -		if (!seen[i] && pathspec[i][0] && !file_exists(pathspec[i]))
> +		if (!seen[i] && pathspec[i][0] && !file_exists(pathspec[i]) && !ignore_unmatch)
>  			die("pathspec '%s' did not match any files",
>  					pathspec[i]);
>  	}
> @@ -108,7 +109,7 @@ static void refresh(int verbose, const char **pathspec)
>  	refresh_index(&the_index, verbose ? REFRESH_SAY_CHANGED : REFRESH_QUIET,
>  		      pathspec, seen);
>  	for (i = 0; i < specs; i++) {
> -		if (!seen[i])
> +		if (!seen[i] && !ignore_unmatch)
>  			die("pathspec '%s' did not match any files", pathspec[i]);
>  	}
>          free(seen);

What's the point of these two loops if under ignore_unmatch everything
becomes no-op?

That is, wouldn't it be much more clear if you wrote like this?

 builtin-add.c |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 581a2a1..49576b4 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -41,16 +41,25 @@ static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
 	}
 }
 
+static char *alloc_seen(const char **pathspec, int *specs_)
+{
+	int specs;
+
+	if (ignore_unmatch)
+		return NULL;
+	for (specs = 0; pathspec[specs];  specs++)
+		; /* nothing */
+	*specs_ = specs;
+	return xcalloc(specs, 1);
+}
+
 static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
 {
 	char *seen;
 	int i, specs;
 	struct dir_entry **src, **dst;
 
-	for (specs = 0; pathspec[specs];  specs++)
-		/* nothing */;
-	seen = xcalloc(specs, 1);
-
+	seen = alloc_seen(pathspec, &specs);
 	src = dst = dir->entries;
 	i = dir->nr;
 	while (--i >= 0) {
@@ -60,6 +69,8 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 			*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
+	if (!seen)
+		return;
 	fill_pathspec_matches(pathspec, seen, specs);
 
 	for (i = 0; i < specs; i++) {
@@ -102,11 +113,11 @@ static void refresh(int verbose, const char **pathspec)
 	char *seen;
 	int i, specs;
 
-	for (specs = 0; pathspec[specs];  specs++)
-		/* nothing */;
-	seen = xcalloc(specs, 1);
+	seen = alloc_seen(pathspec, &specs);
 	refresh_index(&the_index, verbose ? REFRESH_SAY_CHANGED : REFRESH_QUIET,
 		      pathspec, seen);
+	if (!seen)
+		return;
 	for (i = 0; i < specs; i++) {
 		if (!seen[i])
 			die("pathspec '%s' did not match any files", pathspec[i]);
