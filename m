Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B332CEB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 05:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjHKFaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 01:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHKFaV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 01:30:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90766272D
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 22:30:20 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C903F1883AE;
        Fri, 11 Aug 2023 01:30:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nMEnwxC8SKvv2vr8SqG4X9hO4cDknbPmMFFtqu
        FjR4w=; b=RjDjeM2omB1GE1NcXmsojFDgpemGnVI/LvGMckH5aZV9p0m2tARSuu
        b6r5na8LiDpxhn+UQqDbRmB+3uVl2cj2uQeDrANrFu8lVbHd4BqgQhGq23qZ+A/a
        zHS46CA0hzLaW+kfp2J/OMwWTAng0wo++u0Ob/T57EkY0LJQK027I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AED0F1883A9;
        Fri, 11 Aug 2023 01:30:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0650E1883A8;
        Fri, 11 Aug 2023 01:30:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley <wesleys@opperschaap.net>
Cc:     git@vger.kernel.org
Subject: Re: [[PATCH v2]] Fix bug when more than one readline instance is used
References: <20230810004956.GA816605@coredump.intra.peff.net>
        <20230810011831.1423208-1-wesleys@opperschaap.net>
        <xmqqcyzupf3b.fsf@gitster.g>
        <8d683835-31d4-41f0-9d4e-90c95acbea28@opperschaap.net>
Date:   Thu, 10 Aug 2023 22:30:17 -0700
In-Reply-To: <8d683835-31d4-41f0-9d4e-90c95acbea28@opperschaap.net> (Wesley's
        message of "Thu, 10 Aug 2023 21:09:52 -0400")
Message-ID: <xmqqwmy2no2e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28CBFC52-3808-11EE-BF27-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wesley <wesleys@opperschaap.net> writes:

> On 8/10/23 21:01, Junio C Hamano wrote:
>> Wesley Schwengle <wesleys@opperschaap.net> writes:
>> This line with "};" on it should not be added, I think.
>> cf. https://github.com/git/git/actions/runs/5827208598/job/15802787783#step:5:74
>> 
>>> +		return $term;
>>>   	}
>>>   }
>>   git-svn.perl | 1 -
>>   1 file changed, 1 deletion(-)
>> diff --git a/git-svn.perl b/git-svn.perl
>> index 93f6538d61..e919c3f172 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -307,7 +307,6 @@ package main;
>>   		$term = $ENV{"GIT_SVN_NOTTY"}
>>   				? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
>>   				: new Term::ReadLine 'git-svn';
>> -		};
>>   		return $term;
>>   	}
>>   }
>
> You are 100% correct.

And embarrassingly, the above is not sufficient, as the way $term is
used in git-send-email and git-svn are subtly different.

I think we further need something like this on top, but my Perl is
rusty.

diff --git a/git-svn.perl b/git-svn.perl
index e919c3f172..6033b97a0c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -427,7 +427,7 @@ sub ask {
 	my $default = $arg{default};
 	my $resp;
 	my $i = 0;
-	term_init() unless $term;
+	my $term = term_init();
 
 	if ( !( defined($term->IN)
             && defined( fileno($term->IN) )
-- 
2.42.0-rc1

