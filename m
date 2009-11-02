From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Mon, 2 Nov 2009 07:41:04 -0800
Message-ID: <20091102154104.GR10505@spearce.org>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com> <7vzl75v737.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 16:41:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4z1t-00084l-6r
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 16:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbZKBPlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 10:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190AbZKBPlB
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 10:41:01 -0500
Received: from george.spearce.org ([209.20.77.23]:50325 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168AbZKBPlA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 10:41:00 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0C71C381FE; Mon,  2 Nov 2009 15:41:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vzl75v737.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131915>

Junio C Hamano <gitster@pobox.com> wrote:
> Scott Chacon <schacon@gmail.com> writes:
> > +Git Protocol
> > +------------
> > +
> > +The Git protocol starts off by sending "git-receive-pack 'repo.git'"
> > +on the wire using the pkt-line format, followed by a null byte and a
> > +hostname paramater, terminated by a null byte.
> > +
> > +   0032git-upload-pack /project.git\0host=myserver.com\0
> 
>  - The example and the first line of the description contradict with each
>    other.

Yes.  The first line description implies the repository path is
wrapped in single quotes, but the example doesn't, because the
protocol doesn't.
 
> > +Initiating the upload-pack or receive-pack processes over SSH is
...
> 
> This depends on the intended audience of this document, but if we are
> writing for people who want to implement their own gitosis and gitolite to
> replace the login shell spawned by ssh daemon,

We are.  If we aren't, we should be.  This is an area everyone has
struggled with.  I had to fight with GitHub to get them to properly
support ssh:// style URLs and not just the scp-style URL.

> you may want to explain the
> "command line" given to it a bit more precisely.  Specifically:
> 
>  - The "command name" is spelled with dash (e.g. git-upload-pack), but
>    this can be overridden by the client;
> 
>  - The repository path is always quoted with sq (i.e. by sq_quote_buf()).

One thing I have been confused on is how ~user is handled here,
because it seems to me we would be allowing ~user outside of the
sq path, so the shell can expand ~user to /home/user or whatever.
But the C code reads to me like we don't do that.
 
> > +Reference Discovery
> > +-------------------
...
> > +   00441d3fcd5ced445d1abc402225c0b8a1299641f497 refs/heads/integration
> > +   003f7217a7c7e582c46cec22a130adf4b9d7d950fba0 refs/heads/master
> > +   003cb88d2441cac0977faf98efc80305012112238d9d refs/tags/v0.9
> > +   003c525128480b96c89e6418b1e40909bf6c5b2d580f refs/tags/v1.0
> > +   003fe92df48743b7bc7d26bcaabfddde0a1e20cae47c refs/tags/v1.0^{}
> > +   0000
> > +Server SHOULD terminate each non-flush line
> > +using LF ("\n") terminator; client MUST NOT complain if there is no
> > +terminator.
> 
> Hmm, LF ("\n") makes me wonder how precise we would want to be.  We
> probably should also say we use ASCII (meaning "not EBCDIC") somewhere but
> that level of details can wait until a more later draft..

True.  But the common document which also explains our ABNF includes
a definition of LF as the byte %x0D.  It might be sufficient to
also say we mean ASCII in that document, though I think these days
that's implied when you start using the IETF ABNF grammar for a
network protocol.  Nobody in their right mind assumes EBCDIC.

> > +The returned response is a pkt-line stream describing each ref and
> > +its known value.  The stream SHOULD be sorted by name according to
> > +the C locale ordering.  The stream SHOULD include the default ref
> > +named 'HEAD' as the first ref.  The stream MUST include capability
> > +declarations behind a NUL on the first ref.
> 
> I have a vague recollection that in a recent discussion (not discussion on
> this documentation patch, but on a "builtin-fetch.c" patch around mid
> September), we decided that the above two SHOULD should be MUST.  Another
> MUST that is missing from here is that a line that describes a peeled tag
> MUST immediately follow the tag itself.

Almost, yes.

The first SHOULD about sorting is a MUST.

Another MUST missing here is that the peeled value of a ref (that is
"ref^{}") MUST be immediately after the ref itself, if presented.
A conforming server MUST peel the ref if its an annotated tag.

The second SHOULD regarding HEAD is more delicate to word.  I think
its more like:

  If HEAD is a valid ref, HEAD MUST appear as the first advertised
  ref.  If HEAD is not a valid ref, HEAD MUST NOT appear in the
  advertisement list at all, but other refs may still appear.

Consider what happens when HEAD is a symref to refs/heads/foo, but
that branch doesn't exist yet, but refs/heads/master does exist.
The repository is completely valid (it'll pass fsck --full), HEAD
won't advertise, but master will.  A clone will fail with no HEAD
reference, but that doesn't mean you can't pull from it with a more
specific refspec.

We shouldn't encourage repository owners to setup their repository
with a dangling HEAD like that, but this is the wrong document to
explain that in.

> > +	capability-list  =  capability *(SP capability)
> > +    capability       =  1*(ALPHA / DIGIT / "-" / "_")
> > +----
> > +
> > +Server and client SHOULD use lowercase for SHA1, both MUST treat SHA1
> > +as case-insensitive.
> 
> Why do we need to retroactively loosen these to allow uppercases?  Are
> there implementations that want this loosening?

Are you talking about capabilities?  That was a mistake in my draft.
This should instead be:

  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_")
  LC_ALPHA         =  %x61-7A


If its SHA-1 you are talking about, I wanted this to be a MUST
use lowercase, but people screamed about it (Jakub and Ilari
IIRC).  The current C code accepts uppercase due to its use of
get_sha1_hex(), and they wanted to follow the "be liberal in what
you accept" suggestion from other IETF authors.

IIRC, all implementations use lowercase.  We should be able to safely
say MUST produce lowercase, and MUST accept lowercase, and SHOULD
NOT accept uppercase, but then the canonical C implementation isn't
exactly conforming anymore due to get_sha1_hex().  Hell, pkt-line.c
also wouldn't conform I guess, it will read uppercase hex.
 
-- 
Shawn.
