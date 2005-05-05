From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial v0.4d
Date: Thu, 5 May 2005 13:36:58 -0700
Message-ID: <20050505203658.GG22038@waste.org>
References: <20050504025852.GK22038@waste.org> <20050504181802.GS22038@waste.org> <427A6E3F.5090904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 05 22:31:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTmzp-0002yI-MR
	for gcvg-git@gmane.org; Thu, 05 May 2005 22:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVEEUhK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 16:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVEEUhK
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 16:37:10 -0400
Received: from waste.org ([216.27.176.166]:46045 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261540AbVEEUhC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2005 16:37:02 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j45Kaxac025999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 5 May 2005 15:36:59 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j45KawTM025996;
	Thu, 5 May 2005 15:36:58 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Content-Disposition: inline
In-Reply-To: <427A6E3F.5090904@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 05, 2005 at 03:04:31PM -0400, Jeff Garzik wrote:
> Matt Mackall wrote:
> >The web protocol is painfully slow, mostly because it makes an http
> >round trip per file revision to pull. I'm about to start working on a
> >replacement that minimizes round trips.
> 
> Can you make it do HTTP 1.1 pipelining?

Yes, a zsync-like protocol ought to be doable. But you'll still
potentially be doing 16k requests to pull something the size of the
kernel, which isn't very friendly to a web server. So I'm working on a
stand-alone or possibly CGI-based replacement.

My goal is to do something like this:

client                             server
I last saw change N from you 
                                   W, X, Y, and Z are newer here
Send me X, Y, and Z relative to N
                                   Here you go, deltas from N to X to
				   Y to Z, sorted by file

So not only can we be efficient in number of round trips and data
transferred, we can reduce seeks by applying all per-file changes together.
We can also usually avoid decompress/recompress and patch/diff because
both ends will end up storing the same delta.

-- 
Mathematics is the supreme nostalgia of our time.
