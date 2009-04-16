From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] archive: do not read .gitattributes in working
 directory
Date: Wed, 15 Apr 2009 17:26:52 -0700
Message-ID: <7vr5ztpho3.fsf@gitster.siamese.dyndns.org>
References: <1239260490-6318-1-git-send-email-pclouds@gmail.com>
 <1239260490-6318-2-git-send-email-pclouds@gmail.com>
 <1239260490-6318-3-git-send-email-pclouds@gmail.com>
 <1239260490-6318-4-git-send-email-pclouds@gmail.com>
 <7vws9u2ov4.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0904090353s4ec770bfk3cd3f6559c367a20@mail.gmail.com>
 <49E316CD.7030001@lsrfire.ath.cx> <49E32D9F.2050906@lsrfire.ath.cx>
 <49E33935.5090203@lsrfire.ath.cx> <7vk55nakge.fsf@gitster.siamese.dyndns.org>
 <49E4FCF8.3050207@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Apr 16 02:28:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuFT3-0001s4-G0
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 02:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbZDPA1D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2009 20:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753508AbZDPA1B
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 20:27:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbZDPA1A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2009 20:27:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B1200AA9CB;
	Wed, 15 Apr 2009 20:26:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3A552AA9C7; Wed,
 15 Apr 2009 20:26:53 -0400 (EDT)
In-Reply-To: <49E4FCF8.3050207@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Tue, 14 Apr 2009 23:15:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4C1C2B68-2A1D-11DE-8A82-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116657>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
> ...
>> Ah, bootstrap_attr_stack() and prepare_attr_stack() still assume tha=
t you
>> won't be doing any per-level attributes in a bare repository because=
 the
>> concept of attributes is inherently tied to having a work tree from =
their
>> point of view.
>>=20
>> How about this "mostly re-indent with four line removal" patch?
>
> Plus the following (on top of Duy's GIT_ATTR_INDEX patch)?

Actually, the "mostly re-indent" patch breaks things for normal users t=
hat
expect the attributes never kicks in when you are doing things in a bar=
e
repository as-is.

> diff --git a/attr.c b/attr.c
> index f5917de..cce561b 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -672,6 +672,8 @@ int git_checkattr(const char *path, int num, stru=
ct git_attr_check *check)
>  void git_attr_set_direction(enum git_attr_direction new, struct inde=
x_state *istate)
>  {
>  	enum git_attr_direction old =3D direction;
> +	if (is_bare_repository())
> +		new =3D GIT_ATTR_INDEX;
>  	direction =3D new;
>  	if (new !=3D old)
>  		drop_attr_stack();

This looks _conceptually_ wrong.

I think your patch came from the fact that check_updates() unconditiona=
lly
calls git_attr_set_direction() without checking o->update, and I think =
it
is a bug in check_updates().

A bare repository is by definition without a work tree, and we shouldn'=
t
be reading the index in general.  I wouldn't go as far to say that a ba=
re
repository should not have the index file, because people often clone
forgetting the --bare option and manually convert that to a bare
repository, and they forget to remove the index that is never used.

	... thinks a bit more ...

I think codepaths that make calls to git_attr_set_direction() inside
is_bare_repository() are special already.  If we were to teach check-at=
tr
how to check attributes for paths _inside a given tree-ish_, most likel=
y
the implementation would be similar to what Duy did for archive; read t=
he
tree into in-core index, set direction to the INDEX, and start using th=
e
attribute mechanism.

So I think we'd rather not have the patch to force GIT_ATTR_INDEX in
set_direction(); if anything, the patch should say something like "if w=
e
are in a bare repository and the new direction is not INDEX, it is a
programming error".

Instead, such specialized codepaths should call set_direction() itself,
perhaps after reading the tree-ish into the in-core index.  And we shou=
ld
fix the "mostly re-indent" patch not to remove the conditional, but mak=
e
the conditional to check "If in a bare repository and the direction is =
not
explicitly set to INDEX, do not use the attributes".
