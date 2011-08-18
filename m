From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] fetch-pack: check for valid commit from server
Date: Thu, 18 Aug 2011 20:36:03 +0700
Message-ID: <1313674563-12755-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 15:36:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu2le-0000gp-RX
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 15:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204Ab1HRNgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 09:36:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63580 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab1HRNgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 09:36:11 -0400
Received: by gya6 with SMTP id 6so1461385gya.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 06:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=77bbUD6TpvrvS4MD6HSw/vIk8eDV8msmVZdcJbwiI3w=;
        b=OuawNXsfM/RWhcDVPNReaqDngu33VldvqHaIxiLygslJ2ocsSlQVhniOnNtOAiZ7t7
         eOpG6H2ha+MxjXUTCdbnj5tDOAYhPkcf8BMhsSL2Y9y9FdnGJ+K9yoSYzTWhuyxols/w
         PVAfcgf8PSOL68U1O4iM3Q4fMR5ISkhyVG894=
Received: by 10.143.20.12 with SMTP id x12mr436104wfi.105.1313674570749;
        Thu, 18 Aug 2011 06:36:10 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id l10sm1482022pbl.62.2011.08.18.06.36.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 06:36:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 18 Aug 2011 20:36:04 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179596>

A malicious server can return ACK with non-existent SHA-1 or not a
commit. lookup_commit() in this case may return NULL. Do not let
fetch-pack crash by accessing NULL address in this case.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
  However it raises another question, what if the other end returns a
  valid commit, but not the one in "have" line fetch-pack sent? Are we
  OK with that?

 builtin/fetch-pack.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4367984..3c871c2 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -395,6 +395,8 @@ static int find_common(int fd[2], unsigned char *re=
sult_sha1,
 				case ACK_continue: {
 					struct commit *commit =3D
 						lookup_commit(result_sha1);
+					if (!commit)
+						die("invalid commit %s", sha1_to_hex(result_sha1));
 					if (args.stateless_rpc
 					 && ack =3D=3D ACK_common
 					 && !(commit->object.flags & COMMON)) {
--=20
1.7.4.74.g639db
