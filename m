From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Wed, 8 Jun 2016 21:30:21 +0200
Message-ID: <fb7795c4-60db-94b3-a584-8fadd0440773@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-5-samuel.groot@grenoble-inp.org>
 <xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
 <CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>, aaron@schrab.com,
	Eric Wong <e@80x24.org>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:30:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAjBY-00020P-Ld
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 21:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423664AbcFHTaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 15:30:30 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:54817 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423543AbcFHTa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 15:30:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 6AAEB20B4;
	Wed,  8 Jun 2016 21:30:21 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qe2eXAWWnLaO; Wed,  8 Jun 2016 21:30:21 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 4B8C820B2;
	Wed,  8 Jun 2016 21:30:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 3E7892066;
	Wed,  8 Jun 2016 21:30:21 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TTWD9Ye8j7Mf; Wed,  8 Jun 2016 21:30:21 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 1E7352064;
	Wed,  8 Jun 2016 21:30:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296840>

On 06/08/2016 08:12 PM, Eric Sunshine wrote:
> On Wed, Jun 8, 2016 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>>> +sub parse_email {
>>> +     my %mail = ();
>>> +     my $fh = shift;
>>> +     my $last_header;
>>
>>> +     # Unfold and parse multiline header fields
>>> +     while (<$fh>) {
>>> +             last if /^\s*$/;
>>
>> You stop at the end of fields before the message body starts.
>>
>>> +             s/\r\n|\n|\r//;
>>
>> The pattern is not anchored at the right end of the string;
>> intended?  Is it worth worrying about a lone '\r'?
>
> Thanks, I think you covered pretty much everything I was going to say.
> I'd just add that if the matching is going to be kept loose like this
> (rather than anchoring it), then s/[\r\n]+//g might be easier to read,
> but it's a minor point.

Indeed s/[\r\n]+//g is way better, it works even if there's a CR in the 
middle of the line.

>>> +             if (/^([^\s:]+):[\s]+(.*)$/) {
>>> +                     $last_header = lc($1);
>>> +                     @{$mail{$last_header}} = ()
>>> +                             unless defined $mail{$last_header};
>>> +                     push @{$mail{$last_header}}, $2;
>>
>>> +             } elsif (/^\s+\S/ and defined $last_header) {
>>> +                     s/^\s+/ /;
>>> +                     push @{$mail{$last_header}}, $_;
>>
>> Even though the comment said "unfold", you do not really do the
>> unfolding here and the caller can (if it wants to) figure out where
>> one logical header was folded in the original into multiple physical
>> lines, because you are returning an arrayref.
>
> Also, the comment about folding lines should be moved down the part of
> the code which is actually (supposed to be) doing the folding rather
> than having the comment at the top of the loop.

Will do in next re-roll.

>>> +     # Separate body from header
>>> +     $mail{"body"} = [(<$fh>)];
>>> +
>>> +     return \%mail;
>>
>> The name of the local thing is not observable from the caller, but
>> because this is "parse-email-header" and returns "header fields"
>> without reading the "mail", perhaps call it %header instead?
>
> If there is (for some reason) a mail header named 'body', then this
> assignment of the body portion of the message will overwrite it.
> Perhaps this function should instead return multiple values: the
> header hash, and the message body.

I will drop the body part in re-roll.
