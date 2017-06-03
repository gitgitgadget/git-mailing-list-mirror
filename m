Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBE3720D13
	for <e@80x24.org>; Sat,  3 Jun 2017 00:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbdFCAhQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 20:37:16 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36577 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdFCAhP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 20:37:15 -0400
Received: by mail-pf0-f172.google.com with SMTP id m17so58602567pfg.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 17:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TGkOkz8cDjQ9Iu0P1zxOXGYv/jLcL4Asn3GViCGkNkQ=;
        b=IUjuPP9doqDDdrqwGW9YN96Iy46+Y9hNbab6p23QBmJrbmMDTmwYFytGwAyVW0ytjs
         O5lwb3zJIuxZ7ampDvuu3G/dAISjiEXhRcveozBrIOD+R9AFbfgihBJoRd2b8jKwnoBD
         8K1e0ebKq5VPJYJR3KeoetYsIXN+AST3hQP3mRYPEDtRAFjG/E02jwWj6mCcQj9JN+/C
         F6cwV/W8q4bh9/ahwVs7/jXBvbvdBuo51afutdYltY0lRGit/5jHdiFXYOBDAWyOUN2I
         n0+Vmpi5NMG4hhWqlZG88dj3Xr+apuNrktxVx6erAo6Y51ggSTYQxEfSfY8nOoLMFcHT
         fbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TGkOkz8cDjQ9Iu0P1zxOXGYv/jLcL4Asn3GViCGkNkQ=;
        b=M6QFTgR6beBf2vkP5HD6VYKxkThilIC2/Wf8/p11Fc/EN5yws//Ca4MsIOc7KxYIy8
         X8FUWFTMLF42zVx2sQnTm3/k0bfDOkwoQ9yERRvaj+nxm2p7evCnAgJ0R5YSkISHq6g9
         9imJQEHIcymstbu4E95BPqbks4HptOWMlatd8DvYUPNb8gfhbuYS2qT8/7SIFC36VxC7
         OqaQVJ4ZXAj/aYUMzgFmbi8jh6O2Dg5ehn82wKEfBG5g7CocNFmVgfOEftvahBlOR78+
         vBFUHNnGc7fnF+HnzK9s/9WbZVPKuQ7Q1+xIA7HMNEU8Me2ZCTNKN4AuZ4u7auuaVXxn
         vuHw==
X-Gm-Message-State: AODbwcBo0B4Dtf3SPeciNKoKPundyqSb+9swlfnVcec1Ue4alGKKP6jn
        w5IvVo9X7Z3IymyN
X-Received: by 10.84.175.129 with SMTP id t1mr2536067plb.62.1496450234655;
        Fri, 02 Jun 2017 17:37:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:4d01:b9a:6ca2:1de8])
        by smtp.gmail.com with ESMTPSA id l88sm11937527pfg.23.2017.06.02.17.37.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 17:37:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, pc44800@gmail.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com
Subject: [PATCH] submodule foreach: correct $sm_path in nested submodules from a dir
Date:   Fri,  2 Jun 2017 17:37:10 -0700
Message-Id: <20170603003710.5558-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.gab62347cd9
In-Reply-To: <20170515183405.GA79147@google.com>
References: <20170515183405.GA79147@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git submodule foreach' from a subdirectory of your
repository, nested submodules get a bogus value for $sm_path:
For a submodule 'sub' that contains a nested submodule 'nested',
running 'git -C dir submodule foreach echo $path' would report
path='../nested' for the nested submodule. The first part '../' is
derived from the logic computing the relative path from $pwd to the
root of the superproject. The second part is the submodule path inside
the submodule. This value is of little use and is hard to document.

There are two different possible solutions that have more value:
(a) The path value is documented as the path from the toplevel of the
    superproject to the mount point of the submodule.
    In this case we would want to have path='sub/nested'.

(b) As Ramsay noticed the documented value is wrong. For the non-nested
    case the path is equal to the relative path from $pwd to the
    submodules working directory. When following this model,
    the expected value would be path='../sub/nested'.

The behavior for (b) was introduced in 091a6eb0fe (submodule: drop the
top-level requirement, 2013-06-16) the intent for $path seemed to be
relative to $cwd to the submodule worktree, but that did not work for
nested submodules, as the intermittent submodules were not included in
the path.

If we were to fix the meaning of the $path using (a) such that "path"
is "the path from the toplevel of the superproject to the mount point
of the submodule", we would break any existing submodule user that runs
foreach from non-root of the superproject as the non-nested submodule
'../sub' would change its path to 'sub'.

If we would fix the meaning of the $path using (b), such that "path"
is "the relative path from $pwd to the submodule", then we would break
any user that uses nested submodules (even from the root directory) as
the 'nested' would become 'sub/nested'.

Both groups can be found in the wild.  The author has no data if one group
outweighs the other by large margin, and offending each one seems equally
bad at first.  However in the authors imagination it is better to go with
(a) as running from a sub directory sounds like it is carried out
by a human rather than by some automation task.  With a human on
the keyboard the feedback loop is short and the changed behavior can be
adapted to quickly unlike some automation that can break silently.

To ameliorate the situation, perform these changes
* Document 'sm_path' instead of 'path'.
  As using a variable '$path' may be harmful to users due to
  capitalization issues, see 64394e3ae9 (git-submodule.sh: Don't
  use $path variable in eval_gettext string, 2012-04-17). Adjust
  the documentation to advocate for using $sm_path,  which contains
  the same value. We still make the 'path' variable available,
  though not documented.

* Clarify the 'toplevel' variable documentation.
  It does not contain the topmost superproject as the author assumed,
  but the direct superproject, such that $toplevel/$sm_path is the
  actual absolute path of the submodule.

* The variable '$displaypath' was accessible but undocumented.
  Rename it '$displaypath' to '$dpath'. Document what it contains.
  Users that are broken by the behavior change of 'sm_path' introduced
  in this commit, can switch from '$path' to '$dpath'.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Ramsay,
I would think this would be least offensive to all parties involved.
With my current understanding of the situation
I think this is the best fix for now.

Prathamesh, sorry for the missleading suggestions earlier
on how to approach this bug. Let's see how the discussion turns out on this
one before rebasing the rewrite in C on this one.

Thanks,
Stefan

 Documentation/git-submodule.txt | 32 ++++++++++++++++++--------------
 git-submodule.sh                |  7 +++----
 t/t7407-submodule-foreach.sh    | 39 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 74bc6200d5..52e3ef1325 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -218,20 +218,24 @@ information too.
 
 foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $name, $path, $sha1 and
-	$toplevel:
-	$name is the name of the relevant submodule section in .gitmodules,
-	$path is the name of the submodule directory relative to the
-	superproject, $sha1 is the commit as recorded in the superproject,
-	and $toplevel is the absolute path to the top-level of the superproject.
-	Any submodules defined in the superproject but not checked out are
-	ignored by this command. Unless given `--quiet`, foreach prints the name
-	of each submodule before evaluating the command.
-	If `--recursive` is given, submodules are traversed recursively (i.e.
-	the given shell command is evaluated in nested submodules as well).
-	A non-zero return from the command in any submodule causes
-	the processing to terminate. This can be overridden by adding '|| :'
-	to the end of the command.
+	The command has access to the following variables:
++
+* `$name` is the name of the relevant submodule section in .gitmodules,
+* `$sha1` is the commit as recorded in the superproject.
+* `$sm_path` is the path recorded in the superproject.
+* `$toplevel` is the absolute path to its superproject, such that
+  `$toplevel/$sm_path` is the absolute path of the submodule.
+* `$dpath` contains the relative path from the current working directory
+   to the submodules root directory.
++
+Any submodules defined in the superproject but not checked out are
+ignored by this command. Unless given `--quiet`, foreach prints the name
+of each submodule before evaluating the command.
+If `--recursive` is given, submodules are traversed recursively (i.e.
+the given shell command is evaluated in nested submodules as well).
+A non-zero return from the command in any submodule causes
+the processing to terminate. This can be overridden by adding '|| :'
+to the end of the command.
 +
 As an example, the command below will show the path and currently
 checked out commit for each submodule:
diff --git a/git-submodule.sh b/git-submodule.sh
index c0d0e9a4c6..8133640fa1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -337,14 +337,13 @@ cmd_foreach()
 		die_if_unmatched "$mode" "$sha1"
 		if test -e "$sm_path"/.git
 		then
-			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-			say "$(eval_gettext "Entering '\$displaypath'")"
+			dpath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
+			say "$(eval_gettext "Entering '\$dpath'")"
 			name=$(git submodule--helper name "$sm_path")
 			(
 				prefix="$prefix$sm_path/"
 				sanitize_submodule_env
 				cd "$sm_path" &&
-				sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
 				# we make $path available to scripts ...
 				path=$sm_path &&
 				if test $# -eq 1
@@ -358,7 +357,7 @@ cmd_foreach()
 					cmd_foreach "--recursive" "$@"
 				fi
 			) <&3 3<&- ||
-			die "$(eval_gettext "Stopping at '\$displaypath'; script returned non-zero status.")"
+			die "$(eval_gettext "Stopping at '\$dpath'; script returned non-zero status.")"
 		fi
 	done
 }
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6ba5daf42e..a082ca75aa 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -82,16 +82,16 @@ test_expect_success 'test basic "submodule foreach" usage' '
 
 cat >expect <<EOF
 Entering '../sub1'
-$pwd/clone-foo1-../sub1-$sub1sha1
+$pwd/clone-foo1-sub1-../sub1-$sub1sha1
 Entering '../sub3'
-$pwd/clone-foo3-../sub3-$sub3sha1
+$pwd/clone-foo3-sub3-../sub3-$sub3sha1
 EOF
 
 test_expect_success 'test "submodule foreach" from subdirectory' '
 	mkdir clone/sub &&
 	(
 		cd clone/sub &&
-		git submodule foreach "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
+		git submodule foreach "echo \$toplevel-\$name-\$sm_path-\$dpath-\$sha1" >../../actual
 	) &&
 	test_i18ncmp expect actual
 '
@@ -197,6 +197,39 @@ test_expect_success 'test messages from "foreach --recursive" from subdirectory'
 	test_i18ncmp expect actual
 '
 
+sub1sha1=$(cd clone2/sub1 && git rev-parse HEAD)
+sub2sha1=$(cd clone2/sub2 && git rev-parse HEAD)
+sub3sha1=$(cd clone2/sub3 && git rev-parse HEAD)
+nested1sha1=$(cd clone2/nested1 && git rev-parse HEAD)
+nested2sha1=$(cd clone2/nested1/nested2 && git rev-parse HEAD)
+nested3sha1=$(cd clone2/nested1/nested2/nested3 && git rev-parse HEAD)
+submodulesha1=$(cd clone2/nested1/nested2/nested3/submodule && git rev-parse HEAD)
+
+cat >expect <<EOF
+Entering '../nested1'
+$pwd/clone2-nested1-nested1-../nested1-$nested1sha1
+Entering '../nested1/nested2'
+$pwd/clone2/nested1-nested2-nested2-../nested1/nested2-$nested2sha1
+Entering '../nested1/nested2/nested3'
+$pwd/clone2/nested1/nested2-nested3-nested3-../nested1/nested2/nested3-$nested3sha1
+Entering '../nested1/nested2/nested3/submodule'
+$pwd/clone2/nested1/nested2/nested3-submodule-submodule-../nested1/nested2/nested3/submodule-$submodulesha1
+Entering '../sub1'
+$pwd/clone2-foo1-sub1-../sub1-$sub1sha1
+Entering '../sub2'
+$pwd/clone2-foo2-sub2-../sub2-$sub2sha1
+Entering '../sub3'
+$pwd/clone2-foo3-sub3-../sub3-$sub3sha1
+EOF
+
+test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
+	(
+		cd clone2/untracked &&
+		git submodule foreach --recursive "echo \$toplevel-\$name-\$sm_path-\$dpath-\$sha1" >../../actual
+	) &&
+	test_i18ncmp expect actual
+'
+
 cat > expect <<EOF
 nested1-nested1
 nested2-nested2
-- 
2.13.0.17.gab62347cd9

