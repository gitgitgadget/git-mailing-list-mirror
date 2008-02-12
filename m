From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] pack-objects: only throw away data during memory pressure
Date: Tue, 12 Feb 2008 11:14:03 -0600
Message-ID: <20080212171403.GG27535@lavos.net>
References: <120271478556-git-send-email-mkoegler@auto.tuwien.ac.at> <alpine.LFD.1.00.0802110942310.2732@xanadu.home> <20080212082211.GE27535@lavos.net> <alpine.LFD.1.00.0802120910440.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 18:15:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOyiR-0008Cl-8S
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 18:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758314AbYBLROI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 12:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757991AbYBLROH
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 12:14:07 -0500
Received: from mxsf07.insightbb.com ([74.128.0.77]:13857 "EHLO
	mxsf07.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758433AbYBLROG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 12:14:06 -0500
X-IronPort-AV: E=Sophos;i="4.25,341,1199682000"; 
   d="scan'208";a="244027339"
Received: from unknown (HELO asav00.insightbb.com) ([172.31.249.124])
  by mxsf07.insightbb.com with ESMTP; 12 Feb 2008 12:14:04 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAKhisUdKhvkY/2dsb2JhbACBWapx
X-IronPort-AV: E=Sophos;i="4.25,341,1199682000"; 
   d="scan'208";a="155573350"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav00.insightbb.com with ESMTP; 12 Feb 2008 12:14:05 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id B2998309F21; Tue, 12 Feb 2008 11:14:03 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802120910440.2732@xanadu.home>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73675>

On Tue, Feb 12, 2008 at 09:26:25AM -0500, Nicolas Pitre wrote:
> I think your use case has merits, but the previous behavior had 
> semantics problems.  We always had constant window size with dynamic 
> memory usage, and now we have constant window size with bounded memory 
> usage.
> 
> If what you want is really to have a dynamic window size using a 
> constant memory usage then it needs a different and coherent way to be 
> specified.

Sometimes I want a bounded window size with bounded memory usage; i.e. a
maximum of 50 entries OR 256 megs worth.  That's for everyday repacking
of my troublesome repository; without the window going down to less than
10 or so for the large files, it still takes way too long, but doing the
whole thing at 10 makes for very poor packing.

So that gives four options:

1. No memory limit, constant entry depth.  Original Git behavior.
2. The above with an additional memory-based depth limit.  This is 
   what was added with --memory-limit.
3. Constant entry depth with a memory-usage limit.  This is what the
   proposed patch does.
4. Dynamic entry depth, with a memory-based limit.  This is I believe
   what you are proposing above, and what I emulate by setting
   --window=$bignum --window-memory=x.

I'm willing to try and make all of those work. (Though frankly I don't
care much about #3; setting the window entry size to something "large
enough" seems a simple enough work-around for me, and it prevents what's
probably some truly ridiculous behavior if you have a gigantic number of
tiny, say, tree objects.  Having a cap on window depth stops that case
from taking a truly inordinate amount of time.)

However, I can't figure out what sensible command-line and/or config
parameters would be for the cases above.  Any ideas?

-bcd
