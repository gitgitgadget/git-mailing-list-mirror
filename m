From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/7] read-cache: refuse to create index referring to external objects
Date: Thu, 24 Jan 2013 15:42:19 +0700
Message-ID: <1359016940-18849-6-git-send-email-pclouds@gmail.com>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 09:43:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyIPS-00033B-DX
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 09:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab3AXInW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 03:43:22 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:64426 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab3AXInU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 03:43:20 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so5355048pad.2
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 00:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=90+ivkY2nbgoSIPorXudMMsddn7YeLGArKoZpWeC0zM=;
        b=T2/7jaVR+w7UODOmpQWkknwJwhECPQ2kyLEZA9ICAkF4elZB95HyQNSn3cdBSiCQUb
         EDb6sYF7Vesv9OXKpKF9W9YQ1Tf4rvDqueLHoH75SVueaCW6nOGz7WfY43xat36Jtjh1
         o9cTMoRGwQvQGRyFmDgm6jUd/0GD/P/Z4RqFMQ44lQz4egOL8fkyg9RtNbtHeTcr7b0p
         yOKUKsrOHMZ6dZuVuqVDBODRjQTXOXqWwJdMp6CvKy2TawwOyjFLVBotKlnA3KO5Myjs
         Xjg/mgSdRiu4HuU8N7PMc3g/tvvrfCFf8FFEcFP0bHYvx949TEEOhLTHFJmGsbBiaDXv
         hmEA==
X-Received: by 10.66.78.168 with SMTP id c8mr2855464pax.16.1359016999800;
        Thu, 24 Jan 2013 00:43:19 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id az8sm15307526pab.3.2013.01.24.00.43.16
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 00:43:19 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 24 Jan 2013 15:42:55 +0700
X-Mailer: git-send-email 1.8.0.rc3.18.g0d9b108
In-Reply-To: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214417>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index fda78bc..4579215 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1720,6 +1720,26 @@ static int ce_write_entry(git_SHA_CTX *c, int fd=
, struct cache_entry *ce,
 			      ce->name + common, ce_namelen(ce) - common);
 	}
=20
+	if (object_database_contaminated) {
+		struct object_info oi;
+		switch (ce->ce_mode) {
+		case S_IFGITLINK:
+			break;
+		case S_IFDIR:
+			if (sha1_object_info_extended(ce->sha1, &oi) !=3D OBJ_TREE ||
+			    (oi.alt && oi.alt->external))
+				die("cannot create index referring to an external tree %s",
+				    sha1_to_hex(ce->sha1));
+			break;
+		default:
+			if (sha1_object_info_extended(ce->sha1, &oi) !=3D OBJ_BLOB ||
+				    (oi.alt && oi.alt->external))
+				die("cannot create index referring to an external blob %s",
+				    sha1_to_hex(ce->sha1));
+			break;
+		}
+	}
+
 	result =3D ce_write(c, fd, ondisk, size);
 	free(ondisk);
 	return result;
--=20
1.8.0.rc3.18.g0d9b108
