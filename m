From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 3/4] bundle: don't leak an fd in case of early return
Date: Thu, 31 Mar 2016 17:25:45 -0700
Message-ID: <CAGZ79kYMxJdh_8n8zaaaEQP_BqWfS12JEry1MHkYqwQPJTWTNw@mail.gmail.com>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
	<1459357518-14913-4-git-send-email-sbeller@google.com>
	<9C112693D94545DC917C90299E52A719@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 02:25:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1almuN-0003EB-5p
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 02:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbcDAAZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 20:25:47 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33112 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcDAAZq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 20:25:46 -0400
Received: by mail-io0-f177.google.com with SMTP id a129so125826219ioe.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 17:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=rEpPJUpUr6m2piMI170+7LgZC8RE1tTuAAaI51Ls7aU=;
        b=X36sPt/lGAuVvE51Fr7whXFjOTcoyHVFxFJ4aPvqeT2NlgsMC+EoknIRXhkfa/38tq
         DvuOSMa7J2klpiWFLX/QSyBrM+yGc42tbSkzuWBoaYXHjP15HmuVRUxQGxaPVB7RfK7v
         oY/Qxe5hzxsL0fBJkUnFo5EBMPTR3WF6FMDC/I05QjUOo4MpeA+9VoVO9svqIr1Ai5yP
         OQYC9UmXhV8ruyOkP8xUQmEsXiF2BOE7J1xuDlzwqt8wxe6QRk+9aTfZljQS7qI0vAUz
         ESg0JkciLCSARsEnfRQCJLg0TWOBxvIdfJMTer8lM8ry5wkTa0VEJB1Uo5lDfBC5HYnw
         3PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=rEpPJUpUr6m2piMI170+7LgZC8RE1tTuAAaI51Ls7aU=;
        b=FYSznlfDPlOrdJplZmPmN4V82l7k5SpbqIAjXKbvF54tvzI0y8MKgRFSNf/iD/ghQ8
         9RQVaPSBFWAJDy8ZVaoGImLCgvdzaBTuqk4w03v7YZI97NYW/aXy/hL6cfoKCGETDyQS
         aXWJTyQ3HQV7lH0eUInJRXyLzP+NoYr0GaDGsJSpwgB86lHNqPnMHBT4M80VbdaWOb8E
         uq+JXrFvMdmMe5tn1sU/DMZElLP8FkW3AF+U7yiJfDI9lZRgNa2nz/bahLJX11Fpo/dR
         9gIEBKCg2Q1M2P3S6/wSf7qnxIIX8w9Ee5TffUq9pu1hldyJ3SueakE9SG5ckKQyGMCx
         EgMw==
X-Gm-Message-State: AD7BkJJNPQLa6DgR+H3AOotCSf4ufcM6S8PeiM1+CXjenrlvTzLMgt0iizBZecbJ58J/xAGcG6qSqL1ndkQ85lmr
X-Received: by 10.107.184.8 with SMTP id i8mr1737320iof.96.1459470345492; Thu,
 31 Mar 2016 17:25:45 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Thu, 31 Mar 2016 17:25:45 -0700 (PDT)
In-Reply-To: <9C112693D94545DC917C90299E52A719@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290494>

On Thu, Mar 31, 2016 at 12:00 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Stefan Beller" <sbeller@google.com>
>>
>> In successful operation `write_pack_data` will close the `bundle_fd`,
>> but when we exit early, we need to take care of the file descriptor
>> as well as the lock file ourselves. The lock file may be deleted at the
>> end of running the program, but we are in library code, so we should
>> not rely on that.
>>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>
>
> Has this been tested on Windows? I had a similar problem very recently
> https://groups.google.com/forum/#!msg/git-for-windows/6LPxf9xZKhI/-s7XD18yCwAJ
> where a bad rev-list-arg would cause the `bundle create` to die, and, on
> windows, leave the incomplete bundle file locked.
>
> dscho suggested one possible solution for that, but I haven't had any time
> to try any patches.

I think with Jeffs suggestion to only rollback the lock in case of
(!bundle_to_stdout)
we're not making it worse. I do not have a Windows machine at hand to test it :(
