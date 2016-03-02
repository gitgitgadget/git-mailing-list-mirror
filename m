From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Resumable git clone?
Date: Wed, 2 Mar 2016 08:41:18 -0800
Message-ID: <20160302164118.GA13732@x>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
 <CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
 <20160302023024.GG17997@ZenIV.linux.org.uk>
 <xmqq8u215r25.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DcNrOmrKKPibV6GuSqspovBmHzUv_mRB6fZyLjw5wWzQ@mail.gmail.com>
 <20160302075437.GA8024@x>
 <xmqq4mcp5lij.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 17:41:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab9q6-0007Im-HW
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 17:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbcCBQlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 11:41:25 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43260 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcCBQlY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 11:41:24 -0500
Received: from mfilter30-d.gandi.net (mfilter30-d.gandi.net [217.70.178.161])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 439CEFB902;
	Wed,  2 Mar 2016 17:41:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter30-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter30-d.gandi.net (mfilter30-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id IFnBkfcPEDRw; Wed,  2 Mar 2016 17:41:21 +0100 (CET)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id F40DEFB8E7;
	Wed,  2 Mar 2016 17:41:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqq4mcp5lij.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288128>

On Wed, Mar 02, 2016 at 12:31:16AM -0800, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> > I think several simpler optimizations seem
> > preferable, such as binary object names, and abbreviating complete
> > object sets ("I have these commits/trees and everything they need
> > recursively; I also have this stack of random objects.").
> 
> Given the way pack stream is organized (i.e. commits first and then
> trees and blobs that belong to the same delta chain together), and
> our assumed goal being to salvage objects from an interrupted
> transfer of a packfile, you are unlikely to ever see "I have these
> commits/trees and everything they need" that are salvaged from such
> a failed transfer.  So I doubt such an optimization is worth doing.

True for the resumable clone case.  For that optimization, I was
thinking of the "pull during the merge window" case that Al Viro was
also interested in optimizing.

> Besides it is very expensive to compute (the computation is done on
> the client side, so the cycles burned and the time the user has to
> wait is of much less concern, though); you'd essentially be doing
> "git fsck" to find the "dangling" objects.

Trading client-side computation for bandwidth can potentially be
worthwhile if you have plenty of local compute but a slow and metered
link.

> The list of what would be transferred needs to come in full from the
> server end, as the list names objects that the receiving end may not
> have seen, but the response by the client could be encoded much
> tightly.  For the full list of N objects from the server, we can
> think of your response to be a bitstream of N bits, each on-bit in
> which signals an unwanted object in the list.  You can optimize this
> transfer by RLE compressing the bitstream, for example.
> 
> As git-over-HTTP is stateless, however, you cannot assume that the
> server side remembers what it sent to the client (instead, the
> client side needs to re-post what it heard from the server in the
> previous exchange to allow the server side to use it after
> validating).  So "objects at these indices in your list" kind of
> optimization may not work very well in that environment.  I'd
> imagine that an exchange of "Here are the list of objects", "Give me
> these objects" done naively in full 40-hex object names would work
> OK there, though.

Good point.  Between statelessness and Duy's point about the client list
usually being smaller than the server list, perhaps it would make sense
to not have the server send a list at all, and just have the client send
its own list.

- Josh Triplett
