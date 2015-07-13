From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] notes: Allow treeish expressions as notes ref
Date: Tue, 14 Jul 2015 05:53:04 +0900
Message-ID: <20150713205304.GA26911@glandium.org>
References: <CALKQrgdGJy6vtBRL413bbSHSi+=KTh4Q98hpbgg29j4J191=bA@mail.gmail.com>
 <1436517551-12172-1-git-send-email-mh@glandium.org>
 <xmqqzj30yq03.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 22:53:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEkj3-0007B4-KF
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 22:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbbGMUxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 16:53:15 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:47983 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839AbbGMUxN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 16:53:13 -0400
Received: from glandium by zenigata with local (Exim 4.86_RC4)
	(envelope-from <glandium@glandium.org>)
	id 1ZEkim-000719-HS; Tue, 14 Jul 2015 05:53:04 +0900
Content-Disposition: inline
In-Reply-To: <xmqqzj30yq03.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273927>

On Mon, Jul 13, 2015 at 09:35:40AM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > init_notes() is the main point of entry to the notes API. It is an arbitrary
> > restriction that all it allows as input is a strict ref name, when callers
> > may want to give an arbitrary treeish.
> >
> > However, some operations that require updating the notes tree require a
> > strict ref name, because they wouldn't be able to update e.g. foo@{1}.
> >
> > So we allow treeish expressions to be used in the case the notes tree is
> > going to be used without write "permissions", and to distinguish whether
> > the notes tree is intended to be used for reads only, or will be updated,
> > a flag is added.
> 
> It is unfair to call the current check arbitrary, though.  From the
> point of view of the person who views notes as a database, it is
> entirely a sensible thing to treat it as an read/write data store.
> 
> > This has the side effect of enabling the use of treeish as notes refs in
> > commands allowing them, e.g. git log --notes=foo@{1}.
> 
> I do not think it is a "side effect".  It's the primary benefit this
> change brings in.

My original motivation for this change was for init_notes() to take a
committish so that I can feed it with one in a C program that uses the
notes API. So from that perspective, that command lines can now use them
is a side effect.

> I'd flip the attitude around and sell this as "an enhancement",
> perhaps like this:
> 
>     notes: allow treeish expressions as notes ref
>     
>     init_notes() is the main point of entry to the notes API. It ensures
>     that the input can be used as ref, because it needs a ref to update
>     to store notes tree after modifying it.
>     
>     There however are many use cases where notes tree is only read, e.g.
>     "git log --notes=...".  Any notes-shaped treeish could be used for
>     such purpose, but it is not allowed due to existing restriction.
>     
>     Allow treeish expressions to be used in the case the notes tree is
>     going to be used without write "permissions".  Add a flag to
>     distinguish whether the notes tree is intended to be used read-only,
>     or will be updated.
>     
>     With this change, operations that use notes read-only can be fed any
>     notes-shaped tree-ish can be used, e.g. git log --notes=notes@{1}.
>     
>     Signed-off-by: Mike Hommey <mh@glandium.org>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

WFM.

> We probably should do a few more things:
> 
>  - Make sure that we show "there is no such tree-ish, no way to look
>    up any note to any commit from there" and "I understood the tree
>    you gave me, but there is no note for that commit" differently.

How would you reconcile that with the usual "there are only a couple
commits with a note in the hundreds you make me display"?

>  - Decide if we want to "fail" the operation when the notes tree
>    given by the user is not even a tree-ish or just "warn" and keep
>    going.  And do so consistently.

Is this something you want to be figured before merging this patch?

Mike
