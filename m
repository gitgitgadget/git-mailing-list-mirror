From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/16] do not use thin packs and subtree together (just a bad feeling about this)
Date: Sat, 31 Jul 2010 23:18:25 +0700
Message-ID: <1280593105-22015-17-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:39:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfOT0-0003Ct-JS
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553Ab0HACjy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:39:54 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49942 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0HACjx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:39:53 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so976843pzk.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=DOlz8TBooSZeLMx7XdzO6JGF2YAbKwBqZRKqSDZya4M=;
        b=J/Dz16nXLbKrtJ6sV5aPpdoNzLHujZa+guWg1zGHqwhW4I5FZuk15E0GO1H3kSVOqH
         4eMANGtJ4veq2AgPCrjhJnj4fG2/eayUoSUXz4zJgSUNNtLQnlu755son2QJTBWgb1CZ
         Nt0LrY82Kgek/wZlQtmahpzkd5XRwDMH7/D48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sgjFFzratnmdlGivoDvlPctLhd86Xj1SAQO3AfRYtSidz9stKmjy+wvMCUKrA8yFw9
         sWx2SXzlTmqbxV4GDtWxrqsCiYAvrC2zzs/1FZ6qJi934dxJx0bJU6aG7ZDj0PD3HiPq
         EyAit6cEaTLn7pzV2kAYaWotGN0s1RzMOjmG4=
Received: by 10.115.77.17 with SMTP id e17mr4827112wal.108.1280630393122;
        Sat, 31 Jul 2010 19:39:53 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id q6sm7705851waj.10.2010.07.31.19.39.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:39:52 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:20:45 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152363>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/send-pack.c |    2 ++
 upload-pack.c       |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 481602d..fb1ad2b 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -53,6 +53,8 @@ static int pack_objects(int fd, struct ref *refs, str=
uct extra_have_objects *ext
 	int i;
=20
 	i =3D 4;
+	if (core_subtree)
+		args->use_thin_pack =3D 0;
 	if (args->use_thin_pack)
 		argv[i++] =3D "--thin";
 	if (args->use_ofs_delta)
diff --git a/upload-pack.c b/upload-pack.c
index 9b6710a..c65a3cb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -581,6 +581,9 @@ static void receive_needs(void)
 	if (!use_sideband && daemon_mode)
 		no_progress =3D 1;
=20
+	if (core_subtree)
+		use_thin_pack =3D 0;
+
 	if (depth =3D=3D 0 && shallows.nr =3D=3D 0)
 		return;
 	if (depth > 0) {
--=20
1.7.1.rc1.69.g24c2f7
