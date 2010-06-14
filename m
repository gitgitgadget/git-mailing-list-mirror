From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] revert: do not rebuild argv on heap
Date: Mon, 14 Jun 2010 00:32:09 -0500
Message-ID: <20100614053209.GC1737@burratino>
References: <20100614032251.20121.83253.chriscool@tuxfamily.org>
 <20100614052027.GA1509@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jun 14 07:32:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO2Ha-0007Gk-Sh
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 07:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382Ab0FNFcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 01:32:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35957 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab0FNFcV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 01:32:21 -0400
Received: by iwn9 with SMTP id 9so2915193iwn.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 22:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=U0ZKHQ+TK3Ozl4wSwu/ZP7VCW/uyXDWzS+IW9HaELqg=;
        b=qH5UFCgkG3H+Gzi67xE9C1Crh0ovFc8ett5ruvdDDnrtx2Cx/1Ad9+t3gyoT0HcbtX
         3gdikOhssG33n5sxj+LLuHy6URVy/qKPn6bV4NuGVporekFHkRuUpXg1VqWeahbBvKrn
         ZKNB2aFUAr2NkgsGhAoLMHOHHau/lC7H20uqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=orUs80kfyPNxIlcEGfu+4rsUORIKiN3NUDSakb9O5P1aPWGljoxysKzRJBPhtrAdfK
         GALor4HoJEEf9CDMnGAYjbHVa2wRF4eG+Tar9jyGaTn3iA9uVSd4VSN+zhnPmSBcjsHz
         A8ijoPwlgm/ZXxBBKc175XLdSI+A6AofrrZQ4=
Received: by 10.231.168.129 with SMTP id u1mr6011609iby.49.1276493540344;
        Sun, 13 Jun 2010 22:32:20 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a8sm18978763ibi.23.2010.06.13.22.32.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 13 Jun 2010 22:32:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100614052027.GA1509@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149072>

Set options in struct rev_info directly so we can reuse the
arguments collected from parse_options without modification.

This is just a cleanup; no noticeable change is intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks, Christian.

 builtin/revert.c              |   34 +++++++++++++++++-----------------
 t/t3501-revert-cherry-pick.sh |   18 ++++++++++++++++++
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 67e191b..88b7501 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -50,10 +50,14 @@ static const char *strategy;
 
 static char *get_encoding(const char *message);
 
+static const char * const *revert_or_cherry_pick_usage(void)
+{
+	return action == REVERT ? revert_usage : cherry_pick_usage;
+}
+
 static void parse_args(int argc, const char **argv)
 {
-	const char * const * usage_str =
-		action == REVERT ?  revert_usage : cherry_pick_usage;
+	const char * const * usage_str = revert_or_cherry_pick_usage();
 	int noop;
 	struct option options[] = {
 		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
@@ -79,8 +83,9 @@ static void parse_args(int argc, const char **argv)
 	}
 
 	commit_argc = parse_options(argc, argv, NULL, options, usage_str,
+	                            PARSE_OPT_KEEP_ARGV0 |
 	                            PARSE_OPT_KEEP_UNKNOWN);
-	if (commit_argc < 1)
+	if (commit_argc < 2)
 		usage_with_options(usage_str, options);
 
 	commit_argv = argv;
@@ -526,27 +531,22 @@ static int do_pick_commit(void)
 
 static void prepare_revs(struct rev_info *revs)
 {
-	int argc = 0;
-	int i;
-	const char **argv = xmalloc((commit_argc + 4) * sizeof(*argv));
-
-	argv[argc++] = NULL;
-	argv[argc++] = "--no-walk";
-	if (action != REVERT)
-		argv[argc++] = "--reverse";
-	for (i = 0; i < commit_argc; i++)
-		argv[argc++] = commit_argv[i];
-	argv[argc++] = NULL;
+	int argc;
 
 	init_revisions(revs, NULL);
-	setup_revisions(argc - 1, argv, revs, NULL);
+	revs->no_walk = 1;
+	if (action != REVERT)
+		revs->reverse = 1;
+
+	argc = setup_revisions(commit_argc, commit_argv, revs, NULL);
+	if (argc > 1)
+		usage(*revert_or_cherry_pick_usage());
+
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
 
 	if (!revs->commits)
 		die("empty commit set passed");
-
-	free(argv);
 }
 
 static int revert_or_cherry_pick(int argc, const char **argv)
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 7f85815..f61c54d 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -41,6 +41,24 @@ test_expect_success setup '
 	git tag rename2
 '
 
+test_expect_success 'cherry-pick --nonsense' '
+
+	pos=$(git rev-parse HEAD) &&
+	git diff --exit-code HEAD &&
+	test_must_fail git cherry-pick --nonsense 2>msg &&
+	git diff --exit-code HEAD "$pos" &&
+	grep '[Uu]sage:' msg
+'
+
+test_expect_success 'revert --nonsense' '
+
+	pos=$(git rev-parse HEAD) &&
+	git diff --exit-code HEAD &&
+	test_must_fail git revert --nonsense 2>msg &&
+	git diff --exit-code HEAD "$pos" &&
+	grep '[Uu]sage:' msg
+'
+
 test_expect_success 'cherry-pick after renaming branch' '
 
 	git checkout rename2 &&
-- 
1.7.1.246.g398e5.dirty
