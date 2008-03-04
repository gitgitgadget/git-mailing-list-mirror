From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add test for cloning with "--reference" repo being a
 subset of source repo
Date: Tue, 4 Mar 2008 18:10:25 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803041801320.19665@iabervon.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200803031004.16568.johan@herland.net> <alpine.LNX.1.00.0803031318000.19665@iabervon.org> <200803040402.57993.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 00:11:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWgHw-0008Fh-Lt
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 00:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934304AbYCDXKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 18:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934618AbYCDXKa
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 18:10:30 -0500
Received: from iabervon.org ([66.92.72.58]:60762 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934594AbYCDXK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 18:10:27 -0500
Received: (qmail 23143 invoked by uid 1000); 4 Mar 2008 23:10:25 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Mar 2008 23:10:25 -0000
In-Reply-To: <200803040402.57993.johan@herland.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76153>

On Tue, 4 Mar 2008, Johan Herland wrote:

> On Monday 03 March 2008, Daniel Barkalow wrote:
> > On Mon, 3 Mar 2008, Johan Herland wrote:
> > 
> > > Not sure what's going on here, yet, but I thought I'd give you a heads up.
> > 
> > I figured it out, and pushed out a fix; it was doing everything correctly, 
> > but it wrote to the alternates files after the library had read that file, 
> > so it then didn't notice that it actually had the objects that are in the 
> > second alternate repository.
> 
> Thanks. After looking a bit more at the original test repo where I found
> this issue, I discovered another, similar bug. This one seems ugly; brace
> yourself:
> 
> In some cases (I'm not exactly sure of all the preconditions) when
> cloning with "--reference", it seems git tries to access a loose object
> in the "--reference" repo instead of in the cloned repo, even if that
> object is already present in the cloned repo and _missing_ in the
> "--reference" repo. The symptom is this error message:
>     error: Trying to write ref $ref with nonexistant object $sha1
> 
> After playing around with this in gdb, it seems the problem is all the
> way down in sha1_file_name() (sha1_file.c). This function is responsible
> for generating the loose object filename for a given $sha1. It keeps a
> static char *base which is initially set to the object directory name,
> and then calls fill_sha1_path() to copy the rest of the object filename
> into the following bytes. On subsequent calls, only the fill_sha1_path()
> part is done, thereby reusing the base from the previous invocation.
>
> What I observe is that this base is not reset after accessing loose
> objects in the "--reference" repo. Thus, later when accessing objects in
> the cloned repo, sha1_file_name() generates incorrect filenames (pointing
> to the "--reference" repo instead of the cloned repo).
> 
> Of course, this often goes undetected since the "--reference" repo often
> have the same loose objects as the clone.
> 
> Unfortunately (from a builtin git-clone's POV) this seems to be
> symptomatic of a deeper problem in this part of the code: Using
> function-static variables as caches only works as far as the cache
> is in sync with reality. Especially when switching between multiple
> repositories within the same process, it seems that several of these
> variables are left with invalid data in them. This needs to be fixed,
> if not only for now, then at least as part of the libification effort.
> 
> I'm not sure what is the best way of fixing this issue; my initial guess
> is to move these function-static variables out to file-level, and make
> sure they're properly reset whenever the appropriate context is changed
> (typically when set_git_dir() is called, I guess).

I think we should be able to avoid setting git_dir to anything other than 
the repo we're creating, which would avoid this problem for the present, 
although, as you say, it would be good to be able to switch around as 
instructed for libification purposes eventually.

	-Daniel
*This .sig left intentionally blank*
