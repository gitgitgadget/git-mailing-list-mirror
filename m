From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 0/2] fix http deadlock on giant ref negotiations
Date: Fri, 15 May 2015 10:44:50 +0200
Message-ID: <1431679490.14042.42.camel@kaarsemaker.net>
References: <20150513210436.GA7407@gmail.com>
	 <20150514004724.GA3059@peff.net> <20150515062901.GA30768@peff.net>
	 <1431675680.14042.39.camel@kaarsemaker.net>
	 <20150515083843.GA16910@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 15 10:45:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtBEu-0008TO-Dj
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 10:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbbEOIo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 04:44:58 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34167 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbbEOIoy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 04:44:54 -0400
Received: by wicmc15 with SMTP id mc15so33637175wic.1
        for <git@vger.kernel.org>; Fri, 15 May 2015 01:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=nmAjw2/axmdhY/cYV0JSDpCcA+7w0fSgwhYyD8zAj/s=;
        b=UY6ItP/cmbgc5g51tIjZomuLaiKTrPKICoeBv5RdLxx1o7oonZjOu4Xvb9aUmUXLgR
         B3GF38nH6nerrIy/78gxUkheZ5vkdJO9QAO7Yn76ZxPTe+TkG8qgi9vvcuhak5oWEP8P
         dOnK72yjDWW81b1GDPQDbsjM9LDYWeE9gxzauHiKwL+UbzJ/iCbg1M/9TzkLYsw/kf3A
         ob6a6Dtm+BqPHMH5yjzOVbjkC2zZ8dLTL1syF+3v2tXb/lnxJn+3YKfcreNcBFHYy6S7
         XJAFGtdV4WEpS3yGv4KzsVUa2KE+XMCUmd4BbnKGanHQLewiKSQUdiyodZxoL28z1cSq
         645w==
X-Gm-Message-State: ALoCoQkUohK95nDiVWRlTPHQu8pl9mTf83G/tfI6zro2xa+P/vERpTxikpnFraOAFupVcn6ldK7p
X-Received: by 10.180.219.42 with SMTP id pl10mr31911767wic.70.1431679492904;
        Fri, 15 May 2015 01:44:52 -0700 (PDT)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id ei8sm1388576wjd.32.2015.05.15.01.44.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 01:44:51 -0700 (PDT)
In-Reply-To: <20150515083843.GA16910@peff.net>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269134>

On vr, 2015-05-15 at 04:38 -0400, Jeff King wrote:
> On Fri, May 15, 2015 at 09:41:20AM +0200, Dennis Kaarsemaker wrote:
> 
> > > I have no clue how to write a test that would trigger this reliably
> > > without requiring a gigantic test fixture. However, I did confirm that
> > > it fixes the problem on the chromium case you provided (which otherwise
> > > deadlocks reliably for me).
> > 
> > This looks similar to the failure I posted about alst year in
> > http://thread.gmane.org/gmane.comp.version-control.git/258514
> > 
> > Though the issue is different, it has the same 'hanging git fetch'
> > symptom due to the deadlock between upload-pack and http-backend.
> 
> Thanks, I think it is the same issue (in the end I was replicating not
> with `--reference`, but just by doing a fetch from the other
> repository). And our solutions are essentially the same. I do prefer
> mine because:
> 
>   1. It keeps the buffering logic in http-backend; the half-duplex
>      nature is an http detail.
> 
>   2. I think it's better to buffer the request rather than the response,
>      for the reasons I stated in the commit message.
> 
> > The patch I sent back then is suboptimal, as it can cause larger packs
> > than necessary (we still use it though, as the alternative is a
> > non-working git), but it does include a test you may be able to use to
> > verify your fix, if this is indeed the same issue.
> 
> I applied the test from your patch, but couldn't get it to fail even
> with stock git.  The test above it shrunk a bit, but I was able to tweak
> yours to generate tags from 2001..100000, which I thought would have
> worked.  I suspect it's something silly like the size not being quite
> big enough for the pipe buffer on my system, or something like that.
> Though I couldn't get it to fail even with 200,000 tags, so perhaps it's
> something else.

The shrinkage in the test above it will actually work around the issue,
as there are now fewer already-fetched tags to negotiate. Either
reverting that shrinkage or executing the new test twice should do the
trick.
-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
