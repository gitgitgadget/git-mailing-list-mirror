From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] Blame functionality for jgit
Date: Mon, 12 Jan 2009 09:42:32 -0800
Message-ID: <20090112174232.GJ10179@spearce.org>
References: <3d045c7e0901111223j43a69402s28a59612212943f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Manuel Woelker <manuel.woelker@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 18:44:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMQpR-000889-Sp
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 18:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbZALRmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 12:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbZALRmf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 12:42:35 -0500
Received: from george.spearce.org ([209.20.77.23]:60913 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbZALRme (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 12:42:34 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 794DD38210; Mon, 12 Jan 2009 17:42:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <3d045c7e0901111223j43a69402s28a59612212943f3@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105362>

Manuel Woelker <manuel.woelker@gmail.com> wrote:
> Over the weekend I have been hacking the jgit sources a little to see
> if I can add blame/praise/annotate functionality to it. The results
> can be found at http://github.com/manuel-woelker/egit/tree/blame . All
> work is in the blame branch in org.spearce.jgit.blame package.

Interesting.
 
> I largely ported the cgit blame algorithm described here
> https://kerneltrap.org/mailarchive/git/2006/10/12/224187 , the
> relevant file is builtin-blame.c cf.
> http://repo.or.cz/w/git.git?a=blob;f=builtin-blame.c;hb=HEAD

OK.  Fortunately Junio has largely given his blessing to this code
being converted to Java under the BSD license.

> The blame algorithm needs to use a diff algorithm to find common parts
> in files. AFAICT there is no diff implementation in jgit at the
> moment. I used the incava java-diff library, (see
> http://www.incava.org/projects/java/java-diff ), but I introduced an
> interface that should make it possible to swap implementations with a
> minimum of effort. To compile I just create a new eclipse project with
> the java-diff sources.

Unfortunately I can't reach incava.org to download java-diff, but
its entry on sourceforge says it uses an LGPL license.  Within JGit
we do want to stick to BSD and BSD dependencies, so bringing in
java-diff as a new dependency isn't something we really want to do.

Fortunately Dscho has been working on a Java diff implementation for
JGit, and is considering releasing it under a BSD license so we can
include it.

The interface is still to be decided, but in general we have
found that running against a byte[] is much faster than running
against String.  We're probably going to want the diff library to
take a byte[] and an IntList (as created by RawParseUtils.lineMap)
and let it work against the byte array ranges directly, without any
additional allocations, except where it needs to build up its hash
of records.
 
> I would like to hear your thoughts on a couple of topics:
>  - Merge/patch/diff/blame functionality needs a diff implementation,
> what are our options within technical and license constraints?

I'm open to a plugin interface like you have done with the IDiff
API to hide java-diff, but for that to work we cannot have the
java-diff code as part of the JGit classpath.  It needs to be
something added externally by the user, in a different context,
so the user can easily load their preferred diff implementation.

If that happents to be the LGPL java-diff, that's the user's choice.
We can provide the shim needed to get it to load, and the adapter,
but IMHO we shouldn't distribute the LGPL code, and we shouldn't
make it required in order to make the library compile or work.

Eclipes has its own LCS implementation, we should also be able
to have the Eclipse plugin provide its own shim to link to the
Eclipse EPL licensed LCS, so Eclipse can avoid java-diff entirely.
I'm not sure if NetBeans has an LCS available that the NetBeans
plugin could easily link to.  It probably does.

I think eventually we'll have a BSD licensed LCS that will come with
JGit, which would eliminate the need for such a shim.  I'd like
to see that happen before blame gets added, but if blame is ready
and the shim is reasonably well done, I'm inclined to bring blame
in early.

>  - What is the roadmap for these features?

There isn't one.  Its whatever gets contributed in a state that is
ready for inclusion.  :-)

Since you are submitting this work, I'd say its on you to get
blame added.

>  - Can you see this blame effort getting integrated upstream?

Yes.
 
> I would love to contribute more effort to egit and the blame
> functionality in particular. To me, "blame" is one of the killer
> features of modern SCMs.

I agree, I use git blame fairly often myself...

> Last no least, kudos to the git and egit teams for their hard work on
> making git such a great piece of software.

Thanks.

Now for some comments about your blame branch.

- Don't use @author tags, we don't use them anywhere else.

- Please include copyright headers on all new files.

- I think the IDiff, IDifference should be in a ".diff" package so
we can reuse them for other diff applications.  Especially if we
wind up using a shim to link to different LCS implementations.

- I think the API for BlameEngine should be more like:

  public class BlameEngine {
    private final RevWalk rw;

    public BlameEngine(final Repository repo) {
      this(new RevWalk(repo));
    }

    public BlameEngine(final RevWalk walk) {
      rw = walk;
    }

    public RevWalk getRevWalk() {
      return rw;
    }

    public List<BlameEntry> blame(RevCommit c, String path);
  }

  One reason for this style of API is we can have the engine cache
  blame records.  This can make a GUI navigator much more efficient
  as it jumps around between commits and asks for blames over the
  same data.

- Internally you should *always* use RevCommit, not Commit.
The RevCommit class can be orders of magnitude faster than Commit.

- Internally you should always use RevTree and TreeWalk to locate
blob IDs.  Its orders of magnitude faster than Tree and TreeEntry.

- Don't use new String(loader.getBytes()) (e.g. in Origin.getData)
to get the data for a file.  We want to do raw diffs, so that the
character encoding is considered as part of the blame.  E.g. if
a file switches character encodings, the blame has to go to the
commit that introduced the new encoding.  This is a huge reason
to use byte[] and IntList over an array of String.

- RawParseUtils.lineMap will be faster than a Pattern of "^(.*)$".


Otherwise, I'm finding your code to be quite clear, and converted
rather nicely from C.  I'd love to see this integrated into the
JGit project.

-- 
Shawn.
