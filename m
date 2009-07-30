From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: suppress 'Use of uninitialized value' error
Date: Thu, 30 Jul 2009 23:15:40 +0200
Message-ID: <1248988540-8971-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 23:15:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWcyU-00036M-8D
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 23:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbZG3VPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 17:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbZG3VPE
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 17:15:04 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:42806 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbZG3VOy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 17:14:54 -0400
Received: by fxm28 with SMTP id 28so931614fxm.17
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 14:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=H355vxqPo/27xBjYjB0iznjy8zcaSEqxlWuunNpJxts=;
        b=V7KGHkHbiwqvpY9DicRU01GV0qMS6AcjX/0F5tmhPHxHruK+SQwBeGQbRwymZradqr
         H7dYC4nAjoKwTokvcBZ0iHZlADwVzjLmglqCohA5uty9uXIn6m3sDBE3Z/V4Vmw2rtxY
         3u+btoMzWfQNK947DlXrfI4/7syLqOdN6tfs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wHvKtATq4iGMwFAX0zG2StQ0S8knHLccbnQlo/ldpuLuehdzVE3WiUIoSYkIKAczcL
         dD4b0esypGe0uIKUnB4BMY52HPGvEIVYsll9MCEUd3Y5unHBEuPBc+qJoerOgPjZ+ovM
         OGpSfVwLe6hmHxGbmJIPFneRAe68ARE2s61ns=
Received: by 10.103.241.15 with SMTP id t15mr1012019mur.1.1248988493825;
        Thu, 30 Jul 2009 14:14:53 -0700 (PDT)
Received: from localhost (host-78-15-19-142.cust-adsl.tiscali.it [78.15.19.142])
        by mx.google.com with ESMTPS id b9sm5947215mug.39.2009.07.30.14.14.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Jul 2009 14:14:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124483>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

The patch could have been a one-liner by adding the defined check at
line 943, but that pushed the line to 120 char, so I decided for this
slightly more complex form.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7fbd5ff..c7f257e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -940,10 +940,13 @@ sub href {
 			if (defined $params{'hash_parent_base'}) {
 				$href .= esc_url($params{'hash_parent_base'});
 				# skip the file_parent if it's the same as the file_name
-				delete $params{'file_parent'} if $params{'file_parent'} eq $params{'file_name'};
-				if (defined $params{'file_parent'} && $params{'file_parent'} !~ /\.\./) {
-					$href .= ":/".esc_url($params{'file_parent'});
-					delete $params{'file_parent'};
+				if (defined $params{'file_parent'}) {
+					if ($params{'file_parent'} eq $params{'file_name'}) {
+						delete $params{'file_parent'};
+					} else if ($params{'file_parent'} !~ /\.\./) {
+						$href .= ":/".esc_url($params{'file_parent'});
+						delete $params{'file_parent'};
+					}
 				}
 				$href .= "..";
 				delete $params{'hash_parent'};
-- 
1.6.3.rc1.192.gdbfcb
