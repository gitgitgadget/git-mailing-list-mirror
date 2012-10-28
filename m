From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: crash on git diff-tree -Ganything <tree> for new files with textconv
 filter
Date: Sun, 28 Oct 2012 20:56:39 +0100
Message-ID: <508D8DF7.7040007@arcor.de>
References: <508C29E4.5000801@arcor.de> <20121028120104.GE11434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 20:57:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSYzX-00013y-BA
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 20:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab2J1T5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 15:57:38 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:58446 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752401Ab2J1T5h (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2012 15:57:37 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id A23EC5AF5F;
	Sun, 28 Oct 2012 20:57:35 +0100 (CET)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 9D48E31A002;
	Sun, 28 Oct 2012 20:57:35 +0100 (CET)
Received: from [10.0.0.4] (178-190-163-21.adsl.highway.telekom.at [178.190.163.21])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-04.arcor-online.net (Postfix) with ESMTPA id 376E7AAD2F;
	Sun, 28 Oct 2012 20:57:35 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-04.arcor-online.net 376E7AAD2F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1351454255; bh=X+6XoHa5X8yJ4vaZDExf4TEQzf6eit1SUfkBHv9HD6Y=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=kJVNcF5CRGaulT71JZUh5K6nebHyWlzJrI1kEijz/opXLDcyPt8TdTHBinMpAuzu3
	 Akm5+gVjQ+XYJikYEVoyg6tOWDvYDZXAVUxt2sKI00xNMQAAz09VKpW6gFGNa5ttr0
	 cvdYLyx+BzkT/nCfFVmFCld/G7xZe0Rmz1rJOnHw=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <20121028120104.GE11434@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208561>

On 2012-10-28 13:01, Jeff King wrote:
> On Sat, Oct 27, 2012 at 08:37:24PM +0200, Peter Oberndorfer wrote:
>
>> It seems "git diff-tree -Ganything <tree>" crashes[1] with a null
>> pointer dereference
>> when run on a commit that adds a file (pdf) with a textconv filter.
>>
>> It can be reproduced with vanilla git by having a commit on top that
>> adds a file with a textconv filter and executing git diff-tree
>> -Ganything HEAD
>> But running git log -Ganything still works without a crash.
>> This problem seems to exist since the feature was first added in f506b8e8b5.
> Thanks for a thorough bug report. I didn't reproduce the crash, but I
> can see how it happens (it happens with diff-tree because we will reuse
> the working tree file in that instance; it could also happen if you
> turned on textconv caching).
>
>> While testing I also noticed the -S and -G act on the original file
>> instead of the textconv munged data.
>> Is this intentional or caused by accessing the wrong data?
> Both, perhaps. :)
Hi,
thanks for your patch for this!

>
> -G operates on the munged data; you can see it feed the munged data to
> xdiff in diff_grep. But the optimization for handling added and removed
> files accidentally fed the wrong pointer. Fixing that is a no-brainer,
> since the optimization is inconsistent with the regular code path.
>
> -S, however, predates the invention of textconv and has never used it.
> It is a little less clear that textconv is the right thing here, because
> it is not about grepping the diff, but about counting occurrences of the
> string inside the file content. I tend to think that doing so on the
> textconv'd data would be what people generally want, but it is a
> behavior change.
>
>> Wild guess: should we really access p->one->data and not mf1.ptr?
> Precisely. Thanks for your wild guess; it made finding the bug very
> easy. :)
>
>> Is there some more information i should provide?
> The patch below should fix it. I added tests, but please try your
> real-world test case on it to double-check.

I tested your patch, but now it crashes for another reason :-)
i have a file with exactly 12288(0x3000) bytes in the repository.
When the file is loaded, the data is placed luckily so the data end
falls at a page boundary.
Later diff_grep() calls regexec() which calls strlen() on the loaded buffer
and ends up reading beyond the actual data into the next page
which is not allocated and causes a pagefault.
Or it could possibly (randomly) match the regex on data that is not
actually part of a file...
Different memory allocation rules on Windows probably also have some
influence here.

My guess is that diff_filespec->data is not supposed to be zero terminated
and we should not invoke strlen() on a not zero terminated data.
But this should be decided by somebody who knows the rules.

Greetings Peter
