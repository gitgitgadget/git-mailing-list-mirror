From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] submodule: fix recursive path printing from non root directory
Date: Thu, 24 Mar 2016 16:34:25 -0700
Message-ID: <1458862468-12460-2-git-send-email-sbeller@google.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, Jens.Lehmann@web.de, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 25 00:34:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajEm5-0005ha-Np
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 00:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbcCXXem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 19:34:42 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36136 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbcCXXel (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 19:34:41 -0400
Received: by mail-pf0-f170.google.com with SMTP id u190so69617176pfb.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 16:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ViIO/lkqUV1i/FT5rUjOP2U9APKdc7d4UQOHXflrYkk=;
        b=QVPhGIrHH90YB01/SWTgls1XvT7MZm1uF6FOq5CtZ92CHfFZT5ztcx2z3nMbyWRy/5
         7lXzMVFYsl27Qv9ESGwSGC6RhYR5hM0TVTmHnMdb0QpfKhBxwFqb6mA6wILZLZDhFM/T
         HdRhc+pIvR2bhlBeTghGADwSZRiZzLQh1iyMJ3ttmwutOgQFmhkf8hJYHQld+cKVDas2
         CpU1ZUU58LWzQPYJ5e3/vQO8Ict7bmE7HIc1SedOpPQVi2BJLi0Uad9MQpkQtRGuotbU
         T33AC79KCIRzVD7U8zbsfWLgQWNQdnERlwJvz1j/1SDBHPv/TN6qPji9Ez7X0GupVN86
         LYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ViIO/lkqUV1i/FT5rUjOP2U9APKdc7d4UQOHXflrYkk=;
        b=fBU8zr3zcTjSZvEn8OoHZ//EaZxk89/4Aoe4ei6Ik9IrFPTkyqYUCH9yGriqBMQDtn
         yBXKLQ6XmNEu1gbWVHuS5ofk+WrFLjrIuu8ExlxZkSCy2sTrmEQQGgy4cLPo4w3PgAfc
         2Wot2HCuX598ImlMKyvbv8Sz1dXf011ByheaIBJdROGr2sBFyrE1deJfni9cOfO2XZab
         AFgIAjlRzh6CkBhFE3CyRPyK+dv5GuAOTG2eoVtKBcHjKVrn04UdRSTd9EGTKH+eb+F2
         s98r5GEzLzg1GE6US0ePBpOxNjwDps5MIJwBMsLw2nk/PATIg4bnIRd0fUUGhBGK3053
         vROw==
X-Gm-Message-State: AD7BkJLGTmM7/p0yHiN22JydTIYLMgJq8h5px9f3VCa435frE6xQct/I/Uun7/h7Uo0wfNWV
X-Received: by 10.98.74.200 with SMTP id c69mr16426568pfj.129.1458862480871;
        Thu, 24 Mar 2016 16:34:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a88b:7b22:8e5b:edac])
        by smtp.gmail.com with ESMTPSA id 82sm12384149pfi.78.2016.03.24.16.34.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 16:34:40 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.10.g52f3f33
In-Reply-To: <1458862468-12460-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289823>

Recursing into submodules currently works by just calling
(cd $submodule && eval <command>) for update, sync and status
command.

Say you have the following setup

repo/ # a superproject repository
repo/untracked/ # an untracked dir in repo/
repo/sub/ # a submodule
repo/sub/subsub # a submodule of a submodule

When being in repo/untracked/ and invoking "git submodule status"
you would expect output like:

    repo/untracked/$ git submodule status --recursive
     <sha1> ../sub (version)
     <sha1> ../sub/subsub (<version>)

We need to take into account that we are in the untracked/ dir,
so we need to prepend ../ to the paths. By using relative_path
to compute the prefix, we'll have that output.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 43c68de..536ba68 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -825,7 +825,7 @@ Maybe you want to use 'update --init'?")"
 		if test -n "$recursive"
 		then
 			(
-				prefix="$prefix$sm_path/"
+				prefix="$(relative_path $prefix$sm_path)/"
 				clear_local_git_env
 				cd "$sm_path" &&
 				eval cmd_update
@@ -1233,13 +1233,13 @@ cmd_sync()
 			then
 			(
 				clear_local_git_env
+				prefix=$(relative_path "$prefix$sm_path/")
 				cd "$sm_path"
 				remote=$(get_default_remote)
 				git config remote."$remote".url "$sub_origin_url"
 
 				if test -n "$recursive"
 				then
-					prefix="$prefix$sm_path/"
 					eval cmd_sync
 				fi
 			)
-- 
2.8.0.rc4.10.g52f3f33
