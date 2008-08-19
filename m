From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3 v10] gitweb: add test suite with
 Test::WWW::Mechanize::CGI
Date: Mon, 18 Aug 2008 18:17:44 -0700
Message-ID: <7vd4k5kdl3.fsf@gitster.siamese.dyndns.org>
References: <48A9CEC0.2020100@gmail.com>
 <1219088389-14828-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 03:19:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVFsA-0001mp-7z
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 03:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbYHSBRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 21:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753873AbYHSBRw
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 21:17:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbYHSBRv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 21:17:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 35688544D8;
	Mon, 18 Aug 2008 21:17:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 35DA7544D7; Mon, 18 Aug 2008 21:17:46 -0400 (EDT)
In-Reply-To: <1219088389-14828-1-git-send-email-LeWiemann@gmail.com> (Lea
 Wiemann's message of "Mon, 18 Aug 2008 21:39:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A33602F0-6D8C-11DD-80CF-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92800>

Lea Wiemann <lewiemann@gmail.com> writes:

> This test uses Test::WWW::Mechanize::CGI to check gitweb's output.  It
> also uses HTML::Lint, XML::Parser, and Archive::Tar (if present, each)
> to validate the HTML/XML/tgz output, and checks all links on the
> tested pages if --long-tests is given.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>

This s-o-b chain is a bit confusing; was this authored by you or Jakub?

> diff --git a/Makefile b/Makefile
> index ca418fc..35779a7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1289,6 +1289,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
>  GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
>  	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
>  	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
> +	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >>$@
>  
>  ### Detect Tck/Tk interpreter path changes
>  ifndef NO_TCLTK
> diff --git a/t/t9503-gitweb-Mechanize.sh b/t/t9503-gitweb-Mechanize.sh
> new file mode 100755
> index 0000000..53f2a8a
> --- /dev/null
> +++ b/t/t9503-gitweb-Mechanize.sh
> @@ -0,0 +1,144 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2008 Jakub Narebski
> +# Copyright (c) 2008 Lea Wiemann
> +#
> +
> +# This test supports the --long-tests option.
> +
> +# This test only runs on Perl 5.8 and later versions, since
> +# Test::WWW::Mechanize::CGI requires Perl 5.8.
> +
> +test_description='gitweb tests (using WWW::Mechanize)
> +
> +This test uses Test::WWW::Mechanize::CGI to test gitweb.'
> +
> +# helper functions
> +
> +safe_chmod () {
> +	chmod "$1" "$2" &&
> +	if [ "$(git config --get core.filemode)" = false ]
> +	then
> +		git update-index --chmod="$1" "$2"
> +	fi
> +}

You have this in t9500 as well.  Perhaps it can go to test-lib?

> +. ./test-lib.sh
> +
> +# check if test can be run
> +"$PERL_PATH" -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
> +	test_expect_success \
> +		'skipping gitweb tests, perl version is too old' :
> +	test_done
> +	exit
> +}

It may be helpful to say what exactly is lacking (either "Please upgrade
your Perl to 5.8", or "We want decode_utf8() that can CROAK").

> +"$PERL_PATH" -MTest::WWW::Mechanize::CGI -e '' >/dev/null 2>&1 || {
> +	test_expect_success \
> +		'skipping gitweb tests, Test::WWW::Mechanize::CGI not found' :
> +	test_done
> +	exit
> +}

This one is better then the previous one.  t3300, t4000, t5540, t9113,
t9113, t9600, and t9700 use "say" (or say_color), t3902, t4016, t5000, and
t7004 just use "echo", and t9200, t9400, t9401 and t9500 do this phoney
"success".  We should standardize these by introducing "test_stop_early
$msg".  Then we can lose test_done and exit from these places.

> +# set up test repository
> +test_expect_success 'set up test repository' '
> ...
> +	test_tick && git pull . b
> +'

That "pull . b" is somewhat old fashioned, but is Ok.

> +# set up gitweb configuration
> +safe_pwd="$("$PERL_PATH" -MPOSIX=getcwd -e 'print quotemeta(getcwd)')"
> +large_cache_root="../t9503/large_cache.tmp"

Please use $TEST_DIRECTORY without relying on the location of "t/trash
directory"; it was painful to fix all of them.

> +test_expect_success 'create file cache directory' \
> +	'mkdir -p "$large_cache_root"'
> +cat >gitweb_config.perl <<EOF
> +# gitweb configuration for tests
> ...
> +our @stylesheets = ("file:///$safe_pwd/../../gitweb/gitweb.css");
> +our \$logo = "file:///$safe_pwd/../../gitweb/git-logo.png";
> +our \$favicon = "file:///$safe_pwd/../../gitweb/git-favicon.png";

These also assume "t/trash directory" not being "t/trash/t9503".

> +test_external \
> +	'test gitweb output' \
> +	"$PERL_PATH" ../t9503/test.pl

So does this, and you have catfile('..', '..', ...) in the perl part of
this test.

> +# Search form
> +
> +# Search commit
> +if (get_summary && $mech->submit_form_ok(
> +	    { form_number => 1, fields => { 's' => 'Initial' } },
> +	    'submit search form (default: commit search)')) {
> +	check_page;
> +	$mech->content_contains('Initial commit',
> +				'content contains commit we searched for');
> +}
> +
> +# Pickaxe
> +if (get_summary && $mech->submit_form_ok(
> +	    { form_number => 1, fields => { 's' => 'pickaxe test string',
> +					    'st' => 'pickaxe' } },
> +	    'submit search form (pickaxe)')) {
> +	check_page;
> +	test_link( { text => 'dir1/file1' }, 'file found with pickaxe' );
> +	$mech->content_contains('A U Thor', 'commit author mentioned');
> +}
> +
> +# Grep
> +# Let's hope the pickaxe test string is still present in HEAD.
> +if (get_summary && $mech->submit_form_ok(
> +	    { form_number => 1, fields => { 's' => 'pickaxe test string',
> +					    'st' => 'grep' } },
> +	    'submit search form (grep)')) {
> +	check_page;
> +	test_link( { text => 'dir1/file1' }, 'file found with grep' );
> +}

With these search oriented tests, making sure that you would find what you
expect to find is obviously important, but shouldn't you be also making
sure that irrelevant entries are not found?

It is great that there are tests for each view we care about, even though
the way the individual views are tested look somewhat sketchy.
