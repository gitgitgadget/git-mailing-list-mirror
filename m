From: Steven Penny <svnpenn@gmail.com>
Subject: Re: [PATCH 2/2] git-sh-setup: work around Cygwin path handling gotchas
Date: Wed, 16 May 2012 13:51:27 -0500
Message-ID: <CAAXzdLW5VYnHc41WZ0id=4Qe17dHSj4+J9tqVvG-PvtpXLmh+Q@mail.gmail.com>
References: <4FB09FF2.70309@viscovery.net>
	<1337191208-21110-1-git-send-email-gitster@pobox.com>
	<1337191208-21110-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 16 20:51:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUjJu-0004xE-9D
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 20:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760389Ab2EPSv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 14:51:29 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49026 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab2EPSv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 14:51:28 -0400
Received: by yenm10 with SMTP id m10so1015381yen.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 11:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HE99WVS+pD3JVLOHaFdEy/unungqfSzMpPp7c1bykTw=;
        b=Qyq+43lqVt2oJ2tEtMztdvmctaw4qAMxJuJbPNmguA62Z7Lq1iaDm1OjRHQgoGRQE6
         TnQWgniZ9Iqo9V7QhBLUfGif5DrZqh6oZ0ufwNkpDTx1YVWtnKDyhFRdCV7bAFxpnfAF
         GUUWj6v1j5Xvc/QAC6zXaHstacABt2qXDl3CKCZXV5pTWPZFyzueyXJnjCGRAF5jEokm
         f2p014zrLM5Tf1ei/yLclgF+dFdvLMgtd0fNKmrxv2N3ptteoX2oAMgU4aqIiWqMx/C5
         gJRJtqDtS6Lvdo1gEBSYb/0LgtBmGH8uTcNYBa86NdS3tp0gm4ZIftkbS88q125eIlRy
         BB1Q==
Received: by 10.42.80.19 with SMTP id t19mr2416347ick.55.1337194287157; Wed,
 16 May 2012 11:51:27 -0700 (PDT)
Received: by 10.231.69.140 with HTTP; Wed, 16 May 2012 11:51:27 -0700 (PDT)
In-Reply-To: <1337191208-21110-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197891>

Junio C Hamano wrote:
> +*CYGWIN*)
> +       pwd () {
> +               builtin cygpath -m
> +       }
> +       ;;

Ok I got it!

The problem is twofold

1. Ramsay Jones	was right, it needs to be called like

	cygpath -m "$PWD"

2. The Cygwin "pwd" (and quite possibly MinGW "pwd") needs to be defined
   **before** it is called

diff -u a/git-sh-setup.sh b/git-sh-setup.sh
--- a/git-sh-setup.sh	2012-05-16 13:48:43.160399300 -0500
+++ b/git-sh-setup.sh	2012-05-16 13:50:29.465479600 -0500
@@ -218,26 +218,6 @@
 	unset $(git rev-parse --local-env-vars)
 }

-# Make sure we are in a valid repository of a vintage we understand,
-# if we require to be in a git repository.
-if test -z "$NONGIT_OK"
-then
-	GIT_DIR=$(git rev-parse --git-dir) || exit
-	if [ -z "$SUBDIRECTORY_OK" ]
-	then
-		test -z "$(git rev-parse --show-cdup)" || {
-			exit=$?
-			echo >&2 "You need to run this command from the toplevel of the
working tree."
-			exit $exit
-		}
-	fi
-	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
-		echo >&2 "Unable to determine absolute path of git directory"
-		exit 1
-	}
-	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
-fi
-
 # Fix some commands on Windows
 case $(uname -s) in
 *MINGW*)
@@ -260,6 +240,11 @@
 		return 1
 	}
 	;;
+*CYGWIN*)
+	pwd () {
+		cygpath -m "$PWD"
+	}
+	;;
 *)
 	is_absolute_path () {
 		case "$1" in
@@ -269,3 +254,23 @@
 		return 1
 	}
 esac
+
+# Make sure we are in a valid repository of a vintage we understand,
+# if we require to be in a git repository.
+if test -z "$NONGIT_OK"
+then
+	GIT_DIR=$(git rev-parse --git-dir) || exit
+	if [ -z "$SUBDIRECTORY_OK" ]
+	then
+		test -z "$(git rev-parse --show-cdup)" || {
+			exit=$?
+			echo >&2 "You need to run this command from the toplevel of the
working tree."
+			exit $exit
+		}
+	fi
+	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
+		echo >&2 "Unable to determine absolute path of git directory"
+		exit 1
+	}
+	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
+fi
