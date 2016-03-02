From: Jeff King <peff@peff.net>
Subject: Re: Resumable git clone?
Date: Wed, 2 Mar 2016 03:32:27 -0500
Message-ID: <20160302083227.GA30065@sigill.intra.peff.net>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
 <CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
 <20160302023024.GG17997@ZenIV.linux.org.uk>
 <20160302081344.GB8024@x>
 <CACsJy8CBBk4bgz6Gn0QvCwWtOsqcQZBYgOBQTd=4Y+2YKs44Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Josh Triplett <josh@joshtriplett.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 09:32:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab2D2-0006nx-5o
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 09:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbcCBIcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 03:32:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:53064 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751240AbcCBIcb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 03:32:31 -0500
Received: (qmail 10825 invoked by uid 102); 2 Mar 2016 08:32:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Mar 2016 03:32:30 -0500
Received: (qmail 21690 invoked by uid 107); 2 Mar 2016 08:32:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Mar 2016 03:32:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2016 03:32:27 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CBBk4bgz6Gn0QvCwWtOsqcQZBYgOBQTd=4Y+2YKs44Qg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288107>

On Wed, Mar 02, 2016 at 03:22:17PM +0700, Duy Nguyen wrote:

> > As a simple proposal, the server could send the list of hashes (in
> > approximately the same order it would send the pack), the client could
> > send back a bitmap where '0' means "send it" and '1' means "got that one
> > already", and the client could compress that bitmap.  That gives you the
> > RLE and similar without having to write it yourself.  That might not be
> > optimal, but it would likely set a high bar with minimal effort.
> 
> We have an implementation of EWAH bitmap compression, so compressing
> is not a problem.
> 
> But I still don't see why it's more efficient to have the server send
> the hash list to the client. Assume you need to transfer N objects.
> That direction makes you always send N hashes. But if the client sends
> the list of already fetched objects, M, then M <= N. And we won't need
> to send the bitmap. What did I miss?

Right, I don't see what the point is in compressing the bitmap. The sha1
list for a clone of linux.git is 87 megabytes. The return bitmap, even
naively, is 500K. Unless you are trying to optimize for wildly
asymmetric links.

If the client just naively sends "here's what I have", then we know it
can never be _more_ than 87 megabytes. And as a bonus, the longer the
list is, the more we are saving (so at the moment you are sending 82MB,
it's really worth it, because you do have 95% of the pack, which is
worth amortizing).

I'm still a little dubious that anything involving "send all the hashes"
is going to be useful in practice, especially for something like the
kernel (where you have tons of huge small objects that delta well). It
would work better when you have gigantic objects that don't delta (so
the cost of a sha1 versus the object size is way better), but then I
think we'd do better to transfer all of the normal-sized bits up front,
and then allow fetching the large stuff separately.

-Peff
