From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] teach git-config to output large integers
Date: Tue, 20 Aug 2013 21:38:41 -0700
Message-ID: <20130821043841.GA2802@elie.Belkin>
References: <20130820223953.GA3429@sigill.intra.peff.net>
 <20130820224710.GB24766@sigill.intra.peff.net>
 <20130820225745.GL4110@google.com>
 <20130821030036.GD25296@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 21 06:38:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC0CA-000492-IQ
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 06:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760Ab3HUEiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 00:38:51 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:65293 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635Ab3HUEiv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 00:38:51 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so340305pab.24
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 21:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=S6MJG51AXfqDdJqNeKcNFjg2/uN0joqConZbjEEGaEg=;
        b=TDgBtQVntloy7kkoVgyW2boZT6grHAsiPwLImqu6LJtVRbniGDHWcpet5LycQF7LFR
         VkHUSXDd5g/7einBYjASg3+PpsUt6tOZ1r8JY3eee7IOUtxEpUs0lfb154wRtcayJ7KP
         1ESqd4dhs5yIGUEExdHc8YHV5n1ywhVmhA5435Q0DpvoG4eWCMiK98rYtr99koz+Bbxc
         W4lABIynL2UBE+YeDBuyxKl5KXg7y9I1MfHkALl2pXj20zUvCbrxwIoKa9JnteA07NPr
         mDK7H+Ar7K4vcUkvZX/nrB4EwZMPH5ksF9IFujipDNDm4TK4J5F+3ElvbVDugXQQnfLy
         GwxQ==
X-Received: by 10.68.131.168 with SMTP id on8mr5654283pbb.97.1377059930696;
        Tue, 20 Aug 2013 21:38:50 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id bg3sm5643572pbb.44.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 21:38:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130821030036.GD25296@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232686>

Jeff King wrote:

> I almost sent it as "--size" with unsigned long internally. But try
> writing the documentation for it. You want to say something like "it's
> big enough to handle file sizes". Except that on 32-bit, it's _not_.
> It's only 4G.
>
> You really want something that uses off_t internally, so 32-bit systems
> with largefile support do the sane thing. But now you have no way of
> emulating the way that git parses stuff internally.

Let's take a step back for a moment.  What problem is this patch
solving?

>From the motivating example, I thought it was

	When reading or writing an integer config item, git sometimes
	encounters integer overflow and doesn't know how to deal with it.
	Worse, this means that some meaningful values are unrepresentable
	in config files.  Fix it in two steps:

	 1. Catch overflow, and error out instead of pretending to be
	    able to handle it.

	 2. Provide at least an option to use a wider integer type and
	    handle larger meaningful values.

	This involves a new option --size instead of making --int use
	intmax_t for the following compatibility reason: ...

For example, the compatibility reason could be that some scripts
calling "git config" were not able to handle large integers and that
we do not want to expose them to unexpectedly large values.

But that reason doesn't sound realistic to me.  So what is the actual
reason not to always use a wider range?

That is what I was trying to get at in discussing the test.  It is not
"We would like --int to reject values higher than this, but some
platforms do not allow us to", but "Either rejecting this value, or
even better, computing the right size and printing it, is an
acceptable behavior, and this test checks for those."

Hoping that clarifies,
Jonathan
