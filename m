From: Dmitry Risenberg <dmitry.risenberg@gmail.com>
Subject: cherry-pick is slow
Date: Sun, 13 May 2012 02:39:36 +0400
Message-ID: <CAPZ_ugYojqTaWi0atr2ApOu9xmcwy4y8FduNC+TDhgWgSxXNPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 13 00:40:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STKyz-0002js-Ao
	for gcvg-git-2@plane.gmane.org; Sun, 13 May 2012 00:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab2ELWji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 18:39:38 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34864 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab2ELWjg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2012 18:39:36 -0400
Received: by obbtb18 with SMTP id tb18so5203384obb.19
        for <git@vger.kernel.org>; Sat, 12 May 2012 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=4Q65Tc4RrTaI2h0Py6ngqvGtewqQYtD4qzciggpLNmQ=;
        b=KKLrpIy1A++9u3L2RCFWP2EIFKcconHv/Vlw76Susm7x1jF1j6xOCsO2j2KQb+/Ri4
         vaIcQ4i2PHC0oI+LkZaphe3kSVbj8VxEw/bUQRqzGQN0nIB+f/PB+Okyb4ADHo0QWiZN
         KCcsET8EG4lVEUG2b1QJWN/quqWZctUdLd00tOYQB3WZFpdra4e8jN1SppjjX0Equ7rw
         M8ysB+ImDOX6c9d1lbrE9A7ougMFiPYMr3x6o7JwuswDT0SuipMCjOZHTn/xaejrzqmp
         nq/I5lR1YWjnURm0lO74LM3zNCnvqRK4B7AR6Qs/NbaxwZaQnQplvXpHA4iZx7ZThb/T
         O65w==
Received: by 10.182.47.105 with SMTP id c9mr4870540obn.49.1336862376272; Sat,
 12 May 2012 15:39:36 -0700 (PDT)
Received: by 10.60.79.193 with HTTP; Sat, 12 May 2012 15:39:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197740>

Hello.

I have a very big git repository (the .git directory is about 5.3 Gb),
which is a copy of an svn repository fetched via git-svn. In fact
there are a few repositories ("working copies") that share the same
=2Egit directory (via symlinks), in which I have different svn branches
checked out. Now I want to merge a commit from one svn branch to
another via git cherry-pick. The commit contains diff in only one
file. So I do

git cherry-pick <commit>

And the operation takes tens of seconds to finish. In "top" output I
see that git process uses almost no CPU, but has hundreds of page
faults, so I assume that it is reading a lot of files from disk. I
also tried running git in gdb and interrupting it in random places,
the stacktrace I get is usually like this:

#0  0x00000000004fb70c in experimental_loose_object (
    map=3D0x3268e000
"x\001+)JMU043g040031Qp=F6M=CCN=F5=C9,.)=D6+=A9(a=F8t*=E4=E3=FA=BD\v=CD=
4\236Y=F1\230=A4&z=AF=DF<{=BA\211\001\020(=A4eV0\024\177=F2\177=E1$\\$\=
034\224\036=F6*=F7v=C2\216#3=BA=E2!=B2\231)@=D9*=ED=FC=BB=DC7\233Bm=DC\=
005^=B7\034=F1=CFO=E4=A8\205=C8=E6f\227\024e=A62=ACf=D0\tY=BE}=D1=B3\21=
2,=FB\027=EE<=EA\236[=B3w\234\204*(=CD)=C9d0=F8\024\030n\233=F8=ECP\210=
\214=FCDS=C6?=F3\216=BD=B9>\a")
at sha1_file.c:1259
#1  0x00000000004fb8df in unpack_sha1_header (stream=3D0x7fffffffc9f0,
    map=3D0x3268e000
"x\001+)JMU043g040031Qp=F6M=CCN=F5=C9,.)=D6+=A9(a=F8t*=E4=E3=FA=BD\v=CD=
4\236Y=F1\230=A4&z=AF=DF<{=BA\211\001\020(=A4eV0\024\177=F2\177=E1$\\$\=
034\224\036=F6*=F7v=C2\216#3=BA=E2!=B2\231)@=D9*=ED=FC=BB=DC7\233Bm=DC\=
005^=B7\034=F1=CFO=E4=A8\205=C8=E6f\227\024e=A62=ACf=D0\tY=BE}=D1=B3\21=
2,=FB\027=EE<=EA\236[=B3w\234\204*(=CD)=C9d0=F8\024\030n\233=F8=ECP\210=
\214=FCDS=C6?=F3\216=BD=B9>\a",
mapsize=3D173,
    buffer=3D0x7fffffffa9f0, bufsiz=3D8192) at sha1_file.c:1308
#2  0x00000000004fbc85 in unpack_sha1_file (map=3D0x3268e000,
mapsize=3D173, type=3D0x7fffffffcbf0, size=3D0x7fffffffcbe8,
    sha1=3D0x7fffffffcbd0 "\001/=C74&=E7=AE=BA\036=A9 wK`\214\"=CB\035H=
\203") at
sha1_file.c:1435
#3  0x00000000004fd96c in read_object (sha1=3D0x7fffffffcbd0
"\001/=C74&=E7=AE=BA\036=A9 wK`\214\"=CB\035H\203", type=3D0x7fffffffcb=
f0,
size=3D0x7fffffffcbe8)
    at sha1_file.c:2233
#4  0x00000000004fda0d in read_sha1_file_extended (sha1=3D0x7fffffffcbd=
0
"\001/=C74&=E7=AE=BA\036=A9 wK`\214\"=CB\035H\203", type=3D0x7fffffffcb=
f0,
size=3D0x7fffffffcbe8,
    flag=3D1) at sha1_file.c:2258
#5  0x00000000004fdcda in read_sha1_file (sha1=3D0x7fffffffcbd0
"\001/=C74&=E7=AE=BA\036=A9 wK`\214\"=CB\035H\203", type=3D0x7fffffffcb=
f0,
size=3D0x7fffffffcbe8)
    at cache.h:761
#6  0x00000000004fdbb1 in read_object_with_reference (sha1=3D0x334a8130
"\001/=C74&=E7=AE=BA\036=A9 wK`\214\"=CB\035H\203", required_type_name=3D=
0x55a1a0
"tree",
    size=3D0x7fffffffcc30, actual_sha1_return=3D0x0) at sha1_file.c:229=
9
#7  0x0000000000510f50 in fill_tree_descriptor (desc=3D0x7fffffffcd10,
sha1=3D0x334a8130 "\001/=C74&=E7=AE=BA\036=A9 wK`\214\"=CB\035H\203") a=
t
tree-walk.c:57
#8  0x00000000005133dd in traverse_trees_recursive (n=3D1, dirmask=3D1,
df_conflicts=3D0, names=3D0x349d68a0, info=3D0x7fffffffd020) at
unpack-trees.c:456
#9  0x0000000000514239 in unpack_callback (n=3D1, mask=3D1, dirmask=3D1=
,
names=3D0x349d68a0, info=3D0x7fffffffd020) at unpack-trees.c:809
#10 0x00000000005119c9 in traverse_trees (n=3D1, t=3D0x7fffffffd0b0,
info=3D0x7fffffffd020) at tree-walk.c:407
#11 0x000000000051342d in traverse_trees_recursive (n=3D1, dirmask=3D0,
df_conflicts=3D0, names=3D0x349d6860, info=3D0x7fffffffd3c0) at
unpack-trees.c:460
#12 0x0000000000514239 in unpack_callback (n=3D1, mask=3D1, dirmask=3D1=
,
names=3D0x349d6860, info=3D0x7fffffffd3c0) at unpack-trees.c:809
#13 0x00000000005119c9 in traverse_trees (n=3D1, t=3D0x7fffffffd450,
info=3D0x7fffffffd3c0) at tree-walk.c:407
#14 0x000000000051342d in traverse_trees_recursive (n=3D1, dirmask=3D0,
df_conflicts=3D0, names=3D0x349d6840, info=3D0x7fffffffd760) at
unpack-trees.c:460
#15 0x0000000000514239 in unpack_callback (n=3D1, mask=3D1, dirmask=3D1=
,
names=3D0x349d6840, info=3D0x7fffffffd760) at unpack-trees.c:809
#16 0x00000000005119c9 in traverse_trees (n=3D1, t=3D0x7fffffffda40,
info=3D0x7fffffffd760) at tree-walk.c:407
#17 0x0000000000514af5 in unpack_trees (len=3D1, t=3D0x7fffffffda40,
o=3D0x7fffffffd830) at unpack-trees.c:1063
#18 0x000000000049f140 in diff_cache (revs=3D0x7fffffffdaf0,
tree_sha1=3D0x32f3b094 "=F2\032'\023\220U", tree_name=3D0x546766 "HEAD"=
,
cached=3D1) at diff-lib.c:476
#19 0x000000000049f18a in run_diff_index (revs=3D0x7fffffffdaf0,
cached=3D1) at diff-lib.c:484
#20 0x000000000049f34d in index_differs_from (def=3D0x546766 "HEAD",
diff_flags=3D0) at diff-lib.c:519
#21 0x0000000000470288 in do_pick_commit (commit=3D0x32f3b000,
opts=3D0x7fffffffe270) at builtin/revert.c:502
#22 0x0000000000471d38 in single_pick (cmit=3D0x32f3b000,
opts=3D0x7fffffffe270) at builtin/revert.c:1069
#23 0x0000000000471ea9 in pick_revisions (opts=3D0x7fffffffe270) at
builtin/revert.c:1113
#24 0x0000000000472045 in cmd_cherry_pick (argc=3D2,
argv=3D0x7fffffffe4c0, prefix=3D0x6a81c1 ) at builtin/revert.c:1161
#25 0x0000000000405093 in run_builtin (p=3D0x65d190, argc=3D2,
argv=3D0x7fffffffe4c0) at git.c:308
#26 0x0000000000405288 in handle_internal_command (argc=3D2,
argv=3D0x7fffffffe4c0) at git.c:467

It always interrupts inside experimental_loose_object, when reading
memory-mapped data from disk(?).

git diff <commit>^ <commit>

works blazingly fast, so I assume that cherry-picking should also be,
but it is not. What can I do to make the cherry-picking go quicker?

I am using git 1.7.10 on FreeBSD 7.2.

--=20
Dmitry Risenberg
