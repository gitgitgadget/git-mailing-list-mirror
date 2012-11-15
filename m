From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCHv2 8/8] send-email: do not prompt for explicit repo ident
Date: Thu, 15 Nov 2012 11:28:46 +0100
Message-ID: <CAMP44s2NBGDRLUKhBTU+kNy7Fyn8T6qm3nneSbS4rrNN1oPgdw@mail.gmail.com>
References: <20121115003029.GA17550@sigill.intra.peff.net>
	<20121115003640.GH17819@sigill.intra.peff.net>
	<CAMP44s0d+g7bXCnOf55jZNNFS6uJ+4BDowx5uYxWBP4xA+-0zA@mail.gmail.com>
	<20121115083315.GA23377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 11:29:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYwgw-0001r0-Hb
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 11:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855Ab2KOK2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 05:28:48 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:47082 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964838Ab2KOK2r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 05:28:47 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1470295oag.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 02:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GoNF/Uqpk4+y3IJlTqDKjcCbTFnbvqEUPCi6ecgJwsw=;
        b=mzxJ7foFHOjzvdZB++mDD8+zYCn8zgygdUQqZEf25mYV69Fh5/HMMaScBlt3SqYySJ
         t8/s5qF3m519FYlPcU+h0G36PadDCEsgJ0txlpWC751LbQuCr9XVA5JiEPaO9rmjlEtL
         d7RcbRA+Q8N0KjiFABN636jJ7i3FCYQxDy+mu/4ywMBIbwAoBktoJKHcwJVrVFR2pRC5
         jCN9tS2PjsB7VS76I5yuu5p6h7cNKXr5GKKuiWUh7Mt1rBUYsHw2orojIG0ReOVyeG7X
         XPFxOGoaYDeFNfHz5LXmqvg9TzsCi+KmL0h2x9GUGc1ERipYkFH/IkgfLFE9dqWSf+h9
         HDDg==
Received: by 10.182.38.101 with SMTP id f5mr454976obk.80.1352975326478; Thu,
 15 Nov 2012 02:28:46 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Thu, 15 Nov 2012 02:28:46 -0800 (PST)
In-Reply-To: <20121115083315.GA23377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209812>

On Thu, Nov 15, 2012 at 9:33 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 15, 2012 at 03:08:42AM +0100, Felipe Contreras wrote:
>
>> I don't think there's any need for all that, this does the trick:
>>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index aea66a0..503e551 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -748,16 +748,11 @@ if (!$force) {
>>         }
>>  }
>>
>> -my $prompting = 0;
>>  if (!defined $sender) {
>>         $sender = $repoauthor || $repocommitter || '';
>> -       $sender = ask("Who should the emails appear to be from? [$sender] ",
>> -                     default => $sender,
>> -                     valid_re => qr/\@.*\./, confirm_only => 1);
>> -       print "Emails will be sent from: ", $sender, "\n";
>> -       $prompting++;
>>  }
>>
>> +my $prompting = 0;
>>
>> This passes all the current tests and the ones you added.
>
> It may pass on your system, but it will not on a system that meets the
> AUTOIDENT prerequisite (it fails the new t9001.19 on my system; I
> suspect your system config is such that we skip t9001.19 and run
> t9001.20, whereas mine is the opposite).

I tried both:

ok 19 # skip implicit ident prompts for sender (missing AUTOIDENT of
PERL,AUTOIDENT)
ok 20 - broken implicit ident aborts send-email

ok 19 - implicit ident prompts for sender
ok 20 # skip broken implicit ident aborts send-email (missing
!AUTOIDENT of PERL,!AUTOIDENT)

However, it would be much easier if ident learned to check
GIT_TEST_FAKE_HOSTNAME, or something.

But then I realized I had to run 'make' again. Yes, my patch breaks
test 19, but see below.

>> Which kind of user will get the prompt with your patch, that would
>> miss it with mine?
>
> One whose system is configured in such a way that git can produce an
> automatic ident (i.e., has a non-blank GECOS name and a FQDN).

And doesn't have any of the following:

 * configured user.name/user.email
 * specified $EMAIL
 * configured sendemail.from
 * specified --from argument

Very unlikely. And then, what would be the consequences of not
receiving this prompt?

Cheers.

-- 
Felipe Contreras
