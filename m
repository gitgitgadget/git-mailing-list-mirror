From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCHv10 01/11] fast-import: Proper notes tree manipulation
Date: Tue, 08 Dec 2009 02:44:30 +0100
Message-ID: <200912080244.30390.johan@herland.net>
References: <1260185254-1523-1-git-send-email-johan@herland.net>
 <1260185254-1523-2-git-send-email-johan@herland.net>
 <20091207164130.GD17173@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 02:44:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHp87-0008SC-2V
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 02:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935737AbZLHBob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 20:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935735AbZLHBoa
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 20:44:30 -0500
Received: from smtp.getmail.no ([84.208.15.66]:37871 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S935734AbZLHBo3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 20:44:29 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUB00K738UAAB20@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Dec 2009 02:44:34 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUB004598U7CQ30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Dec 2009 02:44:34 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.8.13619
User-Agent: KMail/1.12.4 (Linux/2.6.31-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <20091207164130.GD17173@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134798>

On Monday 07 December 2009, Shawn O. Pearce wrote:
> Johan Herland <johan@herland.net> wrote:
> > +static uintmax_t do_change_note_fanout(
> > +		struct tree_entry *orig_root, struct tree_entry *root,
> > +		char *hex_sha1, unsigned int hex_sha1_len,
> > +		char *fullpath, unsigned int fullpath_len,
> > +		unsigned char fanout)
> 
> I think this function winds up processing all notes twice.  Yuck.
> 
> tree_content_set() adds a new tree entry to the end of the current
> tree.  So when converting "1a9029b006484e8b9aca06ff261beb2324bb9916"
> into "1a" (to go from fanout 0 to fanout 1) we'll place 1a at the
> end of orig_root, and this function will walk 1a/ recursively,
> examining 1a9029b006484e8b9aca06ff261beb2324bb9916 all over again.

Yep, you're right. Still, we only do the tree_content_remove()/set() once 
per note, so although performance is probably not abysmal, we are still 
clearly suboptimal.

Also, keep in mind that change_note_fanout() is only called when the number 
of notes crosses a power of 256. Thus for typical notes trees (which are 
assumed to mostly accumulate notes over their lifetime), 
change_note_fanout() will be called zero, one or two times (depending on the 
final number of notes).

> If we're here, isn't it likely that *all* notes are in the wrong
> path in the tree, and we need to move them all to a new location?
> If that's true then should we instead just build an entirely new
> tree and swap the root when we are done?

Hmm. Not always. In your earlier scenario where we add 2,000,000 notes in a 
single commit, the current code would need to rewrite 255 of them from 
fanout 0 to fanout 2, and 65,535 of them from fanout 1 to fanout 2. But the 
vast majority (1,934,465) would not require rewriting (having been added at 
the correct fanout initially). However, if we build a new tree (by which I 
assume you mean tree_content_remove() from the old tree and 
tree_content_set() to the new tree for every single note (and non-note)), we 
end up processing all 2,000,000 entries.

> As we empty out a tree the object will be recycled into a pool of
> trees which can be reused at a later point.  It might actually make
> sense to build the new tree under a different root.  We won't scan
> entries we've moved, and the memory difference should be fairly
> small as tree_content_remove() will make a subtree available for
> reuse as soon as its empty.  So we're only dealing with a handful
> of additional tree objects as we do the conversion.

I'm not sure I get the details here. How can we avoid doing the 
_remove()/_set() from/to the old/new tree for every tree_entry? In other 
words, how do we avoid removing and re-setting the 2,000,000 notes in the 
above example?


Thanks for the review!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
