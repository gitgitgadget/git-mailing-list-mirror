From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t6301: new tests of for-each-ref error handling
Date: Mon, 01 Jun 2015 10:33:08 -0700
Message-ID: <xmqqa8wj72qz.fsf@gitster.dls.corp.google.com>
References: <1433174031-5471-1-git-send-email-mhagger@alum.mit.edu>
	<1433174031-5471-2-git-send-email-mhagger@alum.mit.edu>
	<20150601160834.GA15148@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 19:33:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzTaO-0005sB-I5
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 19:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbbFARdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 13:33:12 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36365 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbbFARdK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 13:33:10 -0400
Received: by ieclw1 with SMTP id lw1so19315663iec.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2j2kJdVHjty2hGfyXaxZDardTt50s8OBMiz1nlVFec0=;
        b=ZUnPeu215FjkAu032W7clRpLYtPtlLunf5XoNV9d24aza46iISjdPwopvsAl2ERoSZ
         ZpMW7LyQy2NX0p5R5iZnM0oGA5udTjYeGWiYcfNjxMTSu+wMGLnl620DAUdMj5pW+f4V
         LIEADQUYM7IME4zC99jDfmAPLbiQBxlh+gKMkmV33QB1kr8Yrwcy6CDTflAUvITwP967
         1KubP8cA0SmGAfGDzjxDm5Foyz0XlEiAPGmCUREKyt0ZzOEl9l2tZVZoPU3MwU+KG3av
         laQ4CG5rbicdMUAuzSORQmPxoS086d/JvdFL0OBrQwoYMaDDM3aJVIg+t57WDZCYymI/
         iudg==
X-Received: by 10.42.15.20 with SMTP id j20mr30202188ica.16.1433179989567;
        Mon, 01 Jun 2015 10:33:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id f15sm10816295iof.36.2015.06.01.10.33.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 10:33:08 -0700 (PDT)
In-Reply-To: <20150601160834.GA15148@peff.net> (Jeff King's message of "Mon, 1
	Jun 2015 12:08:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270443>

Jeff King <peff@peff.net> writes:

> On Mon, Jun 01, 2015 at 05:53:49PM +0200, Michael Haggerty wrote:
>
>> Add tests that for-each-ref correctly reports broken loose reference
>> files and references that point at missing objects. In fact, two of
>> these tests fail, because (1) NULL_SHA1 is not recognized as an
>> invalid reference value, and (2) for-each-ref doesn't respect
>> REF_ISBROKEN. Fixes to come.
>
> This whole series looks straightforward and correct to me. Thanks for a
> pleasant read. I have two minor comments on the tests:
>
>> --- /dev/null
>> +++ b/t/t6301-for-each-ref-errors.sh
>> @@ -0,0 +1,45 @@
>> +#!/bin/sh
>> +
>> +test_description='for-each-ref errors for broken refs'
>> +
>> +. ./test-lib.sh
>> +
>> +ZEROS=0000000000000000000000000000000000000000
>> +MISSING=abababababababababababababababababababab
>
> The test suite provides $_z40, so you can skip $ZEROS. I don't think
> it's a big deal, though, and it may be nicer to have it explicitly next
> to $MISSING here.

Yeah, ZEROS=$_z40 next to MISSING=abababa... may not be too bad.

>> +test_expect_success 'Missing objects are reported correctly' '
>> +	r=refs/heads/missing &&
>> +	echo $MISSING >.git/$r &&
>> +	test_when_finished "rm -f .git/$r" &&
>> +	echo "fatal: missing object $MISSING for $r" >missing-err &&
>> +	test_must_fail git for-each-ref 2>err &&
>> +	test_cmp missing-err err
>> +'
>
> Due to b7dd2d2 (that you mentioned in the message for patch 2), we only
> sometimes notice the missing objects. Is it worth testing that:
>
>   git for-each-ref --format='%(refname)'
>
> does _not_ barf here?

Sound like a good thing to check, too.

Thanks.
