From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v7 4/5] pretty: Add failing tests: --format output should
 honor logOutputEncoding
Date: Tue, 2 Jul 2013 02:50:13 +0400
Message-ID: <20130701225013.GA17377@ashu.dyn1.rarus.ru>
References: <cover.1372240998.git.Alex.Crezoff@gmail.com>
 <9e83de68067be7548c0119d6e99caa905fab0c0f.1372240999.git.Alex.Crezoff@gmail.com>
 <51D12927.5050000@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jul 02 00:50:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtmvP-0004va-Ih
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 00:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948Ab3GAWuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 18:50:19 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:53118 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945Ab3GAWuS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 18:50:18 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so4852203lab.23
        for <git@vger.kernel.org>; Mon, 01 Jul 2013 15:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X8RQunvOuP0J8WENy6vwmeB2DBNibCLkAW+dBXOLK+s=;
        b=QMY8HkER3WrijZLj9FNSOsC5M+sftxYKxPm+TwTaVvU8kUnYMn8GK124Q4u160pPzp
         TfUhPpqEzCBymcEqotIw2lq3zE5yb5hAuy+6Ij0reWk60WjJZjpVrUA1sTodIfCv5ci1
         21Hhth0X1h2l1a273covJumM9/KNIwPhey82TbGXamC6VFkzob0weVOH0/4HUq6ibHC7
         UOmjy27Be2ot1xCNto9hyJjrOmh4G6hSTP/UwY6hKfpnMcwyCgG6tVbn2+3fUKun0TDP
         LBKlM22tHYrGf9UTx2QvtHnvosZO8v/+bnlWt9e0QqDgVGAPG5a2LZk+CKeSfdM1Dh+C
         DvZg==
X-Received: by 10.152.121.73 with SMTP id li9mr13162071lab.42.1372719016300;
        Mon, 01 Jul 2013 15:50:16 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id e5sm7867312lbw.3.2013.07.01.15.50.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jul 2013 15:50:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51D12927.5050000@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229346>

On Mon, Jul 01, 2013 at 09:00:55AM +0200, Johannes Sixt wrote:
> Am 6/26/2013 12:19, schrieb Alexey Shumkin:
> > One can set an alias
> > 	$ git config alias.lg "log --graph --pretty=format:'%Cred%h%Creset
> > 	-%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset'
> > 	--abbrev-commit --date=local"
> > 
> > to see the log as a pretty tree (like *gitk* but in a terminal).
> > 
> > However, log messages written in an encoding i18n.commitEncoding which differs
> > from terminal encoding are shown corrupted even when i18n.logOutputEncoding
> > and terminal encoding are the same (e.g. log messages committed on a Cygwin box
> > with Windows-1251 encoding seen on a Linux box with a UTF-8 encoding and vice versa).
> > 
> > To simplify an example we can say the following two commands are expected
> > to give the same output to a terminal:
> > 
> > 	$ git log --oneline --no-color
> > 	$ git log --pretty=format:'%h %s'
> > 
> > However, the former pays attention to i18n.logOutputEncoding
> > configuration, while the latter does not when it formats "%s".
> > 
> > The same corruption is true for
> > 	$ git diff --submodule=log
> > and
> > 	$ git rev-list --pretty=format:%s HEAD
> > and
> > 	$ git reset --hard
> > 
> > This patch adds failing tests for the next patch that fixes them.
> > 
> > Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> 
> > diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> > index 73ba5e8..6b62da2 100755
> > --- a/t/t4205-log-pretty-formats.sh
> > +++ b/t/t4205-log-pretty-formats.sh
> ...
> > +commit_msg() {
> > +	# String "initial. initial" partly in German (translated with Google Translate),
> > +	# encoded in UTF-8, used as a commit log message below.
> > +	msg=$(printf "initial. anf\303\244nglich")
> > +	if test -n "$1"
> > +	then
> > +		msg=$(echo $msg | iconv -f utf-8 -t $1)
> > +	fi
> > +	if test -n "$2" -a -n "$3"
> > +	then
> > +		# cut string, replace cut part with two dots
> > +		# $2 - chars count from the beginning of the string
> > +		# $3 - "trailing" chars
> > +		# LC_ALL is set to make `sed` interpret "." as a UTF-8 char not a byte
> > +		# as it does with C locale
> > +		msg=$(echo $msg | LC_ALL=en_US.UTF-8 sed -e "s/^\(.\{$2\}\)$3/\1../")
> 
> This does not work as expected on Windows because sed ignores the .UTF-8
> part of the locale specifier. (We don't even have en_US; we have de, but
> with de.UTF-8 this doesn't work, either.)
> 
> I don't have an idea, yet, how to work it around.
> 
Hmm. I have Cygwin v1.7 (on Windows 7 and Windows 2003 Server R2)
with many locales installed (and with en_US.UTF-8 locale, too)
Today I could not find a way to run tests with "no en_US.UTF-8 locale installed" simulation
to test your failure
> > +	fi
> > +	echo $msg
> > +}
> 
> > -test_expect_success 'left alignment formatting with mtrunc' '
> > -	git log --pretty="format:%<(10,mtrunc)%s" >actual &&
> > +test_expect_failure 'left alignment formatting with mtrunc' "
> > +	git log --pretty='format:%<(10,mtrunc)%s' >actual &&
> >  	# complete the incomplete line at the end
> >  	echo >>actual &&
> >  	qz_to_tab_space <<\EOF >expected &&
> >  mess.. two
> >  mess.. one
> >  add bar  Z
> > -initial  Z
> > +$(commit_msg "" "4" ".\{11\}")
> >  EOF
> >  	test_cmp expected actual
> > -'
> > +"
> 
> This is the failing test case.
Hmm, for me all these tests pass on both Linux and Cygwin (mentioned
above) boxes
> 
> BTW, if you re-roll, there would be fewer changes needed if you kept the
> test code single-quoted, but changed <<\EOF to <<EOF where needed.
Yep, thanks for your correction

> 
> > diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> > index cc1008d..c66a07f 100755
> > --- a/t/t6006-rev-list-format.sh
> > +++ b/t/t6006-rev-list-format.sh
> ...
> >  test_expect_success 'setup' '
> >  	: >foo &&
> >  	git add foo &&
> > -	git commit -m "added foo" &&
> > +	git config i18n.commitEncoding iso-8859-1 &&
> 
> Perhaps
> 	test_config i18n.commitEncoding iso-8859-1 &&
> 
> Also, it is "iso-8869-1" here, but we see "iso8859-1" already used later.
> It's probably wise to use that same encoding name everywhere because we
> can be very sure that the latter is already understood on all supported
> platforms.
You're right (I've looked at explanation in
3994e8a98dc7bbf67e61d23c8125f44383499a1f; I've thought ISO-8859-1 is a
common name).
> 
> > +	git commit -m "$added_iso88591" &&
> >  	head1=$(git rev-parse --verify HEAD) &&
> >  	head1_short=$(git rev-parse --verify --short $head1) &&
> >  	tree1=$(git rev-parse --verify HEAD:) &&
> >  	tree1_short=$(git rev-parse --verify --short $tree1) &&
> > -	echo changed >foo &&
> > -	git commit -a -m "changed foo" &&
> > +	echo "$changed" > foo &&
> > +	git commit -a -m "$changed_iso88591" &&
> >  	head2=$(git rev-parse --verify HEAD) &&
> >  	head2_short=$(git rev-parse --verify --short $head2) &&
> >  	tree2=$(git rev-parse --verify HEAD:) &&
> >  	tree2_short=$(git rev-parse --verify --short $tree2)
> > +	git config --unset i18n.commitEncoding
> >  '
> >  
> > -# usage: test_format name format_string <expected_output
> > +# usage: test_format [failure] name format_string <expected_output
> >  test_format () {
> > +	must_fail=0
> > +	# if parameters count is more than 2 then test must fail
> > +	if test $# -gt 2
> > +	then
> > +		must_fail=1
> > +		# remove first parameter which is flag for test failure
> > +		shift
> > +	fi
> >  	cat >expect.$1
> > -	test_expect_success "format $1" "
> > -		git rev-list --pretty=format:'$2' master >output.$1 &&
> > -		test_cmp expect.$1 output.$1
> > -	"
> > +	name="format $1"
> > +	command="git rev-list --pretty=format:'$2' master >output.$1 &&
> > +		test_cmp expect.$1 output.$1"
> > +	if test $must_fail -eq 1
> > +	then
> > +		test_expect_failure "$name" "$command"
> > +	else
> > +		test_expect_success "$name" "$command"
> > +	fi
> >  }
> 
> This function would be much shorter with the optional "failure" token as
> $3 (untested):
> 
> test_format () {
> 	cat >expect.$1
> 	test_expect_${3:-success} "format $1" "
> 		git rev-list --pretty=format:'$2' master >output.$1 &&
> 		test_cmp expect.$1 output.$1
> 	"
Thank you for your suggesstion
> }
> 
> >  test_expect_success 'setup complex body' '
> >  	git config i18n.commitencoding iso8859-1 &&
> >  	echo change2 >foo && git commit -a -F commit-msg &&
> >  	head3=$(git rev-parse --verify HEAD) &&
> > -	head3_short=$(git rev-parse --short $head3)
> > +	head3_short=$(git rev-parse --short $head3) &&
> > +	# unset commit encoding config
> > +	# otherwise %e does not print encoding value
> > +	# and following test fails
> 
> I don't understand this comment. The test vector below already shows that
> an encoding is printed. Why would this suddenly be different with the
> updated tests?
I've changed tests. I've reverted back these ones, and added
new ones with no i18n.commitEncoding set
> 
> Assuming that this change doesn't sweep a deeper problem under the rug,
> it's better to use test_config a few lines earlier.
> 
> > +	git config --unset i18n.commitEncoding
> > +
> >  '
> >  
> >  test_format complex-encoding %e <<EOF
> >  commit $head3
> >  iso8859-1
> 
> This is the encoding that I mean.
These encodings "have appeared" because we've changed 'setup':
we make commits with i18n.commitEncoding set
> 
> >  commit $head2
> > +iso-8859-1
> >  commit $head1
> > +iso-8859-1
> >  EOF
> 
> > diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> > index 05dfb27..72e364e 100755
> > --- a/t/t7102-reset.sh
> > +++ b/t/t7102-reset.sh
> > @@ -9,6 +9,17 @@ Documented tests for git reset'
> >  
> >  . ./test-lib.sh
> >  
> > +commit_msg() {
> > +	# String "modify 2nd file (changed)" partly in German(translated with Google Translate),
> > +	# encoded in UTF-8, used as a commit log message below.
> > +	msg=$(printf "modify 2nd file (ge\303\244ndert)")
> > +	if test -n "$1"
> > +	then
> > +		msg=$(echo $msg | iconv -f utf-8 -t $1)
> > +	fi
> > +	echo $msg
> > +}
> 
> If you wanted to, you could write this as
> 
> commit_msg () {
> 	# String "modify 2nd file (changed)" partly in German
> 	#(translated with Google Translate),
> 	# encoded in UTF-8, used as a commit log message below.
> 	printf "modify 2nd file (ge\303\244ndert)" |
> 	if test -n "$1"
> 	then
> 		iconv -f utf-8 -t $1
> 	else
> 		cat
> 	fi
> }
> 
> but I'm not sure whether it's a lot better.
It looks more readable. Thank you
> 
> -- Hannes

-- 
Alexey Shumkin
