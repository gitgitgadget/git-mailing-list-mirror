From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add valgrind support in test scripts
Date: Wed, 21 Jan 2009 01:41:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901210130030.19014@racer>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 01:42:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPRB7-0004RF-85
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 01:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761457AbZAUAlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 19:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757596AbZAUAlE
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 19:41:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:45545 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757216AbZAUAlB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 19:41:01 -0500
Received: (qmail invoked by alias); 21 Jan 2009 00:40:59 -0000
Received: from pD9EB302D.dip0.t-ipconnect.de (EHLO noname) [217.235.48.45]
  by mail.gmx.net (mp015) with SMTP; 21 Jan 2009 01:40:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HbZVy9omHUXZVh/jJRnVNCzTRvjbgDQeaZW/D2J
	rMuTl99+iS4284
X-X-Sender: gene099@racer
In-Reply-To: <20090121001219.GA18169@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106551>

Hi,

On Tue, 20 Jan 2009, Jeff King wrote:

> On Tue, Jan 20, 2009 at 04:04:28PM +0100, Johannes Schindelin wrote:
> 
> > +else
> > +	# override all git executables in PATH and TEST_DIRECTORY/..
> > +	GIT_VALGRIND=$TEST_DIRECTORY/valgrind
> > +	mkdir -p "$GIT_VALGRIND"
> 
> Isn't this mkdir unnecessary, since it is actually part of the
> repository (i.e., there is a gitignore there already).
> 
> However, I think it makes more sense to put the symlink cruft into
> "$GIT_VALGRIND/bin". That way you can clean up the cruft very easily. In
> which case you do need to "mkdir" that directory.

Hmm. I actually liked the hierarchy to be shallow, but I could be 
convinced...

> > +	OLDIFS=$IFS
> > +	IFS=:
> > +	for path in $PATH:$TEST_DIRECTORY/..
> > +	do
> > +		ls "$TEST_DIRECTORY"/../git "$path"/git-* 2> /dev/null |
> 
> Why aren't these both "$path"/ ?

Yeah.  Makes it more readable, doesn't it?

> But more importantly, do we really need to bother overriding the whole 
> $PATH? In theory, we aren't calling anything git-* that isn't in 
> "$TEST_DIRECTORY/..". And while it might be nice to catch it if we do, 
> it seems like detecting that is totally orthogonal to running valgrind, 
> and we get different behavior from valgrind versus not. And I think the 
> two should be as similar as possible (with the obvious except of 
> actually, you know, running valgrind).

Actually, the two _are_ orthogonal from the technical viewpoint.

But with the infrastructure we have in place, it was already very easy to 
make sure that calls to a Git program we no longer ship are caught.

I vividly remember such a bug costing me 3 hours of my life, and a few 
hairs.

So I think "as it's already _that_ easy, we should catch them bugs, too".

Needs some documentation though, I agree.

> > +			base=$(basename "$file")
> > +			test ! -h "$GIT_VALGRIND"/"$base" || continue
> > +
> > +			if test "#!" = "$(head -c 2 < "$file")"
> > +			then
> > +				# do not override scripts
> > +				ln -s ../../"$base" "$GIT_VALGRIND"/"$base"
> > +			else
> > +				ln -s valgrind.sh "$GIT_VALGRIND"/"$base"
> > +			fi
> 
> It would be nice to actually detect errors. But you have to
> differentiate between EEXIST and other errors, which is a pain. And you
> can't use "ln -sf" because it isn't atomic.

I really would not care all that much about that.  
'GIT_TEST_OPTS==--valgrind make test' should be run by experts.  And even 
if it is a dummy driving the test, the next "make" call should take care 
of that.

> Copying would solve that (provided you copied to a tempfile and did
> an atomic rename). Or writing this snippet as a C helper.

Nah, that is really too much work for such a rare thing.  Think about it.  
The symlinks are set up once.  And even if you do that with -j50, there is 
hardly a chance that two processes conflict with each other, and even if 
they do, they do the same thing.

No, what I really want to fix is a script being replaced by a binary.

> > --- /dev/null
> > +++ b/t/valgrind/valgrind.sh
> > @@ -0,0 +1,12 @@
> > +#!/bin/sh
> > +
> > +base=$(basename "$0")
> > +
> > +exec valgrind -q --error-exitcode=126 \
> > +	--leak-check=no \
> > +	--suppressions="$GIT_VALGRIND/default.supp" \
> > +	--gen-suppressions=all \
> > +	--log-fd=4 \
> > +	--input-fd=4 \
> > +	$GIT_VALGRIND_OPTIONS \
> > +	"$GIT_VALGRIND"/../../"$base" "$@"
> 
> Hm. My version had to do some magic with the GIT_EXEC_PATH, but I think
> that is because I didn't set GIT_EXEC_PATH in the first place. If yours
> works (and I haven't really tested it -- I remember it being a real pain
> in the butt to make sure valgrind was getting called from every code
> path), then I like your approach much better.

I set GIT_EXEC_PATH... to $GIT_VALGRIND.

Ciao,
Dscho
