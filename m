From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Mon, 8 Aug 2011 18:22:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com> <1311517282-24831-4-git-send-email-srabbelier@gmail.com> <7vy5znscst.fsf@alter.siamese.dyndns.org> <7vr55fs1z0.fsf@alter.siamese.dyndns.org> <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 18:22:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqSbS-0000FZ-1d
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 18:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957Ab1HHQWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 12:22:52 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:46248 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752347Ab1HHQWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 12:22:51 -0400
Received: (qmail invoked by alias); 08 Aug 2011 16:22:49 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp013) with SMTP; 08 Aug 2011 18:22:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+P7MESzPOPCLBoOapxrcSQOoe01pgBWNvL4KatH3
	l23uF4rR4bFDA6
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <7vy5zabbz7.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178961>

Hi Junio,

On Wed, 3 Aug 2011, Junio C Hamano wrote:

> Sverre Rabbelier <srabbelier@gmail.com> writes:
> 
> > On Sun, Jul 24, 2011 at 21:23, Junio C Hamano <gitster@pobox.com> wrote:
> >> Sverre Rabbelier <srabbelier@gmail.com> writes:
> >>
> >>>  void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
> >>>  {
> >>> -     add_pending_object_with_mode(revs, obj, name, S_IFINVALID);
> >>> +     add_pending_object_with_mode(revs, obj, name, S_IFINVALID, 0);
> >>>  }
> >>
> >> This seems utterly broken.  For example, fmt-merge-msg.c adds "^HEAD" 
> >> and of course the flags on the object is UNINTERESTING. Has all the 
> >> callers of add_pending_object() been verified? Why is it passing an 
> >> unconditional 0 and not !!(obj->flags & UNINTERESTING) or something?

If you do that, you're back to start. Since obj has not the faintest clue 
whether the pending object was added from a negative or a positive ref.

And yes, all the callers have been verified: I don't want them to change. 
I only need to catch the callers inside the revision machinery's argument 
parsing, since that is what I need anyway, to traverse the objects later 
on. And rather than reimplementing the wheel^Wargument parsing, I'd like 
to reuse what is already there and just forgets the single bit of 
information I need.

The other users of the argument parsing can change their callers if 
necessary, when they also need the information about whether a ref was 
positive/negative.

> > If I understand correctly (and it's not unlikely that I don't), the 
> > 'flags' field is used to store the actual flags (not just a boolean). 
> > Would the following be appropriate?
> >
> > +     add_pending_object_with_mode(revs, obj, name, S_IFINVALID, obj->flags);
> 
> I would think that the information you are trying to convey is more in
> line with the spirit of "name" field, not "mode".

No, it is a flag. The parsed argument is a negative ref. It has a name 
(not including the "^") and it has a flag ("negative").

The mode is indeed only relevant for non-commitishs: If you look where a 
pending object is added _with_ a mode other than S_IFINVALID, it is only 
when calling get_sha1_with_mode(). That function indirectly calls 
get_sha1_with_context_1() which sets the mode to ce_mode. In other words, 
the mode is the file mode when specifying a blob/tree as <ref>:<path>. All 
commits (and tags) have a mode set to S_IFINVALID.

> [...]
>
> Wouldn't it be wonderful if the revision machinery left richer clue in
> each element of the pending object array while parsing, so that the caller
> does not have to guess?

That is what we are trying to solve, and rather than to reuse the "mode" I 
thought that it'd be wiser to add new "flags".

Many of the richer clues you refer to could be expressed as such flags, 
including the problem I need to address.

For the only itch I have is to get remote-hg working nicely for me, and 
Sverre said I can only have that if fast-export is running correctly, i.e. 
updating all the refs, even if some other ref already points at the same 
commit.

> In addition to a single "mode" integer, which says if it is supposed to 
> be a tree or a blob, we could allocate a single structure that records 
> something like this:
> 
> 	struct parsed_rev {
>                 enum {
> 			SHA1, REF, RANGE, SYMMETRIC_RANGE, REFLOG_ENT, ...
>                         // there are others like OBJ^!, OBJ@!, ...
>                 } kind;
>                 const char *string;
>                 union {
> 			struct {
> 				const char *real_ref;
> 			} ref;
> 			struct {
> 				struct parsed_rev *bottom;
> 				struct parsed_rev *top;
>                         } range;
> 			...
>                 } u;
> 	};

Is this not a little bit of a big, huge, tremendous overkill? All I need 
right now is a simple flag. Let's not cross bridges at which we haven't 
arrived for another 50 miles yet.

Or in other words: I'd rather stay with a simple, elegant, minimal patch 
that solves the problem at hand while not preventing future enhancements.

Also remember that the pending objects array is used for the complete 
object traversal. If you make that bigger you might end up with a 
substantial increase in memory consumption (which made me think of 
reusing the "mode", but then I thought about the possible side effects in 
the future and rejected that idea).

The only way to convince me to do that complicated stuff is by 
blackmailing me, stating that I cannot have a working remote-hg without 
doing all this nested/union/self-referential struct work I don't need.

Ciao,
Johannes
