From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/3] git-instaweb: Fix Apache environment variable passing
Date: Tue, 29 Jun 2010 21:44:59 -0500
Message-ID: <1277865900-25044-2-git-send-email-dpmcgee@gmail.com>
References: <1277865900-25044-1-git-send-email-dpmcgee@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>, Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 04:45:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTnIh-0007Hn-CY
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 04:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416Ab0F3CpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 22:45:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60666 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab0F3CpO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 22:45:14 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so365968iwn.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 19:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZqRd3AxI0S9rbhZPkT/a87G8JRSEvAVgU9oHoFN6S+Q=;
        b=ke+TH56WBvx2hSWxYFol/zOT2rcWG++hv9RmsK5E8zoceoUO/6FaHECAwPLOXQOLbr
         SDr9uIQePoBP3q0J9RJkSXm6KBZNodK7uMAcipa2g9+l2SeChJeGKt7a5ckA+ovMyaXE
         tpxSs4q+1Q97g+yvBm7YFfzLkxAM9fi4wC114=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lsWl6ubMxKEjFQwKIW+kyRWbEkfViKEvwuDLSguJMX1+ENXO4c5dgU08khCySAzLOq
         dOJq+MSoHjlwP/7GMvixJFiNFvvj9N2RtzVHvSpxIvJ1vQr3g56pgEMiJnZlC29MN7T/
         aSLJyFnkVsMoOi5wEuoAb1wjKnfraE/hRQ9mk=
Received: by 10.231.39.195 with SMTP id h3mr5661831ibe.71.1277865914540;
        Tue, 29 Jun 2010 19:45:14 -0700 (PDT)
Received: from localhost (adsl-76-193-181-63.dsl.chcgil.sbcglobal.net [76.193.181.63])
        by mx.google.com with ESMTPS id g8sm17492763ibb.17.2010.06.29.19.45.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Jun 2010 19:45:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1277865900-25044-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149938>

We were passing the non-existent GIT_EXEC_DIR through instead of the real
GIT_EXEC_PATH. In addition, these weren't being passed at all for CGI (non
mod_perl) execution so get them included there as well.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 git-instaweb.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index a01476a..1d349b8 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -314,7 +314,7 @@ PidFile "$fqgitdir/pid"
 Listen $bind$port
 EOF
 
-	for mod in mime dir log_config; do
+	for mod in mime dir env log_config; do
 		if test -e $module_path/mod_${mod}.so; then
 			echo "LoadModule ${mod}_module " \
 			     "$module_path/mod_${mod}.so" >> "$conf"
@@ -334,7 +334,7 @@ EOF
 		cat >> "$conf" <<EOF
 LoadModule perl_module $module_path/mod_perl.so
 PerlPassEnv GIT_DIR
-PerlPassEnv GIT_EXEC_DIR
+PerlPassEnv GIT_EXEC_PATH
 PerlPassEnv GITWEB_CONFIG
 <Location /gitweb.cgi>
 	SetHandler perl-script
@@ -364,6 +364,9 @@ EOF
 			echo "ScriptSock logs/gitweb.sock" >> "$conf"
 		fi
 		cat >> "$conf" <<EOF
+PassEnv GIT_DIR
+PassEnv GIT_EXEC_PATH
+PassEnv GITWEB_CONFIG
 AddHandler cgi-script .cgi
 <Location /gitweb.cgi>
 	Options +ExecCGI
-- 
1.7.1
