From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Introduce git version --list-features for porcelain use
Date: Thu, 21 Jun 2007 02:10:45 -0400
Message-ID: <20070621061045.GG8477@spearce.org>
References: <20070621045903.GA14047@spearce.org> <7v1wg55065.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 08:11:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Fsm-0004t5-O4
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 08:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbXFUGKv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 02:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbXFUGKv
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 02:10:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38837 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbXFUGKu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 02:10:50 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1FsU-0004Uc-Vm; Thu, 21 Jun 2007 02:10:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D867E20FBAE; Thu, 21 Jun 2007 02:10:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v1wg55065.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50597>

Junio C Hamano <gitster@pobox.com> wrote:
> Unless we are talking about dynamically extensible feature list
> (eh, dll, anybody?), it might be easier to keep (1) the list
> sorted, and (2) free of insane feature name in
> supported_features[] array at the source level.  Then you can
> lose that is_feature_name_sane() function.

Yes, this is true.  But I'm being overly defensive here.  If the
list does get out of order we force it back in --list-features just
to be consistent in output, and t0000 will fail if any item in the
list is insane.

If you want to be less defensive, OK, it would also reduce the
patch size a bit, but may allow someone to add an insane item to
the list.

> > +static int supports_feature(const char *the_feature)
> 
> And you can  perform a bsearch here. instead of linear.

Sure.  But I'm actually expecting more for Porcelain that cares
to run `git version --list-features` and store that output into
its own internal table, then consult that table rather than the
--supports-feature option.  I figured the bsearch would take more
code than the linear, and probably wasn't worth it in this dark
little corner of Git.

> > +test_expect_failure \
> > +	'feature "THISNEVERWILLBEAGITFEATURE" is not supported' \
> > +	'git version --supports-feature=THISNEVERWILLBEAGITFEATURE'
> 
> I would expect that THISNEW... will get complaint saying "That
> is not a valid feature name, as it has uppercase", from a
> version that has is_feature_name_sane() function.

Eh, probably true.  I guess I should make that lowercase so it is
actually a sane name, just one so unlikely that we will never use it.
 
> I suspect that this patch is meant for my 'maint' (and
> 1.5.2.3).  Or is it for my 'master'?  What's your plan to handle
> transition?

Eh, sorry, I should have mentioned that.  I meant for you to apply
this to your master, where `git blame -w` is already present.

Currently with next I get:

  $ git version --list-features
  git version 1.5.2.2.1050.g51a8b

So what I was planning on doing in git-gui was running that, and if
I just get one line with `git version` on it (which is an insane
feature name btw) then I know --list-features is not supported,
and neither is any other feature that I might be looking for from
the --list-features command.

On the other hand if --list-features is actually supported instead
I'll get back at least a line with "list-features" on it, and I
won't get a line with "git version" on it (as that is an insane
feature name).

I guess it is good that our cmd_version() routine never actually
checked to see if its argv[] matched what it expects to receive
(nothing up until now).  :)

Now I'm fine with you applying this back into a 1.5.2.x maint
release, but because of the cmd_version() behavior I don't think
that is really required.  Nor am I looking for you to cherry-pick
back the `git blame -w` feature.
 
> If this is meant to be only for 1.5.3 and later, then you know
> that "blame -w" is available as well, so the fact you can do
> "git version --list-features" alone tells you that you can use
> "blame -w", among other many things, such as "diff -C -C"
> instead of --find-copies-harder.

Yes, that is true.
 
> Where does the above discussion lead us?  It essentially means,
> in either case, "blame-ignore-whitespace" should not be in that
> supported_features[] array.

Hmm.  So assuming that is true, under what rule do you propose we
add new features to that array in the future?  And what name(s)
do we give to them?

For a recent hypothetical example, assume this patch was already
applied in your master by the time Linus submitted his useful hack
`git log --follow`.  How would we signal in the supported_features[]
that log would understand --follow for a single file pathname?

-- 
Shawn.
