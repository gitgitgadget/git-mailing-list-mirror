From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Fri, 30 Mar 2012 12:19:48 +0700
Message-ID: <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
 <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
 <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
 <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
 <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
 <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
 <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com>
 <7vk423qfps.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 07:20:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDUGX-0006sB-8T
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 07:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873Ab2C3FUV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Mar 2012 01:20:21 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48515 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751269Ab2C3FUT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 01:20:19 -0400
Received: by lahj13 with SMTP id j13so317703lah.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 22:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OaFf2do/sVjrsuDMtubqRrpzmOYIIhCAy2KydH1PPLE=;
        b=OjI6Q5CWIRsMDUbPtssJPPXdYeGXs22KGRZARhC4S7g9wnSb4rMuHI1Suj7M2yWC6o
         aAfnru/5rQjnuJEz0icp4JpjhlunkKZ3Jvq+Nm7yQCZbke9538jbbwaLEVxbgDNwMPmg
         WwCTp77OC1G8+1f28EQP9rlSIkz4iBtUvsKPiQmUa/X9eax3EPRQSIdNUhNIzYWn7LI+
         4DnfYpNrSjg/HwkFlo1zFvRc5J3QIsusDrGsomliKhS0H7g+mgnyLb/b7Egn2EKA0BDS
         d4X8gv3Qp7F+qiyp4aReXfz486XyQhJiBndfHuBSwgAziPqachBaQEDLEvA4vGWpg8Du
         d2Gw==
Received: by 10.152.147.202 with SMTP id tm10mr1005283lab.49.1333084818229;
 Thu, 29 Mar 2012 22:20:18 -0700 (PDT)
Received: by 10.112.42.197 with HTTP; Thu, 29 Mar 2012 22:19:48 -0700 (PDT)
In-Reply-To: <7vk423qfps.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194327>

On Fri, Mar 30, 2012 at 4:06 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Is it really the time consuming part in the overall picture? =C2=A0Do=
 you have
> vital statistics for various pieces to justify that you are solving t=
he
> right problem? =C2=A0E.g. (not exhaustive)
>
> =C2=A0- read_index(): overhead to
> =C2=A0 - validate the checksum of the whole index;
> =C2=A0 - extract entries into the_index.cache[] array;
>
> =C2=A0- write_index(): overhead to
> =C2=A0 - serialize entries into the on-disk format;
> =C2=A0 - compute the checksum over the entire index;
> =C2=A0 - write the whole index to disk;
>
> =C2=A0- frequency of the above two operations.

Also maybe the frequency of entry updates vs additions/removals. I
suspect refresh operation in some case can update a lot of entries. If
that's the case (and happens often), we may need special treatment for
it because simply appending entries might be costly.

> Also, optimizing the write codepath by penalizing the read codepath i=
s a
> wrong trade-off if the index is read far more often than it is writte=
n
> during a single day of a developer.

I suspect so too, but some measurement has to be done there. It'd be
good if you provide a patch to collect index operation statistics.
Some of us can try it on for a few weeks. That would give us a better
picture.

On Thu, Mar 29, 2012 at 10:21 PM, Thomas Gummerer <t.gummerer@gmail.com=
> wrote:
> - Tree structure
> The advantage of the tree structure over the append-only data structu=
re that was
> proposed would be that it would not require any merge or other mainta=
inance work
> work after a change of a file. The disadvantage however is that chang=
ing a file
> would always require log(n) changes to the index, where n is the numb=
er of
> entries in the index. Another problem might be the integrity check, w=
hich would
> need either to use a hash over the whole index file or a hash on the =
tree,
> which would however take more time for checking.

I'd say it takes less time for checksuming because we only verify the
trees we read. And tree-based structure allows us to read just a
subdirectory, an advantage for multi-project repositories where people
stay in a subdir most of the time. Shawn suspected crc32 checksum over
a large chunk of data may be insufficient. By hashing tree by tree,
the chunks are significantly shorter, making crc32 viable and cheap
candidate compared to sha-1 (also note that crc32 is used to verify
compressed objects in a pack)
--=20
Duy
