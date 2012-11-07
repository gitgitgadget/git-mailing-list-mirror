From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: crash on git diff-tree -Ganything <tree> for new files with textconv
 filter
Date: Wed, 07 Nov 2012 22:10:59 +0100
Message-ID: <509ACE63.9070007@arcor.de>
References: <508C29E4.5000801@arcor.de> <20121028120104.GE11434@sigill.intra.peff.net> <508D8DF7.7040007@arcor.de> <20121029060524.GB4457@sigill.intra.peff.net> <508EE4E4.1080407@arcor.de> <20121029223521.GJ20513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 07 22:12:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWCut-0006Og-7L
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 22:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555Ab2KGVLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 16:11:53 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:42315 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752105Ab2KGVLw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2012 16:11:52 -0500
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net [151.189.8.36])
	by mx.arcor.de (Postfix) with ESMTP id AED59E4185;
	Wed,  7 Nov 2012 22:11:50 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id A6E373F83BF;
	Wed,  7 Nov 2012 22:11:50 +0100 (CET)
Received: from [10.0.0.5] (88-117-62-181.adsl.highway.telekom.at [88.117.62.181])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-02.arcor-online.net (Postfix) with ESMTPA id 378BB30940;
	Wed,  7 Nov 2012 22:11:50 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-02.arcor-online.net 378BB30940
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1352322710; bh=WTln8qztFy/8ZhKW7x7aOTZ/7AIh96BjW+TMtIFaFlI=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=Nt4b0lJHAfCPSmJRZvuPrl2RtG1ZCin5Cb6dUzO3u51dvq7vVF+1gAjxfrDrqUgjb
	 XHx1sS1DJNjw7wM/SZB5nH46mHq0a+7o9yBRPlDfettTTSstTsxwO92PqO2sKoITNt
	 53HY3hIZ75+Ts312l11stD2cqyMVWnm/kQq4avA4=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <20121029223521.GJ20513@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209141>

On 2012-10-29 23:35, Jeff King wrote:
> On Mon, Oct 29, 2012 at 09:19:48PM +0100, Peter Oberndorfer wrote:
>
>> I could reproduce with my 0x3000 bytes file on linux. The buffer is not
>> read with a trailing null byte it is mapped by mmap in
>> diff_populate_filespec...
>> So i think we will not get away with expecting a trailing null :-/
> Thanks for the reproduction recipe. I was testing with "git log", which
> does not use the mmap optimization.
>
>> For me the key to reproduce the problem was to have 2 commits.
>> Adding the file in the root commit it did not work. [1]
> You probably would need to pass "--root" for it to do the diff of the
> initial commit.
>
> The patch below fixes it, but it's terribly inefficient (it just detects
> the situation and reallocates). It would be much better to disable the
> reuse_worktree_file mmap when we populate the filespec, but it is too
> late to pass an option; we may have already populated from an earlier
> diffcore stage.
Hi,
I tested your patch, and i can confirm it fixes the problem for me.
(also on my real world test in msysgit)

Again, thanks a lot!
Greetings Peter

> I guess if we teach the whole diff code that "-G" (and --pickaxe-regex)
> is brittle, we can disable the optimization from the beginning based on
> the diff options. I'll take a look.
>
> <snip patch>
