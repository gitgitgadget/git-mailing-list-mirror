From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] archive: do not read .gitattributes in working
 directory
Date: Mon, 13 Apr 2009 22:11:13 -0700
Message-ID: <7vk55nakge.fsf@gitster.siamese.dyndns.org>
References: <1239260490-6318-1-git-send-email-pclouds@gmail.com>
 <1239260490-6318-2-git-send-email-pclouds@gmail.com>
 <1239260490-6318-3-git-send-email-pclouds@gmail.com>
 <1239260490-6318-4-git-send-email-pclouds@gmail.com>
 <7vws9u2ov4.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0904090353s4ec770bfk3cd3f6559c367a20@mail.gmail.com>
 <49E316CD.7030001@lsrfire.ath.cx> <49E32D9F.2050906@lsrfire.ath.cx>
 <49E33935.5090203@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 14 07:13:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtaxO-000860-BC
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 07:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbZDNFL1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2009 01:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbZDNFL0
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 01:11:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbZDNFLZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 01:11:25 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 78A36E052;
	Tue, 14 Apr 2009 01:11:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8C642E051; Tue,
 14 Apr 2009 01:11:20 -0400 (EDT)
In-Reply-To: <49E33935.5090203@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Mon, 13 Apr 2009 15:08:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B34853DC-28B2-11DE-B4BE-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116511>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Ren=C3=A9 Scharfe schrieb:
>>> I
>>> think it makes sense to create a separate script for the new tests =
and
>>> eventually move the existing archive attribute tests there.
>>=20
>> Something like this?
>
> I forgot to add tests against bare repositories.  Otherwise I'd notic=
ed
> earlier that read_attr() is only called for non-bare repositories
> currently, i.e. your patches won't allow reading of .gitattribute fil=
es
> from the tree in bare repos.

Curious.

Shouldn't the call chain look like:

    write_archive()
    ->write_archive_entries()
      ->unpack_trees() to read the tree into the in-core index
      ->git_attr_set_direction()
      ->read_tree_recursive()
        ->write_archive_entry()
          ->git_checkattr()

Ah, bootstrap_attr_stack() and prepare_attr_stack() still assume that y=
ou
won't be doing any per-level attributes in a bare repository because th=
e
concept of attributes is inherently tied to having a work tree from the=
ir
point of view.

How about this "mostly re-indent with four line removal" patch?

 attr.c |   48 ++++++++++++++++++++++--------------------------
 1 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/attr.c b/attr.c
index 37ca288..f5917de 100644
--- a/attr.c
+++ b/attr.c
@@ -468,13 +468,11 @@ static void bootstrap_attr_stack(void)
 		elem->prev =3D attr_stack;
 		attr_stack =3D elem;
=20
-		if (!is_bare_repository()) {
-			elem =3D read_attr(GITATTRIBUTES_FILE, 1);
-			elem->origin =3D strdup("");
-			elem->prev =3D attr_stack;
-			attr_stack =3D elem;
-			debug_push(elem);
-		}
+		elem =3D read_attr(GITATTRIBUTES_FILE, 1);
+		elem->origin =3D strdup("");
+		elem->prev =3D attr_stack;
+		attr_stack =3D elem;
+		debug_push(elem);
=20
 		elem =3D read_attr_from_file(git_path(INFOATTRIBUTES_FILE), 1);
 		if (!elem)
@@ -535,25 +533,23 @@ static void prepare_attr_stack(const char *path, =
int dirlen)
 	/*
 	 * Read from parent directories and push them down
 	 */
-	if (!is_bare_repository()) {
-		while (1) {
-			char *cp;
-
-			len =3D strlen(attr_stack->origin);
-			if (dirlen <=3D len)
-				break;
-			strbuf_reset(&pathbuf);
-			strbuf_add(&pathbuf, path, dirlen);
-			strbuf_addch(&pathbuf, '/');
-			cp =3D strchr(pathbuf.buf + len + 1, '/');
-			strcpy(cp + 1, GITATTRIBUTES_FILE);
-			elem =3D read_attr(pathbuf.buf, 0);
-			*cp =3D '\0';
-			elem->origin =3D strdup(pathbuf.buf);
-			elem->prev =3D attr_stack;
-			attr_stack =3D elem;
-			debug_push(elem);
-		}
+	while (1) {
+		char *cp;
+
+		len =3D strlen(attr_stack->origin);
+		if (dirlen <=3D len)
+			break;
+		strbuf_reset(&pathbuf);
+		strbuf_add(&pathbuf, path, dirlen);
+		strbuf_addch(&pathbuf, '/');
+		cp =3D strchr(pathbuf.buf + len + 1, '/');
+		strcpy(cp + 1, GITATTRIBUTES_FILE);
+		elem =3D read_attr(pathbuf.buf, 0);
+		*cp =3D '\0';
+		elem->origin =3D strdup(pathbuf.buf);
+		elem->prev =3D attr_stack;
+		attr_stack =3D elem;
+		debug_push(elem);
 	}
=20
 	/*
