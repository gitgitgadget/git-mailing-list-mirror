From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: RFC: git send-email and error handling
Date: Thu, 14 Apr 2011 20:30:26 -0400
Message-ID: <4DA791A2.3010901@windriver.com>
References: <4DA754A4.3090709@windriver.com> <20110414210913.GC6525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 02:31:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAWx4-0003Wk-R8
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 02:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845Ab1DOAbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 20:31:53 -0400
Received: from mail.windriver.com ([147.11.1.11]:39983 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783Ab1DOAbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 20:31:53 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p3F0VWQo001990;
	Thu, 14 Apr 2011 17:31:45 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 14 Apr 2011 17:30:27 -0700
Received: from [128.224.146.65] ([128.224.146.65]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 14 Apr 2011 17:30:27 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Thunderbird/3.1.9
In-Reply-To: <20110414210913.GC6525@sigill.intra.peff.net>
X-OriginalArrivalTime: 15 Apr 2011 00:30:27.0693 (UTC) FILETIME=[518E91D0:01CBFB04]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171573>

On 11-04-14 05:09 PM, Jeff King wrote:
> On Thu, Apr 14, 2011 at 04:10:12PM -0400, Paul Gortmaker wrote:
> 
>> The command line (git 1.7.4.4) is typically something like:
>>
>> git send-email --to stable@kernel.org --to linux-kernel@vger.kernel.org \
>>    --cc stable-review@kernel.org   some_patch_dir
>>
>> So, let me get to what happened today:  After sending 113 out of 209
>> patches, it came to the 114th patch, and gave me this:
>>
>> (mbox) Adding cc: Dmitry Torokhov <dmitry.torokhov@gmail.com> from line 'From: Dmitry Torokhov <dmitry.torokhov@gmail.com>'
>> (body) Adding cc: Dmitry Torokhov <dtor@mail.ru> from line 'Signed-off-by: Dmitry Torokhov <dtor@mail.ru>'
>> (body) Adding cc: Paul Gortmaker <paul.gortmaker@windriver.com> from line 'Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>'
>> 5.2.1 <dtor@mail.ru>... Mailbox disabled for this recipient
>>
>> Then, taking that as a hard error, it simply exited,
>> leaving me scrambling to figure out how to quickly fix the
>> offending patch and continue with the unsent queue.
> 
> I suspect part of the issue is that your mail setup is unlike that of
> most people. Usually, we would deliver to some local MTA (either by SMTP
> directly, by sendmail that speaks SMTP to a smarthost, or by sendmail
> that queues directly); that MTA would queue the message in a spool for
> you, and attempt delivery asynchronously.  So the errors generally come
> all or nothing. You can queue mail, or you can't, and trying again and
> again after each error is just wasteful and annoying. Eventual errors
> are reported back to you as bounces.
> 
> Your setup seems different; it looks like your sendmail (or the SMTP
> server you connect to) actually routes the mail without queueing at all,
> and you synchronously get the final word on whether it can be delivered.
> Or maybe it just connects to the recipient site and checks that "RCPT
> TO" works before actually queueing. It's hard to say from the snippet
> above. What's your MTA?

Yes, the above is true -- I'm not queuing anything locally or involving
a local MTA.  I've set sendemail.smtpserver in my ~/.gitconfig to the
hostname of an infrastructural server running sendmail (telnet 25 doesnt
show me what version, but I'm told it is sendmail).  This configuration
gives me the most portability to run on any random machine within our
org without having to wonder if it has a locally installed and correctly
configured MTA -- it works so well, I've even abused git send-email to
dispatch random (non-patch) mails from ad-hoc scripts on occasions, simply
because I know everyone has git installed somewhere in $PATH.

> 
> I can see in your case how it would be preferable to keep going through
> the list and then assemble a set of errors at the end. But that should
> be configurable, because most setups won't want that behavior.
> 
>>  From my point of view, the right thing to do here would have
>> been to ignore the error on the harvested mail address, and continue
>> on through the rest of the queue.
> 
> It's a little tricky, because send-email may not know the details of
> what happened, especially if this behavior comes from a sendmail
> wrapper rather than SMTP. We dump the message and a list of recipients
> to an external program, and then get back a "yes it was sent" or "no it
> was not" code. So we can't do anything clever, like say "Well, it was
> sent, but not to one particular address, but that's OK because that
> address was auto-harvested from a signed-off-by line".

True.  I wonder if there is some flexibility in what we do, depending
on whether the setting is a local binary like /usr/bin/sendmail, vs.
a hostname of a server, like it was in my case...

> 
> Whether we can do better depends on your MTA. _If_ you are sending via
> SMTP, and _if_ it will reject particular recipients at the time of "rcpt
> to", then we could do something that clever. Given that the 5.2.1
> message appeared on your terminal, and that it should not have been
> generated by git-send-email, that implies to me you are using the local
> sendmail binary.
> 
>> Or even interactively ask me what to do when it saw the 5.2.1 failure.
>> But maybe that wouldn't be right for everyone.  I didn't see anything
>> in the GSE man page that would let me configure this behaviour either.
> 
> The problem there is that the message probably was not actually sent (or
> at least, sendmail presumably returned an error code to git, which is
> why git stopped). And you, as a human, saw that the error was something
> survivable. But you can't just tell git "it's OK to continue". You need
> to actually fix the problem and re-send, which means telling git that
> the one particular address is not interesting. And that is a lot more
> interface than just yes/no.
> 
> I would think what you really want is a system that tries to send
> everything, keeps track of which recipients are to receive which
> message, and then marks success or failure for each. At the end, you
> would find that dtor@mail.ru didn't receive anything, and realize you
> don't care. And you don't have to worry about restarting a failed
> send-email and sending duplicates. You know who got what.
> 
> If that sounds good, then you should consider switching MTAs, because
> that is exactly what the job of an MTA is. :)

I could set up a local queue, and for the big batches of patches I
may do that, but the portability of having sendemail.smtpserver pointing
at a host instead of a program is too nice for me to be willing to
give that up globally.

P.

> 
> -Peff
