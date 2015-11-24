From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] git-send-email.perl: Fixed sending of many/huge
 changes/patches
Date: Mon, 23 Nov 2015 16:38:41 -0800
Message-ID: <17df1d26b8508437dccf7d7a6a4a8139@agner.ch>
References: <1443597969-3962-1-git-send-email-polynomial-c@gentoo.org>
 <xmqqr3lf94o2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Lars Wendler <polynomial-c@gentoo.org>, git@vger.kernel.org,
	juston.h.li@gmail.com, Junio C Hamano <jch2355@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 01:40:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a11eb-0004Xj-TF
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 01:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbbKXAkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 19:40:12 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:34278 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbbKXAkL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 19:40:11 -0500
Received: from webmail.kmu-office.ch (unknown [178.209.48.103])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id 266D15C0FD9;
	Tue, 24 Nov 2015 01:39:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=agner.ch; s=dkim;
	t=1448325586; bh=lXQkug5rgT9MitHoWcYqPZXZ4A2a8P0KPRjjiMUrLE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=inxg02yx0YaugoUD0Uwu4oLeFws/41Q4rfphUMLjXhTkdAMJeF7gOmoeW0Vi85re9
	 KDbmoE+QYzXKq+9RGm+K1ODyx2xCxJ6Hl5/LLeOgp+aFqFd6JIM/Xtjop52F9T51JF
	 hS8orp2BhG9Fqa6cqVHc0H+VOkKJFB7Jp9A9Otkc=
In-Reply-To: <xmqqr3lf94o2.fsf@gitster.mtv.corp.google.com>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281604>

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
> Thanks.  One and a half comments.
> 
>  * If 16k is the limit, and smtp payload line limit is much much
>    shorter than that, is it sensible to send data line by line?
> 
>  * Has this been reported to Net::Cmd::datasend() upstream?

I still constantly run in to this issue. Fixing it locally, and next
time git gets updated and I send a larger patch, it happens again.

Just dig a bit more into that, it seems that this is a documented Perl
limitation:
http://search.cpan.org/~sullr/IO-Socket-SSL-2.020/lib/IO/Socket/SSL.pod#syswrite

All examples use datasend line wise, so I guess it is not a all to bad
choice...

--
Stefan


> 
>>  		$smtp->dataend() or die $smtp->message;
>>  		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
>>  	}
