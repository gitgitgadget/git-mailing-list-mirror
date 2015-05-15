From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 0/2] fix http deadlock on giant ref negotiations
Date: Fri, 15 May 2015 09:41:20 +0200
Message-ID: <1431675680.14042.39.camel@kaarsemaker.net>
References: <20150513210436.GA7407@gmail.com>
	 <20150514004724.GA3059@peff.net> <20150515062901.GA30768@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 15 09:41:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtAFO-0002NQ-1C
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 09:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbbEOHlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 03:41:25 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36767 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbbEOHlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 03:41:25 -0400
Received: by wizk4 with SMTP id k4so275239206wiz.1
        for <git@vger.kernel.org>; Fri, 15 May 2015 00:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=zdfzaMB5di9vW9OsHGJeCcWBgPVt0mB8fgp06fyRqmY=;
        b=S0bBfXKE+sTu2T2w/Imzv8jvUk35U9lJvMslnRPQRs54IfDNzR00diKazo/zogyB1V
         snLqUNBD9DWxw57ttPExLbh8zAesnJvV4zXmQKWs4Q+Y8W2nchnAhX6JXd6Um+PNSGZV
         3ZXpOJnrnhYsH0huDd0wGKxXQtq44S7iFzFBThp8erCXZl7AoypEtmwzPzRElDhRWKEJ
         nLfLH8ra+NGOxfGr+UxxlSC7l0LFwzP2R/vVDUCUPKSlTBcaC8dnUhUFWIAkxtmW+CK7
         icCI0eIDn5X0NycH+AGm3n3meCJbpkzRYGDAQOqtp9js0QtUmmIf2Ke6YYnlFNXNCdGC
         6vow==
X-Gm-Message-State: ALoCoQmm2AC8G2/4vMBb5NpO21KSZ/bRu4FmoPDXFe8aqfuhfhpuB+BDZh04LCpE/WzSlhQf5pBl
X-Received: by 10.194.209.130 with SMTP id mm2mr15231685wjc.64.1431675683742;
        Fri, 15 May 2015 00:41:23 -0700 (PDT)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id jq3sm1165569wjc.22.2015.05.15.00.41.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 00:41:22 -0700 (PDT)
In-Reply-To: <20150515062901.GA30768@peff.net>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269131>

On vr, 2015-05-15 at 02:29 -0400, Jeff King wrote:
> On Wed, May 13, 2015 at 08:47:24PM -0400, Jeff King wrote:
> 
> > The fundamental problem is the deadlock on the server side, which is
> > producing bogus protocol output. And that's a mismatch between what
> > Apache expects (that the CGI will read all of the input request and then
> > generate an output request) and what the CGI wants to do (stream output
> > as it reads the input).
> 
> At first I was irritated with Apache for this. But thinking on it more,
> it's really due to our shoe-horning of a full-duplex protocol into the
> half-duplex HTTP protocol. Even if we could convince Apache to work in a
> full-duplex way here, and even if our client is full-duplex (since
> otherwise we are just trading pipe buffers for TCP buffers), we still
> may face arbitrary HTTP proxies or other infrastructure in the middle.
> 
> So here's a series to try to address the issue. The first patch is a
> fixed version of the die-recursion fixup I posted earlier. The second is
> the interesting one.
> 
>   [1/2]: http-backend: fix die recursion with custom handler
>   [2/2]: http-backend: spool ref negotiation requests to buffer
> 
> I have no clue how to write a test that would trigger this reliably
> without requiring a gigantic test fixture. However, I did confirm that
> it fixes the problem on the chromium case you provided (which otherwise
> deadlocks reliably for me).

This looks similar to the failure I posted about alst year in
http://thread.gmane.org/gmane.comp.version-control.git/258514 

Though the issue is different, it has the same 'hanging git fetch'
symptom due to the deadlock between upload-pack and http-backend.

The patch I sent back then is suboptimal, as it can cause larger packs
than necessary (we still use it though, as the alternative is a
non-working git), but it does include a test you may be able to use to
verify your fix, if this is indeed the same issue.

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
