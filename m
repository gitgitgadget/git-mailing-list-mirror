From: Jeff King <peff@peff.net>
Subject: Re: sh -x -i -v with continuous integration, was Re: [PATCH 1/4]
 t7601: test for pull.ff=true overrides merge.ff=false
Date: Sat, 16 May 2015 11:28:58 -0400
Message-ID: <20150516152858.GA19269@peff.net>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
 <1431510740-9710-2-git-send-email-pyokagan@gmail.com>
 <2a5e49ff1cc3a0275e09328a3ad07866@www.dscho.org>
 <xmqqy4kr85wg.fsf@gitster.dls.corp.google.com>
 <81926313e0a131cd7224f0f6f8984dd2@www.dscho.org>
 <xmqqh9rf84we.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 16 17:29:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yte1U-00084s-D2
	for gcvg-git-2@plane.gmane.org; Sat, 16 May 2015 17:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061AbbEPP3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2015 11:29:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:59638 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754074AbbEPP3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2015 11:29:03 -0400
Received: (qmail 6225 invoked by uid 102); 16 May 2015 15:29:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 16 May 2015 10:29:02 -0500
Received: (qmail 11830 invoked by uid 107); 16 May 2015 15:29:02 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 16 May 2015 11:29:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 May 2015 11:28:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9rf84we.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269197>

On Thu, May 14, 2015 at 10:06:57AM -0700, Junio C Hamano wrote:

> And I would say that "verbose test" is not a useful way to make the
> test output more verbose for Human's sake; GIT_TEST_OPTS="-v -x -i"
> on the other hand is.
> 
> I am very tempted to suggest doing this ;-)
> 
>  t/test-lib-functions.sh | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 0698ce7..c6c67e8 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -638,8 +638,14 @@ test_cmp_bin() {
>  }
>  
>  # Call any command "$@" but be more verbose about its
> -# failure. This is handy for commands like "test" which do
> -# not output anything when they fail.
> +# failure. This may seem handy for commands like "test" which do
> +# not output anything when they fail, but in practice not
> +# very useful for things like 'test "$actual" = "$expect"',
> +# as this only shows the actual values (i.e. after $actual and
> +# $expect are turned into the values in these variables).
> +#
> +# In short, do not add use of this; this is kept only to
> +# avoid having to remove its use (for now).

Sorry, but I completely disagree here (no surprise, as I was the one who
added "verbose").

It's true that it does not tell you the original commands that were
handed to the shell. But neither does the output of "test_cmp". However,
combined with the output of the test code snippet that we already
provide, it is often clear.

E.g., let's "break" a verbose test from the test suite and break it:

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1b2e981..f3206a3 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -113,7 +113,7 @@ test_expect_success 'diff-filter=M' '
 
 	actual=$(git log --pretty="format:%s" --diff-filter=M HEAD) &&
 	expect=$(echo second) &&
-	verbose test "$actual" = "$expect"
+	verbose test "$actual" = "foo-$expect"
 
 '
 

Right now the output is:

    expecting success: 
    
            actual=$(git log --pretty="format:%s" --diff-filter=M HEAD) &&
            expect=$(echo second) &&
            verbose test "$actual" = "foo-$expect"
    
    
    command failed:  'test' 'second' '=' 'foo-second'
    not ok 10 - diff-filter=M

which IMHO is pretty helpful. If we take away the "verbose", we get:

    expecting success: 
    
            actual=$(git log --pretty="format:%s" --diff-filter=M HEAD) &&
            expect=$(echo second) &&
            test "$actual" = "foo-$expect"
    
    
    not ok 10 - diff-filter=M

which leaves you with head-scratching (did log exit non-zero, or did the
comparison fail?). If we add in "-x", we get:

    expecting success: 

            actual=$(git log --pretty="format:%s" --diff-filter=M HEAD) &&
            expect=$(echo second) &&
            test "$actual" = "foo-$expect"
    
    
    + git log --pretty=format:%s --diff-filter=M HEAD
    + actual=second
    + echo second
    + expect=second
    + test second = foo-second
    error: last command exited with $?=1
    not ok 10 - diff-filter=M

That essentially gives us the same data, but with a lot of other cruft.
In this case, I don't think it's too bad (the test isn't that long), but
some of the "-x" cases can get pretty verbose. I guess things are a bit
better since I added the "last command exited..." in red, but I still
think the "verbose" version is the most straightforward.

Do we object to having to sprinkle the "verbose" throughout the test
scripts? IMHO it is not any worse than test_cmp. But if that is a
problem, would it be too magical to do something like:

  test () {
	verbose command test "$@"
  }

(but only inside the test snippets)?

-Peff
