From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] diffcore-pickaxe: further refactor count_match()
Date: Fri, 27 Feb 2009 22:08:51 -0800
Message-ID: <7v8wnrgkjw.fsf@gitster.siamese.dyndns.org>
References: <cover.1235629933.git.gitster@pobox.com>
 <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com>
 <49A88FA7.1020402@lsrfire.ath.cx> <7vy6vrgxnn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Feb 28 07:14:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdITK-00073f-1c
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 07:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbZB1GJB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 01:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbZB1GJB
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 01:09:01 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbZB1GJA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 01:09:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CE1049DD5C;
	Sat, 28 Feb 2009 01:08:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5665E9DD5B; Sat,
 28 Feb 2009 01:08:54 -0500 (EST)
In-Reply-To: <7vy6vrgxnn.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 27 Feb 2009 17:25:48 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 490ADF2A-055E-11DE-81C8-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111749>

Junio C Hamano <gitster@pobox.com> writes:

> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
> ...
>> In any case, there is also memmem(), which uses the same fast algori=
thm
>> as strstr() in recent glibc versions.  Like this?
>
> Thanks; it would be nice to bench this change.

With memmem() patch applied on top of [1-4/4], the same test as describ=
ed
in the commit log message of [4/4] which was:

    $ STRING=3D'Ensure that the real time constraints are schedulable.'
    $ git log -S"$STRING" HEAD -- kernel/sched.c >/dev/null

    (Before the patch, best of 5 runs)
    5.59user 0.15system 0:05.74elapsed 99%CPU (0avgtext+0avgdata 0maxre=
sident)k
    0inputs+0outputs (0major+39956minor)pagefaults 0swaps

    (After the patch, best of 5 runs)
    3.04user 0.17system 0:03.23elapsed 99%CPU (0avgtext+0avgdata 0maxre=
sident)k
    0inputs+0outputs (0major+49697minor)pagefaults 0swaps

    The file "kernel/sched.c" has roughly 900 changes applied to it, an=
d over
    its lifetime, it has grown from 5kB to 9kB in size.  I'd expect a l=
arger
    file may see a bigger performance boost.

(With memmem() patch, best of 5 runs)
2.46user 0.15system 0:02.62elapsed 99%CPU (0avgtext+0avgdata 0maxreside=
nt)k
0inputs+0outputs (0major+49698minor)pagefaults 0swaps
