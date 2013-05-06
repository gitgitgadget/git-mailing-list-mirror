From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: git rev-list | git cherry-pick --stdin is leaky
Date: Mon, 06 May 2013 13:16:55 -0700
Message-ID: <51880FB7.8020701@codeaurora.org>
References: <517F0C18.8060703@codeaurora.org> <51804A02.6080301@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon May 06 22:17:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZRqG-0006y5-Rs
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 22:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175Ab3EFUQ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 May 2013 16:16:57 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:45757 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971Ab3EFUQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 16:16:56 -0400
X-IronPort-AV: E=Sophos;i="4.87,623,1363158000"; 
   d="scan'208";a="44620845"
Received: from pdmz-ns-snip_115_219.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.115.219])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 May 2013 13:16:56 -0700
Received: from [10.46.166.8] (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id E595F10004C7;
	Mon,  6 May 2013 13:16:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <51804A02.6080301@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223501>

On 04/30/13 15:47, Ren=E9 Scharfe wrote:
> Am 30.04.2013 02:11, schrieb Stephen Boyd:
>> (resending since the attachment seems to make vger sad)
>>
>> Hi,
>>
>> I'm running git rev-list | git cherry-pick --stdin on a range of abo=
ut
>> 300 commits. Eventually the chery-pick dies with:
>>
>>      error: cannot fork() for commit: Cannot allocate memory
>>
>> Running valgrind shows me that the tree traversal code is leaking
>> gigabytes of memory (particularly unpack_callback). Since cherry-pic=
k is
>> a very long running process all these allocations are never freed an=
d
>> eventually I run out of memory. The worst offender and summary is:
>>
>> =3D=3D7986=3D=3D 938,956,692 (929,961,582 direct, 8,995,110 indirect=
) bytes in
>> 7,765,439 blocks are definitely lost in loss record 257 of 257
>> =3D=3D7986=3D=3D    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
>> =3D=3D7986=3D=3D    by 0x4FAF57: xcalloc (wrapper.c:119)
>> =3D=3D7986=3D=3D    by 0x4F5281: unpack_callback (unpack-trees.c:539=
)
>> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
>> =3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467=
)
>> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
>> =3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467=
)
>> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
>> =3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467=
)
>> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
>> =3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467=
)
>> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
>> =3D=3D7986=3D=3D
>> =3D=3D7986=3D=3D LEAK SUMMARY:
>> =3D=3D7986=3D=3D    definitely lost: 2,514,117,692 bytes in 21,210,8=
61 blocks
>> =3D=3D7986=3D=3D    indirectly lost: 885,481,947 bytes in 10,165,801=
 blocks
>> =3D=3D7986=3D=3D      possibly lost: 650,712,395 bytes in 6,014,309 =
blocks
>> =3D=3D7986=3D=3D    still reachable: 7,734,870 bytes in 47,794 block=
s
>> =3D=3D7986=3D=3D         suppressed: 0 bytes in 0 blocks
> I looked at that particular leak a year ago but couldn't convince mys=
elf
> to submit the patch below.  If the callback function we call through
> call_unpack_fn does something strange like free()ing entries itself o=
r
> adding them to some list without duplication then the added free() ca=
n
> cause trouble.
>
> Looking at it again today I don't understand that concern any more.  =
The
> current callback functions don't do something like that, in any case.
> Maybe I'm missing something.
>
> Anyway, could you please check if the patch helps with your use case?

Ok. I tested it and it definitely helps.

=3D=3D10728=3D=3D LEAK SUMMARY:
=3D=3D10728=3D=3D    definitely lost: 316,355,458 bytes in 8,652 blocks
=3D=3D10728=3D=3D    indirectly lost: 1,327,251,588 bytes in 16,180,628=
 blocks
=3D=3D10728=3D=3D      possibly lost: 677,049,918 bytes in 7,381,801 bl=
ocks
=3D=3D10728=3D=3D    still reachable: 9,238,039 bytes in 63,947 blocks
=3D=3D10728=3D=3D         suppressed: 0 bytes in 0 blocks

vs.

=3D=3D27614=3D=3D LEAK SUMMARY:
=3D=3D27614=3D=3D    definitely lost: 2,369,692,222 bytes in 20,005,707=
 blocks
=3D=3D27614=3D=3D    indirectly lost: 829,151,786 bytes in 9,594,715 bl=
ocks
=3D=3D27614=3D=3D      possibly lost: 658,069,373 bytes in 6,345,172 bl=
ocks
=3D=3D27614=3D=3D    still reachable: 8,806,386 bytes in 50,199 blocks
=3D=3D27614=3D=3D         suppressed: 0 bytes in 0 blocks

--=20
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
