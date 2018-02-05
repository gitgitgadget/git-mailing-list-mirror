Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A780C1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750879AbeBEXhg (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:37:36 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46407 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeBEXhe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:37:34 -0500
Received: by mail-wr0-f193.google.com with SMTP id 35so58597wrb.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=7/RkF9GN25rAqKURIZ9Uarnfshmbx7aw7Y69pE76KQk=;
        b=iwmE8seTrX9A714ElnpHW11WSoRhmbVtMOoTlxBzDI1RxUS5jmE8n7Pwqb3wipZiZe
         WJqdgu2Rr5Wk8jeoxO4qVvqMXAHTnwVhC87ZcsFiO+g1b4Wl6N2bJanaklj95ZDmggYP
         KlZ2gxjWdZ9d3riudXCg8NZiMFV24s2plUKV+e75QGwV3EFVk0+PL7Xc7R92Jdj7cUzV
         vMj+OKK8r2IqRpMeNAiFvoKZrklDwvDpJUb042INDD2C9BdV1Q5ejbKrV/UMU3GjEXVv
         9CssCTZJoeYp/cfVKGUrFiMyDT65MZoktxKtnbaI0L7fef76PWa58dAW/kddcxQ++OWz
         Qdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=7/RkF9GN25rAqKURIZ9Uarnfshmbx7aw7Y69pE76KQk=;
        b=M4z/8vqcfBKHs+3X5Nz3T7R5N6/zvaJl7w0vgtjdzjGUpadhRlcfItaKLTCUFNcY0j
         W53WY2dyURpZ/YQx43yTVczDQqs7ZG6311l2LTh54twsnYP5UEbuZrW7eKuZtx+KXcwU
         BwXJ9iQBlp5uXE0sQZDHIEQxnmRMiYe3joauPoOF6fq4/B0hSWt0wrX6O7P5ESWck3GC
         2bcXVjBX58YkO45w90dNzJaV/wYeHRAUH92+71I0vbKeNDu/TLvgtMF1Z+3+dn2jlC0t
         oOrBzFWyG4Os8RKXl8tRBAZBaehuQ+obviDlf56j4LgYo1Jre1rgTegYUts/0CIg8EMF
         vWQA==
X-Gm-Message-State: APf1xPDj/uoemTEjumWEhjCdSIbk29XAgShDJvSr46W3UEujs1V3kl+S
        4+qq8QvXy5JL53Epugr8njjXDKXG
X-Google-Smtp-Source: AH8x224mhuiDYyL4ZHmg89vRIe0DIBK9oTAKtCjJCLoZaKWeOeqdtZk8zeCoMpdX51CfWGmvA1A3IQ==
X-Received: by 10.223.185.29 with SMTP id k29mr398834wrf.37.1517873852413;
        Mon, 05 Feb 2018 15:37:32 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p5sm11525070wmf.13.2018.02.05.15.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:37:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [RFH/PATCH] blame: tighten command line parser
Date:   Mon, 05 Feb 2018 15:37:29 -0800
Message-ID: <xmqqmv0n80ue.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command line parser of "git blame" is prepared to take an
ancient odd argument order "blame <path> <rev>" in addition to the
usual "blame [<rev>] <path>".  It has at least two negative
ramifications:

 - In order to tell these two apart, it checks if the last command
   line argument names a path in the working tree, using
   file_exists().  However, "blame <rev> <path>" is a request to
   explalin each and every line in the contents of <path> stored in
   revision <rev> and does not need to have a working tree version
   of the file.  A check with file_exists() is simply wrong.

 - To coerce that mistaken file_exists() check to work, the code
   calls setup_work_tree() before doing so, because the path it has
   is relative to the top-level of the project tree.  However,
   "blame <rev> <path>" MUST be usable even in a bare repository,
   and there is no reason for letting setup_work_tree() to complain
   and die with "This operation must be run in a work tree".

To correct the former, switch to check if the last token is a
revision (and if so, parse arguments using "blame <path> <rev>"
rule).  Correct the latter by getting rid of setup_work_tree() and
file_exists() check--the only case the call to this function matters
is when we are running "blame <path>" (i.e. no starting revision and
asking to blame the working tree file at <path>, digging through the
HEAD revision), but there is a call in setup_scoreboard() just
before it calls fake_working_tree_commit().

Also attempt to give a bit more sensible error message when "blame
XYZ" is given and XYZ cannot be a path.

   side note: I am not happy with the "only one arg, which is a rev,
   given in a bare repository" condition to give the new error
   message, but this should be a good starting point.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Somebody noticed that this transcript looked funny.

   $ cd .git
   $ git blame HEAD
   fatal: This operation must be run in a work tree
   
   If it were a request for blaming Makefile instead, this error
   message may make some sense, though.

   By the way, I am not happy with is_a_rev() either.  There should
   be a handy helper function (or two) we already have that I am
   forgetting.

 builtin/blame.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 005f55aaa2..9dcb367b90 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -649,6 +649,15 @@ static int blame_move_callback(const struct option *option, const char *arg, int
 	return 0;
 }
 
+static int is_a_rev(const char *name)
+{
+	struct object_id oid;
+
+	if (get_oid(name, &oid))
+		return 0;
+	return OBJ_NONE < sha1_object_info(oid.hash, NULL);
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -845,16 +854,15 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	} else {
 		if (argc < 2)
 			usage_with_options(blame_opt_usage, options);
-		path = add_prefix(prefix, argv[argc - 1]);
-		if (argc == 3 && !file_exists(path)) { /* (2b) */
+		if (argc == 3 && is_a_rev(argv[argc - 1])) { /* (2b) */
 			path = add_prefix(prefix, argv[1]);
 			argv[1] = argv[2];
+		} else {	/* (2a) */
+			if (argc == 2 && is_a_rev(argv[1]) && !get_git_work_tree())
+				die("missing <path> to blame");
+			path = add_prefix(prefix, argv[argc - 1]);
 		}
 		argv[argc - 1] = "--";
-
-		setup_work_tree();
-		if (!file_exists(path))
-			die_errno("cannot stat path '%s'", path);
 	}
 
 	revs.disable_stdin = 1;
-- 
2.16.1-72-g5be1f00a9a

