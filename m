From: Marko Poutiainen <regs@sofistes.net>
Subject: Re: Gitignore matching "git add" wildcard prevents operation
Date: Thu, 14 Jan 2010 23:07:44 +0200
Message-ID: <4B4F87A0.2090301@sofistes.net>
References: <4B4F6000.4070005@sofistes.net> <20100114195234.GA26684@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 22:08:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVWvF-0001Mp-7r
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 22:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263Ab0ANVHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 16:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151Ab0ANVHw
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 16:07:52 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:41902 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242Ab0ANVHu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 16:07:50 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 8CF25EF484;
	Thu, 14 Jan 2010 23:07:48 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A00C656E5B4; Thu, 14 Jan 2010 23:07:48 +0200
Received: from [192.168.0.24] (a91-155-40-90.elisa-laajakaista.fi [91.155.40.90])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 63F8227D9C;
	Thu, 14 Jan 2010 23:07:46 +0200 (EET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20100114195234.GA26684@coredump.intra.peff.net>
X-Enigmail-Version: 0.96.0
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137025>

Jeff King wrote:
> On Thu, Jan 14, 2010 at 08:18:40PM +0200, Marko Poutiainen wrote:
> 
>> It seems that that there is a bug related to how Git handles the add
>> command with wildcards if the wildcard also matches a file that is ignored.
>>
>> E.g (I activate the *.[ao] rule when editing .git/info/exclude):
>>
>> mep@Blackbird:~$ cd /tmp
>> mep@Blackbird:/tmp$ mkdir git
>> mep@Blackbird:/tmp$ cd git
>> mep@Blackbird:/tmp/git$ git init
>> Initialized empty Git repository in /tmp/git/.git/
>> mep@Blackbird:/tmp/git$ nano -w .git/info/exclude
>> mep@Blackbird:/tmp/git$ touch a.o a.c a.h
>> mep@Blackbird:/tmp/git$ git add a.*
>> The following paths are ignored by one of your .gitignore files:
>> a.o
>> Use -f if you really want to add them.
>> fatal: no files added
> 
> It's not a bug. That is working as designed. If "git add" encounters a
> problem with any of the files you gave it on the command line (and
> remember, the shell expands the wildcard, so git literally sees the
> three files on the command line) then it aborts the entire operation.
> 
> Now whether that is useful behavior in this case, I don't know. If you
> were truly manually specifying the files, then it would probably not be
> a big deal to simply remove the offending file. But there is no way to
> use the shell wildcard and get the behavior you want (not even a "git
> add --really-ignore-my-ignores a.*").
> 
> I don't think it would be right to silently ignore them, because it may
> be the sign of an error. It could be downgraded to a warning, like:
> 
>   $ git add *.a
>   warning: a.o is ignored, not adding
> 
> The downside would be that somebody who really _did_ want to add such a
> file but forgot to use "-f" is going to be less likely to notice it, as
> the command does not barf. So maybe such behavior should be triggered
> with a command-line option. I dunno.

Well, it then the interface just isn't consistent, because if that's the
reason, then why does

$git add .

then work in this case? . is still just a type of wildcard, so it fail
in a similar way, shouldn't it?

Your idea of giving a warning is good as is the command-line option. In
any case, in my opinion this feature can make some operations more
complex than they should be. For instance, in my example I would have to
separately do git add to both files. What if there are more than two
files to add and I get this error every time I try to add the files?
