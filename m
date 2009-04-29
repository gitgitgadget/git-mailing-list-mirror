From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff -c -p: do not die on submodules
Date: Wed, 29 Apr 2009 16:09:28 -0700
Message-ID: <7vr5zb5a6v.fsf@gitster.siamese.dyndns.org>
References: <gt7err$3m4$1@ger.gmane.org>
 <7v4ow8my1u.fsf@gitster.siamese.dyndns.org> <20090428211257.GA31191@pvv.org>
 <20090429084209.GA24064@localhost>
 <7v8wljcmvk.fsf_-_@gitster.siamese.dyndns.org>
 <7vy6tj8aur.fsf_-_@gitster.siamese.dyndns.org>
 <81b0412b0904291450w3d292ed5i3b2ab5164c0ae0f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Tim Olsen <tim@brooklynpenguin.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 01:10:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzIv2-0005FD-9J
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 01:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509AbZD2XJi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 19:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbZD2XJh
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 19:09:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbZD2XJh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 19:09:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 54EAC13819;
	Wed, 29 Apr 2009 19:09:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 51EBA13818; Wed,
 29 Apr 2009 19:09:30 -0400 (EDT)
In-Reply-To: <81b0412b0904291450w3d292ed5i3b2ab5164c0ae0f4@mail.gmail.com>
 (Alex Riesen's message of "Wed, 29 Apr 2009 23:50:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CED3F82E-3512-11DE-A347-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117975>

Alex Riesen <raa.lkml@gmail.com> writes:

> 2009/4/29 Junio C Hamano <gitster@pobox.com>:
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (S_ISGITLINK(mode)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blob =3D xmalloc(=
100);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *size =3D snprint=
f(blob, 100,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Subproject commit %s\n", =
sha1_to_hex(sha1));
>
> snprintf returns a signed value. It also has a bad record of returnin=
g
> negative values for obscure reasons (on obscure platforms, admittedly=
).

The arena is sufficiently large that there is no way any broken snprint=
f
can return negative here.

This is a copy from Linus's diff_populate_gitlink(), that dates back to
0478675 (Expose subprojects as special files to "git diff" machinery,
2007-04-15), and you have never seen any breakage, which should tell yo=
u
something.

As I mentioned in the original patch, the codepath that reads one side =
of
diff (either from a blob or from a work tree entity) in show_patch_diff=
()
and grab_blob() in combine-diff.c should do the same thing as what
diff_populate_filespec() in diff.c does, and these three functions need
some refactoring to share more code.  The patch however is about fixing
the existing breakage without invasive refactoring.
