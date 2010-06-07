From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] bash completion: Support "unpushed commits" warnings in __git_ps1
Date: Mon, 7 Jun 2010 09:42:34 +0200
Message-ID: <201006070942.34753.trast@student.ethz.ch>
References: <4C0AE640.3040503@pileofstuff.org> <201006062014.59386.trast@student.ethz.ch> <4C0C09BF.4070503@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon Jun 07 09:42:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLWyq-0001vi-Kr
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 09:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331Ab0FGHmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 03:42:40 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:36636 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932234Ab0FGHmj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 03:42:39 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 7 Jun
 2010 09:42:37 +0200
Received: from thomas.localnet (129.132.210.56) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 7 Jun
 2010 09:42:37 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <4C0C09BF.4070503@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148582>

Andrew Sayers wrote:
> 
> I'm not averse to adding a config setting, or to exploring the
> "--no-metadata" case.  I am concerned about the strict time constraints
> for code called in a command prompt though.  For instance, calling
> git-svn could easily make your prompt take over half a second to respond
> because of all the Perl you'd have to compile.

True, I forgot about that.

> I'd also want a few
> real-world use cases and a nod from Shawn before diverging any further
> from the existing GIT_PS1_FOO= convention.

> Having said all that, I'm quite happy to resubmit with
> GIT_PS1_SHOWUNPUSHED=svn treated like GIT_PS1_SHOWUNPUSHED=1 when
> $GIT_DIR/svn doesn't exist.

There's the precedent of bash.showDirtyState that allows you to
disable the +* indicators _per repository_.  The latter idea also
sounds reasonable, though I personally would find the configuration
more useful.  I have several repos that push to both git (for real
work) and SVN (for buildbots) where I'd prefer the indicator to refer
to git.

> > How about starting with
> > 
> >   git log -1 --first-parent --grep="^git-svn-id: $remote_branch"
> 
> Good idea about "-1" and "--grep", but multi-parent commits aren't
> compatible with SVN, so I don't see how "--first-parent" is useful here?
>  In fact I'm tempted to look for merge commits and print a big warning
> when one is found.

Please don't; you'd immediately lose me as a user :-)

First, --first-parent is actually how git-svn looks for the
git-svn-id, and any other search is liable to turn up wrong results.
See working_head_info in git-svn.perl.

Second, the behaviour of git-svn with merges is very useful and
well-defined.  (Yes, there are stern warnings in the manpage, but if
you know what you're doing just ignore them...)

'git svn dcommit' will first determine the correct upstream branch
according to the above logic, i.e., it *always* commits to the
first-parent ancestry.  Then it commits the diff along this line of
history (i.e., always diffing to the first parent) but it does rewrite
the commits so that merges are preserved.

In pictures, if you have

    o---B---o---o---o    trunk
         \
          *---*---*---*    topic

and run 'git checkout trunk; git merge topic; git svn dcommit' you get

    o---B---o---o---o---M'    trunk
         \             /
          *---*---*---*    topic

(writing M' since this is already the rewritten version of an original
merge M).  M' looks to SVN like a 'git merge --squash topic' because
git-svn doesn't (yet?) store the merge info.

So you get to keep the git merge info, which is very useful for later
merges of 'topic'.

Note: NEVER run 'git checkout topic; git merge trunk'.  git-svn will
think (because of the first-parent rule) that you want to commit on
top of B!  I don't know what happens next but I expect it won't be too
pretty.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
