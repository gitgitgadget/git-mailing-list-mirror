From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] instaweb: load Apache mime and dir modules if they are needed
Date: Tue, 2 Jan 2007 00:57:11 -0800
Message-ID: <20070102085711.GA28842@mayonaise.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 09:57:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1fSY-0000pb-1e
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 09:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998AbXABI5O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 03:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933001AbXABI5O
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 03:57:14 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58980 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932998AbXABI5N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 03:57:13 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 073EE2DC01A;
	Tue,  2 Jan 2007 00:57:11 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 02 Jan 2007 00:57:11 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35783>

I've noticed that Apache 2.2 on a Debian etch machine has
these compiled as modules.

Also set ServerName to avoid a warning at startup.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-instaweb.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 16cd351..08362f4 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -160,10 +160,20 @@ apache2_conf () {
 	test "$local" = true && bind='127.0.0.1:'
 	echo 'text/css css' > $fqgitdir/mime.types
 	cat > "$conf" <<EOF
+ServerName "git-instaweb"
 ServerRoot "$fqgitdir/gitweb"
 DocumentRoot "$fqgitdir/gitweb"
 PidFile "$fqgitdir/pid"
 Listen $bind$port
+EOF
+
+	for mod in mime dir; do
+		if test -e $module_path/mod_${mod}.so; then
+			echo "LoadModule ${mod}_module " \
+			     "$module_path/mod_${mod}.so" >> "$conf"
+		fi
+	done
+	cat >> "$conf" <<EOF
 TypesConfig $fqgitdir/mime.types
 DirectoryIndex gitweb.cgi
 EOF
-- 
Eric Wong
