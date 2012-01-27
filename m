From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] run-command: Error out if interpreter not found
Date: Fri, 27 Jan 2012 03:41:45 -0600
Message-ID: <20120127094145.GA2611@burratino>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-6-git-send-email-fransklaver@gmail.com>
 <20120124232421.GH8222@burratino>
 <op.v8moybu10aolir@keputer>
 <4F205028.4060606@kdbg.org>
 <7vr4ym2rad.fsf@alter.siamese.dyndns.org>
 <CAH6sp9NEnkDY-BCccW9VM3waxg8sG8zV5-rVAuMUfZ9rji4-Qw@mail.gmail.com>
 <20120127084845.GC806@burratino>
 <CAH6sp9O7P8bmYA66fY754mn=ogp8OP1i3KQuE_hnrTY46nNAxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 10:42:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqiJo-00040j-Ta
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 10:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239Ab2A0Jl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 04:41:59 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46035 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab2A0Jlz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 04:41:55 -0500
Received: by iacb35 with SMTP id b35so1842137iac.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 01:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2lt8HD+EdOWOWHiMO/BuEQrNyitE8r9xNbnJYxZwF1o=;
        b=rxqvjEUFwyE1/MTwMelL8G6Vp5yUnEfzpjUK6fgSQv6u64aQxZWpXxEmL5iMNyloIf
         YhTXS54vNajinuX1iIgi6Z+zRdUk2b5DuaQFbwo1W3V451BsQyYOTgLFo7EPXJc9XGW4
         YXHiKH/NdjiXQj5QQBowJ5T1GhHtDGIm4Trrw=
Received: by 10.50.6.227 with SMTP id e3mr6320902iga.20.1327657313781;
        Fri, 27 Jan 2012 01:41:53 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gd2sm3429826igc.1.2012.01.27.01.41.52
        (version=SSLv3 cipher=OTHER);
        Fri, 27 Jan 2012 01:41:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAH6sp9O7P8bmYA66fY754mn=ogp8OP1i3KQuE_hnrTY46nNAxw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189210>

Frans Klaver wrote:

> Just for my understanding: before a command is executed, a pager
> (less/more or so) is started? We want to avoid starting the pager if
> we won't be able to execute the command?

See [1] for an example of a recent patch touching the relevant
code path.

For example: if I run "git --paginate foo", foo is an alias for bar,
and the "[pager] bar" configuration is set to point to "otherpager",
then without this safety git launches the default pager in preparation
for running git-foo, receives ENOENT from execvp("git-foo"), and then
the pager has already been launched and it is too late to launch
otherpager instead.

> On Fri, Jan 27, 2012 at 9:48 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> I want to like (b), but the downside seems unacceptable.
>
> The downside being: having to figure out what execvp is going to do?
> That would be tantamount to writing your own execvp.

Exactly.

>> I honestly
>> don't know if something like (a) would be a good idea if well
>> executed, so I was happy to have the opportunity to try to help
>> massage these patches into a form that would make the answer more
>> obvious.
>
> Given the above information, I'm happy to work on this

I see.

Well, as I said, I don't know. :)  And I don't want to give false
hopes --- it's perfectly possible and not even unlikely that this is a
dead end and any patch in this direction will turn out not to be a
good idea and not applied.

That's part of why I was really grateful to Hannes for the reminder to
take a step back for a moment and consider whether it's worth it.
Maybe there's another way or a more targetted way to take care of the
motivational original confusing scenario that leads to execvp errors.
(By the way, can you remind me which one that was?)

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/179635
