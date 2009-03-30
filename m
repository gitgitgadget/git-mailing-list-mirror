From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: fix ls-tree usage with dash-prefixed paths
Date: Mon, 30 Mar 2009 10:41:51 -0700
Message-ID: <20090330174151.GA32728@dcvr.yhbt.net>
References: <22719363.post@talk.nabble.com> <20090326130213.GC3114@atjola.homenet> <83dfc36c0903260735q3231ce96h5949d1123858995f@mail.gmail.com> <83dfc36c0903270418q59a81290xcb8043b8c037be18@mail.gmail.com> <20090329060858.GB15773@dcvr.yhbt.net> <20090329061045.GA29721@dcvr.yhbt.net> <7v8wmoqdc1.fsf@gitster.siamese.dyndns.org> <20090329215651.GA4355@dcvr.yhbt.net> <7v3acvldc7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anton Gyllenberg <anton@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 19:43:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoLWA-0001t9-TK
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 19:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbZC3Rly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 13:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753698AbZC3Rly
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 13:41:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37936 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192AbZC3Rlx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 13:41:53 -0400
Received: from localhost (dcvr.yhbt.net [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8783B1F43E;
	Mon, 30 Mar 2009 17:41:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v3acvldc7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115178>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Junio C Hamano <gitster@pobox.com> wrote:
> >> Eric Wong <normalperson@yhbt.net> writes:
> >> 
> >> > To find the blob object name given a tree and pathname, we were
> >> > incorrectly calling "git ls-tree" with a "--" argument followed
> >> > by the pathname of the file we wanted to get.
> >> >
> >> >   git ls-tree <TREE> -- --dashed/path/name.c
> >> >
> >> > Unlike many command-line interfaces, the "--" alone does not
> >> > symbolize the end of non-option arguments on the command-line.
> >> >
> >> > ls-tree interprets the "--" as a prefix to match against, thus
> >> > the entire contents of the --dashed/* hierarchy would be
> >> > returned because the "--" matches "--dashed" and every path
> >> > under it.
> >> 
> >> The above makes only half a sense to me.  In an empty directory:
> >
> > Ah, I think you missed this line:
> >
> > "the entire contents of the --dashed/* hierarchy would be"
> 
> Actually, that was what I was trying to demonstrate to be false.  Notice
> the empty output from the first ls-tree with only -- and no other pathspec
> on the command line.  "--" should not match "--dashed/*" anything (but
> also notice that I said "should" here).
> 
> >>     $ git init
> >>     Initialized empty Git repository in /tmp/empty/.git
> >>     $ mkdir -p ./--dashed/path
> >>     $ >./--dashed/path/name
> >
> > # Add a second file
> > 	>./--dashed/path/ame
> 
> I think that is an independent bug.  Not just "--" but it appears "--d"
> seems to hit it (and this is an ancient bug---even v1.0.0 seems to have
> it).

> I suspect that ls-tree needs a fix, not about "--" but about the pathspec
> filtering.  It appears that the part that decides if a subtree is worth
> traversing into uses the correct "is a pathspec pattern match leading path
> components?" semantics (i.e. "--dashed" matches but "--" doesn't), but
> after traversing into subtrees, the part that emits the output uses a
> broken semantics "does the path have any pathspec patter as its prefix?"
> It shouldn't check for "prefix", but for "leading path components", in
> other words, the match must happen at directory boundaries.
> 
> And I do not think *this* bug is too late to fix.  We should fix it.

>From the ls-tree documentation, I was under the impression that "--"
matching "--dashed" was intended:

  When paths are given, show them (note that this isn't really raw
  pathnames, but rather a list of patterns to match).

It doesn't make sense to me match like this, either; but I do think it
was intended and it will break things if people depend on the
existing behavior.

-- 
Eric Wong
