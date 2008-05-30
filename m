From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: reducing prune sync()s
Date: Fri, 30 May 2008 22:07:18 +0200
Message-ID: <87iqwvo8sp.fsf@mid.deneb.enyo.de>
References: <20080529205743.GC17123@redhat.com>
	<alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org>
	<alpine.LFD.1.10.0805291727490.3141@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 22:09:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Atp-0000sw-9S
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 22:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691AbYE3UHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 16:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756355AbYE3UHX
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 16:07:23 -0400
Received: from mail.enyo.de ([212.9.189.167]:36373 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756333AbYE3UHU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 16:07:20 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1K2Asg-0004s4-Rh
	for git@vger.kernel.org; Fri, 30 May 2008 22:07:18 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1K2Asg-00027a-EN
	for git@vger.kernel.org; Fri, 30 May 2008 22:07:18 +0200
In-Reply-To: <alpine.LFD.1.10.0805291727490.3141@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 29 May 2008 17:32:30 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83321>

* Linus Torvalds:

> Side note: a lot of systems make "fsync()" pretty expensive too. It's one 
> of my main disagreements with most log-based filesystems - fsync() can in 
> theory be fast, but almost always implies flushing the whole log, even if 
> 99.9% of that log is totally unrelated to the actual file you want to 
> fsync().

And flushing the whole log might be less expensive than several partial
flushes with ordering constraints.  If Linux ever gets support for
partial log flushes, I suppose you could restore the previous
performance by using sync_file_range() with approriate flags (to get the
data in flight to disk), followed by a second round of calls to to
fsync() (to actually wait for I/O completion).

> So fsync() isn't always all that much better than sync().

sync() is potentially a no-op, particularly if some of the targeted
files are still open.
