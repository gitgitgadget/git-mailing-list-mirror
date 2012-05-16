From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] git-sh-setup: define workaround wrappers before they are
 used
Date: Wed, 16 May 2012 11:00:07 -0700
Message-ID: <1337191208-21110-2-git-send-email-gitster@pobox.com>
References: <4FB09FF2.70309@viscovery.net>
 <1337191208-21110-1-git-send-email-gitster@pobox.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Steven Penny <svnpenn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 20:01:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUiXY-0000YG-6A
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 20:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759629Ab2EPSBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 14:01:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61466 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757840Ab2EPSBb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 14:01:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F40DD824C;
	Wed, 16 May 2012 14:01:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=AgiA
	jIwixRknZxJOyTGeSmuNOis=; b=Tlr5zUJOyb0NuGZz6ys4WvvXAcuSwDeEhYDo
	xnv07kQKkSSsz+j9qe3K+SjK6Z9+S/AhjCXKZhAC9sg8K34T5PNnpTT+0duL3qAF
	GZjJAajYj+0KuTCBwciaeGUjxEaocOu0S4tzQur09RCwyGeeblTwUdKdNpflP2hw
	xkMa03M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Agja6Ec61JIx19lWsLazfDEvzUEz4z44XTcSMQ5GUZ+WkxB3XtaTtgj0UFlG8NT5
	P8Mopc4b587TbSo7zRKYK6hqOWcP//apeHT63144q4s3DFPjOFphPl+1aPyDx61E
	PPcwn+0A3jppqmirCdsf5eeb+1MSWqN4Y8DowXpbZhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA4AE824B;
	Wed, 16 May 2012 14:01:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E64658248; Wed, 16 May 2012
 14:01:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.2.537.g0ac6509
In-Reply-To: <1337191208-21110-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 280FA506-9F81-11E1-8F30-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197888>

Recently we tweaked this scriptlet to let mingw port redefine "pwd" to
always return Windows-style path, but the code to do so came after the
first use of "pwd" to set up $GIT_DIR shell variable.

Move the block to define these workaround wrappers, so that everything
everything that executes when the scriptlet is dot-sourced uses the
replacements.

Noticed-by: Ramsay Jones
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-sh-setup.sh | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 7b3ae75..770a86e 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -218,27 +218,8 @@ clear_local_git_env() {
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
-			echo >&2 "You need to run this command from the toplevel of the working tree."
-			exit $exit
-		}
-	fi
-	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
-		echo >&2 "Unable to determine absolute path of git directory"
-		exit 1
-	}
-	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
-fi
 
-# Fix some commands on Windows
+# Platform specific tweaks to work around some commands
 case $(uname -s) in
 *MINGW*)
 	# Windows has its own (incompatible) sort and find
@@ -269,3 +250,23 @@ case $(uname -s) in
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
+			echo >&2 "You need to run this command from the toplevel of the working tree."
+			exit $exit
+		}
+	fi
+	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
+		echo >&2 "Unable to determine absolute path of git directory"
+		exit 1
+	}
+	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
+fi
-- 
1.7.10.2.537.g0ac6509
