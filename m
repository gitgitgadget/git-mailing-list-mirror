From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 2/2] xdiff: implement empty
 line chunk heuristic
Date: Fri, 15 Apr 2016 12:57:05 -0700
Message-ID: <CAGZ79ka7h25=rHun_hPv1qjqeghXt1UwUU3Q6xT0aj4+OW87fg@mail.gmail.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
	<20160415165141.4712-3-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 21:57:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar9rf-0003cp-Hv
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbcDOT5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:57:08 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35810 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbcDOT5H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:57:07 -0400
Received: by mail-io0-f173.google.com with SMTP id g185so145097599ioa.2
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=J55QINsIUeONMjU0Ms9U0BAZLlsyNASSwq3apEHDMZg=;
        b=ZWnLf0CoZz24c2sXsGRC554LMb4zWwGAgS9cnj6ep5upckAq8+7p6fJBZwd82hiS9g
         V9s+nHlQQxvey8f0jONME+GwjhFYQgeb3/w658mYaFg7dEphCkzohLPx3KCq2u5yjCRy
         Ki+JL0Pj/y1/0MSoXlR1lYgyuWl69GUp7Q8vI9S8x0RZuch5iZG1GkQUZpXB2Xm2pemu
         +F36hFDjf2JCOfwvRPp9OcWjsStGa7ZYm2fLvOpYbQsDlzkCd2xx1IWskS8PpLFWyoEI
         pnNZD/fp1y44MmOfETo1mHy3GAszaaFtuuPHSNtTl20gwIK3AUXMpXZdiTkta/ZAD7fA
         FMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=J55QINsIUeONMjU0Ms9U0BAZLlsyNASSwq3apEHDMZg=;
        b=fIL6eE1q5C4yVFKUDagGdCFEblbRhJ3AV19c+yGtnalG/P1xtAOVR6pH7DXKoUxUSu
         8b5OO3897lLDYJJyEhs4WdRmzLegL+JdTM0CKC2lwiv1n1bqBgRbjo6MTFJySrWbevBx
         +JDDtMAxO+BU6Gqr7O8IxICKdBLNVQ8A//5JrdOGhrfnHP1kRE097BU+OGugH3fn5ZfE
         z/+5NLMXCY+Q39rTjPxMibh7dKF7w/g1PE7his0Fwl/soXFUGZhg6MrdkhsoOyVHZUBt
         QtFy4poiY7RsuITTSW1QxG9ycXm7uHczZuw6lrkOUFC12r0w5lmSBmnNr0Zq/Dc1ToP9
         sHAg==
X-Gm-Message-State: AOPr4FXo0BrzZpnC1OusRleKXuD8zF7HlvaZ01PnQqtw7kIsMr2/XPClUyKjdprXaPDaNq2s9kNRsFc/sA7PbWvB
X-Received: by 10.107.184.8 with SMTP id i8mr24573822iof.96.1460750225832;
 Fri, 15 Apr 2016 12:57:05 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Fri, 15 Apr 2016 12:57:05 -0700 (PDT)
In-Reply-To: <20160415165141.4712-3-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291649>

On Fri, Apr 15, 2016 at 9:51 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Stefan Beller <sbeller@google.com>
>
> In order to produce the smallest possible diff and combine several diff
> hunks together, we implement a heuristic from GNU Diff which moves diff
> hunks forward as far as possible when we find common context above and
> below a diff hunk. This sometimes produces less readable diffs when
> writing C, Shell, or other programming languages, ie:
>
> ...
>  /*
> + *
> + *
> + */
> +
> +/*
> ...
>
> instead of the more readable equivalent of
>
> ...
> +/*
> + *
> + *
> + */
> +
>  /*
> ...
>
> Implement the following heuristic to (optionally) produce the desired
> output.
>
>   If there are diff chunks which can be shifted around, shift each hunk
>   such that the last common empty line is below the chunk with the rest
>   of the context above.
>
> This heuristic appears to resolve the above example and several other
> common issues without producing significantly weird results. However, as
> with any heuristic it is not really known whether this will always be
> more optimal. Thus, leave the heuristic disabled by default.
>
> Add an XDIFF flag to enable this heuristic only conditionally. Add
> a diff command line option and diff configuration option to allow users
> to enable this option when desired.
>
> TODO:
> * Add tests
> * Add better/more documentation explaining the heuristic, possibly with
>   examples(?)
> * better name(?)
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  Documentation/diff-config.txt  |  6 ++++++
>  Documentation/diff-options.txt |  6 ++++++
>  diff.c                         | 11 +++++++++++
>  xdiff/xdiff.h                  |  2 ++
>  xdiff/xdiffi.c                 | 26 ++++++++++++++++++++++++++
>  5 files changed, 51 insertions(+)
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index edba56522bce..cebf82702d2a 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -170,6 +170,12 @@ diff.tool::
>
>  include::mergetools-diff.txt[]
>
> +diff.emptyLineHeuristic::

I was looking at the TODO here and thought about the name:
It should not encode the `emptyLine` into the config option as
it is only one of many heuristics.

It should be something like `diff.heuristic=lastEmptyLine`
The we could add firstEmptyLine, aggressiveUp, aggressiveDown,
breakAtShortestLineLength or other styles as well later on.

I do not quite understand the difference between diff.algorithm
and the newly proposed heuristic as the heuristic is part of
the algorithm? So I guess we'd need to have some documentation
saying how these differ. (fundamental algorithm vs last minute
style fixup?)
