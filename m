From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: improve output when bad commit is found
Date: Mon, 11 May 2015 19:08:46 -0700
Message-ID: <xmqqbnhq1r9t.fsf@gitster.dls.corp.google.com>
References: <1431377939-13887-1-git-send-email-tbsaunde@tbsaunde.org>
	<xmqq4mni3jjg.fsf@gitster.dls.corp.google.com>
	<20150511231125.GC18112@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Tue May 12 04:08:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrzcr-00007R-H5
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 04:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbbELCIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 22:08:49 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33444 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbbELCIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 22:08:48 -0400
Received: by iepj10 with SMTP id j10so121186234iep.0
        for <git@vger.kernel.org>; Mon, 11 May 2015 19:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HrpF1wjg3qP9j5CJhupD1FnNwwAIe8ePTnPSeCYI258=;
        b=TRqc7CaF+zdKfNmVMOUTy/m+jgj4TVCRCKRgivpLodtvrR8Q8/Pa/0iymDnPKojcuQ
         fwrqKrOdf3RMEff1H5tvTBe10hq13nVNSzwxhRmbYhjL7hfMEcv3e2+DoEjqHI90MoC5
         fT6X0C2sVw7y4V8MBKkGlNPeAhjU5bz4llQi3lHG95Lu2hhkNXUfGVCGkHVTcFMFF9w0
         rLc2USQcRfQmFr8JsVFIe0eH15Ih01bi0GG8miGXMYOLDgc0aY7AsUCfQNp6xLlqvNy8
         LIblhPbNa0WlCCcDPBI0hqHe+/vTdRCMi9H0MDmh7WVWCWaPhWGNBGIQzq27o8+c3zxc
         F1Ig==
X-Received: by 10.107.132.223 with SMTP id o92mr16917278ioi.49.1431396527898;
        Mon, 11 May 2015 19:08:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id 71sm11022372ioe.16.2015.05.11.19.08.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 19:08:47 -0700 (PDT)
In-Reply-To: <20150511231125.GC18112@tsaunders-iceball.corp.tor1.mozilla.com>
	(Trevor Saunders's message of "Mon, 11 May 2015 19:11:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268837>

Trevor Saunders <tbsaunde@tbsaunde.org> writes:

>> > +	file=$1
>> > +	hash=$2
>> > +	grep "the first bad commit is" $file || return $?
>> > +	grep $hash $file || return $?
>> 
>> Is it OK to have these strings anywhere in the $file?
>
> Its not great, but the test seems to log multiple invokations of git
> bisect into the same file, so there may be text about previous runs
> before we are told which commit is bad.

So if we had a previous entry that happens to match $hash, even if
the current test stopped and pointed at a different thing, this test
declares a success?

This function knows how the $file should end, so it might be more
sensible to craft the expected output and compare the tail end of
the $file with it, something like:

	(
		echo "The first bad commit is"
                git show -s "$hash"
	) >expect &&
        cnt=$(wc -l <expect) &&
        tail -n $cnt "$file" >actual &&
        test_cmp expect actual

perhaps?
