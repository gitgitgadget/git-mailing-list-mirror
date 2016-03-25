From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/5] submodule--helper list: lose the extra prefix option
Date: Fri, 25 Mar 2016 11:39:13 -0700
Message-ID: <1458931156-29125-3-git-send-email-sbeller@google.com>
References: <1458931156-29125-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, Jens.Lehmann@web.de, jacob.keller@gmail.com,
	sunshine@sunshineco.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 25 19:39:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWdq-0005FI-VU
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbcCYSjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:39:24 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34194 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbcCYSjW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:39:22 -0400
Received: by mail-pa0-f46.google.com with SMTP id fe3so51250900pab.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cNcY6hVIktuE/x5hLvzorJFmNPyV+BASfxHUeytzQbU=;
        b=TrNg0fPjmgox8WXHjr/oNrtYYs3+GddzdIoI5RyncAP0rYVK9auTUoaof0fvQnp1TF
         Z7vyUJzkckBy4u0xY5ov6mHaVc0413x3BJacViRTOZTO3rn9gEWMVXNT9fN5DspYdo40
         FZxgQlwCzcVrG2QKSB2RTvlBfvig7gKdg4Jz4jpZf6cmqoZRjAAkAbB+0ZVMbu6stKap
         +/FP7TqWnUNxd6TmAxoJsnqt/URjzpbPWho8SecmmZ86Luv3pyzXNIpMQk5cLQlF3r4k
         74o91vLPagQCJERlp/PbMVrUKm4bKGyIz2ADNkCvzlaQANOv3l4386DaDFdztbkWnShM
         tPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cNcY6hVIktuE/x5hLvzorJFmNPyV+BASfxHUeytzQbU=;
        b=RHPxL6NYzaNMfaceY/DAv7SVKYnZiwMYsvg9vsu570TsA3Me+XWjkvXBhefZQfmXSL
         yd4aXPedo19I6FM1P5gRFzxCj4pH/z/7uOh3bwgcPtcQJAr7k+JgDXp+UlEgG0hcIxqk
         tBjL2hLSFGIUSCU2q+i3SOQOQ9GlFaLpnxiZT+TLhASpfrf/ClVqumSid7CH35az53NL
         /K/GIFVLvaqGVTkOzY7GKyW2/eTi0sX4uP289dWLFS+rdaJkHvgrda6vnq9JRZDqEpDW
         HWlCPPXofxEAOOly1mStyxL+VZUjyyF3Z8Tpae0IvMO93TMbdrIrMfMepz9boWl3xFId
         pu1A==
X-Gm-Message-State: AD7BkJKvjzSkccPWBonTHI9krrrRChqZp8BxkKQqxgv0GcySCFtQUJ0zqJayXq5zPea/21Z5
X-Received: by 10.66.122.100 with SMTP id lr4mr22259178pab.99.1458931161809;
        Fri, 25 Mar 2016 11:39:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e4a5:c9cf:82bb:5195])
        by smtp.gmail.com with ESMTPSA id v14sm18006098pas.10.2016.03.25.11.39.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Mar 2016 11:39:21 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.10.g52f3f33.dirty
In-Reply-To: <1458931156-29125-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289941>

The usual early machinery of Git is to change the directory to
the top level of the working tree and pass the actual path inside
the working tree as `prefix` to the command being run.
This is the case both for commands written in C (where the
prefix is passed into the command in a function parameter) as
well as in git-submodule.sh where the setup code runs

  wt_prefix=$(git rev-parse show-prefix)
  cd_to_top_level

So the prefix passed into the `submodule--helper list` is actually
the relative path inside the working tree, but we were not using
the standard way of passing it through.

Adhere to Gits standard of passing the relative path inside the
working tree by passing it via -C. This is more readable for future
readers of the code.

We do not need to pass it for `submodule foreach` as that command
doesn't take further arguments ('$@') to operate on a subset of
submodules, such that it is irrelevant for listing the submodules.
The computation of the displaypath ('Entering <path>') is done
separately there.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c |  5 +----
 git-submodule.sh            | 12 ++++++------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5295b72..6c3ff91 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -68,14 +68,11 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	struct module_list list = MODULE_LIST_INIT;
 
 	struct option module_list_options[] = {
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("alternative anchor for relative paths")),
 		OPT_END()
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
+		N_("git submodule--helper list [<path>...]"),
 		NULL
 	};
 
diff --git a/git-submodule.sh b/git-submodule.sh
index d83608c..2dd1b18 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -407,7 +407,7 @@ cmd_foreach()
 	# command in the subshell (and a recursive call to this function)
 	exec 3<&0
 
-	git submodule--helper list --prefix "$wt_prefix"|
+	git submodule--helper list |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -467,7 +467,7 @@ cmd_init()
 		shift
 	done
 
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	git -C "$wt_prefix" submodule--helper list "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -549,7 +549,7 @@ cmd_deinit()
 		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
 	fi
 
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	git -C "$wt_prefix" submodule--helper list "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -683,7 +683,7 @@ cmd_update()
 	fi
 
 	cloned_modules=
-	git submodule--helper list --prefix "$wt_prefix" "$@" | {
+	git -C "$wt_prefix" submodule--helper list "$@" | {
 	err=
 	while read mode sha1 stage sm_path
 	do
@@ -1121,7 +1121,7 @@ cmd_status()
 		shift
 	done
 
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	git -C "$wt_prefix" submodule--helper list "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -1199,7 +1199,7 @@ cmd_sync()
 		esac
 	done
 	cd_to_toplevel
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	git -C "$wt_prefix" submodule--helper list "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-- 
2.8.0.rc4.10.g52f3f33.dirty
