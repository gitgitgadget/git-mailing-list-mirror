From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Patches for git-push --confirm and --show-subjects
Date: Mon, 14 Sep 2009 18:21:16 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909141745410.14907@iabervon.org>
References: <1252884685-9169-1-git-send-email-otaylor@redhat.com>  <7vpr9ugxn5.fsf@alter.siamese.dyndns.org> <1252895719.11581.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Owen Taylor <otaylor@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 00:21:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnJvH-0004ET-Pv
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 00:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757319AbZINWVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 18:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756794AbZINWVO
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 18:21:14 -0400
Received: from iabervon.org ([66.92.72.58]:44369 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710AbZINWVO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 18:21:14 -0400
Received: (qmail 7195 invoked by uid 1000); 14 Sep 2009 22:21:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Sep 2009 22:21:16 -0000
In-Reply-To: <1252895719.11581.53.camel@localhost.localdomain>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128499>

On Sun, 13 Sep 2009, Owen Taylor wrote:

> On Sun, 2009-09-13 at 17:47 -0700, Junio C Hamano wrote:
> >  * I do not think it should use two separate push_refs call into transport
> >    (first with dry-run and second with real).
> > 
> >    Immediately after match_refs() call in transport_push(), you know if
> >    the push is a non-fast-forward (in which case you do not know what you
> >    will be losing anyway because you haven't seen what you are missing
> >    from the other end) or exactly what your fast-forward push will be
> >    sending, so between that call and the actual transport->push_refs()
> >    would be the ideal place to call the hook, with a list of "ref old
> >    new", without running a dry-run.
> 
> The reason I had to do two calls to transport->push_refs is not because
> it actually pushes the refs twice. It's because the logic for
> classifying the refs is in builtin-send-pack.c. When you pass in
> args.dry_run=1 you get the classification logic without the network
> traffic.

I think the classification logic should move to match_refs(), assuming you 
mean the ref->nonfastforward and ref->deletion stuff. It would probably 
also be worth having a bit for "already up to date". (Note that 
cmd_send_pack() calls match_refs(), so there wouldn't have to be 
duplication between the legacy cmd_send_pack() code path and the 
transport_push() codepath if the code moved into match_refs()).

> (There's a little messiness about whether it sends the "flush" 0000 or
> not that I had to work around, but that's peripheral.)
> 
> The way to clean it up is pretty obvious:
> 
>  - You add another vfunc to the transport - '->get_capabilities' or
>    something - that encapsulates server_supports("delete-refs").

I think it would be better to have a vfunc that takes refs with the 
classification bits set and sets the statuses based on the idea that we're 
not going to lose any races and the remote won't reject our change for 
some reason we don't know about. There's a potentially large and varied 
set of restrictions on what the other side is willing to accept, and I 
think it would be better to put that on the other side of the vfunc, 
rather than having the main transport code know that "delete-refs" means 
that you can delete refs, "nonfastforward" means you can force a 
non-fast-forward, something means you can create files named "CVS", etc.

This is pretty similar to having a "dry run" call first, except that it 
wouldn't end up rechecking the same things on the real run immediately 
following the dry run, because the checking code has moved to a separate 
method.

Of course, this step isn't entirely needed; without it, you just get asked 
"Are you sure?" for changes the local side can tell won't be permitted, in 
addition to for changes the local side can't tell won't be permitted. 
(Like, you're allowed to delete refs in general, but not the one you're 
trying to delete.)

>  - You split the classification logic out into a helper function
>    (maybe still in builtin-send-pack.c, maybe moved into some other
>    file... don't know what's appropriate.)
> 
>    After all, if there was another push_refs backend, it shouldn't be
>    duplicating the classification logic...

I think match_refs should do it.

>  - You pass pre-classified ref updates to ->push_refs
> 
> I don't know how that interacts with other planned changes to this code.

I think this is a good thing to clean up before further changes; any other 
improvements would either duplicate the logic that's in builtin-send-pack 
or be missing it.

> > for a few reasons.
> > 
> >  (1) When push.confirm is set, you do not want to interact with the user
> >      when the standard input is not a terminal.  But an automated script
> >      that runs git-push can still use an appropriate pre-push hook to make
> >      the decision to intervene without human presense.
> > 
> >  (2) As your --show-subjects patch shows, the likes and dislikes of the
> >      output format for confirmation would be highly personal.  A separate
> >      hook that is fed list of <ref, old, new> would make it easier to
> >      customize this to suite people's tastes.
> 
> The --show-subjects idea is equally useful for --dry-run. And even when
> for successful/failed pushes when neither --confirm not --dry-run is
> passed.
> 
> I'm not that convinced that there's that much scope for configurability
> in this area. Clearly there's some arbitrary decisions I made - that
> abbreviated hashes wouldn't be useful. That up to 8 commit subjects
> should be shown. Etc.
> 
> But as yet, there's no data as to whether people would actually want to
> make *different* arbitrary decisions.
> 
> Adding more configurability (formats, etc.) doesn't really bother me,
> though it does seem like coding in advance of need. But what would
> bother me is if the feature isn't useful without complex configuration
> or installing custom scripts.

I think a pre-push hook would be popular; I know I'd like to have a hook 
that makes sure that I signed off anything I'm pushing (when the server 
might check that *somebody* did, but wouldn't know that this push is 
supposed to be me), and I'd like a hook that checks that I've referenced 
an issue in an issue tracker for each commit that I'm pushing (but only 
when I go to push it).

But I think a simple "ask an interactive user" check makes sense to have 
in the same part of the code.

	-Daniel
*This .sig left intentionally blank*
