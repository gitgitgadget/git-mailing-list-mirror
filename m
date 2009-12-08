From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCHv10 08/11] Notes API: get_note(): Return the note
 annotating the given object
Date: Tue, 08 Dec 2009 04:18:06 +0100
Message-ID: <200912080418.06233.johan@herland.net>
References: <1260185254-1523-1-git-send-email-johan@herland.net>
 <1260185254-1523-9-git-send-email-johan@herland.net>
 <7vk4wy1p8d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 04:18:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHqar-0008S7-1K
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 04:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934810AbZLHDSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 22:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935785AbZLHDSF
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 22:18:05 -0500
Received: from smtp.getmail.no ([84.208.15.66]:60693 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934488AbZLHDSD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 22:18:03 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUB00KA8D68AB30@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Dec 2009 04:18:09 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUB00ED9D66V430@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Dec 2009 04:18:08 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.8.30625
User-Agent: KMail/1.12.4 (Linux/2.6.31-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <7vk4wy1p8d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134808>

On Monday 07 December 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > Created by a simple cleanup and rename of lookup_notes().
> >
> > Signed-off-by: Johan Herland <johan@herland.net>
> > ---
> >  notes.c |   15 ++++++++-------
> >  notes.h |    3 +++
> >  2 files changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/notes.c b/notes.c
> > index 79bfa24..110404a 100644
> > --- a/notes.c
> > +++ b/notes.c
> > @@ -379,12 +379,13 @@ void add_note(const unsigned char *object_sha1,
> > const unsigned char *note_sha1) note_tree_insert(&root_node, 0, l,
> > PTR_TYPE_NOTE);
> >  }
> >
> > -static unsigned char *lookup_notes(const unsigned char *object_sha1)
> > +const unsigned char *get_note(const unsigned char *object_sha1)
> 
> Is there a need to find "note for this commit in the set of notes 3 days
> ago"?  IOW, reading note for the given commit not from the tip of the
> history of the refs/notes/commits but from say refs/notes/commits~4?
> Similarly, is there a need to ask for a history of notes for a given
> commit, something like "git log refs/notes/commit/$this_commit" in a
>  world without any fanout?
>
> Obviously, "there is no need because..." is the best answer I'd be happy
> with.  "There may be in the future but we haven't identified a good use
> case and we don't implement what we do not need now." is also perfectly
> acceptable.

There may be in the future but we haven't identified a good use case and we 
don't implement what we do not need now.

;)

> IOW, I am not suggesting to change it---I just want to know how much
> thought went in before deciding to implement the interface this way.

Well, this later part of the series (from patch #6) was built mainly to 
support the fast-import patch (which is no longer based on this API), but 
also with an eye towards keeping things fairly flexible and generic. 
Furthermore I expect to use most of these patches when I get around to 
builtin-ifying the git-notes shell script (which currently is oblivious the 
notes API and things like fanout and rebalancing).

In any case, if you look at patch #10/11, you'll see I introduce the concept 
of multiple notes trees. This was originally done to allow fast-import to 
edit notes in several branches simultaneously, but it now occurs to me that 
this is exactly what we need to answer your questions above: If you want to 
look at an older version of your notes tree, you simply instantiate another 
notes tree with:

	struct notes_tree my_notes;
	init_notes(my_notes, "refs/notes/commits~4", ...);

and you can now compare notes between my_notes and the current (or any 
other) notes tree.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
