From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 4/4] cygwin: Use native Win32 API for stat
Date: Sat, 27 Sep 2008 20:35:03 +0200
Message-ID: <200809272035.03833.johannes.sixt@telecom.at>
References: <20080927084349.GC21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Marcus Griep <marcus@griep.us>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 20:36:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjeeT-0002LW-Ac
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 20:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445AbYI0SfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 14:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbYI0SfK
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 14:35:10 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:39730 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbYI0SfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 14:35:09 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 9C91333B4C;
	Sat, 27 Sep 2008 20:35:04 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E3553280CD;
	Sat, 27 Sep 2008 20:35:03 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080927084349.GC21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96917>

On Samstag, 27. September 2008, Dmitry Potapov wrote:
> lstat/stat functions in Cygwin are very slow, because they try to emulate
> some *nix things that Git does not actually need. This patch adds Win32
> specific implementation of these functions for Cygwin.
>
> This implementation handles most situation directly but in some rare cases
> it falls back on the implementation provided for Cygwin.

Even though I was concerned about code duplication earlier, with the 
factorization that you do in this series this is acceptable, in particular, 
since working out at a solution that deals with the time_t vs. timespec 
difference we would need dirty tricks that are not worth it.

(But see my comment about get_file_attr() in a separate mail.)

> +core.cygwinNativeStat::

This name is *really* odd, for two reasons:

- If I read "native" in connection with Windows, I would understand Windows's 
implementation as "native". Cygwin is not native - it's a bolted-on feature.

- This name talks about the implementation, not about its effect.

Perhaps a better name would be core.ignoreCygwinFSFeatures, and the 
description would only mention that setting this to true (the default) makes 
many operations much faster, but makes it impossible to use File System 
Features A and B and C in the repository. "If you need one of these features, 
set this to false."

(And after writing above paragraphs I notice, that you actually really meant 
Windows's "native" stat; see how confusing the name is?)

> +static inline void filetime_to_timespec(const FILETIME *ft, struct
> timespec *ts) +{
> +	long long winTime = ((long long)ft->dwHighDateTime << 32) +
> ft->dwLowDateTime; +	winTime -= 116444736000000000LL; /* Windows to Unix
> Epoch conversion */ +	ts->tv_sec = (time_t)(winTime/10000000); /*
> 100-nanosecond interval to seconds */ +	ts->tv_nsec = (long)(winTime -
> ts->tv_sec*10000000LL) * 100; /* nanoseconds */ +}

Shorter lines in this function would be appreciated (and not just because my 
MUA can't deal with them ;).

-- Hannes
