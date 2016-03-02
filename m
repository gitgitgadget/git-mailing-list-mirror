From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Resumable git clone?
Date: Wed, 2 Mar 2016 02:30:24 +0000
Message-ID: <20160302023024.GG17997@ZenIV.linux.org.uk>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
 <CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@joshtriplett.org>,
	Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 03:30:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aawYn-0001Xz-49
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 03:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbcCBCab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 21:30:31 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37639 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbcCBCa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 21:30:28 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.76 #1 (Red Hat Linux))
	id 1aawYS-0007jA-Uq; Wed, 02 Mar 2016 02:30:24 +0000
Content-Disposition: inline
In-Reply-To: <CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288091>

On Tue, Mar 01, 2016 at 05:40:28PM -0800, Stefan Beller wrote:

> So throwing away half finished stuff while keeping the front load?

Throw away the object that got truncated and ones for which delta chain
doesn't resolve entirely in the transferred part.
 
> > indexing the objects it
> > contains, and then re-running clone and not having to fetch those
> > objects.
> 
> The pack is not deterministic for a given repository. When creating
> the pack, you may encounter races between threads, such that the order
> in a pack differs.

FWIW, I wasn't proposing to recreate the remaining bits of that _pack_;
just do the normal pull with one addition: start with sending the list
of sha1 of objects you are about to send and let the recepient reply
with "I already have <set of sha1>, don't bother with those".  And exclude
those from the transfer.  Encoding for the set being available is an
interesting variable here - might be plain list of sha1, might be its
complement ("I want the following subset"), might be "145th to 1029th,
1517th and 1890th to 1920th of the list you've sent"; which form ends
up more efficient needs to be found experimentally...

IIRC, the objection had been that the organisation of the pack will lead
to many cases when deltas are transferred *first*, with base object not
getting there prior to disconnect.  I suspect that fraction of the objects
getting through would still be worth it, but I hadn't experimented enough
to be able to tell...

I was more interested in resumable _pull_, with restarted clone treated as
special case of that.
