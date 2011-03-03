From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] git blame-tree
Date: Thu, 03 Mar 2011 12:20:10 -0800 (PST)
Message-ID: <m3fwr46jp3.fsf@localhost.localdomain>
References: <20110302164031.GA18233@sigill.intra.peff.net>
	<20110302171653.GA18957@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 03 21:20:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvF0r-00007X-G8
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 21:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758738Ab1CCUUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 15:20:36 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59042 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758524Ab1CCUUf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 15:20:35 -0500
Received: by fxm17 with SMTP id 17so1489974fxm.19
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 12:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=uoVgC3mtDoupJmuNPHzP6HkLs1VJqKuGberkdor3Hd4=;
        b=GNuEAsI8iwvqBc8OZmHrrRMVoirqnrCsErfUi0kDONXSwNYZDrUKwzcwzciqLlPART
         aS+/GrvvXmvgRo6JPpzm53yj3icCbiq8f+jtTmzAIYfLDJveW9rq+1JKX6tgav5TLOH5
         CwkaIiOiwskefA/t/GfyBiOFlNdFzPlBkM2nA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=dlvTbdN8vJwNfB5KOFNIewfDGrZlbfVsLTC05+0bIBh63M3XamigvsU7AYo1AE8uwD
         WpoMC261q/sHenJeRn4+xJyoZVkrOT1/0DrSkSjBUR8P6PXxOPdA5Ptw9U9iaha3gtfz
         KVl33Rpbu2RzPhIswjv+461Zc4odWU2y0RbvI=
Received: by 10.223.70.136 with SMTP id d8mr2056283faj.3.1299183614997;
        Thu, 03 Mar 2011 12:20:14 -0800 (PST)
Received: from localhost.localdomain (abwg77.neoplus.adsl.tpnet.pl [83.8.230.77])
        by mx.google.com with ESMTPS id c11sm808887fav.26.2011.03.03.12.20.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Mar 2011 12:20:10 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p23KJdgg032496;
	Thu, 3 Mar 2011 21:19:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p23KJL0G032490;
	Thu, 3 Mar 2011 21:19:21 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110302171653.GA18957@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168406>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 02, 2011 at 11:40:32AM -0500, Jeff King wrote:

> > It's sometimes useful to get a list of files in a tree along with the
> > last commit that touched them. This is the default tree view shown on
> > github.com, but it can also be handy from the command line (there has
> > been talk lately of having a "git ls"), or as plumbing for a local
> > fancier tree view. E.g., something like:
> > 
> >      add.c 6e7293e git-add: make -A description clearer vs. -u
> >    apply.c fd03881 add description parameter to OPT__VERBOSE
> >    blame.c 9ca1169 parse-options: Don't call parse_options_check() so much
> >   branch.c 62270f6 branch_merged: fix grammar in warning
> >   bundle.c 62b4698 Use angles for placeholders consistently
[...] 

> >  blame-tree.c          |  156 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  blame-tree.h          |   25 ++++++++
> >  builtin.h             |    1 +
> >  builtin/blame-tree.c  |   34 +++++++++++
> 
> I tried to lib-ify the implementation as much as possible. It increases
> the lines of code, of course, but I figured there was a reasonable
> chance that there might be a user-friendly "git ls" command eventually,
> and this would probably make a good "-v" option to it.

I think it _might_ be a good idea to add `--blame' option to
"git ls-tree", as a one of ways of presenting tree-blame output.
Or perhaps as part of "git ls".

In "[RFC] Tree blame (git blame <directory>)"[1] I proposed for

  $ git blame --abbrev v1.6.3.3 -- .

to generate

  100644 blob e57630e ba19a80 Junio C Hamano      Feb 10 17:42   walker.c
  100644 blob 8a149e1 c13b263 Daniel Barkalow     Apr 26  2008   walker.h
  100644 blob 7eb3218 fc71db3 Alex Riesen         Apr 29 23:21   wrapper.c
  100644 blob 4c29255 559e840 Junio C Hamano      Jul 20  2008   write_or_die.c
  100644 blob 819c797 a437900 Junio C Hamano      Jun 21 02:35   ws.c
  100644 blob 1b6df45 2af202b Linus Torvalds      Jun 18 10:28   wt-status.c
  100644 blob 78add09 6c2ce04 Marius Storm-Olsen  Jun  5  2008   wt-status.h
  100644 blob b9b0db8 eb3a9dd Benjamin Kramer     Mar  7 21:02   xdiff-interface.c
  100644 blob 7352b9a 86295bb Rene Scharfe        Oct 25  2008   xdiff-interface.h
  040000 tree ef5d413 5719db9 Charles Bailey      May 25 01:21   xdiff/

or something like that.  Date doesn't have to be in this strange format
used by 'ls'.  Also instead of name we can use username part of email,
or just email; OTOH git-blame uses above format for author.

This could be result of "git ls-tree --abbrev --blame v1.6.3.3"...
and it could be combined with `-l' option of git-ls-tree.

[1]: http://article.gmane.org/gmane.comp.version-control.git/122830

> 
> I considered making it a special mode of "git blame" when blame is fed a
> directory instead of a file. But the implementations aren't shared at
> all (nor do I think they need to be; blame-tree is _way_ simpler). And I
> didn't want to steal that concept in case somebody can think of a more
> content-level way of blaming a whole tree that makes sense (obviously
> just showing the concatenation of the blames of each file is one way,
> but I don't know how useful that would be). If we want to go that way,
> we can always catch the special case in blame and just exec blame-tree.

Well, having "git blame [<rev>] <directory>" to output tre-blame
would allow to reuse some of already existing options to ordinary
git-blame; well those that makes sense, like `-b', `-S <revs-file>',
`--reverse', perhaps (depending on available output) also `-l', `-t',
`-s', `--date <format>'.

<rev> is here starting revision or revision range; if it is revision
range then negative specifiers function as boundary.

We could use `-M' to turn on rename detection, and `-C' to turn on
copy detection; I think that in tree-blame we need to consider only
_exact_ renames (pure renames, i.e. the same SHA-1, different name).

Also for GitHub (and perhaps also in the future for gitweb too) would
I think use `--porcelain' or even `--incremental' version of tree-blame;
in [1] I have proposed the following output (following existing "for
porcelain" format):

  $ git blame --porcelain v1.6.3.3 -- .

  86295bb6bac1482d29650d1f77f19d8e7a7cc2fe 7352b9a9c204c2b1d4ca9df5ce040fe22d6f521c
  author Rene Scharfe
  author-mail <rene.scharfe@lsrfire.ath.cx>
  author-time 1224941475
  author-tz +0200
  committer Junio C Hamano
  committer-mail <gitster@pobox.com>
  committer-time 1224961771
  committer-tz -0700
  summary add xdi_diff_hunks() for callers that only need hunk lengths
  filename xdiff-interface.h
  100644 blob 7352b9a9c204c2b1d4ca9df5ce040fe22d6f521c    xdiff-interface.h
  5719db91ce5915ee07c50f1afdc94fe34e91529f ef5d413237b3a390007fba56671b00d7c371ae1e
  author Charles Bailey
  author-mail <charles@hashpling.org>
  author-time 1243210874
  author-tz +0100
  committer Junio C Hamano
  committer-mail <gitster@pobox.com>
  committer-time 1243234594
  committer-tz -0700
  summary add xdi_diff_hunks() for callers that only need hunk lengths
  filename xdiff
  040000 tree ef5d413237b3a390007fba56671b00d7c371ae1e    xdiff

> > +void blame_tree_init(struct blame_tree *bt)
> > +{
> > +	memset(bt, 0, sizeof(*bt));
> > +	bt->paths.strdup_strings = 1;
> > +	init_revisions(&bt->rev, NULL);
> > +	bt->rev.no_merges = 1;
> > +	bt->rev.def = "HEAD";
> > +}
> 
> I turn off merges by default, since they are unlikely to be interesting
> matches (you will see the merge of a side-branch that touched a file
> instead of the actual commit on the side-branch). You could of course do
> "git blame-tree . --no-merges" to get the same effect. I think no-merges
> makes a saner default, but sadly it doesn't seem like there is a way to
> turn no-merges back off ("--merges" means something else, and there is
> no --no-no-merges").

IMHO merges are interecting; moreover if I remember correctly my proof
of concept of tree-blame which I tried to implement in Perl using
Git.pm (git cat-file --batch + git diff-tree --stdin), I have problems
with merges in tree-blame of subdirectory ("--relative" option doesn't
work as I thought it did).
 
> Right now the code just handles trees. But in the long run, it would
> probably make sense to get the list of files from the index, and mark
> files modified in the working tree or index, too. So something like:
> 
>   foo.c  1234abcd this is a commit subject
>   bar.c  modified in working tree
>   baz.c  modified in index
> 
> Sort of like how gitk shows "pseudo-commits" on top of history to
> indicate changes.

Or how "git blame" handles "--contents <file>" option... though what
you mentioned is more than that.

[...] 
> > +int cmd_blame_tree(int argc, const char **argv, const char *prefix)
> > +{
> > +	struct blame_tree bt;
> > +	const char *path = NULL;
> > +
> > +	git_config(git_default_config, NULL);
> > +
> > +	if (argv[1]) {
> > +		path = argv[1];
> > +		argc--;
> > +		argv++;
> > +	}
> 
> Obviously no options. Probably there should at least be "--porcelain" to
> output the current form, and the default output should be more
> user-friendly. And probably "-z" to avoid quoting issues.

Thank you for working on this.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
