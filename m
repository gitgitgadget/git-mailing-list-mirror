From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: git-status segmentation fault in master / OS X
Date: Wed, 20 Jan 2010 10:43:33 +0000
Message-ID: <57518fd11001200243v416aa5f9o37a3b5b92bef3b57@mail.gmail.com>
References: <57518fd11001190959n355a0f22p7caa7251b705efaf@mail.gmail.com> 
	<20100120004146.GB16824@coredump.intra.peff.net> <7vd4157fwt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 11:44:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXY2q-0004HX-2S
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 11:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523Ab0ATKoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2010 05:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081Ab0ATKoB
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 05:44:01 -0500
Received: from juliet.asmallorange.com ([207.210.105.70]:45529 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab0ATKn7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 05:43:59 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:37080)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1NXY2X-0002lg-Uu
	for git@vger.kernel.org; Wed, 20 Jan 2010 05:43:58 -0500
Received: by ewy1 with SMTP id 1so2719928ewy.28
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 02:43:54 -0800 (PST)
Received: by 10.216.85.70 with SMTP id t48mr2988560wee.84.1263984233154; Wed, 
	20 Jan 2010 02:43:53 -0800 (PST)
In-Reply-To: <7vd4157fwt.fsf@alter.siamese.dyndns.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137539>

2010/1/20 Junio C Hamano <gitster@pobox.com>:
> Jeff King <peff@peff.net> writes:
>
>> Could be a bad interaction between commits on nd/sparse and whatever=
 was
>> done since it had branched. You can try rebasing nd/sparse and bisec=
ting
>> a linearised version, like this:
>>
>> =C2=A0 bad_merge=3D73d66323
>> =C2=A0 # pretend we are on nd/sparse
>> =C2=A0 git checkout -b test $bad_merge^2
>> =C2=A0 # rebase onto what we merged onto
>> =C2=A0 git rebase $bad_merge^1
>
> That is a very good suggestion.
>
> You will get hit by a few conflicts during the rebase, but I managed =
to
> arrive at the same tree as $bad_merge after running the rebase proced=
ure
> above. =C2=A0Just for Jonathan's convenience, the result is at:
>
> =C2=A0git://repo.or.cz/alt-git.git junk-linearized-nd-sparse-for-bise=
ction
>
> I'll remove this after a few days.
>
>> =C2=A0 # now bisect. what we have now is presumably
>> =C2=A0 # bad (though you should probably double check)
>> =C2=A0 # and from the previous bisect we know that
>> =C2=A0 # everything pre-merge is good
>> =C2=A0 git bisect start
>> =C2=A0 git bisect good $bad_merge^1
>> =C2=A0 git bisect bad
>
> It would be interesting to hear the result of the test in the particu=
lar
> repository Jonathan is seeing the problem with. =C2=A0The issue didn'=
t
> reproduce for me, either but I only tried "having a staged change" ca=
se
> without any more detailed set-up.
>

OK, found some more interesting results from that.  The new bad commit =
is :

commit 66dce7bdb6742cb06433f8ef25441690b71c7995
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Thu Aug 20 20:47:01 2009 +0700

    Read .gitignore from index if it is skip-worktree


I still haven't been able to come up with a minimal test case, but gdb
gave me this:

Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_INVALID_ADDRESS at address: 0x00000000000001c8
0x0000000100093e69 in excluded_1 (pathname=3D0x7fff5fbfd8b0
"shared/config/environments/.gitignore", pathlen=3D37,
basename=3D0x7fff5fbfd8cb ".gitignore", dtype=3D0x7fff5fbfd8a4,
el=3D0x7fff5fbfeb00) at dir.c:378
378					if (*exclude =3D=3D '/')
(gdb) bt
#0  0x0000000100093e69 in excluded_1 (pathname=3D0x7fff5fbfd8b0
"shared/config/environments/.gitignore", pathlen=3D37,
basename=3D0x7fff5fbfd8cb ".gitignore", dtype=3D0x7fff5fbfd8a4,
el=3D0x7fff5fbfeb00) at dir.c:378
#1  0x0000000100093fd0 in excluded (dir=3D0x7fff5fbfeac0,
pathname=3D0x7fff5fbfd8b0 "shared/config/environments/.gitignore",
dtype_p=3D0x7fff5fbfd8a4) at dir.c:410
#2  0x0000000100094a10 in read_directory_recursive
(dir=3D0x7fff5fbfeac0, base=3D0x7fff5fbfdd20
"shared/config/environments/", baselen=3D27, check_only=3D0, simplify=3D=
0x0)
at dir.c:688
#3  0x0000000100094bfa in read_directory_recursive
(dir=3D0x7fff5fbfeac0, base=3D0x7fff5fbfe190 "shared/config/", baselen=3D=
14,
check_only=3D0, simplify=3D0x0) at dir.c:727
#4  0x0000000100094bfa in read_directory_recursive
(dir=3D0x7fff5fbfeac0, base=3D0x7fff5fbfe600 "shared/", baselen=3D7,
check_only=3D0, simplify=3D0x0) at dir.c:727
#5  0x0000000100094bfa in read_directory_recursive
(dir=3D0x7fff5fbfeac0, base=3D0x1000f48d0 "", baselen=3D0, check_only=3D=
0,
simplify=3D0x0) at dir.c:727
#6  0x0000000100094ecc in read_directory (dir=3D0x7fff5fbfeac0,
path=3D0x1000f48d0 "", len=3D0, pathspec=3D0x0) at dir.c:813
#7  0x0000000100093118 in fill_directory (dir=3D0x7fff5fbfeac0,
pathspec=3D0x0) at dir.c:70
#8  0x00000001000e85a7 in wt_status_collect_untracked
(s=3D0x7fff5fbfef80) at wt-status.c:346
#9  0x00000001000e86cc in wt_status_collect (s=3D0x7fff5fbfef80) at
wt-status.c:366
#10 0x000000010001e467 in cmd_status (argc=3D0, argv=3D0x7fff5fbff248,
prefix=3D0x0) at builtin-commit.c:1026
#11 0x0000000100001b52 in run_builtin (p=3D0x10013e3b0, argc=3D1,
argv=3D0x7fff5fbff248) at git.c:257
#12 0x0000000100001d04 in handle_internal_command (argc=3D1,
argv=3D0x7fff5fbff248) at git.c:401
#13 0x0000000100001e83 in main (argc=3D1, argv=3D0x7fff5fbff248) at git=
=2Ec:482


"shared/config/environments/.gitignore" contained just
"_local_config.rb", no newline.  It seemed like adding or removing
characters from that file would 'fix' the problem, but changing them
wouldn't (ie the problem was always there when .gitignore was 16
bytes), but I'm not entirely sure because it continues to be a bit of
a Schrodinger bug.


One thing I wondered about from that commit - shouldn't the "buf =3D
xmalloc(size);" on dir.c:252 be "buf =3D xmalloc(size+1);" ?  I haven't
really looked at the program flow there, so may be wrong...
