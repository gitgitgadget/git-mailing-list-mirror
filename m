From: Hannu Koivisto <azure@iki.fi>
Subject: CRLF support bugs (was: Re: .gitattributes glob matching broken)
Date: Mon, 03 Nov 2008 17:05:24 +0200
Organization: NOYB
Message-ID: <83y700alzf.fsf_-_@kalahari.s2.org>
References: <83od0yaxzk.fsf@kalahari.s2.org>
	<20081103090932.GA18424@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 16:07:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx118-0007Of-Eq
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 16:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895AbYKCPFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 10:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755865AbYKCPFi
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 10:05:38 -0500
Received: from main.gmane.org ([80.91.229.2]:50840 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755824AbYKCPFh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 10:05:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kx0zn-0005fc-I5
	for git@vger.kernel.org; Mon, 03 Nov 2008 15:05:35 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 15:05:35 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 15:05:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:JuoyLxJ0K4mDjOFOWxCpRRLO/Gc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99951>

Jeff King <peff@peff.net> writes:

> I think your analysis is incorrect. I will try to explain what is
> happening.

Yes, you are right.  The behaviour I saw in my actual use case was
so odd that I got completely confused.

I suspect one part of that "oddness" was caused by git applying its
heuristics in checkout as it doesn't use .gitattributes at that
time.  For example, it seems that it recognized some of my .sh
files as text files and the rest as binary files.  I suppose I was
correct to assume that it would be stupid to rely on git guessing
file type and the only sensible way is to use .gitattributes.  If
it was supported in checkout too, that is.

I don't know what purpose the autodetection aims to serve but I'd
add a big warning in the core.autocrlf documentation about it and
instructions on how to configure things so that it is never applied
but instead the types must always be specified explicitly.

> The problem, again, is that we have inconsistently applied the
> gitattributes. They were _not_ applied during checkout (because
> .gitattributes did not exist yet), but they _are_ being applied here.
>
> To "fix" this, you can then do a "git reset --hard" which will respect
> your .gitattributes (since it is now checked out). And further file
> creation and checkout should work OK.

Since I'm trying to launch git in a company environment, I think I
can't rely on people remembering to do that.

Actually, even if .gitattributes were applied in checkout, I think
the whole CRLF support is broken by design because people will have
to remember to use -n in clone, then enable core.autocrlf support
and then checkout.  This makes it unneccessarily complicated to
create "quick local clones" as well.  You might suggest that
Windows users should enable core.autocrlf globally but it may not
be the right thing to do for all projects/repositories either.

I think CRLF conversion support should have some attribute (be it
.gitattributes attribute or something else) that is somehow
inherited from the parent repository.  It would basically say that
"you should use platform's native line end type for text files with
this repository and its children".  To go with that, one would
maybe have a configuration option to tell what that platform
default line end type is (just in case someone wants to pretend
Cygwin is Unix or something like that).

I also observed this problem:

# Pretend someone does this on Unix
mkdir test1
cd test1
git init
echo "*.c crlf" > .gitattributes
echo -en "foo\r\nfoo\r\nfoo\r\n" > kala.c
git add .gitattributes kala.c
git commit -m "* Initial checkin."
cd ..
# Pretend someone else does this on Windows
git clone -n test1 test2
cd test2
git config core.autocrlf true
git checkout
git status

...
#       modified:   kala.c
...

git reset --hard
git status
...
#       modified:   kala.c
...

Now, even if .gitattributes were obeyed by checkout, I suspect the end
result would be the same(?)  I'm sure someone argues that this makes
sense.  But try to put yourself in the position of a random Window
user.  I think it's far from obvious what is going on and what
should be done in this situation.

-- 
Hannu
