From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 5/5] diff-highlight: document some non-optimal cases
Date: Tue, 14 Feb 2012 07:48:45 +0100
Message-ID: <20120214074845.513bccf6@mkiedrowicz.ivo.pl>
References: <20120213222702.GA19393@sigill.intra.peff.net>
	<20120213223733.GE19521@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 08:03:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxCQb-00073d-2m
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 08:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab2BNHDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 02:03:48 -0500
Received: from mail-ey0-f194.google.com ([209.85.215.194]:33508 "EHLO
	mail-ey0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab2BNHDs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 02:03:48 -0500
X-Greylist: delayed 898 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Feb 2012 02:03:47 EST
Received: by eaah1 with SMTP id h1so1018402eaa.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 23:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=BJ7gpMF8EmLo0EGpKZFT1LMxr/ed+w4LuCaNivLWsUc=;
        b=pEeUa+IcxuhE0urHV27F/AVIMDNOpNlfguP/j89uqj9/WHiujYELdE+JEdxRdwau48
         YqTWr3ATPNVY3TUeawl1P2Odhhx06Vqc3e6B8ZWuhZcrxAcksrSpqKJf6rsveTCw4a9T
         HLM2mKEtbytMqpRXOTRuC7khzmXLJ2kXxATHM=
Received: by 10.213.27.74 with SMTP id h10mr215301ebc.49.1329202128530;
        Mon, 13 Feb 2012 22:48:48 -0800 (PST)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id z47sm69899803eeh.9.2012.02.13.22.48.47
        (version=SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 22:48:48 -0800 (PST)
In-Reply-To: <20120213223733.GE19521@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190705>

Jeff King <peff@peff.net> wrote:

> The diff-highlight script works on heuristics, so it can be
> wrong. Let's document some of the wrong-ness in case
> somebody feels like working on it.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> These were just some that I considered while looking at the output of
> the original and the current code. Suggestions are welcome for more.

I would also add (feel free to reword if my English is not very clear):

3. Sometimes the prefix or suffix is very small but because it exists,
almost whole line is highlighted. For example:

----------------------------------------------
--{This is a very long line}.
++{I like apples}.
----------------------------------------------

or:

----------------------------------------------
-Th-{is is an apple}
+Th+{at was a car}
----------------------------------------------


> 
>  contrib/diff-highlight/README |   93
> +++++++++++++++++++++++++++++++++++++++++ 1 file changed, 93
> insertions(+)
> 
> diff --git a/contrib/diff-highlight/README
> b/contrib/diff-highlight/README index 4a58579..502e03b 100644
> --- a/contrib/diff-highlight/README
> +++ b/contrib/diff-highlight/README
> @@ -57,3 +57,96 @@ following in your git configuration:
>  	show = diff-highlight | less
>  	diff = diff-highlight | less
>  ---------------------------------------------
> +
> +Bugs
> +----
> +
> +Because diff-highlight relies on heuristics to guess which parts of
> +changes are important, there are some cases where the highlighting is
> +more distracting than useful. Fortunately, these cases are rare in
> +practice, and when they do occur, the worst case is simply a little
> +extra highlighting. This section documents some cases known to be
> +sub-optimal, in case somebody feels like working on improving the
> +heuristics.
> +
> +1. Two changes on the same line get highlighted in a blob. For
> example,
> +   highlighting:
> +
> +----------------------------------------------
> +-foo(buf, size);
> ++foo(obj->buf, obj->size);
> +----------------------------------------------
> +
> +   yields (where the inside of "+{}" would be highlighted):
> +
> +----------------------------------------------
> +-foo(buf, size);
> ++foo(+{obj->buf, obj->}size);
> +----------------------------------------------
> +
> +   whereas a more semantically meaningful output would be:
> +
> +----------------------------------------------
> +-foo(buf, size);
> ++foo(+{obj->}buf, +{obj->}size);
> +----------------------------------------------
> +
> +   Note that doing this right would probably involve a set of
> +   content-specific boundary patterns, similar to word-diff.
> Otherwise
> +   you get junk like:
> +
> +-----------------------------------------------------
> +-this line has some -{i}nt-{ere}sti-{ng} text on it
> ++this line has some +{fa}nt+{a}sti+{c} text on it
> +-----------------------------------------------------
> +
> +   which is less readable than the current output.
> +
> +2. The multi-line matching assumes that lines in the pre- and
> post-image
> +   match by position. This is often the case, but can be fooled when
> a
> +   line is removed from the top and a new one added at the bottom (or
> +   vice versa). Unless the lines in the middle are also changed,
> diffs
> +   will show this as two hunks, and it will not get highlighted at
> all
> +   (which is good). But if the lines in the middle are changed, the
> +   highlighting can be misleading. Here's a pathological case:
> +
> +-----------------------------------------------------
> +-one
> +-two
> +-three
> +-four
> ++two 2
> ++three 3
> ++four 4
> ++five 5
> +-----------------------------------------------------
> +
> +   which gets highlighted as:
> +
> +-----------------------------------------------------
> +-one
> +-t-{wo}
> +-three
> +-f-{our}
> ++two 2
> ++t+{hree 3}
> ++four 4
> ++f+{ive 5}
> +-----------------------------------------------------
> +
> +   because it matches "two" to "three 3", and so forth. It would be
> +   nicer as:
> +
> +-----------------------------------------------------
> +-one
> +-two
> +-three
> +-four
> ++two +{2}
> ++three +{3}
> ++four +{4}
> ++five 5
> +-----------------------------------------------------
> +
> +   which would probably involve pre-matching the lines into pairs
> +   according to some heuristic.
