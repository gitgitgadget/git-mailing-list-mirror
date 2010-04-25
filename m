From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [PATCH 2/5] Not all vendor diffs support GNUisms (resend)
Date: Sun, 25 Apr 2010 03:35:10 -0500 (CDT)
Message-ID: <20100315050943.GA22128@thor.il.thewrittenword.com>
References: <20100311163039.GB7877@thor.il.thewrittenword.com>
 <4B994324.9060400@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ren? Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Apr 25 10:36:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5xKA-0005sU-Ck
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 10:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323Ab0DYIfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 04:35:14 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:56792 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0DYIfL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 04:35:11 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id E52985CEC
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:56:12 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com E52985CEC
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 658709A4
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:35:10 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 1820257C; Sun, 25 Apr 2010 03:35:10 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <4B994324.9060400@lsrfire.ath.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145721>

Hi Rene,

Thanks for the review.  I'll respond to your comments in this thread,
but will repost my whole patch series separately later on.

On Thu, Mar 11, 2010 at 08:23:16PM +0100, Ren? Scharfe wrote:
> Am 11.03.2010 17:30, schrieb Gary V. Vaughan:
> > Some of the flags used with the first diff found in PATH cause the
> > vendor diff to choke.
> > 
> > This patch allows us to replace the problematic diff calls in our
> > build script as follows:
> > 
> >   if [ "${SB_VAR_DIFFUTILS+set}" = set ]; then
> >     ${SB_PATH_SED} -i -e "\
> > s|@DIFF@|${SB_VAR_DIFFUTILS}/bin/gnudiff|g;" \
> >     $(find . -type f -exec ${SB_PATH_EGREP} -l '@DIFF@' {} \;)
> >   else
> >     ${SB_PATH_SED} -i -e "\
> > s|@DIFF@|diff|g;" \
> >     $(find . -type f -exec ${SB_PATH_EGREP} -l '@DIFF@' {} \;)
> >   fi
> > 
> > This is fine for us, but upstream it would be better to search
> > the execution path for a diff that has all the required features at
> > configure time, and to do the substitutions at that time.  This is
> > what the latest version of quilt does if an example is useful.
 
> This patch doesn't seem to add this conversion to git's own build script
> (Makefile).  That means the patched scripts now call a command named
> "@DIFF@", which probably doesn't exist on most systems.

Indeed.  At TWW the substitution is done by our build recipe as quoted
above (admittedly, not too useful for everyone else).

> > diff --git a/Documentation/install-webdoc.sh b/Documentation/install-webdoc.sh
> > index 2135a8e..329d052 100755
> > --- a/Documentation/install-webdoc.sh
> > +++ b/Documentation/install-webdoc.sh
> > @@ -12,7 +12,7 @@ do
> >  	then
> >  		: did not match
> >  	elif test -f "$T/$h" &&
> > -	   diff -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "$h"
> > +	   @DIFF@ -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "$h"
> >  	then
> >  		:; # up to date
> >  	else
> 
> For build scripts I think it makes sense to do the same for diff as for
> tar, namely to define and export it in Makefile (run "git grep -w TAR"
> to see what I mean).

Agreed, and thanks for the tip, I hadn't noticed the precedent.

> > diff --git a/contrib/hooks/setgitperms.perl b/contrib/hooks/setgitperms.perl
> > index a577ad0..c45ab0d 100644
> > --- a/contrib/hooks/setgitperms.perl
> > +++ b/contrib/hooks/setgitperms.perl
> > @@ -180,7 +180,7 @@ elsif ($read_mode) {
> >  	    rename "$gitmeta.tmp", $gitmeta;
> >  	}
> >  	else {
> > -	    my $diff = `diff -U 0 $gitmeta $gitmeta.tmp`;
> > +	    my $diff = `@DIFF@ -U 0 $gitmeta $gitmeta.tmp`;
> >  	    if ($diff ne '') {
> >  		rename "$gitmeta.tmp", $gitmeta;
> >  	    }
> 
> I'm not sure the files in contrib/ should be changed at all, as they are
> not touched by Makefile.

Fair enough.  However, diff -U is not at all portable unless you have
GNU diff first in your path.

> > --- a/git-merge-one-file.sh
> > +++ b/git-merge-one-file.sh
> > @@ -28,6 +28,8 @@ then
> >  	exit 1
> >  fi
> >  
> > +DIFF="@DIFF@"
> > +
> >  case "${1:-.}${2:-.}${3:-.}" in
> >  #
> >  # Deleted in both or deleted in one and unchanged in the other
> > @@ -107,7 +109,7 @@ case "${1:-.}${2:-.}${3:-.}" in
> >  		# remove lines that are unique to ours.
> >  		orig=`git-unpack-file $2`
> >  		sz0=`wc -c <"$orig"`
> > -		diff -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
> > +		$DIFF -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
> >  		sz1=`wc -c <"$orig"`
> >  
> >  		# If we do not have enough common material, it is not
> 
> Why does this one use $DIFF unlike the others?
> 
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 1a26843..037bc15 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -1592,7 +1592,7 @@ sub find_file_type_and_diff_status {
> >  	return ('dir', '') if $path eq '';
> >  
> >  	my $diff_output =
> > -	    command_oneline(qw(diff --cached --name-status --), $path) || "";
> > +	    command_oneline(qw(@DIFF@ --cached --name-status --), $path) || "";
> >  	my $diff_status = (split(' ', $diff_output))[0] || "";
> >  
> >  	my $ls_tree = command_oneline(qw(ls-tree HEAD), $path) || "";
> 
> The changed line calls git-diff, not diff; you should keep it as it is.

Okay, thanks.

> > diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
> > index 0241329..0330f13 100755
> > --- a/t/t1002-read-tree-m-u-2way.sh
> > +++ b/t/t1002-read-tree-m-u-2way.sh
> > @@ -215,7 +215,7 @@ test_expect_success \
> >       if cmp M.sum actual14a.sum; then false; else :; fi &&
> >       check_cache_at nitfol clean &&
> >       echo nitfol nitfol >nitfol1 &&
> > -     diff nitfol nitfol1 &&
> > +     @DIFF@ nitfol nitfol1 &&
> >       rm -f nitfol1'
> 
> Here and for most of the rest of the test scripts using test_cmp
> (defined in test-lib.sh) instead of diff directly would be better.
> 
> test_cmp calls the command in $GIT_TEST_CMP.  For your OS, you could set
> it to "cmp" in Makefile instead of the default "diff -u".
> 
> (That also means that test_cmp should only be used in places where the
> output is discarded or displayed, not piped into another command which
> might expect a certain diff format.)

Agreed.

> However, if there are no command line switches given to diff but only
> two files, do you need to change anything at all?  Every diff
> implementation should be able to handle that, right?
> 
> [Lots of test script changes snipped.]

There are a ton of these, so I probably did the substitution with a
sed script, and then tested to make sure the testsuite didn't regress,
rather than manually checking and substituting on a case by case
basis like I did in the other parts of the patch.

> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index a0e396a..cd2c886 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -59,7 +59,7 @@ export GIT_MERGE_VERBOSITY
> >  export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
> >  export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
> >  export EDITOR
> > -GIT_TEST_CMP=${GIT_TEST_CMP:-diff -u}
> > +GIT_TEST_CMP=${GIT_TEST_CMP:-@DIFF@}
> >  
> >  # Protect ourselves from common misconfiguration to export
> >  # CDPATH into the environment
> 
> Define GIT_TEST_CMP in Makefile..
> 
> (I'd split the introduction of DIFF/$DIFF, the diff -> test_cmp
> conversions and the change to set GIT_TEST_CMP=cmp for your platform
> into three separate patches.)

Will do. And then I'll resubmit the whole series.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
