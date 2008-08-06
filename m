From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] tg.sh: Runtime tg-* command check
Date: Wed,  6 Aug 2008 09:49:24 +0200
Message-ID: <1218008964-27286-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 06 09:50:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQdmz-00023I-FG
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 09:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319AbYHFHtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 03:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbYHFHtb
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 03:49:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:35123 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbYHFHta (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 03:49:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1513234fgg.17
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2yS/GcI8WyM2FgI5uLYr/VR+EIZYSJjChO7QfutpbB4=;
        b=HC0kVEM/jPpLASK+qanX7dAiqetjrE+wRBJ8+fpv/MUV2+mX/fba1B00NDG8RbvMu3
         RETFnvz6ES9bYUEuwY6Zd+liweUkTJPZdAN8Kl8gPdFKla1uCC7UECDGClYHFMLWV197
         5xBYF8OrVzMt90kXxbuOmwr1OADAiT/Ig5++o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=i8q31IXhD34QQMoWCfhzQVW0IvB5j6g8YuAX0WEYbVwFFZcI8FEucxBcknDVf2TN7d
         qWlKJz3grbRlc9OdGeIIfUyMnVTDtom87+w9k9+fHoMp2dBqsPxKVY3VAwzVlkmS5W5N
         1WG3Rj53CRBiMrjQfXRwlvCfbYEZQNtv2KApg=
Received: by 10.103.198.20 with SMTP id a20mr1238622muq.56.1218008968610;
        Wed, 06 Aug 2008 00:49:28 -0700 (PDT)
Received: from localhost ( [217.234.68.119])
        by mx.google.com with ESMTPS id y2sm30650491mug.1.2008.08.06.00.49.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Aug 2008 00:49:27 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91489>

Check for tg commands at runtime, not the hard coded list inside tg.sh.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg.sh |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/tg.sh b/tg.sh
index 03a392b..179f0de 100644
--- a/tg.sh
+++ b/tg.sh
@@ -152,8 +152,21 @@ switch_to_base()
 do_help()
 {
 	if [ -z "$1" ] ; then
+		## Build available commands list for help output
+
+		cmds=
+		sep=
+		for cmd in "@cmddir@"/tg-*; do
+			! [ -r "$cmd" ] && continue
+			# strip directory part and "tg-" prefix
+			cmd="$(basename "$cmd")"
+			cmd="${cmd#tg-}"
+			cmds="$cmds$sep$cmd"
+			sep="|"
+		done
+
 		echo "TopGit v0.1 - A different patch queue manager"
-		echo "Usage: tg (create|delete|info|patch|summary|update|help) ..."
+		echo "Usage: tg ($cmds|help) ..."
 	elif [ -f "@sharedir@/tg-$1.txt" ] ; then
 		cat "@sharedir@/tg-$1.txt"
 	else
@@ -171,6 +184,8 @@ root_dir="$(git rev-parse --show-cdup)"; root_dir="${root_dir:-.}"
 setup_ours
 setup_hook "pre-commit"
 
+[ -d "@cmddir@" ] ||
+	die "No command directory: '@cmddir@'"
 
 ## Dispatch
 
@@ -186,12 +201,13 @@ case "$cmd" in
 help)
 	do_help "$1"
 	exit 1;;
-create|delete|info|patch|summary|update)
-	. "@cmddir@"/tg-$cmd;;
 --hooks-path)
 	# Internal command
 	echo "@hooksdir@";;
 *)
-	echo "Unknown subcommand: $cmd" >&2
-	exit 1;;
+	[ -r "@cmddir@"/tg-$cmd ] || {
+		echo "Unknown subcommand: $cmd" >&2
+		exit 1
+	}
+	. "@cmddir@"/tg-$cmd;;
 esac
-- 
tg: (e311d15..) t/auto-generate-command-list-for-tg.sh (depends on: master)
