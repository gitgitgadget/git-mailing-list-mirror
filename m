From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 0/2] merge-base: add --merge-child option
Date: Sat, 11 May 2013 19:48:55 +0100
Message-ID: <20130511184855.GE2299@serenity.lan>
References: <cover.1368274689.git.john@keeping.me.uk>
 <7vmws1xv0b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 11 20:49:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbEr3-0001g3-Mf
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 20:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab3EKStJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 14:49:09 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:49660 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab3EKStI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 14:49:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id BEFCDCDA57C;
	Sat, 11 May 2013 19:49:06 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0m1exV2ZPtYn; Sat, 11 May 2013 19:49:05 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 1F62ACDA59C;
	Sat, 11 May 2013 19:48:57 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vmws1xv0b.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224000>

On Sat, May 11, 2013 at 10:54:12AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > This is helpful when examining branches with disjoint roots, for example
> > because one is periodically merged into a subtree of the other.
> >
> > With the --merge-child option, "git merge-base" will print a
> > first-parent ancestor of the first revision given, where the commit
> > printed is either a merge-base of the supplied revisions or a merge for
> > which one of its parents (not the first) is a merge-base.
> 
> The above two doe snot connect at least to me.  The second paragraph
> seems to describe how this mysterious mode decides its output to a
> sufficient detail, but what the output _means_, and it is unclear
> how it relates to gitk/git-gui style merges.
> 
> > For example, given the history:
> >
> >         A---C---G
> >              \
> >         B-----D---F
> >          \
> >           E
> >
> > we have:
> > ...
> >         $ git log --left-right F...E --not $(git merge-base --merge-child F E)
> >         < F
> >         > E
> >
> > The git-log case is useful because it allows us to limit the range of
> > commits that we are examining for patch-identical changes when using
> > --cherry.
> 
> Hmph, is this reinventing ancestry-path in a different way?  At the
> low level machinery, you are finding D to show only F and E, and
> your goal seems to be to ignore the side ancestry A--C--G, but it is
> not clear if you prefer "E D F"(which would be what F...E would give
> in a history limited to ancestry-path, ignoring C) over "E F".

I hadn't considered ancestry-path, but I don't think it does what I
want.  What I want if for LEFT to be B--D--F and RIGHT to be B--E,
ignoring A--C--G because I know that none of those are patch identical
to anything in B--E.

So what I want is more descendant-path than ancestry path in that I
don't want anything that isn't a descendant of the merge base of the
supplied arguments.

> > For example with git-gui in git.git I know that anything
> > before the last merge of git-gui is not interesting:
> 
> Can this be extended to find the second last such merge?  Or is the
> last one always special?

In this implementation it only finds the last one because that's where
the merge base is.

> Still skeptical, but I'll let people discuss it during the feature
> freeze ;-).

I'm not convinced this is easy to explain myself, which may make it a
bad idea.  Perhaps a --descendant-path argument to git-log is a better
way to help with this case.
