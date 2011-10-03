From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] daemon: print "access denied" if a service does not work
Date: Tue,  4 Oct 2011 06:28:29 +1100
Message-ID: <1317670109-16919-1-git-send-email-pclouds@gmail.com>
References: <20111003111331.GA12707@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 21:28:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAoC5-000888-LS
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347Ab1JCT2s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 15:28:48 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48033 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250Ab1JCT2q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 15:28:46 -0400
Received: by yxl31 with SMTP id 31so3816730yxl.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 12:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FABkltRfBIV0gXpfgPvPueE8P7d9KZJYyZPZs6U9IW0=;
        b=k5/KMzL69PQxo4547xInW2NHCnsJgy+GbmLmAAJvWZOJfesdcWGnuEX5MIdD2DAXFP
         oGwkorUncV05QouPQBKN4dhlec73ZyDu39vWtALULxer26xPEg2xUUKlKmFXVd4IlpGX
         efMq8qzrcF42TWmL4uSJaX3lZp/36xFbhQlb8=
Received: by 10.236.184.198 with SMTP id s46mr2074969yhm.23.1317670126274;
        Mon, 03 Oct 2011 12:28:46 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id v28sm16714510yhi.11.2011.10.03.12.28.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 12:28:45 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 04 Oct 2011 06:28:32 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <20111003111331.GA12707@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182701>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Note that if a service fails, then "access denied" is printed too.
 Not sure if it's a good thing, the service in question may have
 responded to user already. On the other hand, this catches faults
 from start_command() in run_service_command().

 daemon.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
index 4c8346d..6552ca7 100644
--- a/daemon.c
+++ b/daemon.c
@@ -562,7 +562,10 @@ static int execute(void)
 			 * Note: The directory here is probably context sensitive,
 			 * and might depend on the actual service being performed.
 			 */
-			return run_service(line + namelen + 5, s);
+			if (!run_service(line + namelen + 5, s))
+				return 0;
+			packet_write(1, "ERR %s: access denied", line + namelen + 5);
+			return -1;
 		}
 	}
=20
--=20
1.7.3.1.256.g2539c.dirty
