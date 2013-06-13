From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: slow process of post-receive script on a remote (samba) share
Date: Thu, 13 Jun 2013 14:19:57 +0200
Message-ID: <87li6eqk2a.fsf@linux-k42r.v.cablecom.net>
References: <CAH+Cn14TLpR1KT+3GND2Zmb8tDmFBP7AWpyrT7nVeMFw6V7FGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Tamas Csabina <tcsabina@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 14:20:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un6Vw-00061P-MG
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 14:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667Ab3FMMUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 08:20:01 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:2284 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864Ab3FMMUA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 08:20:00 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 13 Jun
 2013 14:19:51 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 13 Jun 2013 14:19:57 +0200
In-Reply-To: <CAH+Cn14TLpR1KT+3GND2Zmb8tDmFBP7AWpyrT7nVeMFw6V7FGA@mail.gmail.com>
	(Tamas Csabina's message of "Thu, 13 Jun 2013 11:18:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227723>

Tamas Csabina <tcsabina@gmail.com> writes:

> I am using Git bash from version 1.8.3.msysgit.0, on a Windows 7x64 PC.
> I have an issue with executing git push if I have a post-receive
> script configured.
> The content of the script is not really important, as if I have a
> script that contains only commented out lines (around 70 lines), my
> git push command is delayed with around 5 seconds.
>
>
> I`ve tested the script on another PC and it is working fine. No delay
> at all. So there are some issues on my PC regarding how git processes
> remote scripts.
>
> I took a wireshark trace with 2 scenarios on my PC:
>
>  1. just execute `cat <path_to_the_script>\post-receive` command in the git bash
>  2. did a `real` git push
>
> Results of the wireshark traces shows:
>
>  1. Read AndX Request, FID: 0x228f, 1024 bytes at offset 0 (1024 bytes
> at time, always)
>  2. Read AndX Request, FID: 0x21c9, 1 byte at offset 0 (1 byte, always)
>
> Conclusion:
> git push command reads the post-receive script in 1 byte chunks, which
> dramatically slows down the execution process.

git doesn't read the script; the interpreter does.  In the case of a
script, the interpreter is specified in the #! line at the top; in the
case of a binary executable, it is specified within the executable (and
for linux, is usually /lib/ld-linux.so.2).

Exactly the same should happen if you run the hook manually, so you can
try that to debug it.

Note also that Weird Things(tm) relating to SIGPIPE may happen if you
don't read your input.  Even if you are only fooling around for testing,
a post-receive hook must consume its input, e.g., by discarding it with
'cat >/dev/null'.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
