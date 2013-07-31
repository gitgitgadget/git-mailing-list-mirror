From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v6 6/6] config: "git config --get-urlmatch" parses section.<url>.key
Date: Wed, 31 Jul 2013 16:03:01 -0700
Message-ID: <62E17EDB-B24D-4F37-95F8-E2E26118E5E9@gmail.com>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com> <1375298768-7740-7-git-send-email-gitster@pobox.com> <20130731224511.GA25882@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 01 01:03:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4fQG-0003Jp-4c
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 01:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab3GaXDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 19:03:07 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:50982 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202Ab3GaXDG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 19:03:06 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so1308541pde.10
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=H6Bugr/bXpC/sxQXUpZ0efHE0yp6hRjoShcqrL0Hh04=;
        b=E5o75MFxKg4NaUYPf53SX2CPOX0yULdsmARc/LoJg07PJgQ2jB2VTCvIcpKYTvcbJd
         ifx6rkUkFJYbnq9z4r9qUUxxX6/8DIaMJjYpeq0kKGXWWiw47blGo4NhSzSp5AeTnMBL
         VDt4iJt+C7kXYegoswOLp982py8J5lRBj61eccZ2Dh1Ai5EsyzXVJE7WTpSL2kHZGlWY
         BV/+OkMQpUDL72TsbxgJRUQznbLyOPLP6h0sFVbPoznnj0LBGo5lbZRTi4tK4vj1fcE1
         UijlTV4qOG3ZWuexxO7Igayb4EvRP+37UXBfpz6lzA+SDc6qriTGaGkmI5Evw03dAZIH
         dQGA==
X-Received: by 10.69.4.5 with SMTP id ca5mr83078534pbd.109.1375311785052;
        Wed, 31 Jul 2013 16:03:05 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id w8sm161644paj.4.2013.07.31.16.03.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 16:03:04 -0700 (PDT)
In-Reply-To: <20130731224511.GA25882@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231477>

On Jul 31, 2013, at 15:45, Jeff King wrote:

> On Wed, Jul 31, 2013 at 12:26:08PM -0700, Junio C Hamano wrote:
>
>> Using the same urlmatch_config_entry() infrastructure, add a new
>> mode "--get-urlmatch" to the "git config" command, to learn values
>> for the "virtual" two-level variables customized for the specific
>> URL.
>>
>>    git config [--<type>] --get-urlmatch <section>[.<key>] <url>
>
> Do we want something like this on top, to convert the third form of
> test-url-normalize into git-config calls?
>
> It would be nicer squashed in, but we the tests are added earlier in  
> the
> series than "--get-urlmatch", so we would have to rip the tests out of
> the earlier patches and have a "[PATCH 7/6] add tests for url
> normalizing".
>
> Two things to note about my test conversion:
>
>  1. Git-config expects pre-canonicalized variable names (so  
> http.noepsv
>     instead of "http.noEPSV"). I think the "git config --get" code  
> path
>     does this for the caller, so we should probably do the same for
>     "--get-urlmatch". And it is even easier here, because we know that
>     "http.noEPSV" does not contain a case-sensitive middle part. :)

The test was testing that too, which I think is a good thing.  Your  
replacement does not test that.  With a fix for --get-urlmatch as you  
mention above, the tests can check that again.

>  2. I turned the many 'test "$(git foo)" = "bar"' invocations into a
>     wrapper function that uses test_cmp. This helped immensely with
>     debugging (1).
>
>     The wrapper is a little ugly. I do wonder if we actually need all
>     of these tests (i.e., it is not clear to me what different things
>     each is testing, and if it is not simply trying to exercise the
>     different variable names, which now all follow the same code path,
>     because git-config does not care about the particular names).

Each one tests a different item from the "$tc-n" config file to make  
sure that everything that's in each config file actually behaves as  
expected.

If we do this (and I don't really have any objection except for the  
point noted above), then the tests really need to move out from t5200  
as they're not tied to the http operations anymore.  Also the Makefile  
rule for test-url-normalize.c needs to be simplified since it won't  
need the extra options to make it link since it's no longer including  
http.c.

The README has this:

> First digit tells the family:
>
>         0 - the absolute basics and global stuff
>         1 - the basic commands concerning database
>         2 - the basic commands concerning the working tree
>         3 - the other basic commands (e.g. ls-files)
>         4 - the diff commands
>         5 - the pull and exporting commands
>         6 - the revision tree commands (even e.g. merge-base)
>         7 - the porcelainish commands concerning the working tree
>         8 - the porcelainish commands concerning forensics
>         9 - the git tools

But the best choice does not immediately jump out at me.  However,  
looking at the other tests that are there, I think perhaps 1307-config- 
url might be a reasonable choice.
