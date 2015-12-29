From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/20] upload-pack: glue code to use get_shallow_commits_by_rev_list
Date: Tue, 29 Dec 2015 19:10:29 +0700
Message-ID: <1451391043-28093-7-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:11:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt7o-0006NA-O7
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbbL2MLe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:11:34 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35805 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbbL2MLc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:11:32 -0500
Received: by mail-pa0-f46.google.com with SMTP id do7so4707970pab.2
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TRK4lYFcE7biseH3w+AL60z00VAKhyM9X9HbOAvh6vY=;
        b=MnTkzWruJ5W1fVNjWyiTp2vsmQzSw0GY+epO7t4MGXhYWU09Zc228CvbeCfVVx3OQn
         CrYsppuqyvKZifZkUxT7NTHjjkv/QHr6TstHY0K1VyLRnMg1hv50oNGDMm33GAhBG2vA
         wgumJTMnzeXNhs8n3vViGhJ+PFmBYW/pTVxmeDpuYs+UWCmTz6KYuGWc4r+cN6Qp8tQt
         e5rGMBQNzf0FhqQN9xGwIMErKMKxE6P8k8Kc3x6YWV3QUP+f/xhIcs7CiBF0DZjtlKJS
         85Lwrl4WpytupT/Z8/FgGqQc2MhV1OYvbCAzTLte/Q6z7gjpKaQAC5wPkKpcIOIAVzEy
         z1/A==
X-Received: by 10.66.254.100 with SMTP id ah4mr73104955pad.121.1451391091590;
        Tue, 29 Dec 2015 04:11:31 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id p17sm53947230pfi.54.2015.12.29.04.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:11:30 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:11:26 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283115>

The remaining thing to do is protocol extensions and translate the
requests to rev-list options.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index 4bb104c..9ae09a0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -599,6 +599,18 @@ static void deepen(int depth, const struct object_=
array *shallows)
 	packet_flush(1);
 }
=20
+static void deepen_by_rev_list(int ac, const char **av,
+			       struct object_array *shallows)
+{
+	struct commit_list *result;
+
+	result =3D get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALL=
OW);
+	send_shallow(result);
+	free_commit_list(result);
+	send_unshallow(shallows);
+	packet_flush(1);
+}
+
 static void receive_needs(void)
 {
 	struct object_array shallows =3D OBJECT_ARRAY_INIT;
--=20
2.3.0.rc1.137.g477eb31
