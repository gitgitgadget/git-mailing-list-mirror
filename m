From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule deinit: require '--all' instead of '.' for all submodules
Date: Tue,  3 May 2016 15:11:39 -0700
Message-ID: <1462313499-6760-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com,
	cederp@opera.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 04 00:11:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axiXn-0007QB-GX
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 00:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546AbcECWLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 18:11:47 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34147 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181AbcECWLq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 18:11:46 -0400
Received: by mail-pf0-f181.google.com with SMTP id y69so16216225pfb.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 15:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DRf+XoPJC+d8vBMAZh4a5m6NHSLDASjkkb9mKaH9hJk=;
        b=CS5ZZZwPE02zwc4tXIKg0Xv6aHDvURPNkUaAiIoCY5IxcAASW9Q8cBLwgezhl8vsvk
         zI/bMox9K9bvuaw8dr1hL2j4nOoxAAY/xGeuDuwowCJzyMsnnGo7dPNq4fC7vdZV48Ud
         UZpsJhfCI7IAckR6HbvndrGrPRsBZEjZMmUAwb9F2Ly9ef8xc5ZB5tra0aLUwr83RueM
         cW0zW0KWAHsmDvjDg3Vrm994yyenadej8BJYqHIsjIfs3I2StOkHC9bDn6i9tBh90Ab5
         x4k55QybzFsX375S686MA/0xjyZ7cUHmKsdNWArkMNxNTrxyZchmw9Z05fd6SB1FKAEf
         njxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DRf+XoPJC+d8vBMAZh4a5m6NHSLDASjkkb9mKaH9hJk=;
        b=HmIUF3BJod2KRtULJjuV+v9vbxSlX5KDsH9hy7kYSfjfaKItGAKC9JUeX1MYyGhv0r
         YdY/hyljg3+eQNWpH4/FRu2xPR3VQ90YYVWSQJg7XZN1bRkCsHrJGggy8zNO+1gHlQw9
         sREDTJdvWESijUKN509QZQbn4XKNd2OL/MjoQWuIn41Sk16qAJBlG09RqnwJlLwBTJyb
         ptzuo4XgPqbuwxFrGDx6KOZtW80m537y4k9Dd8pkImsDijuDhq0tuDe9rGDhc9GAwha4
         CqCWcQkhh9TOZgkyB6wtS7tOqe6rsRXDMTziYsFjtQhLGnd4RX/2nFRILi6CIy/77cV0
         M7NQ==
X-Gm-Message-State: AOPr4FXjxnNpDCzgItOSStdshTQ7HweCYk/ec8Rtrihg1HPW6YOUCYq7f2IrAxA+4rAKUur7
X-Received: by 10.98.92.66 with SMTP id q63mr7168019pfb.21.1462313505846;
        Tue, 03 May 2016 15:11:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:81d8:5415:7a03:cda9])
        by smtp.gmail.com with ESMTPSA id h88sm500988pfd.10.2016.05.03.15.11.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 May 2016 15:11:45 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.10.geb92688.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293465>

The discussion in [1] realized that '.' is a faulty suggestion as
there is a corner case where it fails:

> "submodule deinit ." may have "worked" in the sense that you would
> have at least one path in your tree and avoided this "nothing
> matches" most of the time.  It would have still failed with the
> exactly same error if run in an empty repository, i.e.
>
>        $ E=/var/tmp/x/empty && rm -fr "$E" && mkdir -p "$E" && cd "$E"
>        $ git init
>        $ rungit v2.6.6 submodule deinit .
>        error: pathspec '.' did not match any file(s) known to git.
>        Did you forget to 'git add'?
>        $ >file && git add file
>        $ rungit v2.6.6 submodule deinit .
>        $ echo $?
>        0

So instead of a path spec add a parameter '--all' to deinit all submodules
and add a test to check for the corner case of an empty repository.

There is no need to update the documentation as it did not describe the
special case '.' to remove all submodules.

The code only needs to learn about the '--all' parameter and doesn't
require further changes as `git submodule--helper list "$@"` will list
all submodules in that case.

[1] http://news.gmane.org/gmane.comp.version-control.git/289535

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

This is the result of the discussion, I would think.

I developed it on top of 
    "submodule deinit test: fix broken && chain in subshell"
    on top of 2a4c8c36a7f6, 2016-03-24, Merge branch
    'sb/submodule-module-list-pathspec-fix'
but I think this would rather go in as a new feature, not on top
of a bugfix topic, so I think this could go on origin/master ?

Thanks,
Stefan

 git-submodule.sh           | 12 ++++++++++--
 t/t7400-submodule-basic.sh |  4 ++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 43c68de..301cd0d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -521,6 +521,7 @@ cmd_init()
 cmd_deinit()
 {
 	# parse $args after "submodule ... deinit".
+	deinit_all=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -530,6 +531,9 @@ cmd_deinit()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
+		-a|--all)
+			deinit_all=t
+			;;
 		--)
 			shift
 			break
@@ -544,9 +548,13 @@ cmd_deinit()
 		shift
 	done
 
-	if test $# = 0
+	if test -n "$deinit_all" && test "$#" -ne 0
+	then
+		die "$(eval_gettext "'--all' is incompatible with pathspec arguments")"
+	fi
+	if test $# = 0 && test -z "$deinit_all"
 	then
-		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
+		die "$(eval_gettext "Use '--all' if you really want to deinitialize all submodules")"
 	fi
 
 	git submodule--helper list --prefix "$wt_prefix" "$@" |
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index cf06b2f..a5b0dec 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -11,6 +11,10 @@ subcommands of git submodule.
 
 . ./test-lib.sh
 
+test_expect_success 'submodule deinit works on empty repository' '
+	git submodule deinit --all
+'
+
 test_expect_success 'setup - initial commit' '
 	>t &&
 	git add t &&
-- 
2.8.0.rc4.10.geb92688.dirty
