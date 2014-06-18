From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v2] git-am: support any number of signatures
Date: Wed, 18 Jun 2014 07:34:29 +0300
Message-ID: <1403065765-22598-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 06:34:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx7Za-0000YM-2l
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 06:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbaFREeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 00:34:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54220 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbaFREeE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 00:34:04 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5I4Y2bh030030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2014 00:34:02 -0400
Received: from redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5I4Y0Bp031521;
	Wed, 18 Jun 2014 00:34:00 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251967>

I'm using different signature tags for git am depending on the patch,
project and other factors.

Sometimes I add multiple tags as well, e.g. QEMU
wants both Reviewed-by and Signed-off-by tags.

This patch makes it easy to do so:
1.  new parameter am.signoff can be used any number
	of times:

[am]
	signoff = "Reviewed-by: Michael S. Tsirkin <mst@redhat.com>"

	Will add reviewed by tag in addition to the S.O.B.
	if set all signatures are picked up when git am -s is used.

2.  Any number of alternative signatures

[am "a"]
	signoff = "Acked-by: Michael S. Tsirkin <mst@redhat.com>"
[am "t"]
	signoff = "Tested-by: Michael S. Tsirkin <mst@redhat.com>"

	if set the signature type can be specified by passing
	a parameter to the -s flag:

	git am -sa

A combination is supported:
	git am -sa -st

No docs or tests, sorry, so not yet ready for master, but I'm using this
all the time without any issues so maybe ok for pu.
Early flames/feedback/help welcome.

Changes from v1:
	Address Junio's feedback:
	Default signature is always applied.
	This is to make it a no-brainer for people to track using DCO.
	De-duplication fixed (works for default signature only
	as other signatures might make sense multiple times).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 git-am.sh | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index ee61a77..c1246e6 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -13,7 +13,7 @@ i,interactive   run interactively
 b,binary*       (historical option -- no-op)
 3,3way          allow fall back on 3way merging if needed
 q,quiet         be quiet
-s,signoff       add a Signed-off-by line to the commit message
+s,signoff?      add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
 keep-non-patch  pass -b flag to git-mailinfo
@@ -383,6 +383,7 @@ then
     keepcr=t
 fi
 
+signoffs=
 while test $# != 0
 do
 	case "$1" in
@@ -394,8 +395,15 @@ it will be removed. Please do not use it anymore."
 		;;
 	-3|--3way)
 		threeway=t ;;
-	-s|--signoff)
-		sign=t ;;
+	--signoff)
+		sign=t
+		s=$(git config --get-all am.signoff)
+		signoffs=("${signoffs[@]}" "${s[@]}") ;;
+	--signoff=*)
+		sign=t
+		a="${1#--signoff=}"
+		s=$(git config --get-all am."${a}".signoff)
+		signoffs=("${signoffs[@]}" "${s[@]}") ;;
 	-u|--utf8)
 		utf8=t ;; # this is now default
 	--no-utf8)
@@ -642,6 +650,16 @@ then
 	threeway=t
 fi
 git_apply_opt=$(cat "$dotest/apply-opt")
+EXTRA_SIGNOFFS=
+for ack in "${signoffs[@]}"; do
+	if test "$EXTRA_SIGNOFFS"
+	then
+		EXTRA_SIGNOFFS=$(printf "%s\n%s" "$SIGNOFF" "$ack")
+	else
+		EXTRA_SIGNOFFS="$ack"
+	fi
+done
+
 if test "$(cat "$dotest/sign")" = t
 then
 	SIGNOFF=$(git var GIT_COMMITTER_IDENT | sed -e '
@@ -744,13 +762,13 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."
 		    "$dotest/msg-clean" |
 		    sed -ne '$p'
 		)
-		ADD_SIGNOFF=$(
+		ADD_SIGNOFF="$EXTRA_SIGNOFFS"$(
 		    test "$LAST_SIGNED_OFF_BY" = "$SIGNOFF" || {
 		    test '' = "$LAST_SIGNED_OFF_BY" && echo
 		    echo "$SIGNOFF"
 		})
 	    else
-		ADD_SIGNOFF=
+		ADD_SIGNOFF="$EXTRA_SIGNOFFS"
 	    fi
 	    {
 		if test -s "$dotest/msg-clean"
-- 
MST
