From: William Pursell <bill.pursell@gmail.com>
Subject: Re: permissions
Date: Sat, 05 Jun 2010 23:36:50 -1000
Message-ID: <4C0B6C32.1090700@wpursell.net>
References: <4C0A19FE.1020802@wpursell.net>	<m27hmdn704.fsf@igel.home>	<4C0A9615.4090307@wpursell.net> <AANLkTileRHwUuJpvKJbivRiM9Prn9wJ0zH6abExBgcq0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: William Pursell <bill.pursell@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 06 11:37:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLCHt-0000Wy-DK
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 11:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682Ab0FFJg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 05:36:56 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49169 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab0FFJgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 05:36:55 -0400
Received: by pwj5 with SMTP id 5so506799pwj.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 02:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=fFSojv3M5OblMRLZ1bY5Y24SCodKGCf4r96aMp5TEQs=;
        b=VqLPIJioHeD0Up/c+xwyL/f2Y4bq24981EiaBzB1ASmDW+vfr9o+NlS3BA21yatvQw
         QIz6E7bT5SiK9UXTVPT+tqjMHc9c3x7MFaFyBh7udVBqldzYpJbYnPwMWIi+gz+L2uve
         Yy9oaRRfuARuvk7numdzkgFJI4jJgPVJ14Og4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=SQkgsglvYJ5sDYOdqRMYS298pRiAJ1EnOOO9KfX8aVDdR3yFg3/O3TFA/OEwmNgEKY
         swi+6lTzJKV4O/NbqIC1KGB9DnnVqfhwfVD0PJDNx2n2m8rrh8C6eUWEVsHE2BTJTmH+
         3EnCgfcDKzaeM0/MoDG612/nJsWz/IrH47aMQ=
Received: by 10.142.56.4 with SMTP id e4mr9488096wfa.308.1275817014920;
        Sun, 06 Jun 2010 02:36:54 -0700 (PDT)
Received: from clam.westell.com (udp278831uds.hawaiiantel.net [72.234.51.251])
        by mx.google.com with ESMTPS id a23sm27213464wam.2.2010.06.06.02.36.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 02:36:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Macintosh/20100228)
In-Reply-To: <AANLkTileRHwUuJpvKJbivRiM9Prn9wJ0zH6abExBgcq0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148511>

Alex Riesen wrote:
> On Sat, Jun 5, 2010 at 20:23, William Pursell <bill.pursell@gmail.com> wrote:
>> fatal: Not a git repository (or any of the parent directories): .git
>>
>> That's just weird.  And if there is a git repository in a
>> directory above, there may be great confusion, weeping
>> and gnashing of teeth.
> 
> How about just this? (I assume cwd does hold current working directory).

<patch snipped>

The problem is permissions, not that it's "not a git repository".
The error message should be "permission denied".  The easy solution
is to abort with "permission denied" whenever that is encountered,
but the trouble with that is that it breaks the current work flow
in which a broken dir (or one for which the user lacks
priveleges) is bypassed and a valid object directory higher
up in the filesystem tree is used.

Consider the case in which /etc/.git has mode 777 while
/etc/sysconfig/.git has mode 700, each .git owned by root.
(Granted, git is for recording development history and
not so much for storing history of config files, but
I believe this is a relevant use case.)  /etc/sysconfig/foo
is tracked by /etc/sysconfig/.git but not by /etc/.git.
Regular user in /etc/sysconfig invokes 'git log foo'
and is told: absolutely nothing.   And when
'git status' is invoked, the message is that foo is
untracked.

Now, if /etc/.git does track /etc/sysconfig/foo,
then a regular user in /etc/sysconfig that invokes
'git log foo' sees the history tracked in /etc/.git,
but root in /etc/sysconfig sees the history tracked
by /etc/sysconfig/.git.  This is confusing.  The regular
user in /etc/sysconfig should simply get 'permission denied'
on all invocations of git.

A related question is: does anyone actually prefer (or
rely on) the current model in which ../.git is
used in the event that .git is borked or the user
lacks permission?  It seems to me that if an
object directory is discovered which is borked
or which is unreadable, git must abort with an
error message indicating the relevant problem.

-- 
William Pursell
