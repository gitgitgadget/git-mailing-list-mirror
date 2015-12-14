From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why does send-pack call pack-objects for all remote refs?
Date: Mon, 14 Dec 2015 14:31:55 -0800
Message-ID: <20151214223155.GA6594@google.com>
References: <4766c8518c2a46afb88fc0a2dd9a1688@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
 <xmqqvb89lw5f.fsf@gitster.mtv.corp.google.com>
 <20151207225714.GA3785@sigill.intra.peff.net>
 <8712f730fb4c414ebc2b1168ca7948b8@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
 <20151210041941.GA4056@sigill.intra.peff.net>
 <d0a39b03e49d41e685cf61398c0d1102@EXCHANGE2U.uunet.arlington.PredictiveTechnologies.com>
 <20151214210429.GC14788@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Koverman <dkoverman@predictiveTechnologies.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Nasser Grainawi <nasser@codeaurora.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 23:32:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8bfh-0005Tr-Cz
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 23:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904AbbLNWcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 17:32:36 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33618 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932725AbbLNWce (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 17:32:34 -0500
Received: by pfnn128 with SMTP id n128so112721552pfn.0
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 14:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CscjP5RZiYiOSjyb5TuRLPpMn97989tRDkfnmk0mKGI=;
        b=AaIJtKAL0fPYPN2/dGX3pecin8NoVMcXOrSVpknhbWRgqH7+GqW4dpWFWdP2qkhkJg
         qBAay6XojO+yoVY98KqsYqCnxyxoJitC+lgKQ+QktheFdAEAkNf+FSfWDfCewRSAudhi
         qUyR68Y3qe1GWMUhc82hFNOxYSzG0uweCGvvz6cuu0+/qOmwUDRP2yqtZ0BwTmsrzqC2
         x/9v47Nmme/8CL0yolvzGomoafFdCUlAc+fzy5zFNYuv6WZXVVxGZJb2LHo8Zu4Cx1hp
         9FSdYmtMH4Vln8X1sCQ24WVTeJrFckZXkZ4w5/UwLrA64TeIGQS9dgMLK8lfPXdnL8RP
         Gm9Q==
X-Received: by 10.98.64.209 with SMTP id f78mr39915788pfd.74.1450132351938;
        Mon, 14 Dec 2015 14:32:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d470:8e26:b1a2:9e8f])
        by smtp.gmail.com with ESMTPSA id ah10sm44989261pad.23.2015.12.14.14.32.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Dec 2015 14:32:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151214210429.GC14788@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282431>

Jeff King wrote:

> Hmm. I guess that makes sense. The bitmap we want is the set difference
> between the objects we are sending, and the tips the other side has. If
> we have a bitmap at each ref tip, that's very fast. But if you have a
> very large number of refs, we don't make one for each ref, and it has to
> fallback to walking to the nearest one (and it ends up worse than a
> regular walk, because it's filling in the bitmap for each tree, rather
> than just doing the "good enough" commit walk that we usually do).
>
> I suspect there's room for improvement in the way we select commits to
> store bitmaps for (so that the average walk is smaller). But it's rather
> tricky; there's not a single constant to change to make it work better.

Git gc and JGit GC differ here.  JGit partitions the commits being
packed by branch and then runs a selection algorithm on each part.
Git runs a selection once on a list of all commits.

Some effects:
- JGit selects more bitmaps, so the gc takes longer and the resulting
  bitmap file is larger (bad)
- JGit is more likely to have bitmaps for the commits involved in
  pushes and fetches (good)

The commit selection code, for reference:

https://eclipse.googlesource.com/jgit/jgit/+/86af34e1/org.eclipse.jgit/src/org/eclipse/jgit/internal/storage/pack/PackWriterBitmapPreparer.java#151
https://kernel.googlesource.com/pub/scm/git/git/+/ed1c9977/pack-bitmap-write.c#383

Thoughts?
Jonathan
