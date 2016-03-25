From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 1/5] submodule: prepare recursive path from non root directory
Date: Fri, 25 Mar 2016 11:39:12 -0700
Message-ID: <1458931156-29125-2-git-send-email-sbeller@google.com>
References: <1458931156-29125-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, Jens.Lehmann@web.de, jacob.keller@gmail.com,
	sunshine@sunshineco.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 25 19:39:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWdp-0005FI-WD
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbcCYSjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:39:22 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34178 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbcCYSjV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:39:21 -0400
Received: by mail-pa0-f51.google.com with SMTP id fe3so51250594pab.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oAbHdOF9IvQANUX6RgvzFOOwcwshpMfzarKOv3muJNo=;
        b=fM/tobOqTSt9czEgpzfugvtEX3N7vgKTR+GW4CH9lzPjHHNJ7EF6kh76JaeYoXraUH
         DTN60iPbc9HjKHh+uzGNh3s4sT226QIkn17bndg1A9Dt95J/2sfHvK39nr8yeXFYxtN4
         PlLplEN7oe5wI8JE8WYhEO/AYXXGmztvej+1fAMp2H/TDgnjuiaIBkgbH3y/GpH9TgWY
         ZKewD9imAGOdcJOlHuYl0XVmCX5XOst0LN/NWTRACDVRKtBgMn+WZzRnCbY2RAHcLPDy
         VWS3U7ZPg6iTFfnWpEX2as3yECA7rw60Qu4tlWL7QXfoQwkVsZTFB+Qa1Nr/h9jF8pAT
         VE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oAbHdOF9IvQANUX6RgvzFOOwcwshpMfzarKOv3muJNo=;
        b=jrLmqvi2HLn9fxmlmxxjpg9I0qxwIGNKDIyztzpJuNYMBdoLUNrPsYe/+d6yIjSYP/
         QhfbF1KSaX2HbvnKa2crnXmkxB2n+0DUDjILSiKRUAKdAIzl2lyy9ubj+1I9KtZ3XZK+
         l4/MQRo1zoc+dVQcq/R5IC9HppZBbve5s0DvxLn9sUORb/Nfgm8q2cOFQiwdTHbLknjL
         nc580hr9mAv4XBxlqcekclbXQJ1haZoVAc8oPyn5Oi0LORlDsG4xzZkFg+QHHN5CD4iN
         A2tfk1kJzFG2XQI4mAsH1djXtxAPZkcZ8nPjNub0E6dHc+6n+ZpusG2JOlOXC25fclrG
         IDmQ==
X-Gm-Message-State: AD7BkJL37/p8TMk1icKVNpEzv2OwLauN6bAE8OFrOps/n8JeMQi6dI8rK8cJBPcuj/Ie+Wxd
X-Received: by 10.66.147.74 with SMTP id ti10mr23449647pab.128.1458931160463;
        Fri, 25 Mar 2016 11:39:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e4a5:c9cf:82bb:5195])
        by smtp.gmail.com with ESMTPSA id r68sm17959451pfb.51.2016.03.25.11.39.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Mar 2016 11:39:19 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.10.g52f3f33.dirty
In-Reply-To: <1458931156-29125-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289940>

One of the first things that happens in most submodule sub commands is

    git submodule--helper list --prefix "$wt_prefix"

Currently the passed --prefix is used for doing path calculation
as if we were in that path relative to the repository root, which is
why we need to pass "$wt_prefix". A more common way in Git however
would be to use

    git -C "$wt_prefix" submodule--helper list

which I want to change to later as it is easier to understand for
readers of the code base. That way however does not just pass the
prefix into the submodule command, but also changes into that
directory. Say you have the following setup:

    repo/ # a superproject repository
    repo/untracked/ # an untracked dir in repo/
    repo/sub/ # a submodule
    repo/sub/subsub # a submodule of a submodule

When in repo/untracked/ and invoking "git submodule status --recursive",
the recursed instance of the latter version for listing submodules would
try to change into the directory repo/sub/untracked, which is a bug.
This happens as we cd into the submodule in git-submodule.sh without
clearing wt_prefix, which is the assumed relative path inside the working
directory.

Most times that directory doesn't exist and we error out. Fix this potential
bug by clearing wt_prefix, such that any recursive instances of will assume
to operate from the root of the respective submodule.

When changing wt_prefix, we need to make sure the reported paths stay
correct, as paths are reported relative to the wt_prefix. We can fix
this by computing the relative path before changing the wt_prefix.

As we do not pass in filenames or pathspecs into submodules recursively,
we do not need to care about filenames being relative to wt_prefix,
so fixing the display path for error reporting is the only thing we
need to do.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 43c68de..d83608c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -825,8 +825,9 @@ Maybe you want to use 'update --init'?")"
 		if test -n "$recursive"
 		then
 			(
-				prefix="$prefix$sm_path/"
+				prefix="$(relative_path $prefix$sm_path)/"
 				clear_local_git_env
+				wt_prefix=
 				cd "$sm_path" &&
 				eval cmd_update
 			)
@@ -1159,6 +1160,7 @@ cmd_status()
 			(
 				prefix="$displaypath/"
 				clear_local_git_env
+				wt_prefix=
 				cd "$sm_path" &&
 				eval cmd_status
 			) ||
@@ -1239,7 +1241,8 @@ cmd_sync()
 
 				if test -n "$recursive"
 				then
-					prefix="$prefix$sm_path/"
+					prefix=$(relative_path "$prefix$sm_path/")
+					wt_prefix=
 					eval cmd_sync
 				fi
 			)
-- 
2.8.0.rc4.10.g52f3f33.dirty
