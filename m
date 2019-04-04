Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B428720248
	for <e@80x24.org>; Thu,  4 Apr 2019 07:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfDDHiu (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 03:38:50 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:57094 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfDDHiu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 03:38:50 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id C9904440054;
        Thu,  4 Apr 2019 10:38:46 +0300 (IDT)
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il> <bc20070b-437a-9875-efd0-b4cad1413233@rasmusvillemoes.dk> <604795fe60991f22273cbb652eeeedc17985bc65.camel@perches.com> <xmqqh8c03dcz.fsf@gitster-ct.c.googlers.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joe Perches <joe@perches.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
In-reply-to: <xmqqh8c03dcz.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 04 Apr 2019 10:38:46 +0300
Message-ID: <874l7ekynt.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Mar 18 2019, Junio C. Hamano wrote:
> Joe Perches <joe@perches.com> writes:
>
>> My preference would be for correctness.
>> I presume something like this isn't too onerous.
>
> I am guessing that /^---/ is to stop at the three-dash line *OR*
> after the initial handful of lines of the first diff header (as the
> last resort) and that is why it is not looking for /^---$/.
>
> If that is the case, I think it makes a lot of sense.  It is a
> general improvement not tied to the case that triggered this thread.
>
> Independently, I think it makes sense to do something like
>
> 	/^([a-z][a-z-]*-by|Cc): (.*)/i
>
> to tighten the match to exclude a non-trailer; that would have been
> sufficient for the original case that triggered this thread.

Is there anything I need to do more to get this fix applied for the next
git release?

Thanks,
baruch

>> ---
>>  git-send-email.perl | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 8200d58cdc..83b0429576 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1697,9 +1697,10 @@ sub process_file {
>>  		}
>>  	}
>>  	# Now parse the message body
>> +	my $in_patch = 0;
>>  	while(<$fh>) {
>>  		$message .=  $_;
>> -		if (/^([a-z-]*-by|Cc): (.*)/i) {
>> +		if (!$in_patch && /^([a-z-]*-by|Cc): (.*)/i) {
>>  			chomp;
>>  			my ($what, $c) = ($1, $2);
>>  			# strip garbage for the address we'll use:
>> @@ -1725,6 +1726,8 @@ sub process_file {
>>  			push @cc, $c;
>>  			printf(__("(body) Adding cc: %s from line '%s'\n"),
>>  				$c, $_) unless $quiet;
>> +		} elsif (/^---/) {
>> +			$in_patch = 1;
>>  		}
>>  	}
>>  	close $fh;


--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
