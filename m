From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Resumable git clone?
Date: Wed, 2 Mar 2016 08:40:06 -0800
Message-ID: <20160302164006.GA13790@x>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
 <CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
 <20160302023024.GG17997@ZenIV.linux.org.uk>
 <20160302081344.GB8024@x>
 <CACsJy8CBBk4bgz6Gn0QvCwWtOsqcQZBYgOBQTd=4Y+2YKs44Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 17:40:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab9oz-0006VG-Io
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 17:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbcCBQkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 11:40:15 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49580 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbcCBQkO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 11:40:14 -0500
Received: from mfilter30-d.gandi.net (mfilter30-d.gandi.net [217.70.178.161])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 6B4C9FB8B3;
	Wed,  2 Mar 2016 17:40:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter30-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter30-d.gandi.net (mfilter30-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 9qHMOZ6GjYTr; Wed,  2 Mar 2016 17:40:10 +0100 (CET)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 3810BFB8A9;
	Wed,  2 Mar 2016 17:40:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACsJy8CBBk4bgz6Gn0QvCwWtOsqcQZBYgOBQTd=4Y+2YKs44Qg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288127>

On Wed, Mar 02, 2016 at 03:22:17PM +0700, Duy Nguyen wrote:
> On Wed, Mar 2, 2016 at 3:13 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> > On Wed, Mar 02, 2016 at 02:30:24AM +0000, Al Viro wrote:
> >> On Tue, Mar 01, 2016 at 05:40:28PM -0800, Stefan Beller wrote:
> >>
> >> > So throwing away half finished stuff while keeping the front load?
> >>
> >> Throw away the object that got truncated and ones for which delta chain
> >> doesn't resolve entirely in the transferred part.
> >>
> >> > > indexing the objects it
> >> > > contains, and then re-running clone and not having to fetch those
> >> > > objects.
> >> >
> >> > The pack is not deterministic for a given repository. When creating
> >> > the pack, you may encounter races between threads, such that the order
> >> > in a pack differs.
> >>
> >> FWIW, I wasn't proposing to recreate the remaining bits of that _pack_;
> >> just do the normal pull with one addition: start with sending the list
> >> of sha1 of objects you are about to send and let the recepient reply
> >> with "I already have <set of sha1>, don't bother with those".  And exclude
> >> those from the transfer.  Encoding for the set being available is an
> >> interesting variable here - might be plain list of sha1, might be its
> >> complement ("I want the following subset"), might be "145th to 1029th,
> >> 1517th and 1890th to 1920th of the list you've sent"; which form ends
> >> up more efficient needs to be found experimentally...
> >
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

M can potentially be larger than N if you have many remotes and branches
in your local repository that the server doesn't have.  However, that
certainly wouldn't be the common case, and in that case heuristics on
the client side could help there in determining a subset to send.

I can't think of any good argument for the server's hash list; a
client-sent list does seem reasonable.

- Josh Triplett
