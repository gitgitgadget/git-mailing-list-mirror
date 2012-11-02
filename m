From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] update-index/diff-index: use core.preloadindex
 to improve performance
Date: Fri, 2 Nov 2012 11:38:00 -0400
Message-ID: <20121102153800.GE11170@sigill.intra.peff.net>
References: <OF831F4AE9.23F46743-ONC1257AA7.00353C1F-C1257AA7.00361535@dcon.de>
 <20121102152616.GD11170@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	pro-logic@optusnet.com.au
To: karsten.blees@dcon.de
X-From: msysgit+bncBDO2DJFKTEFBBW6RZ6CAKGQELOXOBPY@googlegroups.com Fri Nov 02 16:38:13 2012
Return-path: <msysgit+bncBDO2DJFKTEFBBW6RZ6CAKGQELOXOBPY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBW6RZ6CAKGQELOXOBPY@googlegroups.com>)
	id 1TUJK0-0003Sa-Se
	for gcvm-msysgit@m.gmane.org; Fri, 02 Nov 2012 16:38:13 +0100
Received: by mail-qc0-f186.google.com with SMTP id y9sf2405816qcp.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 02 Nov 2012 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=zmON2ZpVbJHUS+tiDk26bwSKLhPPtW0Z2SBEkucNjng=;
        b=lIEiehbSGXDl8Qg8FURNPPtm5lFj18iEXF2m3yMbf3EjGgqTqU3Q7fHr4thB5yPc/V
         Sw8U1kJUsmYOA5g1L7jjvWGK3cq5+aZ5pa4wrDHXhhF7MiMOxmF3pVXjsZ/x4NQYlJTf
         O3t+c6wXLOtCRrD5zpvF41NqBRWGX0lCYtfVtv1tCpK/dIJcUQJvKM+uomPHakVegoRr
         oZVDEukIIYYV50K6oUHPscNN7cUSNNE/h5v7yxW7kNCqsbRN5f3Z1g2ojAE8CauDijK5
         ik5WuqeIa7w/cUdlczyZZK5a1NZcuv5JKzVntUGNcZZ99FKqA5QxSIJZ5cXb3daspDoO
       
Received: by 10.50.169.7 with SMTP id aa7mr874279igc.2.1351870683682;
        Fri, 02 Nov 2012 08:38:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.41.194 with SMTP id h2ls3778572igl.4.canary; Fri, 02 Nov
 2012 08:38:02 -0700 (PDT)
Received: by 10.42.118.1 with SMTP id v1mr1245791icq.17.1351870682974;
        Fri, 02 Nov 2012 08:38:02 -0700 (PDT)
Received: by 10.42.118.1 with SMTP id v1mr1245790icq.17.1351870682959;
        Fri, 02 Nov 2012 08:38:02 -0700 (PDT)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id hr6si305109igc.0.2012.11.02.08.38.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Nov 2012 08:38:02 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 6022 invoked by uid 107); 2 Nov 2012 15:38:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 11:38:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 11:38:00 -0400
In-Reply-To: <20121102152616.GD11170@sigill.intra.peff.net>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 75.15.5.89 as permitted sender) smtp.mail=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208953>

On Fri, Nov 02, 2012 at 11:26:16AM -0400, Jeff King wrote:

> Still, I don't think we need to worry about performance regressions,
> because people who don't have a setup suitable for it will not turn on
> core.preloadindex in the first place. And if they have it on, the more
> places we use it, probably the better.

BTW, your patch was badly damaged in transit (wrapped, and tabs
converted to spaces). I was able to fix it up, but please check your
mailer's settings.

-Peff

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
