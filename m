From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH v7 1/3] Introduce bulk-move detection in diffcore.
Date: Thu, 28 Oct 2010 23:42:40 +0200
Message-ID: <20101028214240.GF3347@home.lan>
References: <1287868022-24872-1-git-send-email-ydirson@altern.org>
 <1287868022-24872-2-git-send-email-ydirson@altern.org>
 <7veibeitip.fsf@alter.siamese.dyndns.org>
 <20101025201227.GB3347@home.lan>
 <7vr5fa9ij3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 23:42:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBaFL-0006wJ-RW
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 23:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933803Ab0J1Vmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 17:42:49 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:60751 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933157Ab0J1Vms (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 17:42:48 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 99796D48052;
	Thu, 28 Oct 2010 23:42:41 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PBaF6-0003Ak-FV; Thu, 28 Oct 2010 23:42:40 +0200
Content-Disposition: inline
In-Reply-To: <7vr5fa9ij3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160229>

On Thu, Oct 28, 2010 at 01:20:00PM -0700, Junio C Hamano wrote:
> Yann Dirson <ydirson@free.fr> writes:
> 
> > OTOH, the quoting rules for diff output are quite minimalist, I don't
> > know whether adding "*" as a character that requires quotes around the
> > filename would be acceptable.
> 
> I suspect that would be an unacceptable entry to a slippery slope.

OK.  I have thought of only 2 remaining options:

* keep using 0{40} sha1 as differentiator
  => will prevent us to ever use this sha1 for something useful
* introducing a new change-type letter
  => another slippery slope, with at least bulk removals and bulk
  copies in sight, with already too few letters to keep them meaningful
  to human reader
* introducing a "bulk" flag
  => needs extension of the raw format
  Would could want to extend the <letter><score> group, for things like
  "RB100" (bulk rename), "CB090" (imperfect bulk copy), "DB096" (imperfect
  bulk removal, meaning there were some files left in source directory)

> >> IOW, is the goal of this series
> >> to use the "A/* -> B/" to label the change as bulk directory rename, if
> >> the preimage has A/{1,2,3} and the postimage has their moved contents in
> >> B/{one,two,three}?
> >
> > Yes.  But --hide-bulk-move-details would not hide them, as they would
> > not be strictly included in the bulk move.  Desite their name change,
> > they are however a confirmation that the contents of A/ was move to B/.
> >
> >> I am wondering about the utility of such an extra information.  If there
> >> were no "a/file0 -> b/file3" entry in the example, I would imagine that we
> >> could use this "a/* -> b/" information to move "a/file5" to "b/file5" when
> >> rebasing this patch to apply to a different preimage that had files other
> >> than file{1,2} in directory "a", and I would further imagine that might be
> >> a wonderful thing.
> >
> > I imagined that as well, and that situation would not be a problem:
> > since "a/file0 -> b/file3" would be there in the rebased patch,
> > "apply" would be able to spot the possible conflict.
> >
> > OTOH, I had the vision of "merge does automatic moves" when starting
> > this project, but got convinced on-list that there are always cases
> > where the "automatic move" on merge would be wrong, and that we should
> > report a conflict instead.
> >
> > That would mostly shift the problem to...
> 
> That would mostly make this patch not worth worrying about, wouldn't it?

(assuming "that" refers to not doing automatic moves on merge)

No, at least the "avoid hiding useful info among less-relevant stuff"
provided by the human-targetted --hide-bulk-move-details would stay
regardless of what we decide here.

> What's the point of spending extra cycles to say "many things have moved
> in the same direction" without turning it into a usable information?

If we issue a conflict, we have already gone farther than where we are
now.  Deciding to have this particular type of conflict auto-resolved
in the way useful to a wider audience could be done (having "adds"
follow the bulkmove), with obviously the option of not auto-resolving,
and possibly, the option of auto-resolving "adds" as they are
(ie. keep current behaviour).

But my feeling is "automatically solving the conflict" would be be
only marginally different from applying a patch generated with (what
in current series is) --hide-bulk-move-details where you cannot know
which individual files were moved in the patch author's tree, and has
no info to decide if his own added files are at the right place or
need to follow the move (which I understood to be your point in [1]).

Or did I miss your point ?

[1] http://marc.info/?l=git&m=122610146506413

-- 
Yann
