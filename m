From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] update-index/diff-index: use core.preloadindex
 to improve performance
Date: Fri, 2 Nov 2012 11:26:16 -0400
Message-ID: <20121102152616.GD11170@sigill.intra.peff.net>
References: <OF831F4AE9.23F46743-ONC1257AA7.00353C1F-C1257AA7.00361535@dcon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	pro-logic@optusnet.com.au
To: karsten.blees@dcon.de
X-From: msysgit+bncBDO2DJFKTEFBBG6MZ6CAKGQEWM5FZ5I@googlegroups.com Fri Nov 02 16:26:34 2012
Return-path: <msysgit+bncBDO2DJFKTEFBBG6MZ6CAKGQEWM5FZ5I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ia0-f186.google.com ([209.85.210.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBG6MZ6CAKGQEWM5FZ5I@googlegroups.com>)
	id 1TUJ8g-0008Gc-DW
	for gcvm-msysgit@m.gmane.org; Fri, 02 Nov 2012 16:26:30 +0100
Received: by mail-ia0-f186.google.com with SMTP id k10sf2382301iag.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 02 Nov 2012 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=BxbjG7oLs1iqxghDSSnyTuGItGtqH2iQ4JwCwHPcuGE=;
        b=m5DkwSdyU6LYZvrwJHgRD0QSdk49DgttAI1YTWgGg+PO7MpNnxsqj+iwLb4DwhUW9h
         cWtcJ4vh6KhxyMouJYuntvWurNqT27YzZuq2PZZS/WDqmtFqn6TjarMVnlrU76P/0l7k
         kPrpED8IpXMJ+EDJ/PcVnZwJDOzPBIe63leVffzBpiL7tE3guNf90h09at8PnnjlGx8p
         MdiYXUzxzMY0ueo0XKHj3yO5MS+9Ex9IWt6ewkF2LM56AhCqmybAW1s9sgisz1ZseR3S
         NOCSuVYUTxZf4qiZhOGdGWs4tx19dFLbrLgJymPdGrNgdKvuSCzkaGTqdgEKkfmqSzTn
       
Received: by 10.50.242.106 with SMTP id wp10mr854212igc.0.1351869981101;
        Fri, 02 Nov 2012 08:26:21 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.42.161.7 with SMTP id r7ls8750277icx.9.gmail; Fri, 02 Nov 2012
 08:26:19 -0700 (PDT)
Received: by 10.42.163.135 with SMTP id c7mr1201221icy.13.1351869979088;
        Fri, 02 Nov 2012 08:26:19 -0700 (PDT)
Received: by 10.42.163.135 with SMTP id c7mr1201220icy.13.1351869979076;
        Fri, 02 Nov 2012 08:26:19 -0700 (PDT)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id ul6si298481igb.2.2012.11.02.08.26.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Nov 2012 08:26:19 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 5743 invoked by uid 107); 2 Nov 2012 15:27:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 11:27:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 11:26:16 -0400
In-Reply-To: <OF831F4AE9.23F46743-ONC1257AA7.00353C1F-C1257AA7.00361535@dcon.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208950>

On Tue, Oct 30, 2012 at 10:50:42AM +0100, karsten.blees@dcon.de wrote:

> 'update-index --refresh' and 'diff-index' (without --cached) don't honor
> the core.preloadindex setting yet. Porcelain commands using these (such as
> git [svn] rebase) suffer from this, especially on Windows.
> 
> Use read_cache_preload to improve performance.
> 
> Additionally, in builtin/diff.c, don't preload index status if we don't
> access the working copy (--cached).
> 
> Results with msysgit on WebKit repo (2GB in 200k files):
> 
>                 | update-index | diff-index | rebase
> ----------------+--------------+------------+---------
> msysgit-v1.8.0  |       9.157s |    10.536s | 42.791s
> + preloadindex  |       9.157s |    10.536s | 28.725s
> + this patch    |       2.329s |     2.752s | 15.152s
> + fscache [1]   |       0.731s |     1.171s |  8.877s

Cool numbers. On my quad-core SSD Linux box, I saw a few speedups, too.
Here are the numbers for "update-index --refresh" on the WebKit repo
(all are wall clock time, best-of-five):

             | before | after
  -----------+--------+--------
  cold cache | 4.513s | 2.059s
  warm cache | 0.252s | 0.164s

Not as dramatic, but still nice. I wonder how a spinning disk would fare
on the cold-cache case, though.  I also tried it with all but one CPU
disabled, and the warm cache case was a little bit slower.

Still, I don't think we need to worry about performance regressions,
because people who don't have a setup suitable for it will not turn on
core.preloadindex in the first place. And if they have it on, the more
places we use it, probably the better.

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
