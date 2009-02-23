From: Jeff King <peff@peff.net>
Subject: Re: autocrlf=input and safecrlf (was Re: CVS import [SOLVED])
Date: Sun, 22 Feb 2009 19:08:40 -0500
Message-ID: <20090223000840.GA20392@coredump.intra.peff.net>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl> <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl> <60044.192.168.0.51.1234816333.squirrel@hupie.xs4all.nl> <alpine.DEB.1.00.0902162157080.6289@intel-tinevez-2-302> <20090220152849.GA3826@coredump.intra.peff.net> <32886.77.61.241.211.1235147143.squirrel@hupie.xs4all.nl> <20090220172918.GB4636@coredump.intra.peff.net> <499F3B9B.3020709@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Mon Feb 23 01:10:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbOOi-0001SN-8v
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 01:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbZBWAIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 19:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbZBWAIn
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 19:08:43 -0500
Received: from peff.net ([208.65.91.99]:36221 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444AbZBWAIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 19:08:43 -0500
Received: (qmail 18676 invoked by uid 107); 23 Feb 2009 00:09:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 22 Feb 2009 19:09:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Feb 2009 19:08:40 -0500
Content-Disposition: inline
In-Reply-To: <499F3B9B.3020709@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111067>

On Sat, Feb 21, 2009 at 12:24:11AM +0100, Ferry Huberts (Pelagic) wrote:

>> I still think safecrlf could probably be made more useful in this case
>> to differentiate between "this will corrupt your data if you do a
>> checkout with your current config settings" and "this will corrupt your
>> data forever".  But I am not a user of either config variable, so maybe
>> there is some subtlety I'm missing.
>
> I'm a user of these options myself. I maintain several large repositories 
> that contain data that is used both on Unix and Windows platforms and that 
> have the autocrlf=input and safecrlf=true. This makes sure that everything 
> is in Unix format.

OK, so there is some value to that combination, then, I suppose. It
seems like there must be some easier and more obvious way to say "reject
all CRLFs", but I can't think of one besides setting up a hook (which
would work at commit time, not add time).

> Your remark about corrupting your data is a bit strong for my taste.  
> Corruption from one point of view, making sure that everybody handles the 
> same content from another :-)

I'm not sure you understood what I meant. What I meant is that for some
set of data, applying CRLF->LF conversion is lossy, and will permanently
destroy the ability to restore the original data. For example, arbitrary
binary data which contains both CRLF and LF will have all CRLF become
LF, but you don't know which of the resulting LFs were originally CRLFs,
and which were just LFs. The data is corrupted, there is no way to get
back the original, and this is what CRLF is about protecting.

However, that safecrlf check is implemented by saying "with the current
autocrlf settings, would checkin and checkout get the same file?". In
the case of autocrlf=true, that that exactly prevents the data above
from being corrupted. But with autocrlf=input, it prevents _any_ CRs
from being converted, since checkout will not convert them back. So even
though your data is not irretrievable (the transformation _is_
reversible, you just don't have it enabled), safecrlf is still
triggering and refusing the content.

And I was suggesting that it might be useful to distinguish between
those two situations. Because right now, with autocrlf=input you have
two choices:

  - safecrlf=false, in which you will corrupt mixed CRLF/LF data without
    any warning

  - safecrlf=true, in which case you are not allowed to check in CR at
    all

But there is no choice for "protect me from actual corruption, but
convert text files (i.e., all CRLF)".

I am a bit concerned about a proposal to set safecrlf=false in all
cvsimported repositories.  You are turning off the protection against
corrupting binary files.  _Even if_ the person has put safecrlf=true
into their ~/.gitconfig and thinks they are safe.

-Peff
