From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Wed, 8 Jun 2016 21:36:46 +0200
Message-ID: <c5bd7c4f-614c-14c1-1395-2bd0e5c1d81c@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-5-samuel.groot@grenoble-inp.org>
 <xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, aaron@schrab.com, e@80x24.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:36:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAjHZ-0006FG-6r
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 21:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422945AbcFHTgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 15:36:49 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:35747 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161952AbcFHTgt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 15:36:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 065D72584;
	Wed,  8 Jun 2016 21:36:47 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sb-nl9lQiSpd; Wed,  8 Jun 2016 21:36:46 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 6E872222F;
	Wed,  8 Jun 2016 21:36:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 68CAF2066;
	Wed,  8 Jun 2016 21:36:46 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s2xdsbfY24rR; Wed,  8 Jun 2016 21:36:46 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 438D92064;
	Wed,  8 Jun 2016 21:36:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296843>

On 06/08/2016 07:58 PM, Junio C Hamano wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>> +sub parse_email {
>> +	my %mail = ();
>> +	my $fh = shift;
>> +	my $last_header;
>
>> +	# Unfold and parse multiline header fields
>> +	while (<$fh>) {
>> +		last if /^\s*$/;
>
> You stop at the end of fields before the message body starts.
>
>> +		s/\r\n|\n|\r//;
>
> The pattern is not anchored at the right end of the string;
> intended?  Is it worth worrying about a lone '\r'?

A lone '\r' shouldn't happen, but we are never too careful. It's fixed 
with what Eric suggested.

>> +		if (/^([^\s:]+):[\s]+(.*)$/) {
>> +			$last_header = lc($1);
>> +			@{$mail{$last_header}} = ()
>> +				unless defined $mail{$last_header};
>> +			push @{$mail{$last_header}}, $2;
>
>> +		} elsif (/^\s+\S/ and defined $last_header) {
>> +			s/^\s+/ /;
>> +			push @{$mail{$last_header}}, $_;
>
> Even though the comment said "unfold", you do not really do the
> unfolding here and the caller can (if it wants to) figure out where
> one logical header was folded in the original into multiple physical
> lines, because you are returning an arrayref.
>
> However, that means the caller still cannot tell what the original
> was if you are given:
>
> 	X-header: a b
>             c
> 	X-header: d
>
> as you would return { 'X-header' => ["a b", "c", "d")] }
>
> In that sense, it may be better to do a real unfolding here, so that
> it would return { 'X-header' => ["a b c", "d"] } from here instead?
>
> I.e. instead of "push @{...}, $_", append $_ to the last element of
> that array?

I will do that. It makes more sense regarding Subject split into several 
lines, for example.
