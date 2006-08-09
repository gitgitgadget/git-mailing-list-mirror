From: Junio C Hamano <junkio@cox.net>
Subject: Re: Strange output of git-diff-tree
Date: Wed, 09 Aug 2006 13:17:43 -0700
Message-ID: <7v7j1h3bq0.fsf@assigned-by-dhcp.cox.net>
References: <ebcnml$btf$1@sea.gmane.org>
	<7vfyg54vjb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 22:18:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAuV0-0008Qa-VX
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 22:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWHIURq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 16:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWHIURq
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 16:17:46 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:1501 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751362AbWHIURp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 16:17:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060809201744.UHNI27846.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Aug 2006 16:17:44 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7vfyg54vjb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 09 Aug 2006 11:24:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25141>

Junio C Hamano <junkio@cox.net> writes:

> Well spotted.  The minimum reproduction recipe is:
>
>      $ git diff-tree --find-copies-harder 2ad9331
>
> Will look into it.

This is because the original command line has -C and -M in this
order, and the minimum reproduction does not have either.

diff_setup_done() "silently" complains about it but the caller
was not taking notice.

What happens is that the check at the top of diff_setup_done()
fails, and does not set up options->abbrev to 40 upon seeing
abbrev is set to zero.  This later causes find_unique_abbrev()
to be called with len=0, which returns an empty string, because
it is not expecing to get something like that.

Incidentally, there is another funny breakage related to this.

	$ git diff-tree --find-copies-harder v1.4.1

complains quite a lot about "feeding unmodified" file pairs.
This is because "harder" is given without -C.

So there are three things to fix:

 (1) callers of diff_setup_done() that do not check and die
     should do so like others.

 (2) find_unique_abbrev() should prepare being called with
     len=0.

 (3) make --find-copies-harder imply -C.

Strictly speaking, the third is an incompatible change, but it
makes something that used to be an invalid/undefined operation
to a valid one, so it would not be so bad.

*1*

diff --git a/builtin-diff.c b/builtin-diff.c
index 1075855..dd9886c 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -253,7 +253,8 @@ int cmd_diff(int argc, const char **argv
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
-		diff_setup_done(&rev.diffopt);
+		if (diff_setup_done(&rev.diffopt) < 0)
+			die("diff_setup_done failed");
 	}
 
 	/* Do we have --cached and not have a pending object, then
diff --git a/revision.c b/revision.c
index a58257a..5a91d06 100644
--- a/revision.c
+++ b/revision.c
@@ -936,7 +936,8 @@ int setup_revisions(int argc, const char
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 	}
 	revs->diffopt.abbrev = revs->abbrev;
-	diff_setup_done(&revs->diffopt);
+	if (diff_setup_done(&revs->diffopt) < 0)
+		die("diff_setup_done failed");
 
 	return left;
 }

*2*

diff --git a/sha1_name.c b/sha1_name.c
index 5fe8e5d..c5a05fa 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -193,7 +193,7 @@ const char *find_unique_abbrev(const uns
 
 	is_null = !memcmp(sha1, null_sha1, 20);
 	memcpy(hex, sha1_to_hex(sha1), 40);
-	if (len == 40)
+	if (len == 40 || !len)
 		return hex;
 	while (len < 40) {
 		unsigned char sha1_ret[20];

*3*

diff --git a/diff.c b/diff.c
index 895c137..02a409d 100644
--- a/diff.c
+++ b/diff.c
@@ -1515,9 +1515,10 @@ void diff_setup(struct diff_options *opt
 
 int diff_setup_done(struct diff_options *options)
 {
-	if ((options->find_copies_harder &&
-	     options->detect_rename != DIFF_DETECT_COPY) ||
-	    (0 <= options->rename_limit && !options->detect_rename))
+	if (options->find_copies_harder)
+		options->detect_rename = DIFF_DETECT_COPY;
+
+	if ((0 <= options->rename_limit && !options->detect_rename)
 		return -1;
 
 	if (options->output_format & (DIFF_FORMAT_NAME |
diff --git a/sha1_name.c b/sha1_name.c
index 5fe8e5d..c5a05fa 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -193,7 +193,7 @@ const char *find_unique_abbrev(const uns
 
 	is_null = !memcmp(sha1, null_sha1, 20);
 	memcpy(hex, sha1_to_hex(sha1), 40);
-	if (len == 40)
+	if (len == 40 || !len)
 		return hex;
 	while (len < 40) {
 		unsigned char sha1_ret[20];
