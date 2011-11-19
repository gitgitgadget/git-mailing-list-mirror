From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: Stack overflow at write_one()
Date: Sat, 19 Nov 2011 18:27:29 -0200
Message-ID: <4EC81131.2010704@cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 21:38:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRrgO-0003Ks-NG
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 21:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992Ab1KSUeO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Nov 2011 15:34:14 -0500
Received: from smtp-04.mandic.com.br ([200.225.81.151]:39142 "EHLO
	smtp-04.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1KSUeN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 15:34:13 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Nov 2011 15:34:13 EST
Received: (qmail 8859 invoked from network); 19 Nov 2011 20:27:31 -0000
Received: from unknown (HELO cesarb-inspiron.home.cesarb.net) (zcncxNmDysja2tXBptWToZWJlF6Wp6IuYnI=@[200.157.204.20])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-04.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 19 Nov 2011 20:27:30 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111115 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185708>

I have found a stack overflow at builtin/pack-objects.c:write_one(),=20
where it calls itself endlessly. This is caused by the object_entry e=20
and e->delta->delta being the same. But I have no idea how that happene=
d.

=46irst, the full story:

I used Google's repo tool to mirror AOSP to my machine. This mirrors=20
several kernel trees (six last time I counted), without sharing objects=
=20
one with another. To save space, I decided to point their=20
objects/info/alternates to my mirror of the Linus kernel tree (which=20
should be safe, since Linus makes it always fast-forward), and run "git=
=20
gc" on them to create a smaller pack. This worked for all trees except=20
one, where it core dumped (abrt report at=20
https://bugzilla.redhat.com/show_bug.cgi?id=3D755132).

I compiled the latest git (v1.7.8-rc3-17-gf56ef11) to see if it still=20
happened, and here is what I could get from gdb. I attached to the=20
pack-objects process before it crashed (full command line "git=20
pack-objects --keep-true-parents --honor-pack-keep --non-empty --all=20
--reflog --unpack-unreachable --local --delta-base-offset=20
/home/cesarb/src/bug755132/omap.git/objects/pack/.tmp-5171-pack"),=20
continued, and let it crash:

(gdb) cont
Continuing.
[New Thread 0x7f3f2bad3700 (LWP 5205)]
[New Thread 0x7f3f2b2d2700 (LWP 5206)]
[New Thread 0x7f3f2aad1700 (LWP 5207)]
[New Thread 0x7f3f2a2d0700 (LWP 5208)]
[Thread 0x7f3f2b2d2700 (LWP 5206) exited]
[Thread 0x7f3f2bad3700 (LWP 5205) exited]
[Thread 0x7f3f2aad1700 (LWP 5207) exited]
[Thread 0x7f3f2a2d0700 (LWP 5208) exited]

Program received signal SIGSEGV, Segmentation fault.
0x00000000004472b9 in write_one (f=3D0x6a97db0, e=3D0x7f3f30233490,
     offset=3D0x7fff79b53908) at builtin/pack-objects.c:415
415	{

Unlike on Fedora's git binary, where it happened on a call instruction,=
=20
this time it happened on a push instruction:

(gdb) disassemble
Dump of assembler code for function write_one:
    0x00000000004472b0 <+0>:	push   %r15
    0x00000000004472b2 <+2>:	push   %r14
    0x00000000004472b4 <+4>:	push   %r13
    0x00000000004472b6 <+6>:	mov    %rdx,%r13
=3D> 0x00000000004472b9 <+9>:	push   %r12
    0x00000000004472bb <+11>:	mov    %rdi,%r12

The last few frames on the stack show the endless recursion:

(gdb) where
#0  0x00000000004472b9 in write_one (f=3D0x6a97db0, e=3D0x7f3f30233490,
     offset=3D0x7fff79b53908) at builtin/pack-objects.c:415
#1  0x00000000004472ed in write_one (f=3D0x6a97db0, e=3D0x7f3f30277390,
     offset=3D0x7fff79b53908) at builtin/pack-objects.c:423
#2  0x00000000004472ed in write_one (f=3D0x6a97db0, e=3D0x7f3f30233490,
     offset=3D0x7fff79b53908) at builtin/pack-objects.c:423
#3  0x00000000004472ed in write_one (f=3D0x6a97db0, e=3D0x7f3f30277390,
     offset=3D0x7fff79b53908) at builtin/pack-objects.c:423
#4  0x00000000004472ed in write_one (f=3D0x6a97db0, e=3D0x7f3f30233490,
     offset=3D0x7fff79b53908) at builtin/pack-objects.c:423

And here is the loop in the data structures:

(gdb) p e
$1 =3D (struct object_entry *) 0x7f3f30233490
(gdb) p e->delta
$2 =3D (struct object_entry *) 0x7f3f30277390
(gdb) p e->delta->delta
$3 =3D (struct object_entry *) 0x7f3f30233490

Unfortunately, I do not know enough of git's internals to debug further=
=2E=20
In case it helps, here is the contents of a few of these structures:

(gdb) p *e
$4 =3D {idx =3D {
     sha1 =3D "\257>J\241)\266\023\064\a\342J\320\375=D3=86\262M\245",=20
<incomplete sequence \356>, crc32 =3D 0, offset =3D 0}, size =3D 20, in=
_pack =3D=20
0x259b610,
   in_pack_offset =3D 231061238, delta =3D 0x7f3f30277390,
   delta_child =3D 0x7f3f30277390, delta_sibling =3D 0x7f3f30413b10,
   delta_data =3D 0x0, delta_size =3D 20, z_delta_size =3D 0, hash =3D =
2099915708,
   type =3D OBJ_OFS_DELTA, in_pack_type =3D OBJ_OFS_DELTA,
   in_pack_header_size =3D 5 '\005', preferred_base =3D 0 '\000',
   no_try_delta =3D 0 '\000', tagged =3D 0 '\000', filled =3D 1 '\001'}
(gdb) p *(e->delta)
$5 =3D {idx =3D {
     sha1 =3D=20
"\372\307\035\372\017\350\307\f\310R\t\236\006\034\063N*T\216\253",
     crc32 =3D 0, offset =3D 0}, size =3D 14, in_pack =3D 0x259b610,
   in_pack_offset =3D 39990, delta =3D 0x7f3f30233490,
   delta_child =3D 0x7f3f30233490, delta_sibling =3D 0x0, delta_data =3D=
 0x0,
   delta_size =3D 14, z_delta_size =3D 0, hash =3D 2099915708, type =3D=
=20
OBJ_REF_DELTA,
   in_pack_type =3D OBJ_REF_DELTA, in_pack_header_size =3D 21 '\025',
   preferred_base =3D 0 '\000', no_try_delta =3D 0 '\000', tagged =3D 0=
 '\000',
   filled =3D 1 '\001'}
(gdb) p *(e->in_pack)
$6 =3D {next =3D 0x25a53c0, windows =3D 0x259bc40, pack_size =3D 449155=
894,
   index_data =3D 0x7f3f4f0a9000, index_size =3D 58351420, num_objects =
=3D=20
2083941,
   num_bad_objects =3D 0, bad_object_sha1 =3D 0x0, index_version =3D 2,
   mtime =3D 1321387261, pack_fd =3D -1, pack_local =3D 1, pack_keep =3D=
 0,
   do_not_close =3D 0, sha1 =3D=20
"\371Q4\177.=C8=B3v\364\246\332Z\234\025?\352=DD=A0P\210",
   pack_name =3D 0x259b671=20
"/home/cesarb/src/bug755132/omap.git/objects/pack/pack-f951347f2ec8b376=
f4a6da5a9c153feadda05088.pack"}

I tried using "git fsck" to see if it could find anything strange, but=20
it seems to get stuck (using 100% CPU) after these lines:

[...]
Checking commit fb630b9fc902e24209166b1659a8b375bf38099c
Checking tree fc32c012c750084eb1d82782cee7c80a45a78289
Checking blob fc7bbba585cee2c2b0d5282c42fb986bfb032a0a
Checking commit fdcb23634c9b6649bb02c681033d4973491b0e35
Checking tree fe773cf73ff553249be2f24ddf770f5dc43a41f1
Checking blob fe67b5c79f0ff33d92ebe7469a89c5a5d044fc0a
Checking blob fe73276e026bf263f494a917c84c6a3fcaeaaeda
Checking tree fe30eda9d92d074816f9c3a47fd3ffb9b89ca835
Checking tree fe9c75396e6d433b289d0e40c7e47921b91cad3a
Checking blob ff3ed6086ce1c6b6b4b5111c034d14a208c0d045
Checking blob ff66638ff54d5ad7067e4f246d392059eef1a7bf
Checking tree ff126d2bc67017199049ddba761979f3bda57eb9

Unfortunately, the reproducer I have (a copy of both trees with=20
objects/info/alternates modified) is 1.8G in size, and I do not know ho=
w=20
to create a smaller reproducer. If you know of a command which would ge=
t=20
more relevant information from them, just ask; I plan on keeping them=20
around for a while.

--=20
Cesar Eduardo Barros
cesarb@cesarb.net
cesar.barros@gmail.com
