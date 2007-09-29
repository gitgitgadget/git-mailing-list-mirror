From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Fri, 28 Sep 2007 20:00:56 -0400
Message-ID: <20070929000056.GZ3099@spearce.org>
References: <87ir5us82a.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 02:01:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbPlg-000200-MT
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 02:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756347AbXI2ABE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2007 20:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756325AbXI2ABD
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 20:01:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55682 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757052AbXI2ABA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Sep 2007 20:01:00 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IbPlx-0001X8-JH; Fri, 28 Sep 2007 20:01:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9E71320FBAE; Fri, 28 Sep 2007 20:00:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87ir5us82a.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59433>

Carl Worth <cworth@cworth.org> wrote:
> I recently "ported" the introductory chapter of Bryan O=E2=80=99Sulli=
van's
> Distributed revision control with Mercurial[1] from mercurial to
> git. The result is here:
>=20
> 	A tour of git: the basics
> 	http://cworth.org/hgbook-git/tour/

Interesting.
=20
>  * Is "git help" actually a builtin thing or just a way to call out t=
o
>    "man"? Does it work at all in Windows ports of git, for example?
>    (OK, so that one's just a question, not an issue it git)

`git help` with no arguments displays a message compiled into git.
`git help init` runs `man git-init`.  If you don't have any manual
pages installed, or if they aren't available to your man installation
then it fails with "No manual entry for git-init" or whatever your
local man implementation dumps.

Brett Schwartz started an asciidoc viewer for Tcl/Tk that I am still
playing around with and trying to get working right in git-gui.
In theory one could use that to display the manual right from the
asciidoc files, thus bypassing the need for asciidoc and xmlto.

On Cygwin we have man, so `git help init` (or `git init --help`) work
just fine to display the manual entry.  No idea about the MSYS port.
=20
>   * The output from a git-clone operating locally is really confusing=
:
>=20
> 	$ git clone hello hello-clone
> 	Initialized empty Git repository in /tmp/hello-clone/.git/
> 	0 blocks
>=20
>     Empty? Didn't I just clone it? What does "0 blocks" mean?

Yea.  That's because we realized its on the local disk and used
`cpio` with hardlinks to copy the files.  So cpio says it copied
0 blocks as it actually just hardlinked everything for you.  No
data was actually copied.

git-gui's new clone UI uses fancy progress meters here and tries
to shield the user from "plumbing and UNIX tools" spitting out
seemingly nonsense messages.  We probably should try harder in
git-clone to do the same here.
=20
>   * git-log by default displays "Date" that is the author date, but
>     also only uses committer date for options such as --since. This i=
s
>     confusing.

I've never thought about that.  But when you say it I think its very
obvious that it could be confusing to a new user.  Maybe we should
show the committer line and its date if it doesn't match the author
name/date.  Usually I don't care who committed a change in git.git
(its a very small handful of people that Junio pulls from directly)
but at day-job committer name is usually just as interesting as
the author name *when they aren't the same*.

>   * There's a ton of extraneous output from git-fetch. I would love t=
o
>     see it reduced to a single-line progress bar, (even if a
>     multiple-staged progress bar). I'm imagining a final line
>     something like:
>=20
> 	Computing (100%) Transferring (100%)
>=20
>     But you can imagine more accurate words than those, (I'm not even
>     sure what all of the things mean that git-fetch is currently
>     reporting progress on).

Yea.  About half of that output is from pack-objects and either
unpack-objects or index-pack.  The other part is from git-fetch
itself as it updates the local tracking branches (if any are to be
updated).  Now that git-fetch is in C and reasonably stable maybe
I can look into making this prettier.  Few people really grok the
pack-objects/index-pack output, nor do they care.  They just want
to know two things:

  - Is git working or frozen in limbo?
  - Is git frozen because my network sucks, or git sucks?
  - When will this be done?  Please $DIETY, I want to go home!
    Make the fetch finish!

The C based git-fetch made the http protocol almost totally silent.
(No more got/walk messages.)  But that's actually also bad as it
now doesn't even let you know its transferring anything at all.

There are serious issues here about getting the user the progress
they really want.  The last item ("When will this be done?") is
actually not possible to determine under either the native git
protocol or HTTP/FTP.  We have no idea up front how much data must
be transferred.  In the native git case we do know how many objects,
but we don't know how many bytes that will be.  It could be under
a kilobyte in one project.  That same object count for a different
set of objects fetch could be 500M.  Radically different transfer
times would be required.
=20
--=20
Shawn.
