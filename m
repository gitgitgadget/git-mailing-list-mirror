From: Markos Chandras <Markos.Chandras@imgtec.com>
Subject: git rerere is confused with identical conflicts in multiple files
Date: Fri, 10 Jul 2015 09:04:17 +0100
Message-ID: <559F7C81.50805@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 10:04:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDTIN-0001aJ-Dv
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 10:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbbGJIE0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2015 04:04:26 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:36288 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbbGJIEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 04:04:21 -0400
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
	by Websense Email Security Gateway with ESMTPS id D5F19C51861F8
	for <git@vger.kernel.org>; Fri, 10 Jul 2015 09:04:16 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 09:04:18 +0100
Received: from [192.168.154.48] (192.168.154.48) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 10 Jul
 2015 09:04:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
X-Originating-IP: [192.168.154.48]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273807>

Hi,

(Please keep me on CC as I am not subscribed to the list)

I am having a weird problem when merging a branch which causes some
conflicts

This is the initial status for the rerere cache

$ tree .git/rr-cache
=2Egit/rr-cache [error opening dir]

0 directories, 0 files


I then go ahead and merge the said branch and I end up with the
following conflicts

Auto-merging arch/mips/mm/sc-mips.c
Auto-merging arch/mips/mm/c-r4k.c
CONFLICT (content): Merge conflict in arch/mips/mm/c-r4k.c
Auto-merging arch/mips/kernel/traps.c
CONFLICT (content): Merge conflict in arch/mips/kernel/traps.c
Auto-merging arch/mips/kernel/spram.c
CONFLICT (content): Merge conflict in arch/mips/kernel/spram.c
Auto-merging arch/mips/kernel/idle.c
CONFLICT (content): Merge conflict in arch/mips/kernel/idle.c
Auto-merging arch/mips/kernel/cpu-probe.c
Auto-merging arch/mips/include/asm/mipsregs.h
Auto-merging arch/mips/include/asm/cpu.h
CONFLICT (content): Merge conflict in arch/mips/include/asm/cpu.h
Auto-merging arch/mips/include/asm/cpu-type.h
CONFLICT (content): Merge conflict in arch/mips/include/asm/cpu-type.h
Recorded preimage for 'arch/mips/include/asm/cpu-type.h'
Recorded preimage for 'arch/mips/include/asm/cpu.h'
Automatic merge failed; fix conflicts and then commit the result.

As you see, git only records two preimage files instead of 6.

the rr-cache is like this now

$ tree .git/rr-cache
=2Egit/rr-cache
=E2=94=9C=E2=94=80=E2=94=80 5563edc0fb427275a0ca5677c93c40def8b53258
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 preimage
=E2=94=94=E2=94=80=E2=94=80 f175ff6228f624296b661664bce4ab4e84d712cc
    =E2=94=94=E2=94=80=E2=94=80 preimage

2 directories, 2 files

and .git/MERGE_RR

$ cat .git/MERGE_RR
5563edc0fb427275a0ca5677c93c40def8b53258
arch/mips/include/asm/cpu-type.hf175ff6228f624296b661664bce4ab4e84d712c=
c

arch/mips/include/asm/cpu.h5563edc0fb427275a0ca5677c93c40def8b53258
   arch/mips/kernel/idle.c5563edc0fb427275a0ca5677c93c40def8b53258
arch/mips/kernel/spram.c5563edc0fb427275a0ca5677c93c40def8b53258
arch/mips/kernel/traps.c5563edc0fb427275a0ca5677c93c40def8b53258
arch/mips/mm/c-r4k.c

so as you see, multiple files share the same hash. That's probably
because the "conflicting context ( the part between >>> <<<<)" in every
file but cpu.h is identical and git seems to calculate the hash purely
on the conflicting context. That makes git rerere thinks that it only
has to resolve 2 conflicts instead of 6.

Does anyone have an idea how to resolve that? If my assumption is
correct (I only looked at the git code briefly) I believe it would make
sense to throw the filepath into the sha1 calculation as well in order
to ensure it will not conflict with similar changes across different fi=
les.

--=20
markos
