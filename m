From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v5 0/6] {checkout,reset,stash} --patch
Date: Sat, 15 Aug 2009 12:14:58 +0200
Message-ID: <200908151215.00713.trast@student.ethz.ch>
References: <200908101136.34660.trast@student.ethz.ch> <20090815065125.GA23068@coredump.intra.peff.net> <7v4os9v7al.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 12:16:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McGJH-0008NV-Ke
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 12:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbZHOKPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 06:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbZHOKPg
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 06:15:36 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:14131 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157AbZHOKPg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 06:15:36 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 15 Aug
 2009 12:15:35 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 15 Aug
 2009 12:15:14 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <7v4os9v7al.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125996>

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> >> reset -p [HEAD]		Reset this hunk? (**)
> >> reset -p other		Apply this hunk to index? (**)
> >
> > This doesn't make sense to me.
> 
> Not to me, either.
> 
> Let's say you have modified $path and ran "git add $path" earlier.
> 
> "reset -p -- $path" and "reset -p HEAD -- $path" both show what your index
> has relative to the commit you are resetting your index to and offer to
> "Unstage" [*1*].  This is consistent and feels natural.
> 
> "reset -p HEAD^ -- $path" however shows the same forward diff (i.e. how
> your index is different compared to the commit HEAD^ you are resetting
> to), but offers to "Apply".
[...]
> Perhaps you meant to show a reverse diff and use the word
> "Apply".

Indeed.

> However, that would break down rather badly when HEAD did not change $path
> since HEAD^.  Logically what the "reset -p" would do to $path is the same,
> but the patch shown and the operation offered to the user are opposite.
> 
> You could compare HEAD and the commit you are resetting the index to and
> see if the path in question is different between the two commits, and
> switch the direction---if there is no change, you show forward diff and
> offer to "Remove this change out of the index", if there is a change, you
> show reverse diff and offer to "Apply this change to the index".  But if
> the difference between HEAD and the commit you are resetting to does not
> overlap with the change you staged to the index earlier from your work
> tree, it is unclear such heuristics would yield a natural feel.
> 
> So I actually think you may be better off if you consistently showed a
> forward diff (i.e. what patch would have been applied to the commit in
> question to bring the index into its current shape), and always offer
> "Remove this change out of the index?"

HEAD^ is not special.  What do we do if the user resets to something
that is logically further progressed in time, perhaps another branch?
I just have a much better mental model of it as "apply <something> to
index" than if it said: here's some diff between whatever commit you
gave me, and your index; but I'm going to apply it reverse!

(v4 actually did it this way and I found it a bit confusing...)

> The same comment applies to "checkout -p HEAD" vs "checkout -p HEAD^".
> I think the latter shouldn't show a reverse diff and offer "Apply?";
> instead both should consitently show a forward diff (i.e. what patch would
> have been applied to the commit to bring your work tree into its current
> shape), and offer "Remove this change out of the index and the work tree?".

Again (and unlike in the reset case, I can actually see myself doing
this at times) the user could pass in a commit that is logically
newer than HEAD.

> *1* I actually have a slight problem with the use of word "Unstage" in
> this context; "to stage", at least to me, means "adding _from the work
> tree_ to the index", not just "modifying the index" from a random source.
> The command is resetting the index in this case from a tree-ish and there
> is no work tree involved, and the word "stage/unstage" feels out of place.

It's not using "unstage" any more if the commit is not HEAD.  If it
is, then we're doing the opposite of 'add -p', so doesn't the term
apply then?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
