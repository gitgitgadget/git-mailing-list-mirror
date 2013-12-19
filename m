From: Tom Miller <jackerran@gmail.com>
Subject: Re: [PATCH 1/3] builtin/fetch.c: Add pretty_url() and print_url()
Date: Wed, 18 Dec 2013 19:18:17 -0600
Message-ID: <20131219011817.GA31924@gmail.com>
References: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
 <xmqq8uvhhlwg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 02:18:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtSFu-0005mG-9k
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 02:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab3LSBSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 20:18:22 -0500
Received: from mail-qe0-f53.google.com ([209.85.128.53]:58345 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab3LSBSV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 20:18:21 -0500
Received: by mail-qe0-f53.google.com with SMTP id nc12so424668qeb.12
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 17:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NH/ZOyabYX0h4Eu4H2KbtfO4xE0dI6NptBLQlBpXNl4=;
        b=gL0a+ld3InbntY4ASbKP1UAtzrEw/seYCWNqvQe3J3dR2pmpymTsjZ4YQuXyLNSmPM
         hnkTrtdlt9E8FPFVwyMMV0H/RJ1aZVVSNm7jdMqDfyeCOAanTAb7NWTtCTh9IIhFS8HA
         P1A8LYvDh+ADuhjRhVNBHc6tgBta4i8piCKd4oyhfu2rQkaczK7w6mThjzlAnRajlHKq
         CbDlpAjZ8eoTx4OvxfnRFXbm0LtJIiccyH3JSBvgUvPXJHlR0bwnDbar+bMgRt1jE9of
         202mBcb9HWEBKvGikBCD9FOHyVEZS44wEodw8d1Wa4X3tNjUwz4dvQQc0nWJiYxy/pGJ
         aV2w==
X-Received: by 10.49.2.132 with SMTP id 4mr59208038qeu.15.1387415900703;
        Wed, 18 Dec 2013 17:18:20 -0800 (PST)
Received: from gmail.com (24-197-19-70.static.leds.al.charter.com. [24.197.19.70])
        by mx.google.com with ESMTPSA id r5sm5379470qaj.13.2013.12.18.17.18.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2013 17:18:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq8uvhhlwg.fsf@gitster.dls.corp.google.com>
Received: by 10.229.238.131 with HTTP; Wed, 18 Dec 2013 15:55:27 -0800 (PST)
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239511>

On Wed, Dec 18, 2013 at 3:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Tom Miller <jackerran@gmail.com> writes:
>
>> In order to fix branchname DF conflicts during `fetch --prune`, the way
>> the header is output to the screen needs to be refactored. Here is an
>> exmaple of the output with the line in question denoted by '>':
>>
>>       $ git fetch --prune --dry-run upstream
>>>      From https://github.com/git/git
>>          a155a5f..5512ac5  maint      -> upstream/maint
>>          d7aced9..7794a68  master     -> upstream/master
>>          523f7c4..3e57c29  next       -> upstream/next
>>        + 462f102...0937cdf pu         -> upstream/pu  (forced update)
>>          e24105a..5d352bc  todo       -> upstream/todo
>>        * [new tag]         v1.8.5.2   -> v1.8.5.2
>>        * [new tag]         v1.8.5.2   -> v1.8.5.2
>>
>> pretty_url():
>> This function when passed a transport url will anonymize the transport
>> of the url. It will strip a trailing '/'. It will also strip a trailing
>> '.git'. It will return the newly formated url for use. I do not believe
>> there is a need for stripping the trailing '/' and '.git' from a url,
>> but it was already there and I wanted to make as little changes as
>> possible.
>
> OK.  I tend to agree that stripping the trailing part is probably
> not a good idea and we would want to remove that but that definitely
> should be done as a separate step, or even as a separate series on
> top of this one.

I think that removing the trailing part will greatly reduce the complexity
to the point were it is unnecessary to have pretty_url().  My goal with
extracting this function is to isolate the complexity of formatting the
url to a single spot. I am thinking along the lines of the following
commit order:

1. Remove the "remove trailing part"
2. Add print_url()
3. Always print url when pruning
4. Reverse order of prune and fetch

>> print_url():
>> This function will convert a transport url to a pretty url using
>> pretty_url(). Then it will print out the pretty url to stderr as
>> indicated above in the example output. It uses a global variable
>> named "gshown_url' to prevent this header for being printed twice.
>
> Gaah.  What is that 'g' doing there?  Please don't do that
> meaningless naming.

I am not familiar with C conventions and I was trying to stay consistent.
I saw other global variables starting with 'g' and made an assumption.
It will use the original name in the upcoming patches.

> I do not think the change to introduce such a global variable
> belongs to this refactoring step.  The current caller can decide
> itself if it called that function, and if you are going to introduce
> new callers in later steps, they can coordinate among themselves,
> no?

I agree, there is no reason for introducing it in this step. Thanks for
pointing that out.
