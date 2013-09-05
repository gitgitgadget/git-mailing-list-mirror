From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] pathspec: catch prepending :(prefix) on pathspec with short magic
Date: Thu,  5 Sep 2013 10:40:38 +0700
Message-ID: <1378352440-25410-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 05:37:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHQO5-0007c4-2F
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 05:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab3IEDhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Sep 2013 23:37:36 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:61502 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab3IEDhf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 23:37:35 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so1315567pab.20
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 20:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=8qATs+ygXuCYOiNosQjTMlZ0jTLbvOP5RiCx8tPLy8M=;
        b=J4opGUt3uidnm5ssmKF4u+DS3XREj4kRdYMjsQMG7u9hLqrmG9xXwWRDviQoT6MCc6
         xhiCUYtURPYEwiMsZ2PCTkXjRqCo3m1VlkpYwu3PEakzUWebGwSLZrAWT7PMldhaIA1Z
         HfNckwwYe+UeOlD9AjamAyVe2EryciBU3dOYrZUGv4OFIQ2SbcziE7kiYCM+YS+JTuLY
         vckB3GOp+IKb0ZXQdwGhudx1QS9CodC1HyGwZuKpo55kk1deGoujyXo7ByjiQA4UpVcj
         SwhPClHv1ezT/U6Ap1rJ3zGPX3tRiU79O+A669hXh0N0u8MCDpW2/kJ2r4mPvAgEZpba
         Hi/Q==
X-Received: by 10.66.142.107 with SMTP id rv11mr7035731pab.17.1378352255139;
        Wed, 04 Sep 2013 20:37:35 -0700 (PDT)
Received: from lanh ([115.73.237.243])
        by mx.google.com with ESMTPSA id gg10sm16332900pbc.46.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Sep 2013 20:37:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Sep 2013 10:40:41 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233885>

:(prefix) is in the long form. Suppose people pass :!foo with '!'
being the short form of magic 'bar', the code will happily turn it to
:(prefix..)!foo, which makes '!' part of the path and no longer a magic=
=2E

The correct form must be ':(prefix..,bar)foo', but as so far we
haven't had any magic in short form yet (*), the code to convert from
short form to long one will be inactive anyway. Let's postpone it
until a real short form magic appears.

(*) The short form magic '/' is a special case and won't be caught by
this die(), which is correct. When '/' magic is detected, prefixlen is
set back to 0 and the whole "if (prefixlen..)" block is skipped.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fixes on top of nd/magic-pathspec.

 pathspec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index d9f4143..62fde50 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -231,7 +231,9 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 		const char *start =3D elt;
 		if (prefixlen && !literal_global) {
 			/* Preserve the actual prefix length of each pattern */
-			if (long_magic_end) {
+			if (short_magic)
+				die("BUG: prefixing on short magic is not supported");
+			else if (long_magic_end) {
 				strbuf_add(&sb, start, long_magic_end - start);
 				strbuf_addf(&sb, ",prefix:%d", prefixlen);
 				start =3D long_magic_end;
--=20
1.8.2.83.gc99314b
