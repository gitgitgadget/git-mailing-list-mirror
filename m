From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 21:02:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606092043460.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> 
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> 
 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com> 
 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>  <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
  <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com> 
 <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
 <46a038f90606092041neadcc54n2acb6272d1f71de7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 06:02:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FougU-0001TR-CA
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 06:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWFJECj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 00:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWFJECj
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 00:02:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20894 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932357AbWFJECi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jun 2006 00:02:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5A42Zgt018033
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 21:02:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5A42YcD008972;
	Fri, 9 Jun 2006 21:02:35 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606092041neadcc54n2acb6272d1f71de7@mail.gmail.com>
X-Spam-Status: No, hits=0.16 required=5 tests=HTML_MESSAGE
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21593>



On Sat, 10 Jun 2006, Martin Langhoff wrote:
> 
> So the per-file and per-directory overhead are significant. I can do a
> cvs checkout via pserver:localhost but I don't know off-the-cuff how
> to measure the traffic. Hints?

Over localhost, you won't see the biggest issue, which is just latency.

The git protocol should be absolutely <i>wonderful</i> with bad latency, 
because once the early bakc-and-forth on what each side has is done, 
there's no synchronization any more - it's all just streaming, with 
full-frame TCP.

If :pserver: does per-file "hey, what are you up to" kind of 
syncronization, the big killer would be the latency from one end to the 
other, regardless of any throughput.

You can try to approximate the latency by just looking at the number of 
packets, and using a large MTU (and on localhost, the MTU will be pretty 
large - roughly 16kB. Don't count packet size at all, just count how many 
packets each protocol sends (both ways), ignoring packets that are just 
empty ACK's.

I don't know how to build a tcpdump expression for "TCP packet with an 
empty payload", but I bet it's possible.

[ And I won't guarantee that it's a wonderful approximation for "network 
  cost", but I think it's potentially a reasonably good one. It's totally 
  realistic to equate 32kB of _streaming_ data (two packets flowing in 
  one direction with no synchronization) with just a single byte of data 
  going back-and-forth synchronously ]

		Linus
