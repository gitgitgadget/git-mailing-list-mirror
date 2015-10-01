From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] git-send-email.perl: Fixed sending of many/huge
 changes/patches
Date: Thu, 01 Oct 2015 16:43:56 -0700
Message-ID: <ddfab710e6ee78f6890b92d5b8af3bee@agner.ch>
References: <1443597969-3962-1-git-send-email-polynomial-c@gentoo.org>
 <xmqqr3lf94o2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Lars Wendler <polynomial-c@gentoo.org>, git@vger.kernel.org,
	juston.h.li@gmail.com, Junio C Hamano <jch2355@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 01:44:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhnWq-00027o-Sj
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 01:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbbJAXoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 19:44:44 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:42946 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbbJAXon (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 19:44:43 -0400
Received: from webmail.kmu-office.ch (unknown [178.209.48.103])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id 679AB5C11EB;
	Fri,  2 Oct 2015 01:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=agner.ch; s=dkim;
	t=1443742998; bh=XSc+KHx9+24CUbhKhDFjX8e99Vu6AaYIC+emNhTthp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sj3KoOLO6SyPgI9BXcPei7g7QY/I1C/Sz1q1kvzJ9aumA+oOWH8YMUTDgQFRMAyCP
	 2zeyV7VkJvuDwaoIUDB6zCNssyVGMU+oSPlvx9uFWFTShGZSoGuxUNiiUrRB5ZPyhf
	 jXCBaAy/Y5Gdk/JtSrUzAyyCdd7Bw4y3vhyWpzDA=
In-Reply-To: <xmqqr3lf94o2.fsf@gitster.mtv.corp.google.com>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278905>

On 2015-09-30 10:51, Junio C Hamano wrote:
> Lars Wendler <polynomial-c@gentoo.org> writes:
> 
>> It seems to me that there is a size limit, after cutting down the patch
>> to ~16K, sending started to work. I cut it twice, once by removing lines
>> from the head and once from the bottom, in both cases at the size of
>> around 16K I could send the patch.
>>
>> See also original report:
>> http://permalink.gmane.org/gmane.comp.version-control.git/274569
>>
>> Reported-by: Juston Li <juston.h.li@gmail.com>
>> Tested-by: Markos Chandras <hwoarang@gentoo.org>
>> Signed-off-by: Lars Wendler <polynomial-c@gentoo.org>
>> ---
>>  git-send-email.perl | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index e3ff44b..e907e0ea 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1365,7 +1365,11 @@ Message-Id: $message_id
>>  		$smtp->mail( $raw_from ) or die $smtp->message;
>>  		$smtp->to( @recipients ) or die $smtp->message;
>>  		$smtp->data or die $smtp->message;
>> -		$smtp->datasend("$header\n$message") or die $smtp->message;
>> +		$smtp->datasend("$header\n") or die $smtp->message;
>> +		my @lines = split /^/, $message;
>> +		foreach my $line (@lines) {
>> +			$smtp->datasend("$line") or die $smtp->message;
>> +		}
> 

Hi,

> Thanks.  One and a half comments.
> 
>  * If 16k is the limit, and smtp payload line limit is much much
>    shorter than that, is it sensible to send data line by line?

It was a easy and quick way which popped into my mind. The 16k limit has
been evaluated just by trying out some patch sizes, not sure whether
that is really right and where that really comes from. I guess before
using this as split size one would need to understand what causes that
limit actually...

>  * Has this been reported to Net::Cmd::datasend() upstream?

Not by me. I also have to admit that I am not a perl hacker at all...

--
Stefan

> 
>>  		$smtp->dataend() or die $smtp->message;
>>  		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
>>  	}
