From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] index-pack: correctly initialize appended objects
Date: Fri, 25 Jul 2008 11:15:47 -0700
Message-ID: <7v4p6du8x8.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807241821440.8986@racer>
 <7vy73q4jzp.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807251219530.11976@eeepc-johanness>
 <alpine.LFD.1.10.0807250751220.9968@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	spearce@spearce.org, git@vger.kernel.org,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jul 25 20:17:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMRqy-0005Az-Kz
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 20:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbYGYSP7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 14:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbYGYSP7
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 14:15:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50775 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbYGYSP6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2008 14:15:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DCDEA3B9DD;
	Fri, 25 Jul 2008 14:15:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EC27A3B9D6; Fri, 25 Jul 2008 14:15:49 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0807250751220.9968@xanadu.home> (Nicolas
 Pitre's message of "Fri, 25 Jul 2008 07:54:49 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B962BF70-5A75-11DD-AC6B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90081>

Nicolas Pitre <nico@cam.org> writes:

> On Fri, 25 Jul 2008, Johannes Schindelin wrote:
>
>> Hi,
>>=20
>> On Thu, 24 Jul 2008, Junio C Hamano wrote:
>>=20
>> > The function does not seem to use type (which the patch is also se=
tting)=20
>> > nor real_type (which the patch does not set).
>> >=20
>> > However, the code checks objects[nth].real_type all over the place=
 in=20
>> > the code.  Doesn't the lack of real_type assignment in=20
>> > append_obj_to_pack() affect them in any way?
>>=20
>> >From staring at the code, I thought that real_type was set in=20
>> resolve_delta(), but I may be wrong.
>>=20
>> The safer thing would be to set it, but I am not quite sure if we ca=
n use=20
>> "type" directly, or if type can be "delta" for an object that is use=
d to=20
>> complete the pack, and therefore stored as a non-delta.
>
> Objects to complete the pack are always non delta, so the type and=20
> real_type should be the same.  However that shouldn't matter since at=
=20
> that point the object array is not walked anymore, at least not for=20
> appended objects, and therefore initializing the type at that point i=
s=20
> redundant.

Thanks.  Here is what I committed.

commit 72de2883bd7d4ceda05f107826c7607c594de965
Author: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
Date:   Thu Jul 24 18:32:00 2008 +0100

    index-pack.c: correctly initialize appended objects
   =20
    When index-pack completes a thin pack it appends objects to the pac=
k.
    Since the commit 92392b4(index-pack: Honor core.deltaBaseCacheLimit=
 when
    resolving deltas) such an object can be pruned in case of memory
    pressure, and will be read back again by get_data_from_pack().  For=
 this
    to work, the fields in object_entry structure need to be initialize=
d
    properly.
   =20
    Noticed by Pierre Habouzit.
   =20
    Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
    Acked-by: Nicolas Pitre <nico@cam.org>
    Acked-by: Shawn O. Pearce <spearce@spearce.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/index-pack.c b/index-pack.c
index c359f8c..7d5344a 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -698,6 +698,10 @@ static struct object_entry *append_obj_to_pack(
 	write_or_die(output_fd, header, n);
 	obj[0].idx.crc32 =3D crc32(0, Z_NULL, 0);
 	obj[0].idx.crc32 =3D crc32(obj[0].idx.crc32, header, n);
+	obj[0].size =3D size;
+	obj[0].hdr_size =3D n;
+	obj[0].type =3D type;
+	obj[0].real_type =3D type;
 	obj[1].idx.offset =3D obj[0].idx.offset + n;
 	obj[1].idx.offset +=3D write_compressed(output_fd, buf, size, &obj[0]=
=2Eidx.crc32);
 	hashcpy(obj->idx.sha1, sha1);
