From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 5/5] run-command: Error out if interpreter not found
Date: Sat, 04 Feb 2012 22:31:27 +0100
Message-ID: <op.v86bepmh0aolir@keputer>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-6-git-send-email-fransklaver@gmail.com>
 <20120124232421.GH8222@burratino> <op.v8moybu10aolir@keputer>
 <4F205028.4060606@kdbg.org> <7vr4ym2rad.fsf@alter.siamese.dyndns.org>
 <CAH6sp9NEnkDY-BCccW9VM3waxg8sG8zV5-rVAuMUfZ9rji4-Qw@mail.gmail.com>
 <20120127084845.GC806@burratino>
 <CAH6sp9O7P8bmYA66fY754mn=ogp8OP1i3KQuE_hnrTY46nNAxw@mail.gmail.com>
 <20120127094145.GA2611@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j6t@kdbg.org>, git@vger.kernel.org,
	"Jeff King" <peff@peff.net>
To: "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 22:31:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtnCr-0008Pt-Vl
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 22:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262Ab2BDVbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 16:31:33 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40990 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973Ab2BDVbc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 16:31:32 -0500
Received: by eaah12 with SMTP id h12so1960661eaa.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 13:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=m9zIDiPlBD5u6DNpSF3C2jivqA/W+hYfLFNnbwqTFCk=;
        b=PgeGNy62yXNKv1BZ192Q8SkDNsBi7oeop89QkWQ1tiXMbrK9I5ewbqYmMj+7sLSsgS
         gE/Fq4KhTe+eYbqH/DNJbyQmg4FfkF6RKskQj0/BpwPq00VoBKDztaM1Jk8HEhjAK4xG
         uD+6WU+bMJgSJHqb0dL4b4BTCsjOpP4/rePEA=
Received: by 10.213.15.16 with SMTP id i16mr489467eba.87.1328391090286;
        Sat, 04 Feb 2012 13:31:30 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id y12sm39636464eeb.11.2012.02.04.13.31.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 13:31:29 -0800 (PST)
In-Reply-To: <20120127094145.GA2611@burratino>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189913>

On Fri, 27 Jan 2012 10:41:45 +0100, Jonathan Nieder <jrnieder@gmail.com>  
wrote:

> Frans Klaver wrote:
>
>> Just for my understanding: before a command is executed, a pager
>> (less/more or so) is started? We want to avoid starting the pager if
>> we won't be able to execute the command?
>
> See [1] for an example of a recent patch touching the relevant
> code path.
>
> For example: if I run "git --paginate foo", foo is an alias for bar,
> and the "[pager] bar" configuration is set to point to "otherpager",
> then without this safety git launches the default pager in preparation
> for running git-foo, receives ENOENT from execvp("git-foo"), and then
> the pager has already been launched and it is too late to launch
> otherpager instead.

Took me a while to catch your drift, but if I understand correctly, you're  
thinking using some of the code to find out if starting the pager is a  
good idea or not. If I factor out the part that finds a command in PATH,  
there's the helper that with a fair amount of certainty, will predict  
whether 'git foo' will fail with ENOENT or not. It would fix a possible  
problem that is currently there. Obviously the only case we can catch, is  
the command not actually existing. Although it is just one of the cases  
ENOENT can be returned for, I think it is the only one git actually cares  
about when checking for it.


>> On Fri, Jan 27, 2012 at 9:48 AM, Jonathan Nieder <jrnieder@gmail.com>  
>> wrote:
>
>>> I want to like (b), but the downside seems unacceptable.
>>
>> The downside being: having to figure out what execvp is going to do?
>> That would be tantamount to writing your own execvp.
>
> Exactly.

So as it seems, there are a few cases where we can fairly reliably predict  
whether a command is or isn't going to be found. Unless I'm mistaken,  
dashed externals are never shell built-ins and so we don't have to be able  
to check for their existence. Then assuming that silent_exec_failure  
really only cares about commands actually not existing, we can be fairly  
naive about it. See if we can find it somewhere in PATH and if we can't  
bail out. If we can, start the pager and everything execvp then returns  
will be regarded a fatal error. In this case it would be a choice between  
spawning the wrong pager, or having a quick browse through the file system.


> That's part of why I was really grateful to Hannes for the reminder to
> take a step back for a moment and consider whether it's worth it.

It may be a sensible reminder. I didn't understand that comment as such.  
Maybe it's Hannes' style, I don't know.


> Maybe there's another way or a more targetted way to take care of the
> motivational original confusing scenario that leads to execvp errors.
> (By the way, can you remind me which one that was?)

Been thinking about it and I doubt it. To find out whether EACCES is  
returned due to a PATH issue, you have to go through all of those PATH  
entries. So while you're at it, there's a lot more you can check and most  
of those checks are fairly trivial to do.

I think I've worked through all your review comments. I'll address Hannes'  
comments, create an RFC series and see where we end up.

Junio, care to be CC'd in that?

Thanks,
Frans


> [1] http://thread.gmane.org/gmane.comp.version-control.git/179635
