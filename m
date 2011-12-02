From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Fri, 02 Dec 2011 17:15:42 +0100
Message-ID: <4ED8F9AE.8030605@lsrfire.ath.cx>
References: <cover.1322830368.git.trast@student.ethz.ch> <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Herman <eric@freesa.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 02 17:16:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWVmR-0004WX-VN
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 17:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941Ab1LBQQB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Dec 2011 11:16:01 -0500
Received: from india601.server4you.de ([85.25.151.105]:38778 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864Ab1LBQQA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 11:16:00 -0500
Received: from [192.168.2.105] (p4FFD988F.dip.t-dialin.net [79.253.152.143])
	by india601.server4you.de (Postfix) with ESMTPSA id 43AB12F8039;
	Fri,  2 Dec 2011 17:15:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186224>

Am 02.12.2011 14:07, schrieb Thomas Rast:
> Measuring grep performance showed that in all but the worktree case
> (as opposed to --cached,<committish>  or<treeish>), threading
> actually slows things down.  For example, on my dual-core
> hyperthreaded i7 in a linux-2.6.git at v2.6.37-rc2, I got:
>
> Threads       worktree case                 | --cached case
> ---------------------------------------------------------------------=
-----
> 8 (default) | 2.17user 0.15sys 0:02.20real  | 0.11user 0.26sys 0:00.1=
1real
> 4           | 2.06user 0.17sys 0:02.08real  | 0.11user 0.26sys 0:00.1=
2real
> 2           | 2.02user 0.25sys 0:02.08real  | 0.15user 0.37sys 0:00.2=
8real
> NO_PTHREADS | 1.57user 0.05sys 0:01.64real  | 0.09user 0.12sys 0:00.2=
2real

Are the columns mixed up?

> I conjecture that this is caused by contention on read_sha1_mutex.

Yeah, and I wonder why we need to have this lock in the first place. In=
=20
theory, multiple readers shouldn't have to affect each other at all,=20
right?  The lock could be pushed down into read_sha1_file(), or a=20
thread-safe variant of the function added.

In pratice, however, the code in sha1_file.c etc. scares me. ;-)

> So disable threading entirely when not scanning the worktree, to get
> the NO_PTHREADS performance in that case.  This obsoletes all code
> related to grep_sha1_async.  The thread startup must be delayed until
> after all arguments have been parsed, but this does not have a
> measurable effect.

This is a bit radical.  I think the underlying issue that=20
read_sha1_file() is not thread-safe can be solved eventually and then=20
we'd need to readd that code.

How about adding a parameter to control the number of threads=20
(--threads?) instead that defaults to eight (or five) for the worktree=20
and one for the rest?  That would also make benchmarking easier.

Ren=E9

PS: Patches one and three missed a signoff.
