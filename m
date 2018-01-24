Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 906FB1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 16:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964861AbeAXQnZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 11:43:25 -0500
Received: from forward101p.mail.yandex.net ([77.88.28.101]:55235 "EHLO
        forward101p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964822AbeAXQnY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Jan 2018 11:43:24 -0500
Received: from mxback3j.mail.yandex.net (mxback3j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10c])
        by forward101p.mail.yandex.net (Yandex) with ESMTP id 3A6596A81F77;
        Wed, 24 Jan 2018 19:43:22 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback3j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id B4f4PybbPv-hL8SFZUu;
        Wed, 24 Jan 2018 19:43:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1516812201;
        bh=vXVviOGxs4tNipn2cY+bIqCyl6RgOSSDYHxJJbjV98s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date;
        b=GBp87odnUtyTlECJmDN/+dEGrr8eKicq2I3/Eb18iCIz88Uk4gWu1i0rciY8PuMes
         xjwCdktuUNP/D4Vg+CBEwkal4jrsGHMegwx+qT/B94+GkzxM1qleK4xmAk9iTGJUVv
         LIdwfBi3VAXTiaLsW5KPQeTVeqeAoP3suGv8OK5A=
Authentication-Results: mxback3j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web36o.yandex.ru with HTTP;
        Wed, 24 Jan 2018 19:43:21 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
In-Reply-To: <CA+P7+xqMUPLC-aKW-fiS629_Owat8sCa5vp_bOwQTO8LP4hCzw@mail.gmail.com>
References: <14657461479715884@web21h.yandex.ru> <CA+P7+xrKfqOb-3FhKxXdnF6g9PktNWNzY+ZnHJS=yuVo1YdXzg@mail.gmail.com>
         <CAGZ79kZbGPneUXVEqJYhQAn+dfYve7qCjhO7QFaV1JBs3HD1aA@mail.gmail.com> <CA+P7+xqMUPLC-aKW-fiS629_Owat8sCa5vp_bOwQTO8LP4hCzw@mail.gmail.com>
Subject: Re: Feature request: Improve diff algorithm
MIME-Version: 1.0
Message-Id: <12531516812201@web36o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 24 Jan 2018 18:43:21 +0200
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another place where diff can be improved:
@@ -141,8 +140,9 @@ My_runops(pTHX)
 		// Do not trace variables in DB:: module
 		if( SvOK( inDB ) ) continue;
 
-		sv_inc_nomg( inDB );
 
+		// save_item( inDB );
+		sv_inc_nomg( inDB );
 		dSP; SINFO; SAVETMPS;
 
 		// printf( "SWITCH\n" );


This would be better it the patch looks like:
( this patch is manually created just to light the idea. It may contain errors)
@@ -140,6 +140,7 @@ My_runops(pTHX)
         // Do not trace variables in DB:: module
         if( SvOK( inDB ) ) continue;

+ 
+        // save_item( inDB );
         sv_inc_nomg( inDB );
- 
         dSP; SINFO; SAVETMPS;

As we can see, here the `sv_inc_nomg( inDB );` line is unchanged and `// save_item( inDB );` is added.
Here we just add/remove empty lines and patch looks more better.

I think (and this is my assumption), the the diff algorithm should take into account the string length.
This is more better to add/remove more short lines

21.11.2016, 20:55, "Jacob Keller" <jacob.keller@gmail.com>:
> On Mon, Nov 21, 2016 at 10:17 AM, Stefan Beller <sbeller@google.com> wrote:
>>  On Mon, Nov 21, 2016 at 8:56 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>>  On Mon, Nov 21, 2016 at 12:11 AM, KES <kes-kes@yandex.ru> wrote:
>>>>  Hi.
>>>
>>>  Hi,
>>>
>>>>  I have some question about how diff works then give proposal:
>>>>
>>>>  it will be very useful for each "symbol" store additional meta info as source line length. So in this case when git counter two equal sequence of commands it will do further comparison: Adds 23 chars deletes none VS adds 75 chars deletes 46
>>>>
>>>>  Actually I got this:
>>>>
>>>>  @@ -129,8 +132,9 @@ sub _preprocess_message {
>>>>   sub _process_message {
>>>>       my ($self, $message) = @_;
>>>>
>>>>  - my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
>>>>  + my $time = [ gettimeofday ];
>>>>
>>>>  + my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
>>>>       return $self->send_error(ERROR_REQUEST_INVALID)
>>>>           unless defined($method);
>>>>
>>>>  Instead of expected:
>>>>  @@ -129,6 +132,8 @@ sub _preprocess_message {
>>>>   sub _process_message {
>>>>       my ($self, $message) = @_;
>>>>
>>>>  + my $time = [ gettimeofday ];
>>>>  +
>>>>       my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
>>>>  -
>>>>       return $self->send_error(ERROR_REQUEST_INVALID)
>>>
>>>  Have you tried the various options for git to search for smaller
>>>  diffs? Or using the other diff algorithms such as histogram instead of
>>>  patience?
>>
>>  The newest version of Git comes with a flag to move around the diff
>>  better, based on the work at https://github.com/mhagger/diff-slider-tools
>
> Unfortunately in this case, I'm not convinced that it will improve the
> diff. It's worth a try as well though.
>
> Thanks,
> Jake
