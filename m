From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] builtin-commit: avoid using reduce_heads()
Date: Sat, 27 Sep 2008 01:51:47 +0200
Message-ID: <200809270151.51785.jnareb@gmail.com>
References: <20080925235029.GA15837@neumann> <m37i8y3mqt.fsf@localhost.localdomain> <20080926193122.GW23137@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: SZEDER =?iso-8859-2?q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Sep 27 01:53:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjN7k-00081G-6N
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 01:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbYIZXwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 19:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbYIZXwN
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 19:52:13 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:51606 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbYIZXwM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 19:52:12 -0400
Received: by mu-out-0910.google.com with SMTP id g7so954249muf.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4VuHJQfyqXVm1ZTEqjMLuItFiInwC3LSCtbaCxIXzEc=;
        b=PzsZqmgQ7TYtrcrns3U/RTDPPG8ZPpUW0uVldNianv+3svPRp33cYbZ6ZJ12v08w+u
         rnJgAv7yegHEBHUha74mnuOqaWyTQyqd3Jv2e9n1YK/gN3jRLwySD2LwsLGkfN44yfLe
         NHyGXb9o/Jb6IaryBhr1hAgQzBSYu6YqUlIGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EMNorORSn3iV6rzj99bDESpijHQN/JTDcUFjALa+t05D6FO0ZXHNVTuuu2nxcijejV
         tmK8JeRYMrL05bXi6mZJHRapvKmTF7EzYCtDFAq0zQlcLHHBaz+ViLJ3yfGhRyDdWM6F
         D9GCK+NiuB5azB3ofnqtSPJbhlUCYfPrtiF6g=
Received: by 10.103.198.20 with SMTP id a20mr1410294muq.56.1222473130236;
        Fri, 26 Sep 2008 16:52:10 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.233.191])
        by mx.google.com with ESMTPS id e8sm10178509muf.6.2008.09.26.16.51.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Sep 2008 16:52:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080926193122.GW23137@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96893>

On Fri, 26 Sep 2008, Miklos Vajna wrote:
> On Fri, Sep 26, 2008 at 09:17:39AM -0700, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > 1. As proposed above save git-merge options, for example in MERGE_MODE
> >    or MERGE_OPTS file, so git-commit knows what options to use if it
> >    was invoked to finish a merge.
> 
> First, thank you for the detailed description, I'm really bad in them.
> :)
> 
> ACK, that's why I implemented this one.

This is I think the fastest and seemingly simplest solution.

> > 2. git-merge saves _reduced_ heads in MERGE_HEAD, and git-commit
> >    reduces only HEAD, unless it is in MERGE_HEAD.  This means that
> >    git-commit uses the following pseudo-code
> > 
> >      if (resolve_ref(HEAD) == MERGE_HEAD[0]) {
> >         /* non fast-forward case */
> >         merge HEAD + MERGE_HEAD
> >      } else {
> >         reduce_HEAD_maybe()
> >         merge [HEAD] + MERGE_HEAD
> >      }
> > 
> >    This has the advantage that it doesn't change MERGE_HEAD semantic
> >    for simple merge which did not began as octopus
> 
> This is wrong IMHO. You can write the reduced heads to MERGE_HEAD but
> you can't know if you can omit the HEAD in case it is reachable already
> from one of the heads or not. That depends on if the user used --no-ff
> or not.

I have tried to explain in above pseudocode git-commit is to use
additional hack to decide whether to try to reduce HEAD wrt MERGE_HEAD
heads (normal case), or not (--no-ff case), namely if resolved HEAD
is first head in MERGE_HEAD that means --no-ff case.

It is "halfway" solution and bit hacky (and ugly).

> > 3. Remove reduce_heads() from git-commit entirely, and record in
> >    MERGE_HEAD (or rather now MERGE_HEADS) _all_ _reduced_ heads.
> >    _All_ means that HEAD is included in MERGE_HEAD if it is not
> >    reduced, _reduced_ means that only non-dependent heads are in
> >    MERGE_HEAD.  This for example means that for simple non-octopus
> >    merge case MERGE_HEAD/MERGE_HEADS now contain _all_ parents,
> >    and not only other side of merge.
> > 
> >    This solution has the advantage of being clear solution, clarifying
> >    semantic of MERGE_HEAD (currently HEAD is used both as target, i.e.
> >    where merge is to be recorded, and as one of heads to merge/to
> >    consider), and making it possible to separate layers: git-merge
> >    is about merging, git-commit doesn't need to know anything about
> >    merging.
> > 
> >    The disadvantage is that it changes format (well, semantic) of
> >    MERGE_HEAD, possibly breaking users' scripts; perhaps some of
> >    git commands like "git log --merge" or "git diff --merge" should
> >    be updated on such change.
> 
> Actually I think this would be ugly. MERGE_HEAD is about you can see
> what will be merged once you commit the merge, but once you include HEAD
> there, you can't easily check that. Maybe it's just me who sometimes
> have a look at that file myself directly... :-)

The new semantic would be very simple.  If there is no MERGE_HEAD, it
is an ordinary no-merge commit, and its only parent would be previous
(current) version of HEAD.  If there is MERGE_HEAD it contains _all_
parents in a merge commit, and only those heads which will be parents
(_reduced_ heads); if HEAD is symref, we modify given branch so it
points to newly created merge commit.

Currently parents of merge commits are 'reduce(HEAD + MERGE_HEAD)'
in symbolic equation; I propose they would be simply 'MERGE_HEAD'.
then we set this branch to new commit

-- 
Jakub Narebski
Poland
