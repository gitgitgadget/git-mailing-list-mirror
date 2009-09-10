From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: obnoxious CLI complaints
Date: Fri, 11 Sep 2009 00:19:05 +0200
Message-ID: <4AA97B59.9030903@lsrfire.ath.cx>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com> <m3fxavvl5k.fsf@localhost.localdomain> <4C1FB36D-F8A6-4C01-A42A-8AD2355A9961@wincent.com> <200909101850.26109.jnareb@gmail.com> <7vbpliaaxo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 00:19:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlrzE-0003Pd-G1
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 00:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbZIJWTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 18:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754478AbZIJWTT
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 18:19:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:38594 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbZIJWTS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 18:19:18 -0400
Received: from [10.0.1.101] (p57B7F065.dip.t-dialin.net [87.183.240.101])
	by india601.server4you.de (Postfix) with ESMTPSA id 6D0D02F809E;
	Fri, 11 Sep 2009 00:19:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vbpliaaxo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128154>

Junio C Hamano schrieb:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> First, it would be consistent with how ordinary archivers such as tar
>> or zip are used, where you have to specify list of files to archive
>> (in our case this list is HEAD).  Second, I'd rather not accidentally
>> dump binary to terminal: "git archive [HEAD]" dumps archive to standard
>> output.
> 
> So does "cat".  I do not agree with your second point.
> 
> While I somewhat see the similarity argument, your first point, I am not
> sure if it is relevant.  It is not like "tar or zip allows us to say what
> files to archive, but git-archive doesn't and it always archives HEAD";
> you are saying "they require us to specify, so should we".
> 
> But I do not see a strong reason not to default to HEAD.  The case that
> would make difference would be to differentiate among
> 
> 	$ git archive HEAD TAIL
>         $ git archive HEAD -- TAIL
>         $ git archive -- HEAD TAIL
> 
> i.e. what if you happen to have a tracked content called HEAD.  I didn't
> check the current command line parser in git-archive understands the "--"
> convention for that, but it is not a rocket science to add it if it
> doesn't.

Currently it doesn't.  An attempt to implement it is below (tests and
documentation update missing).

I wonder if we want to make treeless calls to archive the worktree (or the
index) instead of HEAD, similar to git grep, though.  Not that I remember
someone requesting such a thing, but I'm already slightly surprised about
archive being used to tar up HEAD in any case -- I imagined it would mostly
be used to make releases of tagged versions.

---
 archive.c |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/archive.c b/archive.c
index 0bca9ca..04fa6a5 100644
--- a/archive.c
+++ b/archive.c
@@ -214,18 +214,32 @@ static void parse_pathspec_arg(const char **pathspec,
 	ar_args->pathspec = get_pathspec(ar_args->base, pathspec);
 }
 
-static void parse_treeish_arg(const char **argv,
-		struct archiver_args *ar_args, const char *prefix)
+static int parse_treeish_arg(int argc, const char **argv,
+			     struct archiver_args *ar_args, const char *prefix)
 {
-	const char *name = argv[0];
+	const char *name = "HEAD";
 	const unsigned char *commit_sha1;
 	time_t archive_time;
 	struct tree *tree;
 	const struct commit *commit;
 	unsigned char sha1[20];
 
+	if (argc > 0) {
+		int consume = 1;
+
+		if (strcmp(argv[0], "--")) {
+			name = argv[0];
+			if (argc > 1 && !strcmp(argv[1], "--"))
+				consume++;
+		}
+
+		argc -= consume;
+		memmove(argv, argv + consume, argc * sizeof(*argv));
+		argv[argc] = NULL;
+	}
+
 	if (get_sha1(name, sha1))
-		die("Not a valid object name");
+		die("Not a valid object name: %s", name);
 
 	commit = lookup_commit_reference_gently(sha1, 1);
 	if (commit) {
@@ -256,6 +270,8 @@ static void parse_treeish_arg(const char **argv,
 	ar_args->commit_sha1 = commit_sha1;
 	ar_args->commit = commit;
 	ar_args->time = archive_time;
+
+	return argc;
 }
 
 #define OPT__COMPR(s, v, h, p) \
@@ -309,7 +325,8 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, NULL, opts, archive_usage, 0);
+	argc = parse_options(argc, argv, NULL, opts, archive_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (remote)
 		die("Unexpected option --remote");
@@ -327,9 +344,6 @@ static int parse_archive_args(int argc, const char **argv,
 		exit(0);
 	}
 
-	/* We need at least one parameter -- tree-ish */
-	if (argc < 1)
-		usage_with_options(archive_usage, opts);
 	*ar = lookup_archiver(format);
 	if (!*ar)
 		die("Unknown archive format '%s'", format);
@@ -361,8 +375,8 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	if (setup_prefix && prefix == NULL)
 		prefix = setup_git_directory();
 
-	parse_treeish_arg(argv, &args, prefix);
-	parse_pathspec_arg(argv + 1, &args);
+	argc = parse_treeish_arg(argc, argv, &args, prefix);
+	parse_pathspec_arg(argv, &args);
 
 	git_config(git_default_config, NULL);
 
-- 
1.6.5.rc0
