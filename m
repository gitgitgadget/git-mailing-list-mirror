X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] index-pack: correctly initialize appended objects
Date: Thu, 24 Jul 2008 22:21:14 -0700
Message-ID: <7vy73q4jzp.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807241821440.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 25 Jul 2008 05:21:40 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, spearce@spearce.org,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
In-Reply-To: <alpine.DEB.1.00.0807241821440.8986@racer> (Johannes
 Schindelin's message of "Thu, 24 Jul 2008 18:32:00 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 84DC2A32-5A09-11DD-8BD5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1KMFl4-0000Tv-Nl for gcvg-git-2@gmane.org; Fri, 25 Jul 2008
 07:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750768AbYGYFVZ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 01:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbYGYFVZ
 (ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 01:21:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50935 "EHLO
 sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750720AbYGYFVY convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 25 Jul 2008 01:21:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1]) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FE063B5FE; Fri, 25
 Jul 2008 01:21:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EE0E13B5FC; Fri, 25 Jul 2008 01:21:16 -0400 (EDT)
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> From: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
>
> When index-pack completes a thin pack it appends objects to the pack.=
 =20
> Since the commit 92392b4(index-pack: Honor core.deltaBaseCacheLimit w=
hen=20
> resolving deltas) such an object can be pruned in case of memory
> pressure.
>
> To be able to re-read the object later, a few more fields have to be =
set.
>
> Noticed by Pierre Habouzit.
>
> Hopefully-signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
> Hopefully-reviewed-and-signed-off-by: Nicolas Pitre <nico@cam.org>,=20
>
> --
> 	Nico could you have a quick look?  (I would ask Shawn, but I know=20
> 	that he is pretty busy with real world issues.)

Reading get_data_from_pack(), it does rely on hdr_size, idx.offset and
idx.offset of the next entry to be set correctly.  The function does no=
t
seem to use type (which the patch is also setting) nor real_type (which
the patch does not set).

However, the code checks objects[nth].real_type all over the place in t=
he
code.  Doesn't the lack of real_type assignment in append_obj_to_pack()
affect them in  any way?

> diff --git a/index-pack.c b/index-pack.c
> index ac20a46..33ba8ef 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -699,6 +699,9 @@ static struct object_entry *append_obj_to_pack(
>  	write_or_die(output_fd, header, n);
>  	obj[0].idx.crc32 =3D crc32(0, Z_NULL, 0);
>  	obj[0].idx.crc32 =3D crc32(obj[0].idx.crc32, header, n);
> +	obj[0].hdr_size =3D n;
> +	obj[0].type =3D type;
> +	obj[0].size =3D size;
>  	obj[1].idx.offset =3D obj[0].idx.offset + n;
>  	obj[1].idx.offset +=3D write_compressed(output_fd, buf, size, &obj[=
0].idx.crc32);
