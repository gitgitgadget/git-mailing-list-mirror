From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/3] t0000 cleanups
Date: Mon, 30 Dec 2013 10:51:25 -0800
Message-ID: <20131230185125.GI20443@google.com>
References: <20131228092731.GA26337@sigill.intra.peff.net>
 <20131228222129.GE5544@google.com>
 <xmqqwqimry2j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>,
	Thomas Rast <tr@thomasrast.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 30 19:51:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vxhw7-0004Gc-6n
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 19:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118Ab3L3Svb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 13:51:31 -0500
Received: from mail-yh0-f47.google.com ([209.85.213.47]:45634 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab3L3Sva (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 13:51:30 -0500
Received: by mail-yh0-f47.google.com with SMTP id 29so2421488yhl.6
        for <git@vger.kernel.org>; Mon, 30 Dec 2013 10:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1385iOFAKclDAT9siOBzxkea+touUx7mJJFRVvekue0=;
        b=vT8Qfo9BwP3v4ES2Op9p1aDqTlfaHHt8lN9tqFS1peR8dusW1F094eKpgbxIhK2eRz
         YjVRlfikMV2NbKoh59mefofKJhIlyhaH1O6dqISK6FvTo7uMsQ/VVV8oupg/984tRubf
         zLXwvzWdLZq8/vjLbc6ZETRiDrUStanW8uclqXg/d4qOUwfFF4m71vzaEivtsrNK5JE5
         +FV1sw2X1hwK+jC1e6dp5Ci8sQ7Aos2ENOo8Y2tHw6jZeu3gbY7T2tWRNzrvQLFI5Hwv
         TUMxZ2FvwAUGNYkIzqcEMLcTCICf/1yu7rsOo1+SVSq15NW8ZUp25TmmsBoZHZrZKOhe
         kPTg==
X-Received: by 10.236.91.201 with SMTP id h49mr427518yhf.96.1388429488765;
        Mon, 30 Dec 2013 10:51:28 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 9sm62719537yhe.21.2013.12.30.10.51.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Dec 2013 10:51:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqwqimry2j.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239812>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Jeff King wrote:

>>> When I want to debug a failing test, I often end up doing:
>>>
>>>   cd t
>>>   ./t4107-<tab> -v -i
>>>   cd tra<tab>
>>>
>>> The test names are long, so tab-completing on the trash directory is
>>> very helpful. Lately I've noticed that there are a bunch of crufty trash
>>> directories in my t/ directory, which makes my tab-completion more
>>> annoying.
>>
>> Ah, and if I'd read this then I wouldn't have had to be confused at
>> all.
[...]
> The third paragraph of 1/3 sufficiently covers it, no?  We could add
> "It makes it less convenient to use tab completion 'cd t/tra<TAB>'
> to go to the trash directory of the failed test to inspect the
> situation" after "... left in the t/ directory.", though.
[4 paragraphs snipped]

I think it can be better, since the commit message left me scratching
my head while the patch itself seems pretty simple.  How about
something like the following?

First, describing the problem:

	Running t0000 produces more trash directories than expected
	and does not clean up after itself:

	 $ ./t0000-basic.sh
	[...]
	 $ ls -d trash\ directory.*
	 trash directory.failing-cleanup
	 trash directory.mixed-results1
	 trash directory.mixed-results2
	 trash directory.partial-pass
	 trash directory.test-verbose
	 trash directory.test-verbose-only-2

Analysis and fix:

	These scratch areas for sub-tests should be under the t0000
	trash directory, but because the TEST_OUTPUT_DIRECTORY
	setting from the toplevel test leaks into the environment
	they are created under the toplevel output directory (typically
	t/) instead.  Because some of the sub-tests simulate failures,
	their trash directories are kept around.

	Fix it by explicitly setting TEST_OUTPUT_DIRECTORY appropriately
	for sub-tests.

And then, optionally, describing rejected alternatives:

	An alternative fix would be to pass the --root parameter that
	only specifies where to put the trash directories, which would
	also work.  However, using TEST_OUTPUT_DIRECTORY is more
	futureproof in case tests want to write more output in
	addition to the test-results/ (which are already suppressed in
	sub-tests using the HARNESS_ACTIVE setting) and trash
	directories.

And more analysis of why this wasn't caught in the first place:

	This fixes a regression introduced by 38b074d (t/test-lib.sh:
	fix TRASH_DIRECTORY handling, 2013-04-14).  Before then, the
	TEST_OUTPUT_DIRECTORY setting was not respected consistently
	so most tests did their work in a "trash" subdirectory of the
	current directory instead of the output dir.

Does that make sense?

Thanks,
Jonathan
