From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [WIP-PATCH 1/2] send-email: create email parser subroutine
Date: Sun, 29 May 2016 19:15:10 +0200
Message-ID: <8904f487-985c-bd2d-a8d1-4a712c6ef558@grenoble-inp.org>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
 <20160527140104.11192-2-samuel.groot@grenoble-inp.org>
 <vpqeg8mi4wm.fsf@anie.imag.fr> <20160528233329.GA1132@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, gitster@pobox.com,
	aaron@schrab.com, Tom RUSSELLO <tom.russello@grenoble-inp.org>
To: Eric Wong <e@80x24.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun May 29 19:15:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b74J9-0003md-VE
	for gcvg-git-2@plane.gmane.org; Sun, 29 May 2016 19:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbcE2RPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 13:15:16 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:55994 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbcE2RPP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2016 13:15:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 1EC31247F;
	Sun, 29 May 2016 19:15:12 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lrrr1Dg0XDgS; Sun, 29 May 2016 19:15:12 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 08ACC246D;
	Sun, 29 May 2016 19:15:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id F20762077;
	Sun, 29 May 2016 19:15:11 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W9DUVVU4XVin; Sun, 29 May 2016 19:15:11 +0200 (CEST)
Received: from linux.home (LFbn-1-8166-195.w90-112.abo.wanadoo.fr [90.112.75.195])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 809752064;
	Sun, 29 May 2016 19:15:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <20160528233329.GA1132@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295837>

On 05/29/2016 01:33 AM, Eric Wong wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>>
>>> Parsing and processing in send-email is done in the same loop.
>>>
>>> To make the code more maintainable, we create two subroutines:
>>> - `parse_email` to separate header and body
>>> - `parse_header` to retrieve data from header
>>
>> These routines are not specific to git send-email, nor to Git.
>>
>> Does it make sense to use an external library, like
>> http://search.cpan.org/~rjbs/Email-Simple-2.210/lib/Email/Simple.pm ,
>> either by depending on it, or by copying it in Git's source tree ?
>
> That might be overkill and increase installation/maintenance
> burden.  Bundling it would probably be problematic to distros,
> too.

I have no opinion on that topic, but it could be interesting to have 
other opinions. For the first patch I thought it would be easier and 
quicker to use code already written, and maybe use another method in the 
next iteration.

Email::Simple is licensed under Perl's Artistic License or GPL (v1 or 
any later version), so it's fine to bundle it.

>> If not, I think it would be better to introduce an email parsing library
>> in a dedicated Perl module in perl/ in our source tree, to keep
>> git-send-email.perl more focused on the "send-email" logic.
>
> Sounds good, Git.pm already has parse_mailboxes

I agree, I will look into that.

>>> +sub parse_email {
>>> +	my @header = ();
>>> +	my @body = ();
>>> +	my $fh = shift;
>>> +
>>> +	# First unfold multiline header fields
>>> +	while (<$fh>) {
>>> +		last if /^\s*$/;
>>> +		if (/^\s+\S/ and @header) {
>>> +			chomp($header[$#header]);
>>> +			s/^\s+/ /;
>>> +			$header[$#header] .= $_;
>>> +		} else {
>>> +			push(@header, $_);
>>> +		}
>>> +	}
>>> +
>>> +	# Now unfold the message body
>>
>> Why "unfold"? Don't you mean "split message body into a list of lines"?
>>
>>> +	while (<$fh>) {
>>> +		push @body, $_;
>>> +	}
>
> I'd rather avoid the loops entirely and do this:
>
> 	local $/ = "\n"; # in case caller clobbers $/
> 	@body = (<$fh>);

I didn't know this method before, thanks for suggesting it!

>>> +	return (@header, @body);
>>> +}
>
>
>>> +		if (defined $input_format && $input_format eq 'mbox') {
>>> +			if (/^Subject:\s+(.*)$/i) {
>>> +				$subject = $1;
>>> +			} elsif (/^From:\s+(.*)$/i) {
>>> +				$from = $1;
>>
>> Not sure we need thes if/elsif/ for generic headers. Email::Simple's API
>> seems much simpler and general: $email->header("From");
>
> Right.  Reading this, it would've been easier to parse headers into a
> hash (normalized keys to lowercase) up front inside parse_email.

So should we merge parse_email and parse_header in one unique subroutine?
