From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] sha1_file: Show the the type and path to corrupt objects
Date: Thu, 10 Jun 2010 12:47:01 +0000
Message-ID: <1276174021-9544-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 10 14:47:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMhAX-0008Cl-So
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 14:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758890Ab0FJMrd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 08:47:33 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:64603 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab0FJMrc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 08:47:32 -0400
Received: by ewy23 with SMTP id 23so67762ewy.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 05:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=YXWJEJmA4YbozYqrzwXs856fJxvWVW3wuKzaGm+orGg=;
        b=PI6bjfSEJp1Jmx5FQhL4yeM3867zqEH1WnIMludFGYiGocJKakl/xgdMXX0JjAUmTT
         QtaG7VRRhWHh2rVzm19KJgQWH7oznthykQSgvx0pqKHIcxTIQaEyzg7mmNCWeVF6K1A2
         sFEN2pmf67xGtgwbBM/7otgqMa5nfeXYYedQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=jIPdw8HNbQIAgBVKFlFytHGuiSlrId+/vp2tm2HvaNXdGsOWyjs0EIg9PQIVDig1eM
         1KrNrKIbOadnzhWn5k9sVHnE3uQT6gJeA08OPyeZdOkjwMkmQrmHCrt58OZyw86JXYbz
         Is0RHYKmwroyqywUlYS87yN9HpjrR0uH/9wM4=
Received: by 10.213.35.18 with SMTP id n18mr125252ebd.10.1276174050734;
        Thu, 10 Jun 2010 05:47:30 -0700 (PDT)
Received: from localhost.localdomain ([188.110.74.26])
        by mx.google.com with ESMTPS id 16sm4757117ewy.7.2010.06.10.05.47.28
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 10 Jun 2010 05:47:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148863>

Change the error message that's displayed when we encounter corrupt
objects to be more specific. We now print the type (loose or packed)
of corrupted objects, along with the full path to the file in
question.

Before:

    $ git cat-file blob 909ef997367880aaf2133bafa1f1a71aa28e09df
    fatal: object 909ef997367880aaf2133bafa1f1a71aa28e09df is corrupted

After:

    $ git cat-file blob 909ef997367880aaf2133bafa1f1a71aa28e09df
    fatal: loose object 909ef997367880aaf2133bafa1f1a71aa28e09df (store=
d in .git/objects/90/9ef997367880aaf2133bafa1f1a71aa28e09df) is corrupt=
ed

Knowing the path helps to quickly analyze what's wrong:

    $ file .git/objects/90/9ef997367880aaf2133bafa1f1a71aa28e09df
    .git/objects/90/9ef997367880aaf2133bafa1f1a71aa28e09df: empty

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 sha1_file.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d8e61a6..98e61b1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2084,6 +2084,7 @@ void *read_sha1_file_repl(const unsigned char *sh=
a1,
 {
 	const unsigned char *repl =3D lookup_replace_object(sha1);
 	void *data =3D read_object(repl, type, size);
+	char *path;
=20
 	/* die if we replaced an object with one that does not exist */
 	if (!data && repl !=3D sha1)
@@ -2091,8 +2092,16 @@ void *read_sha1_file_repl(const unsigned char *s=
ha1,
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
=20
 	/* legacy behavior is to die on corrupted objects */
-	if (!data && (has_loose_object(repl) || has_packed_and_bad(repl)))
-		die("object %s is corrupted", sha1_to_hex(repl));
+	if (!data) {
+		if (has_loose_object(repl)) {
+			path =3D sha1_file_name(sha1);
+			die("loose object %s (stored in %s) is corrupted", sha1_to_hex(repl=
), path);
+		}
+		if (has_packed_and_bad(repl)) {
+			path =3D sha1_pack_name(sha1);
+			die("packed object %s (stored in %s) is corrupted", sha1_to_hex(rep=
l), path);
+		}
+	}
=20
 	if (replacement)
 		*replacement =3D repl;
--=20
1.7.1.251.g92a7.dirty
