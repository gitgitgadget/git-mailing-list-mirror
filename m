From: Jeff King <peff@peff.net>
Subject: Re: segfault in git-remote-http
Date: Wed, 10 Apr 2013 15:11:03 -0400
Message-ID: <20130410191103.GA22914@sigill.intra.peff.net>
References: <20130407093812.cae0e19123f7b6d2061800aa@lavabit.com>
 <20130409084718.587e99aa7a935296867a84a1@lavabit.com>
 <20130409171623.GE21972@sigill.intra.peff.net>
 <20130409104134.a9a42b74ec33b3147cd45c81@lavabit.com>
 <20130409174735.GA23494@sigill.intra.peff.net>
 <20130409124044.908c160c718cc357a139354e@lavabit.com>
 <20130410043030.GD795@sigill.intra.peff.net>
 <20130410090850.bacd762ad52eb3643ca99927@lavabit.com>
 <20130410185114.GA18084@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 21:11:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0QO-0005Q6-GJ
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759380Ab3DJTLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:11:10 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39022 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897Ab3DJTLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:11:09 -0400
Received: (qmail 5443 invoked by uid 107); 10 Apr 2013 19:13:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 15:13:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 15:11:03 -0400
Content-Disposition: inline
In-Reply-To: <20130410185114.GA18084@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220727>

On Wed, Apr 10, 2013 at 02:51:14PM -0400, Jeff King wrote:

> As for why dmesg reports git-remote-http, I'm not sure. If you "strace
> -f" the command, you can see that git is running git-remote-https. Why
> the kernel chooses to report "git-remote-http", I don't know; you'd have
> to look into how the kernel makes that decision. But I doubt it is
> related to the reason for the segfault in the first place.

Ah, I see. The hard links are a red herring. The kernel's message uses
task->comm, which is presumably set by truncating the basename of the
program to 15 characters (16 bytes with a trailing NUL).

  3.6 /proc/<pid>/comm  & /proc/<pid>/task/<tid>/comm
  --------------------------------------------------------
  These files provide a method to access a tasks comm value. It also
  allows for a task to set its own or one of its thread siblings comm
  value. The comm value is limited in size compared to the cmdline
  value, so writing anything longer then the kernel's TASK_COMM_LEN
  (currently 16 chars) will result in a truncated comm value.

Try:

  $ echo 'int main() { sleep(5); *(int *)0=0; }' >foo.c
  $ gcc -o 12345678901234567890 foo.c
  $ ./123* &
  $ cat /proc/$!/comm
  123456789012345
  $ sleep 5; dmesg | tail -n 1
  [2602639.353584] 123456789012345[23062]: segfault at 0 ip 0000000000400524 sp 00007fff46bb0700 error 6 in 12345678901234567890[400000+1000]

In both cases we only get the first 15 bytes of the program name. And
indeed, "git-remote-http" is exactly 15 bytes. So it is dumb luck that
the limit is such that truncating the name makes it look like another
program.

-Peff
