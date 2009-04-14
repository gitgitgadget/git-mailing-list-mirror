From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 3/3] archive: do not read .gitattributes in working
 directory
Date: Tue, 14 Apr 2009 23:15:36 +0200
Message-ID: <49E4FCF8.3050207@lsrfire.ath.cx>
References: <1239260490-6318-1-git-send-email-pclouds@gmail.com> <1239260490-6318-2-git-send-email-pclouds@gmail.com> <1239260490-6318-3-git-send-email-pclouds@gmail.com> <1239260490-6318-4-git-send-email-pclouds@gmail.com> <7vws9u2ov4.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0904090353s4ec770bfk3cd3f6559c367a20@mail.gmail.com> <49E316CD.7030001@lsrfire.ath.cx> <49E32D9F.2050906@lsrfire.ath.cx> <49E33935.5090203@lsrfire.ath.cx> <7vk55nakge.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 23:17:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltq0Z-0002Y9-Hb
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 23:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbZDNVPx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2009 17:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754435AbZDNVPx
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 17:15:53 -0400
Received: from india601.server4you.de ([85.25.151.105]:35380 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbZDNVPw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 17:15:52 -0400
Received: from [10.0.1.101] (p57B7E023.dip.t-dialin.net [87.183.224.35])
	by india601.server4you.de (Postfix) with ESMTPSA id B4DC42F8056;
	Tue, 14 Apr 2009 23:15:50 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vk55nakge.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116575>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Ren=C3=A9 Scharfe schrieb:
>>>> I
>>>> think it makes sense to create a separate script for the new tests=
 and
>>>> eventually move the existing archive attribute tests there.
>>> Something like this?
>> I forgot to add tests against bare repositories.  Otherwise I'd noti=
ced
>> earlier that read_attr() is only called for non-bare repositories
>> currently, i.e. your patches won't allow reading of .gitattribute fi=
les
>> from the tree in bare repos.
>=20
> Curious.
>=20
> Shouldn't the call chain look like:
>=20
>     write_archive()
>     ->write_archive_entries()
>       ->unpack_trees() to read the tree into the in-core index
>       ->git_attr_set_direction()
>       ->read_tree_recursive()
>         ->write_archive_entry()
>           ->git_checkattr()
>=20
> Ah, bootstrap_attr_stack() and prepare_attr_stack() still assume that=
 you
> won't be doing any per-level attributes in a bare repository because =
the
> concept of attributes is inherently tied to having a work tree from t=
heir
> point of view.
>=20
> How about this "mostly re-indent with four line removal" patch?

Plus the following (on top of Duy's GIT_ATTR_INDEX patch)?

diff --git a/attr.c b/attr.c
index f5917de..cce561b 100644
--- a/attr.c
+++ b/attr.c
@@ -672,6 +672,8 @@ int git_checkattr(const char *path, int num, struct=
 git_attr_check *check)
 void git_attr_set_direction(enum git_attr_direction new, struct index_=
state *istate)
 {
 	enum git_attr_direction old =3D direction;
+	if (is_bare_repository())
+		new =3D GIT_ATTR_INDEX;
 	direction =3D new;
 	if (new !=3D old)
 		drop_attr_stack();
