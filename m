From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Mon, 1 Sep 2008 23:06:08 -0700
Message-ID: <20080902060608.GG13248@spearce.org>
References: <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <20080828145706.GB21072@spearce.org> <7vwsi0a2op.fsf@gitster.siamese.dyndns.org> <48B784FD.3080005@zytor.com> <7vej488gcu.fsf@gitster.siamese.dyndns.org> <20080829173954.GG7403@spearce.org> <905315640809010905w20f4ceeo43e7b0a14abd48a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 08:07:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaP2s-0005tT-2b
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 08:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbYIBGGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 02:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbYIBGGK
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 02:06:10 -0400
Received: from george.spearce.org ([209.20.77.23]:60589 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbYIBGGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 02:06:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8841738375; Tue,  2 Sep 2008 06:06:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <905315640809010905w20f4ceeo43e7b0a14abd48a3@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94648>

Tarmigan <tarmigan+git@gmail.com> wrote:
> On Fri, Aug 29, 2008 at 10:39 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> 
> I just want to see smart http could support a new feature (please yell
> if git:// already supports this and I am not aware of it).   The idea
> is from http://lkml.org/lkml/2008/8/21/347, the relevant portion
> being:
> 
> Greg KH wrote:
> >David Vrabel wrote:
> >> Or you can pull the changes from the uwb branch of
> >>
> >> git://pear.davidvrabel.org.uk/git/uwb.git
> >>
> >> (Please don't clone the entire tree from here as I have very limited
> >> bandwidth.)
> >
> > If this is an issue, I think you can use the --reference option to
> > git-clone when creating the tree to reference an external tree (like
> > Linus's).  That way you don't have the whole tree on your server for
> > stuff like this.
> 
> I do not believe that the server (either git:// or http://) can
> currently be setup with --reference to redirect to another server for
> certain refs,

Correct.  Today _none_ of the transport protocols allow the server
to force the client to use some sort of reference repository for an
initial clone.  There are likely two reasons for this:

 *) Its a lot simpler to program to just get everything from
    one location.

 *) If you really are forking an open source project then in
    some cases you may need to distribute the full source,
	not your delta.  You may just as well distribute the full
	source and call it a day.

The dumb http:// currently supports getting packs from a remote HTTP
server via its objects/info/http-alternates.  But the native and
rsync protocols don't support that.  The logic behind http-alternates
isn't to allow moving load onto a different server, but to make
the locally available alternate repository available through the
same web server.  The path on the UNIX filesystem that is used in
objects/info/alternates may not be the same path used in the web
server's namespace.

> but perhaps with smart http and the POST 302/303
> redirect responses, this would now be possible as a way to reduce
> bandwidth for people's home servers?  I have also seen similar
> requests before ("don't pull the whole kernel from me, just add my
> repo as a remote after you've cloned linus-2.6"), so for larger
> projects, it might be a nice feature.  Would that be something
> desirable to support?

I think this isn't a bad idea, but I'd rather have the server say
"In order to talk to me you need at least these objects in common
with me: ...".  If you don't have those then the user should go
find it on their own, rather than forcing them to a particular URL
and automatically following it.

I'm a little concerned about a US user putting a US mirror site
of kernel.org into the server and forcing a user in India to do a
full clone over the Atlantic links when they could have just used
a more local mirror for that initial "linus-2.6" clone.
 
> Otherwise, it looks very cool, but I have a few more minor questions
> to help my general understanding...
> 
> >     If the client has sent 256 HAVE commits and has not yet
> >     received one of those back from S_COMMON, or the client
> >     has emptied C_PENDING it should include a "give-up"
> >     command to let the server know it won't proceed:
> >
> >        C: 000cgive-up
> 
> What does the server do after a 000cgive-up ?  Does the server send
> back a complete pack (like a new clone) or if not, how does clone work
> over smart http?

When the server receives a "give-up" it needs to create a pack
based on "git rev-list --objects-boundary $WANT --not $COMMON".
If the set $COMMON is non-empty then its a partial pack; if $COMMON
is empty then its a full clone.  This is what the native protocol
does when the client gives up.

> Does that mean that if I fall more than 256 commits
> behind, I have to redownload the whole repo?

You are thinking the wrong way.  If you have more than 256 commits
that the other side doesn't have you may give up too early.
For that to be true you need to create 256 commits locally that
aren't on the remote peer and whose timestamps are all ahead of
the commits you last fetched from the remote peer.

Yes, it can happen.  But its less likely than you think because
we're talking about you doing 256 commits worth of development and
not picking up any new commits from remote peers in the middle of
that time period.  Get just one and it resets the counter back to
0 and allows it to try another 256 commits before giving up.

I should amend this section to talk about what giving up here
really means.  If we have nothing sent in common yet or maybe
very little sent in common we may have existing remote refs tied
to this URL in .git/config that can send, and we may have one or
more annotated tags that we know for a fact are in common as both
peers have the same tag name pointing to the same tag object.

A smart(er) client might try to toss some recently dated annotated
tags at the server before throwing a give-up if it would otherwise
throw a give-up.  Its likely to narrow the result set, and doesn't
hurt if it doesn't.

> >  (s) Parse the upload-pack request:
> >
> >      Verify all objects in WANT are reachable from refs.  As
> >      this may require walking backwards through history to
> >      the very beginning on invalid requests the server may
> >      use a reasonable limit of commits (e.g. 1000) walked
> >      beyond any ref tip before giving up.
> >
> >      If no WANT objects are received, send an error:
> >
> >        S: 0019status error no want
> >
> >      If any WANT object is not reachable, send an error:
> >
> >        S: 001estatus error invalid want
> 
> So again, if the client falls more than 1000 commits behind (not hard
> to do for example during the linux merge window), and then the client
> WANTs HEAD^1001, what happens?  Does the get nothing from the server,
> or does the client essentially reclone, or I am missing something?

Oh, this is a live-lock condition.  If the client grabs the list of
refs from the server, then has to wait 100 ms to get back to the
server and start upload-pack (due to latency) and in that 100ms
window Linus shoves a 1001 commit merge into his tree then yes,
the server may abort and tell the client "error invalid want".

At which point the client may try to restart from the beginning,
or just plain give up and tell the end user try again later.

This condition of 1000 is just some aribtrary limit to allow the
client to still continue with an in-progress download if right in
the middle of the client's RPCs the remote was modified by its owner.
 
> >  (s) Send the upload-pack response:
> >
> >     If the server has found a closed set of objects to pack or the
> >     request contains "give-up", it replies with the pack and the
> >     enabled capabilities.  The set of enabled capabilities is limited
> >     to the intersection of what the client requested and what the
> >     server supports.
> >
> >        S: 0010status pack
> >        C: 001bcapability include-tag
> >        C: 0019capability thin-pack
> >        S: 000c.PACK...
> 
> Should these be all S: ... ?

Yes, thanks.  I will make the correction.  Damn copy and paste.

-- 
Shawn.
