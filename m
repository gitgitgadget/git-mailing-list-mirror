From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: regression in multi-threaded git-pack-index
Date: Tue, 19 Mar 2013 16:45:55 +0100
Message-ID: <87620n4clo.fsf@pctrast.inf.ethz.ch>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
	<87hak74cse.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Zager <szager@google.com>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 16:46:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHyk5-0002Lv-JA
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 16:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137Ab3CSPp6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Mar 2013 11:45:58 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:40692 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754171Ab3CSPp5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Mar 2013 11:45:57 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 16:45:51 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.171.78) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 16:45:55 +0100
In-Reply-To: <87hak74cse.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
	"Tue, 19 Mar 2013 16:41:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.171.78]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218528>

Thomas Rast <trast@student.ethz.ch> writes:

>   (gdb) r index-pack --keep --stdin -v --pack_header=3D2,50757 <borke=
d
>   Starting program: /Users/trast/.local/bin/git index-pack --keep
> --stdin -v --pack_header=3D2,50757 <borked
>   Reading symbols for shared libraries +++........................ do=
ne
>   Receiving objects: 100% (50757/50757), 24.52 MiB | 13.06 MiB/s, don=
e.
>   Resolving deltas:  25% (10568/42272)  =20
>   Program received signal EXC_BAD_ACCESS, Could not access memory.
>   Reason: KERN_PROTECTION_FAILURE at address: 0x000000014484dfe8
>   [Switching to process 96573 thread 0x10f]
>   0x000000010017ee20 in use_pack (p=3D0x100500f30, w_cursor=3D0x14484=
e1a0,
> offset=3D69638148, left=3D0x0) at sha1_file.c:866
>   866             if (!win || !in_window(win, offset)) {
>
> This seems to be a SIGBUS triggered by stack overflow, largely based =
on
> the observation that
>
>   (gdb) p &p
>   $6 =3D (struct packed_git **) 0x144748058

Actually, scratch that; the stack depth is the same no matter what
ulimits I put (up to 64MB).  Roughly speaking

  (gdb) bt 10
  #0  0x000000010017ee20 in use_pack (p=3D0x100500f30, w_cursor=3D0x144=
84e1a0, offset=3D69638148, left=3D0x0) at sha1_file.c:866
  #1  0x000000010018180c in get_delta_base (p=3D0x100500f30, w_curs=3D0=
x14484e1a0, curpos=3D0x14484e138, type=3DOBJ_OFS_DELTA, delta_obj_offse=
t=3D69638146) at sha1_file.c:1609
  #2  0x00000001001819e6 in packed_delta_info (p=3D0x100500f30, w_curs=3D=
0x14484e1a0, curpos=3D69638148, type=3DOBJ_OFS_DELTA, obj_offset=3D6963=
8146, sizep=3D0x0) at sha1_file.c:1655
  #3  0x0000000100181c97 in packed_object_info (p=3D0x100500f30, obj_of=
fset=3D69638146, sizep=3D0x0, rtype=3D0x0) at sha1_file.c:1727
  #4  0x0000000100181a25 in packed_delta_info (p=3D0x100500f30, w_curs=3D=
0x14484e2a0, curpos=3D69638193, type=3DOBJ_OFS_DELTA, obj_offset=3D6963=
8190, sizep=3D0x0) at sha1_file.c:1658
  #5  0x0000000100181c97 in packed_object_info (p=3D0x100500f30, obj_of=
fset=3D69638190, sizep=3D0x0, rtype=3D0x0) at sha1_file.c:1727
  #6  0x0000000100181a25 in packed_delta_info (p=3D0x100500f30, w_curs=3D=
0x14484e3a0, curpos=3D69638240, type=3DOBJ_OFS_DELTA, obj_offset=3D6963=
8237, sizep=3D0x0) at sha1_file.c:1658
  #7  0x0000000100181c97 in packed_object_info (p=3D0x100500f30, obj_of=
fset=3D69638237, sizep=3D0x0, rtype=3D0x0) at sha1_file.c:1727
  #8  0x0000000100181a25 in packed_delta_info (p=3D0x100500f30, w_curs=3D=
0x14484e4a0, curpos=3D69638285, type=3DOBJ_OFS_DELTA, obj_offset=3D6963=
8282, sizep=3D0x0) at sha1_file.c:1658
  #9  0x0000000100181c97 in packed_object_info (p=3D0x100500f30, obj_of=
fset=3D69638282, sizep=3D0x0, rtype=3D0x0) at sha1_file.c:1727
  (More stack frames follow...)
  (gdb) bt -10
  #4088 0x00000001001835f9 in sha1_object_info_extended (sha1=3D0x1011b=
0900 "D=3DL\022eO=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD}=EF=BF=BDr\fW\036=
=46=EF=BF=BDQ\\Q;t=EF=BF=BD8", oi=3D0x1448cdc50) at sha1_file.c:2264
  #4089 0x00000001001836eb in sha1_object_info (sha1=3D0x1011b0900 "D=3D=
L\022eO=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD}=EF=BF=BDr\fW\036F=EF=BF=BD=
Q\\Q;t=EF=BF=BD8", sizep=3D0x1448cdd28) at sha1_file.c:2286
  #4090 0x0000000100053c44 in sha1_object (data=3D0x146002400, obj_entr=
y=3D0x0, size=3D1992, type=3DOBJ_TREE, sha1=3D0x1011b0900 "D=3DL\022eO=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD}=EF=BF=BDr\fW\036F=EF=BF=BDQ\\Q;t=EF=BF=
=BD8") at index-pack.c:722
  #4091 0x000000010005457f in resolve_delta (delta_obj=3D0x1011b0900, b=
ase=3D0x144e00000, result=3D0x144e00040) at index-pack.c:866
  #4092 0x00000001000548b6 in find_unresolved_deltas_1 (base=3D0x144e00=
000, prev_base=3D0x0) at index-pack.c:914
  #4093 0x0000000100054947 in find_unresolved_deltas (base=3D0x144e0000=
0) at index-pack.c:930
  #4094 0x0000000100054a79 in resolve_base (obj=3D0x1011b08c0) at index=
-pack.c:961
  #4095 0x0000000100054ba5 in threaded_second_pass (data=3D0x100537dd0)=
 at index-pack.c:984
  #4096 0x00007fff8ec8b8bf in _pthread_start ()
  #4097 0x00007fff8ec8eb75 in thread_start ()

That leaves me stumped as to the cause of that SIGBUS, however.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
