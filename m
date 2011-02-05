From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] sha1_object_info: examine cached_object store too
Date: Sat,  5 Feb 2011 21:03:02 +0700
Message-ID: <1296914582-619-2-git-send-email-pclouds@gmail.com>
References: <1296914582-619-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 15:04:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plikr-0001yO-9g
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 15:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab1BEOEj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Feb 2011 09:04:39 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56182 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab1BEOEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 09:04:38 -0500
Received: by mail-pw0-f46.google.com with SMTP id 3so615542pwj.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 06:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=LTlrZDtnpnIHoM0QJMqTtoO6SzIFjcwUxUUlR/yyGQE=;
        b=pbOSEKwHma5n0QXt1tXFm0yrrPCUvQHeccGLkSZJuRREJvGz8BGFAXbnPEKBG/QMcB
         iqK5oMCO7yXqQysFROXeLoZsZFu7wYCB+hYJzrnkpf5mJJr9H2u3hMZzeHW0OBEoeg3d
         XZbB927d455ofp2w6VhGMvc3fhl7qRNuAoN7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YpZxedZFjnuS9AR9AGzzkFX2z/6xWMv+CcbUvDQ/6mR5FeIWARmWe8oYx7ycbU1tjE
         HQVwgMhf1C63/018Sk5M5bEift5ZHeXgO5OGgZuO5OyBz2UQsjMkuk18oJedZxYeJ89M
         W12cyGFejS3akPb+Zam+bA6NngX8BnsGj3PBs=
Received: by 10.142.144.2 with SMTP id r2mr584875wfd.244.1296914677989;
        Sat, 05 Feb 2011 06:04:37 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id q13sm2619838wfc.5.2011.02.05.06.04.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 06:04:37 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 05 Feb 2011 21:03:10 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1296914582-619-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166092>

Cached object store was added in d66b37b (Add pretend_sha1_file()
interface. - 2007-02-04) as a way to temporarily inject some objects
to object store.

But only read_sha1_file() knows about this store. While it will return
an object from this store, sha1_object_info() will happily say
"object not found".

Teach sha1_object_info() about the cached store for consistency.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 "git mktree" does not accept empty tree as it should do because of thi=
s.

 sha1_file.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9fd7e16..0b830c8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2020,9 +2020,17 @@ static int sha1_loose_object_info(const unsigned=
 char *sha1, unsigned long *size
=20
 int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 {
+	struct cached_object *co;
 	struct pack_entry e;
 	int status;
=20
+	co =3D find_cached_object(sha1);
+	if (co) {
+		if (sizep)
+			*sizep =3D co->size;
+		return co->type;
+	}
+
 	if (!find_pack_entry(sha1, &e)) {
 		/* Most likely it's a loose object. */
 		status =3D sha1_loose_object_info(sha1, sizep);
--=20
1.7.3.4.878.g439c7
