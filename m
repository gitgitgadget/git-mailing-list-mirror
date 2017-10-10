Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DCBA20372
	for <e@80x24.org>; Tue, 10 Oct 2017 04:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbdJJEGL (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 00:06:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58664 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750734AbdJJEGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 00:06:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C6F5B63FB;
        Tue, 10 Oct 2017 00:06:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=nLMu
        z4isWOXOtS56pTlPRLktnQg=; b=O3PdMbta4dOqXcxIAHTy5+7ciO7WLoOOBcgc
        zbZgGlOf7lDvg3TSwDEHbhQ4qAieL6Qs746yhIjT0nmUJHZCzCc4tq/pYN7f600R
        tal0Q7YIONP+JwvHb79eaqkO9oxYH2D76+GpYhhgscteq8dyaQ7p/gzM7Z/SBRYQ
        SolOjRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=pVa0wW
        2FZRRYk7GHa0k1Xgyy0dnZeJo+8tzJue6QfzFBfRS7ACURS2yZfqv7VxC7NvU33p
        bDpKdDmxYba85iDazTOoawc6MyEep/gSc9eq8hoKbPWK2hScGzVJM8YcHOohslVW
        RXqrI4V38YvqDxZIfCJuC/oK9j1TeRx0UntUc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 537A0B63F9;
        Tue, 10 Oct 2017 00:06:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C3E87B63F7;
        Tue, 10 Oct 2017 00:06:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] describe: do not use cmd_*() as a subroutine
Date:   Tue, 10 Oct 2017 13:06:03 +0900
Message-Id: <20171010040604.26029-2-gitster@pobox.com>
X-Mailer: git-send-email 2.15.0-rc0-209-g4adfc7b6b1
In-Reply-To: <20171010040604.26029-1-gitster@pobox.com>
References: <xmqqr2vlbgyk.fsf@gitster.mtv.corp.google.com>
 <20171010040604.26029-1-gitster@pobox.com>
X-Pobox-Relay-ID: 57BECCC0-AD70-11E7-A910-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cmd_foo() function is a moral equivalent of 'main' for a Git
subcommand 'git foo', and as such, it is allowed to do many things
that make it unsuitable to be called as a subroutine, including

 - call exit(3) to terminate the process;

 - allocate resource held and used throughout its lifetime, without
   releasing it upon return/exit;

 - rely on global variables being initialized at program startup,
   and update them as needed, making another clean invocation of the
   function impossible.

The call to cmd_diff_index() "git describe" makes has been working
by accident that the function did not call exit(3); it sets a bad
precedent for people to cut and paste.

We could invoke it via the run_command() interface, but the diff
family of commands have helper functions in diff-lib.c that are
meant to be usable as subroutines, and using the latter does not
make the resulting code all that longer.  Use it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/describe.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 89ea1cdd60..50263759cb 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -7,12 +7,12 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
+#include "revision.h"
 #include "diff.h"
 #include "hashmap.h"
 #include "argv-array.h"
 #include "run-command.h"
 
-#define SEEN		(1u << 0)
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char * const describe_usage[] = {
@@ -532,7 +532,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			}
 		} else if (dirty) {
 			static struct lock_file index_lock;
-			int fd;
+			struct rev_info revs;
+			struct argv_array args = ARGV_ARRAY_INIT;
+			int fd, result;
 
 			read_cache_preload(NULL);
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
@@ -541,8 +543,13 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			if (0 <= fd)
 				update_index_if_able(&the_index, &index_lock);
 
-			if (!cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1,
-					    diff_index_args, prefix))
+			init_revisions(&revs, prefix);
+			argv_array_pushv(&args, diff_index_args);
+			if (setup_revisions(args.argc, args.argv, &revs, NULL) != 1)
+				BUG("malformed internal diff-index command line");
+			result = run_diff_index(&revs, 0);
+
+			if (!diff_result_code(&revs.diffopt, result))
 				suffix = NULL;
 			else
 				suffix = dirty;
-- 
2.15.0-rc0-203-g4c8d0e28b1

