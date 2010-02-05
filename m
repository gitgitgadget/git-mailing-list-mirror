From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove .git auto detection from setup_git_env()
Date: Fri, 05 Feb 2010 09:27:10 -0800
Message-ID: <7vljf7a901.fsf@alter.siamese.dyndns.org>
References: <1265370468-6147-1-git-send-email-pclouds@gmail.com>
 <20100205151239.GC14116@coredump.intra.peff.net>
 <7vy6j7a98f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 18:27:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdRxp-0000qK-2y
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 18:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757099Ab0BER1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 12:27:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699Ab0BER1W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 12:27:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 565F7978F0;
	Fri,  5 Feb 2010 12:27:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GN0PChFu5ExV4QG+Pc4H6UP4KQw=; b=njwnqv
	SxOtWq9F8OC/1NcgzOFwfo65Nf6kE1qoOwlagJywtdBc+HhZvH2BgjTcbmVS775I
	wNZA1GHG3zNSKqNmdIF3iJjqg+GyYGnLjVWzG5hDv36+/7cgcWsTK3OBuwrs/ulv
	rblXxvm4oQb/qbpBB7Xlw/GVtNpkg1NQuHox4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UnGvYJCcSrSAb5adEUv7/28pK39EhyLG
	47FN9U9WRaO7pU7TNd22FYw9NSSV3FdMNVg352ROsBr39EU/w9AgzM9qsfIrzhww
	RZtUp8iun1A190ziCaIO3iy/bP9+r8Q4ZCXb+yjki3b/vpr8nFXkrIi0ximp5oDT
	0eM3nsb3KKc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1702F978EE;
	Fri,  5 Feb 2010 12:27:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5207978E6; Fri,  5 Feb
 2010 12:27:11 -0500 (EST)
In-Reply-To: <7vy6j7a98f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 05 Feb 2010 09\:22\:08 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B58D91A8-127B-11DF-BD17-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139062>

Junio C Hamano <gitster@pobox.com> writes:

> This topic started from "We broke 'git grep' in .git directory" and I
> think it is the sanest to revert 3081623 (grep --no-index: allow use of
> "git grep" outside a git repository, 2010-01-15) which nobody has used so
> far in any released version of git, until we sort this out at least.

Sorry; spoke too fast.  We'd also need to revert the one to git.c (7e62265
(grep: prepare to run outside of a work tree, 2010-01-15) as well.

diff --git a/builtin-grep.c b/builtin-grep.c
index bff1e68..26d4deb 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -739,7 +739,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	const char **paths = NULL;
 	int i;
 	int dummy;
-	int nongit = 0, use_index = 1;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "cached", &cached,
 			"search in index instead of in the work tree"),
@@ -825,8 +824,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	prefix = setup_git_directory_gently(&nongit);
-
 	/*
 	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
 	 * to show usage information and exit.
@@ -864,10 +861,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_NO_INTERNAL_HELP);
 
-	if (use_index && nongit)
-		/* die the same way as if we did it at the beginning */
-		setup_git_directory();
-
 	/* First unrecognized non-option token */
 	if (argc > 0 && !opt.pattern_list) {
 		append_grep_pattern(&opt, argv[0], "command line", 0,
diff --git a/git.c b/git.c
index b3e23f1..4c3028c 100644
--- a/git.c
+++ b/git.c
@@ -317,7 +317,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
-		{ "grep", cmd_grep, USE_PAGER },
+		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
 		{ "hash-object", cmd_hash_object },
 		{ "help", cmd_help },
 		{ "index-pack", cmd_index_pack },
