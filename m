From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Resumable git clone?
Date: Wed, 2 Mar 2016 00:13:44 -0800
Message-ID: <20160302081344.GB8024@x>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
 <CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
 <20160302023024.GG17997@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us
To: Al Viro <viro@ZenIV.linux.org.uk>
X-From: git-owner@vger.kernel.org Wed Mar 02 09:14:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab1uz-0005wg-AT
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 09:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbcCBINy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 03:13:54 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35179 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbcCBINy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 03:13:54 -0500
Received: from mfilter36-d.gandi.net (mfilter36-d.gandi.net [217.70.178.167])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 1AD8F41C0A0;
	Wed,  2 Mar 2016 09:13:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter36-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter36-d.gandi.net (mfilter36-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id M1cbDduIle1Q; Wed,  2 Mar 2016 09:13:49 +0100 (CET)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 5616841C0B6;
	Wed,  2 Mar 2016 09:13:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160302023024.GG17997@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288102>

On Wed, Mar 02, 2016 at 02:30:24AM +0000, Al Viro wrote:
> On Tue, Mar 01, 2016 at 05:40:28PM -0800, Stefan Beller wrote:
> 
> > So throwing away half finished stuff while keeping the front load?
> 
> Throw away the object that got truncated and ones for which delta chain
> doesn't resolve entirely in the transferred part.
>  
> > > indexing the objects it
> > > contains, and then re-running clone and not having to fetch those
> > > objects.
> > 
> > The pack is not deterministic for a given repository. When creating
> > the pack, you may encounter races between threads, such that the order
> > in a pack differs.
> 
> FWIW, I wasn't proposing to recreate the remaining bits of that _pack_;
> just do the normal pull with one addition: start with sending the list
> of sha1 of objects you are about to send and let the recepient reply
> with "I already have <set of sha1>, don't bother with those".  And exclude
> those from the transfer.  Encoding for the set being available is an
> interesting variable here - might be plain list of sha1, might be its
> complement ("I want the following subset"), might be "145th to 1029th,
> 1517th and 1890th to 1920th of the list you've sent"; which form ends
> up more efficient needs to be found experimentally...

As a simple proposal, the server could send the list of hashes (in
approximately the same order it would send the pack), the client could
send back a bitmap where '0' means "send it" and '1' means "got that one
already", and the client could compress that bitmap.  That gives you the
RLE and similar without having to write it yourself.  That might not be
optimal, but it would likely set a high bar with minimal effort.

One debatable optimization on top of that would rely on git object
structure to imply objects hashes without sending them: the message from
the server could have a list of commit/tree hashes that imply sending
all objects reachable from those, without having to send all the implied
hashes.  However, that would then make the message back from the client
about what it already has larger and more complicated; that might not
make it worthwhile.

This seems like a good case for doing the simplest possible thing first
(complete hash list, compressed "got it already" bitmap), seeing how
much benefit that provides, and creating a v2 protocol if some
additional optimization proves sufficiently worthwhile.

- Josh Triplett
