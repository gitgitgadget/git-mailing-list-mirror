From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCHv2] clone: support cloning full bundles
Date: Wed, 27 Feb 2008 18:48:55 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802271846180.19665@iabervon.org>
References: <1203934349-12125-1-git-send-email-sbejar@gmail.com>  <7v63waqasu.fsf@gitster.siamese.dyndns.org>  <8aa486160802271504r7744422ag290b1f4d1725210f@mail.gmail.com> <8aa486160802271516h7c2c636dna3a9f067fc51da2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-140187807-1204156135=:19665"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 00:49:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUW1u-00076i-7i
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 00:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbYB0XtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 18:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbYB0XtE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 18:49:04 -0500
Received: from iabervon.org ([66.92.72.58]:47806 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939AbYB0XtC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 18:49:02 -0500
Received: (qmail 12978 invoked by uid 1000); 27 Feb 2008 23:48:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2008 23:48:55 -0000
In-Reply-To: <8aa486160802271516h7c2c636dna3a9f067fc51da2@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75326>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-140187807-1204156135=:19665
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 28 Feb 2008, Santi Béjar wrote:

> On Thu, Feb 28, 2008 at 12:04 AM, Santi Béjar <sbejar@gmail.com> wrote:
> >
> > On Wed, Feb 27, 2008 at 11:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >  > Santi Béjar <sbejar@gmail.com> writes:
> >  >
> >  >  > Signed-off-by: Santi Béjar <sbejar@gmail.com>
> >  >
> >  > > diff --git a/git-clone.sh b/git-clone.sh
> >  >  > index 0d686c3..2efb947 100755
> >  >  > --- a/git-clone.sh
> >  >  > +++ b/git-clone.sh
> >  >  > @@ -210,11 +210,14 @@ if base=$(get_repo_base "$repo"); then
> >  >  >       then
> >  >  >               local=yes
> >  >  >       fi
> >  >  > +elif [ -f "$repo" ] ; then
> >  >  > +     case "$repo" in /*);; *) repo="$PWD/$repo" ; esac
> >  >  >  fi
> >  >  >
> >  >  >  dir="$2"
> >  >  >  # Try using "humanish" part of source repo if user didn't specify one
> >  >  >  [ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
> >  >  > +[ -f "$dir" ] && dir=$(expr "$repo" : '.*/\([^/]*\)\.[^/]*')
> >  >  >  [ -e "$dir" ] && die "destination directory '$dir' already exists."
> >  >  >  [ yes = "$bare" ] && unset GIT_WORK_TREE
> >  >  >  [ -n "$GIT_WORK_TREE" ] && [ -e "$GIT_WORK_TREE" ] &&
> >  >
> >  >  What is this [ -f "$dir" ] line doing?  The purpose of these
> >  >  lines is:
> >  >
> >  >   - The user (might have) said "clone to $2";
> >  >
> >  >   - If the user didn't, then set dir to humanish part;
> >  >
> >  >   - If that exists, we barf.
> >  >
> >  >  I do not see any valid reason for an additional logic in this
> >  >  sequence when adding a new clone _source_ type.
> >  >
> >  >  The check to see if "$dir" _exists_ is even worse.  If the user
> >  >  said "clone _to_ this", then we would not have invented $dir
> >  >  based on the $repo (which is what the user said "clone _from_")
> >  >  but used whatever name the user has given us.  The existing
> >  >  check to barf "Hey, that explicit location you told me to clone
> >  >  to is WRONG!!!" should not be broken.
> >  >
> >
> >  Oops, I did not thought about that possibility. The check was to be
> >  able to clone a bundle that was in the local directory. So:
> >
> >  $ git clone git.bundle
> >
> >  clones git.bundle to the directory git. Maybe we can add an && in the
> >  previous line
> 
> and check for [ -f "$repo" ] insted of [ -f "$dir" ]
> 
> >  , or we can say simply that to clone a bundle in the same
> >  directory you have to specify explicitly where to clone.
> >
> >  In another patch we could add an "official" extension to the bundles
> >  (the same way as with the repositories "*.git") as project.bdl or
> >  project.bundle and just remove this extension.
> 
> My preference are in order:
> 
> 1) define an official extension + the && [ -f "$repo" ]
> 2) the && [ -f "$repo"]
> 3) just remove this line
> 
> but not that strong.

The transport.c determination of a bundle is if it's a local path that 
names a file, so [ -f "$repo" ] is the corresponding test.

	-Daniel
*This .sig left intentionally blank*
--1547844168-140187807-1204156135=:19665--
