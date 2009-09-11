From: Jeff King <peff@peff.net>
Subject: Re: bash_completion outside repo
Date: Fri, 11 Sep 2009 17:12:09 -0400
Message-ID: <20090911211209.GA26527@coredump.intra.peff.net>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
 <20090911133313.GF2582@inocybe.localdomain>
 <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
 <20090911141730.GA384@coredump.intra.peff.net>
 <20090911143651.GE1033@spearce.org>
 <20090911150934.GB977@coredump.intra.peff.net>
 <20090911164730.GA21536@coredump.intra.peff.net>
 <7viqfpw6tv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	james bardin <jbardin@bu.edu>, Todd Zullinger <tmz@pobox.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 23:12:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmDPq-0006P8-IC
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 23:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835AbZIKVMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 17:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756831AbZIKVMM
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 17:12:12 -0400
Received: from peff.net ([208.65.91.99]:39853 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756827AbZIKVMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 17:12:12 -0400
Received: (qmail 9167 invoked by uid 107); 11 Sep 2009 21:12:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 11 Sep 2009 17:12:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Sep 2009 17:12:09 -0400
Content-Disposition: inline
In-Reply-To: <7viqfpw6tv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128220>

On Fri, Sep 11, 2009 at 01:43:24PM -0700, Junio C Hamano wrote:

> While I also agree that EACCESS and other failures should be treated as
> fatal in principle for safety, e.g. when running prune without being able
> to read gc.pruneExpire as you mentioned, we would need a tradeoff between
> safety and convenience.  When asked to help looking at a complex merge in
> a colleages' repository, do you want your "git diff" to refuse to run only
> because her .git/config cannot be read by you?  Of course, you _can_ work

Sorry, I think I was a bit unclear in the original message. There are
two classes of errors right now:

  1. access(fn, R_OK) != 0 (i.e., ENOENT and EACCESS)

  2. fopen(fn, "r") != 0

In the case of (1), we treat it as an empty file (except in the case
that _all_ files fail (1), in which case we reported an error, which is
really stupid and is what this patch fixes).

In the case of (2), we treat it as an error, but because nobody actually
bothers to check the error code, it is effectively ignored. What I was
thinking is that (2) should be promoted to die(), and leave (1) as-is.

So I think in your example it would fall under (1), and we both agree
that should be allowed.

But:

> Also there was a move going in the opposite direction to allow a config
> file that is syntactically broken to be handled without the parser dying,
> primarily to help "git config -e".  In the longer term, our direction
> shouldn't be adding more die() in the git_config() callchain, but instead
> allowing it to report different kind of failures to let the caller act
> based on what it does and what the nature of failure is.

Yeah, that is the opposite of what I proposed above. But it is a step
towards lib-ifying the config code, which is probably a good thing. The
config code is an utter mess. I am a little hesitant to touch it just
because I don't think there is anything _broken_ in it exactly, but
every time I look at it, I am always shocked by how unnecessarily
complex it is.

I think the "right" thing to do would probably be to have a lib-ified
function to read the config, and then have a wrapper that 99% of the
programs use that just checks the error return and calls die() if there
is a problem. But such a cleanup is likely to introduce new bugs, so I
have let it be (also, because my time is not infinite and there are
other more interesting things to work on ;) ).

> For example, "gc" may say "I won't prune because I had to skip some of the
> lines in your .git/config because you have syntax errors in them, and I
> may have missed the definition of gc.pruneExpire you may wanted to place
> on them", while "diff" may ignore that kind of errors.

Yeah, that makes sense to me, and should be possible with a decent
lib-ified interface.

> Having said all that, my preference *for now* would be to ignore "there is
> no $HOME/.gitconfig (or /etc/gitconfig) file", but catch all other errors
> and die().

OK, then I think we are on the same page.

> There are some other glitches in the current git_config() callchain.
> 
>  - No config file anywhere gives an error.  I agree with you that this is
>    a bug.

Yep, and this patch fixes that.

>  - Having GIT_CONFIG=/no/such/file in the environment gives an error,
>    which is good.

Yep, and and this patch should leave that untouched (I didn't test that
specifically, but I checked that "git config --global" does, and I
assume they use the same code path. Of course, one never knows...).

> A possible longer term solution would be to:
> 
>  - Change the signature of callbacks (e.g. git_default_branch_config()) so
>    that they return void.  They are not allowed to report any semantic
>    errors while parsing.
> 
>  - Instead, they use special "INVALID" value and store that when they see
>    a semantically incorrect value.  They may also want to store what the
>    actual string the config file gave them for later reporting, together
>    with the name of and the line number in the config file for diagnostic
>    purposes.
> 
>  - The user of the internalized value (i.e. "git grep git_branch_track"
>    shows there are only two, cmd_branch() and cmd_checkout()) must check
>    for the above INVALID value before they use the variable, and die at
>    the point of the use.

That all makes sense to me. My biggest worry is that we will need to be
checking for "INVALID" values in lots of places before actually using
the value from a variable. IOW, it is nice for code to be able to call
into some library call that respects a config variable without having to
care about doing some magic setup to say "Oh, by the way, I am
interesting in the value of diff.foo". At the same time, it is nice for
the library code to not have to say "We're using diff.foo. Let's make
sure somebody has checked the value before using it."

In other words, I would like not-too-syntactically-painful lazy values.
With no runtime overhead. In C. ;)

-Peff
