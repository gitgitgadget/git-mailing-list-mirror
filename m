From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 06/16] diff-test_cmp.patch
Date: Wed, 28 Apr 2010 09:00:46 +0000
Message-ID: <20100428090045.GD36271@thor.il.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <20100427135833.403548000@mlists.thewrittenword.com>
 <20100427171531.GA15553@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 11:00:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O738X-0006AE-PG
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 11:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564Ab0D1JAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 05:00:48 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:55675 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab0D1JAq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 05:00:46 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 0BDC65C48;
	Wed, 28 Apr 2010 09:21:56 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 0BDC65C48
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 2A390AB6;
	Wed, 28 Apr 2010 09:00:46 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 1B53BBAB5; Wed, 28 Apr 2010 09:00:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100427171531.GA15553@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145978>

On Tue, Apr 27, 2010 at 12:15:52PM -0500, Jonathan Nieder wrote:
> Hi,
> 
> Gary V. Vaughan wrote:
> 
> > Subject: diff-test_cmp.patch
> >
> > In tests, call test_cmp rather than raw diff where possible (i.e. if
> > the output does not go to a pipe), to allow the use of, say, 'cmp'
> > when the default 'diff -u' is not compatible with a vendor diff.
> > 
> > When that is not possible, use $DIFF, as set in GIT-BUILD-OPTIONS.
> 
> Sign-off?  (See SubmittingPatches for what I am asking about here.)

Ah, okay.  I didn't read carefully enough. Sorry.

Can I add a Sign-off message to each patch subthread?  Or do you need
me to resubmit the entire series?

> And is it possible to change your mailing script to use more
> meaningful subject lines?

Sure.  What is preferable?  As short a sentence summarising the fixed
issue as I can muster? (Like SuSE Linux, we use quilt to manage and
submit our patch stacks... git seems to require hosting the entire
history of each project which is too heavyweight for the 1000's of
packages we build - if git provides the means to store just the head
of an upstream release branch along with our patch stacks on local
disk, I would love to be proven wrong here).

> This patch makes a good change, but I do not think your description
> captures it.  Most of the changes are from ???diff???, not from ???diff -u???.
> Is your bare ???diff??? really incapable of distinguishing between
> identical and differing files?

A good point, thanks.  I think the scope has crept since I first
started applying such a patch to earlier releases of git in our
package tree.

> But using test_cmp consistently would make debugging test scripts
> with -v much easier, since the output is more readable.
> 
> > --- a/t/t0000-basic.sh
> > +++ b/t/t0000-basic.sh
> > @@ -280,7 +280,7 @@ $expectfilter >expected <<\EOF
> >  EOF
> >  test_expect_success \
> >      'validate git diff-files output for a know cache/work tree state.' \
> > -    'git diff-files >current && diff >/dev/null -b current expected'
> > +    'git diff-files >current && test_cmp current expected >/dev/null'
> 
> The original ignores whitespace changes; this version does not.  It
> turns out that???s okay, but it???s worth mentioning in the commit
> message.  (I think we do guarantee that diff-files will not change the
> whitespace it produces without good reason.)

Okay, I'll rewrite the patch headers where they have bit-rotted.
Maybe in combination with the missing Signed-off-by: headers and
unsuitable Subject headers I need to amend and resubmit the whole
patch series again?

> The original suppressed its output, without any good reason to.  Could
> you remove the >/dev/null while at it, to make it easier to debug?
> 
> > --- a/t/t4124-apply-ws-rule.sh
> > +++ b/t/t4124-apply-ws-rule.sh
> > @@ -44,7 +44,7 @@ test_fix () {
> >  	apply_patch --whitespace=fix || return 1
> >  
> >  	# find touched lines
> > -	diff file target | sed -n -e "s/^> //p" >fixed
> > +	$DIFF file target | sed -n -e "s/^> //p" >fixed
> >  
> >  	# the changed lines are all expeced to change
> >  	fixed_cnt=$(wc -l <fixed)
> 
> Is this needed?  I don???t mind it, just curious.

Probably not, though I prefer the consistency rather than having to
consider diff vs $DIFF at every occurence.  libtool has had numerous
silly bugs tickled by making the wrong choice between echo, $echo,
$lt_echo and $ECHO in rarely exercised corners of the code.

> I hope some earlier patch takes care of setting DIFF in test-lib.sh.
> Tests need to be usable without running them through the makefile.

Unfortunately, that is not the case in 7.1.1.  This is it:

GIT_TEST_CMP=${GIT_TEST_CMP:-diff -u}

The obvious fix would be to use:

: ${DIFF=@DIFF@}
: ${GIT_TEST_CMP=@DIFF@ -u}

And substitute at configure time.  Makefile only builds will require
additional support though.

> > --- a/t/Makefile
> > +++ b/t/Makefile
> > @@ -6,10 +6,14 @@
> >  -include ../config.mak
> >  
> >  #GIT_TEST_OPTS=--verbose --debug
> > +GIT_TEST_CMP ?= $(DIFF)
> >  SHELL_PATH ?= $(SHELL)
> >  TAR ?= $(TAR)
> >  RM ?= rm -f
> >  
> > +# Make sure test-lib.sh uses make's value of GIT_TEST_CMP
> > +export GIT_TEST_CMP
> > +
> >  # Shell quote;
> >  SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
> 
> If neither DIFF nor GIT_TEST_CMP is already set, this will export
> GIT_TEST_CMP as the empty string.  Will t/test-lib.sh treat that as
> asking for the default?  Yes --- phew.

That change was just added to my patch yesterday, to fix the massive
testsuite failures I had previously experienced.

>   Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Much appreciated!

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
