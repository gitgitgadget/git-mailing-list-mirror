From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] lock_packed_refs(): allow retries when acquiring
 the packed-refs lock
Date: Fri, 01 May 2015 18:13:21 +0200
Message-ID: <5543A621.7010208@kdbg.org>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu> <1430491977-25817-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 01 18:13:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoDZD-0004J0-Ci
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 18:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbbEAQN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 12:13:26 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:27511 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751064AbbEAQN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 12:13:26 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lddst5d6pz5tlF;
	Fri,  1 May 2015 18:13:22 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id DA7C151E0;
	Fri,  1 May 2015 18:13:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1430491977-25817-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268153>

Am 01.05.2015 um 16:52 schrieb Michael Haggerty:
> +test_expect_success 'retry acquiring packed-refs.lock' '
> +	LOCK=.git/packed-refs.lock &&
> +	>$LOCK &&
> +	test_when_finished "rm -f $LOCK" &&
> +	{
> +		( sleep 1 ; rm -f $LOCK ) &
> +	} &&

I haven't tested yet, but I think that this will be problematic on 
Windows: a directory cannot be removed if it is the current directory of 
a process. Here, the sub-shell process is alive for a second. If the 
remainder of the test script completes before the process dies, the test 
directory cannot be removed.

How about this:

	test_when_finished "wait; rm -f $LOCK" &&
	{ sleep 1 & } &&
	...

> +	git -c core.packedrefstimeout=3000 pack-refs --all --prune
> +'
> +
>   test_done
>

-- Hannes
