From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Resumable git clone?
Date: Tue, 1 Mar 2016 23:54:37 -0800
Message-ID: <20160302075437.GA8024@x>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
 <CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
 <20160302023024.GG17997@ZenIV.linux.org.uk>
 <xmqq8u215r25.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DcNrOmrKKPibV6GuSqspovBmHzUv_mRB6fZyLjw5wWzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 08:54:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab1cP-00040a-GV
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 08:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbcCBHyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 02:54:46 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58043 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbcCBHyp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 02:54:45 -0500
X-Greylist: delayed 23023 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Mar 2016 02:54:45 EST
Received: from mfilter42-d.gandi.net (mfilter42-d.gandi.net [217.70.178.172])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id D793AFB8CA;
	Wed,  2 Mar 2016 08:54:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter42-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter42-d.gandi.net (mfilter42-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 9hmCUj36yu97; Wed,  2 Mar 2016 08:54:41 +0100 (CET)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 69A8DFB886;
	Wed,  2 Mar 2016 08:54:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACsJy8DcNrOmrKKPibV6GuSqspovBmHzUv_mRB6fZyLjw5wWzQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288101>

On Wed, Mar 02, 2016 at 02:37:53PM +0700, Duy Nguyen wrote:
> On Wed, Mar 2, 2016 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Al Viro <viro@ZenIV.linux.org.uk> writes:
> >
> >> FWIW, I wasn't proposing to recreate the remaining bits of that _pack_;
> >> just do the normal pull with one addition: start with sending the list
> >> of sha1 of objects you are about to send and let the recepient reply
> >> with "I already have <set of sha1>, don't bother with those".  And exclude
> >> those from the transfer.
> >
> > I did a quick-and-dirty unscientific experiment.
> >
> > I had a clone of Linus's repository that was about a week old, whose
> > tip was at 4de8ebef (Merge tag 'trace-fixes-v4.5-rc5' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace,
> > 2016-02-22).  To bring it up to date (i.e. a pull about a week's
> > worth of progress) to f691b77b (Merge branch 'for-linus' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs, 2016-03-01):
> >
> >     $ git rev-list --objects 4de8ebef..f691b77b1fc | wc -l
> >     1396
> >     $ git rev-parse 4de8ebef..f691b77b1fc |
> >       git pack-objects --revs --delta-base-offset --stdout |
> >       wc -c
> >     2444127
> >
> > So in order to salvage some transfer out of 2.4MB, the hypothetical
> > Al protocol would first have the upload-pack give 20*1396 = 28kB
> 
> It could be 10*1396 or less. If the server calculates the shortest
> unambiguous SHA-1 length (quite cheap on fully packed repo) and sends
> it to the client, the client can just sends short SHA-1 instead. It's
> racy though because objects are being added to the server and abbrev
> length may go up. But we can check ambiguity for all SHA-1 sent by
> client and ask for resend for ambiguous ones.
> 
> On my linux-2.6.git, 10 letters (so 5 bytes) are needed for
> unambiguous short SHA-1. But we can even go optimistic and ask the
> client for shorter SHA-1 with hope that resend won't be many.

I don't think it's worth the trouble and ambiguity to send abbreviated
object names over the wire.  I think several simpler optimizations seem
preferable, such as binary object names, and abbreviating complete
object sets ("I have these commits/trees and everything they need
recursively; I also have this stack of random objects.").

That would work especially well for resumable pull, or for the case of
optimizing pull during the merge window.

- Josh Triplett
