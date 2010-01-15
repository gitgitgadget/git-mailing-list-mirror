From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] grep: prepare to run outside of a work tree
Date: Fri, 15 Jan 2010 12:50:54 -0800
Message-ID: <7v4omnw0r5.fsf_-_@alter.siamese.dyndns.org>
References: <201001131713.05505.agruen@suse.de>
 <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
 <20100115223259.6117@nanako3.lavabit.com>
 <7vska71br0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 21:51:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVt8Q-0005jF-8s
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 21:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366Ab0AOUvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 15:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755182Ab0AOUvE
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 15:51:04 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831Ab0AOUvD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 15:51:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 61E849111D;
	Fri, 15 Jan 2010 15:51:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aXmJW7vpqSlPkAaAaQXufvB+wtQ=; b=pcF3Nl
	I1i5Kwd9aw7njYrObrimC1XBKvhm8EGqWMTHOdFDfsjb81+fdX2701RdBHaTDGh1
	VSmxDhiPz5L7Xc3MCz5KIs27IFr52x48UfqsYoRMMJEgSn4bxtqpws0sDQDT65tg
	gK5RhMGNch7xPMnxbjt1bBDf8C0Q9e/zqFoEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dv+Z7Z+492MBad90V5mXYkqqxey4UsxZ
	q3T+FzW9Y5kQCXqeJLWsxNyGO8WrdAlfZYklHo9QMiPXSVvCgVCxUdAofENzyOcw
	Vyk8jVuUjOgPlg3FC1xNjnfpOOVQYVUrQ20n2/mmd3NWayZowhIRCaYw4NjFVhRu
	AHL4BnxfebI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FAF591119;
	Fri, 15 Jan 2010 15:50:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7087491117; Fri, 15 Jan
 2010 15:50:56 -0500 (EST)
In-Reply-To: <7vska71br0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 15 Jan 2010 10\:09\:07 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AF430630-0217-11DF-B604-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137115>

This moves the call to setup_git_directory() for running "grep" from
the "git" wrapper to the implementation of the "grep" subcommand.  A
new variable "use_index" is always true at this stage in the series,
and when it is on, we require that we are in a directory that is under
git control.  To make sure we die the same way, we make a second call
into setup_git_directory() when we detect this situation.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > Nanako Shiraishi <nanako3@lavabit.com> writes:
 >
 >> Is it possible to give --no-index option to "git grep", please?
 >
 > Surely.  And "grep" is much easier to do than "diff".  Will send a
 > patch perhaps during my lunch break.

 This is merely a preparatory step.

 builtin-grep.c |    7 +++++++
 git.c          |    2 +-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 3d6ebb5..229555d 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -414,6 +414,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	const char **paths = NULL;
 	int i;
 	int dummy;
+	int nongit = 0, use_index = 1;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "cached", &cached,
 			"search in index instead of in the work tree"),
@@ -497,6 +498,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	prefix = setup_git_directory_gently(&nongit);
+
 	/*
 	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
 	 * to show usage information and exit.
@@ -534,6 +537,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_NO_INTERNAL_HELP);
 
+	if (use_index && nongit)
+		/* die the same way as if we did it at the beginning */
+		setup_git_directory();
+
 	/* First unrecognized non-option token */
 	if (argc > 0 && !opt.pattern_list) {
 		append_grep_pattern(&opt, argv[0], "command line", 0,
diff --git a/git.c b/git.c
index 11544cd..ad07473 100644
--- a/git.c
+++ b/git.c
@@ -317,7 +317,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
-		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
+		{ "grep", cmd_grep, USE_PAGER },
 		{ "help", cmd_help },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
-- 
1.6.6.324.g20f8f4.dirty
