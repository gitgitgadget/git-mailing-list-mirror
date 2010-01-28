From: Yann Dirson <ydirson@altern.org>
Subject: Re: show/diff --check clarification needed
Date: Thu, 28 Jan 2010 22:38:37 +0100
Message-ID: <20100128213837.GF2725@nan92-1-81-57-214-146.fbx.proxad.net>
References: <d26982ce92a061ee24d04aba6e314fa4.squirrel@intranet.linagora.com>
 <7vmxzykmdp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 22:36:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nac2X-0008Uu-Fy
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 22:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638Ab0A1Vgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 16:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753498Ab0A1Vgc
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 16:36:32 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:33122 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752666Ab0A1Vgb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 16:36:31 -0500
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id E50F994016D;
	Thu, 28 Jan 2010 22:36:25 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 01929940122;
	Thu, 28 Jan 2010 22:36:22 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 60ECDA003; Thu, 28 Jan 2010 22:38:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vmxzykmdp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138274>

On Thu, Jan 28, 2010 at 12:25:22PM -0800, Junio C Hamano wrote:
> "Yann Dirson" <ydirson@altern.org> writes:
> 
> > Unless I missed something, I suggest the following plan:
> >
> > - document in maint that --check only takes worktree into account when
> >   looking for .gitattributes, and more globally add a note to the
> >   gitattributes manpage to explicitely say that too.
> 
> It is not limited to "diff --check".  The current implementation reads
> attributes only from the checked out work tree and/or from the index,
> depending on the direction of operation (e.g. checking out files to work
> tree reads from the index, I think).  The same issue would affect "git
> archive" when generating a tarball from an older revision.
> 
> The exception is $GIT_DIR/info/gitattributes, and for your particular
> purpose, I think it is the right one to use, because the entries in that
> file will apply regardless of which version you are examining patches
> from.

Well, it would have serious disavantages:
- if used alone, info/attributes is not obtained as part of the fetch (so
  needs additional logic to deploy into dev's workspaces)
- if used together with .gitattribute files, would need to be synchronized
  on pull, but then:
  - would also need a policy to tell from which head to update
  - mapping from a set of .gitattributes distributed in the tree is possibly
    not trivial (I have not succeeded to affect files in a specific subdir
    from the toplevel .gitattributes, and the manpage does not seem to mention
    that info/gitattributes allows more flexibility in this respect)


> > - add a global flag to allow something like
> >   "git --attributes-tree=<treeish> <command>"
> 
> I am not sure if this is what we really want.  It seems to me that it
> would make more sense to read from a relevant tree that the <command>
> is operating on, if we are to enhance the attributes implementation.  If
> that <treeish> is a fixed one, it is not much better than having necessary
> entries in your $GIT_DIR/info/gitattributes file.

The idea with this flag is not to have <treeish> fixed, but more for use by
other commands/porcelain, who would make themselves the decision of which
treeish to take attributes from.


> > - adjust defaults to agreed-upon values
> > - add any config entries that would be meaningful
> 
> Sorry, I have no idea what you mean by these two points.

That was partly intentionally vague, partly to blame on me being tired :)

- once the --attributes-tree feature would be in place, various commands like
diff-tree and show will be able to decide what makes more sense as a default
for the requested operation.  Depending on the command and the particular
invocation, the default to use may not always be obvious, so I expect the
general default will be kept to the working tree.

- as ususal, people may want to use different settings than the default for
some commands, so support for overriding them via the config mechanism should
be put in place.


Anyway, how we specify the rule of which treeish to use for this will not be
possible with simply a treeish.  That will probably have to use keywords
that would be meaningful in the context of the operation.

I would expect that all operations would be able to be told "worktree", "index",
and to be given any treeish - this in itself is a problem, I don't think we
already have a "treeish" syntax for worktree and index.

Additionally, "show" applied to a treeish would allow to tell to use the treeish
it is showing (or one of its parents); similarly when applied to "<committish>:<path>"
syntax; "diff-tree" would allow either the positive or negative reference; etc.
All that would also require a special syntax, so it can be specified as a
generally-useful value in the config file.
