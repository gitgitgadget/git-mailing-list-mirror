From: Theodore Tso <tytso@mit.edu>
Subject: Re: How git affects kernel.org performance
Date: Mon, 8 Jan 2007 08:56:22 -0500
Message-ID: <20070108135622.GD32756@thunk.org>
References: <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org> <20070108030555.GA7289@in.ibm.com> <20070108125819.GA32756@thunk.org> <20070108134147.GB5291@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-From: linux-ext4-owner@vger.kernel.org Mon Jan 08 14:57:51 2007
Return-path: <linux-ext4-owner@vger.kernel.org>
Envelope-to: gcfe-linux-ext4@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3v0Y-00038A-4q
	for gcfe-linux-ext4@gmane.org; Mon, 08 Jan 2007 14:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161304AbXAHN5s (ORCPT <rfc822;gcfe-linux-ext4@m.gmane.org>);
	Mon, 8 Jan 2007 08:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbXAHN5s
	(ORCPT <rfc822;linux-ext4-outgoing>); Mon, 8 Jan 2007 08:57:48 -0500
Received: from thunk.org ([69.25.196.29]:58635 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbXAHN5r (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
	Mon, 8 Jan 2007 08:57:47 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H3v3d-0003mk-JX; Mon, 08 Jan 2007 09:01:01 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H3uz8-0003SQ-Fv; Mon, 08 Jan 2007 08:56:22 -0500
To: Johannes Stezenbach <js@linuxtv.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Johannes Stezenbach <js@linuxtv.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070108134147.GB5291@linuxtv.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36260>

On Mon, Jan 08, 2007 at 02:41:47PM +0100, Johannes Stezenbach wrote:
> 
> Would e2fsck -D help? What kind of optimization
> does it perform?

It will help a little; e2fsck -D compresses the logical view of the
directory, but it doesn't optimize the physical layout on disk at all,
and of course, it won't help with the lack of readahead logic.  It's
possible to improve how e2fsck -D works, at the moment, it's not
trying to make the directory be contiguous on disk.  What it should
probably do is to pull a list of all of the blocks used by the
directory, sort them, and then try to see if it can improve on the
list by allocating some new blocks that would make the directory more
contiguous on disk.  I suspect any improvements that would be seen by
doing this would be second order effects at most, though.

						- Ted
