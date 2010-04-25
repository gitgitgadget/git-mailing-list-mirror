From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 05/15] diff-test_cmp.patch
Date: Sun, 25 Apr 2010 03:38:43 -0500 (CDT)
Message-ID: <20100316084302.GB26540@thor.il.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054321.668397000@mlists.thewrittenword.com>
 <7veijkohpe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 10:38:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5xMY-0006s6-Sw
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 10:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914Ab0DYIiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 04:38:46 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:54365 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0DYIip (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 04:38:45 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 917FE5CC0
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:59:46 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 917FE5CC0
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 2F44B9A4
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:38:44 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id DD47C57C; Sun, 25 Apr 2010 03:38:43 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7veijkohpe.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145726>

Hi Junio,

Thanks for the reviews.

On Tue, Mar 16, 2010 at 12:21:01AM -0700, Junio C Hamano wrote:
> "Gary V. Vaughan" <git@mlists.thewrittenword.com> writes:
> 
> > Index: b/t/t0000-basic.sh
> > ===================================================================
> > --- a/t/t0000-basic.sh
> > +++ b/t/t0000-basic.sh
> > @@ -280,7 +280,7 @@ $expectfilter >expected <<\EOF
> >  EOF
> >  test_expect_success \
> >      'validate git diff-files output for a know cache/work tree state.' \
> > -    'git diff-files >current && diff >/dev/null -b current expected'
> > +    'git diff-files >current && test_cmp current expected >/dev/null'
> 
> The original says "compare ignoring whitespace changes" but the updated
> one says "they must match literally".  Is this conversion safe?

Not all diff implementations support the '-b' option, unfortunately.

This change doesn't cause any regressions, at least the test suite
continues to report success on the architectures where running it is
safe (i.e. Linux and Solaris 8+).

> For the purpose of debugging tests, I think it would be better to lose the
> redirection into /dev/null.  If the test passes, we wouldn't see anything
> anyway, and if the test fails, we would see what's different, and that
> helps diagnosing the breakage.  For systems with implementations of diff
> that is "-u" challenged, we could define test_cmp in terms of "diff -c"
> instead of "cmp".

Agreed.  For all the hosts I have access to, diff -c is always
available.

> > Index: b/t/t9400-git-cvsserver-server.sh
> > ===================================================================
> > --- a/t/t9400-git-cvsserver-server.sh
> > +++ b/t/t9400-git-cvsserver-server.sh
> > @@ -226,7 +226,7 @@ test_expect_success 'gitcvs.ext.enabled 
> >    'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
> >     GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false &&
> >     GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
> > -   diff -q cvswork cvswork2'
> > +   test_cmp cvswork cvswork2' >/dev/null
> 
> If the -q in the original really matters, then please add the redirection
> to /dev/null only for test_cmp; never redirect the output from the entire
> test_expect_success.

Don't worry, I didn't do that:

 $ echo 'test_expect_success' &&
 > echo 'test_cmp' >/dev/null
 test_expect_success

> On the other hand, if -q does not matter the outcome
> of the test, simply lose the "quiet".  We really should not care, and make
> sure it is available easily to people who broke cvsserver and need to see
> the difference between expected and actual results while debugging.
> 
> There are similar dubious conversions in your patch to this file.

I'd be even happier to see the >/dev/null redirections dropped if the
patch is pushed.  Part of the reason I didn't invest too much effort
into debugging the massive testsuite failures everything but Linux and
Solaris 8+ is because it's too difficult to find out why a particular
test actually failed.

> > Index: b/t/Makefile
> > ===================================================================
> > --- a/t/Makefile
> > +++ b/t/Makefile
> > @@ -6,6 +6,7 @@
> >  -include ../config.mak
> >  
> >  #GIT_TEST_OPTS=--verbose --debug
> > +GIT_TEST_CMP ?= $(DIFF)
> 
> If this forces plain diff not more readable "diff -u" to everybody, that
> sounds like a regression to me.

It does, because "diff -u" is not portable.

A more comprehensive patch might run a configure test to see whether
-u is supported, and then fallback first to "${ac_cv_prog_DIFF} -c",
or if that breaks too, finally settle on "cmp".  And then we'd have to
set matching defaults in Makefile.

I'm afraid I don't have time to help with that, since the testsuite is
so very broken on nearly all of our architectures.  I'll post some
examples presently.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
