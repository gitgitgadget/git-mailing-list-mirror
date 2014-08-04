From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: doublecheck if really file or dir
Date: Mon, 4 Aug 2014 04:02:12 +0000
Message-ID: <20140804040212.GA14629@dcvr.yhbt.net>
References: <53DE31E8.3070405@gmail.com>
 <53DE352A.5050505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrej Manduch <amanduch@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 06:02:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XE9TV-00088G-8g
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 06:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbaHDECN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 00:02:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39364 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbaHDECM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 00:02:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 399E71FB36;
	Mon,  4 Aug 2014 04:02:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <53DE352A.5050505@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254732>

Andrej Manduch <amanduch@gmail.com> wrote:
> On 08/03/2014 02:22 PM, Andrej Manduch wrote:
> > Nice touch, It works like charm. However unfortunatelly now I think you
> > introduced new bug :)

Good catch!

> > On 08/03/2014 04:45 AM, Eric Wong wrote:
> >>  sub cmd_info {
> >> -	my $path = canonicalize_path(defined($_[0]) ? $_[0] : ".");
> >> -	my $fullpath = canonicalize_path($cmd_dir_prefix . $path);
> >> +	my $path_arg = defined($_[0]) ? $_[0] : '.';
> >> +	my $path = $path_arg;
> >> +	if ($path =~ m!\A/!) {
> >> +		my $toplevel = eval {
> >> +			my @cmd = qw/rev-parse --show-toplevel/;
> >> +			command_oneline(\@cmd, STDERR => 0);
> >> +		};
> >> +		$path =~ s!\A\Q$toplevel\E/?!!;
> > I have problem with this line ^^^
> > 
> > Suppose your $toplevel is "/sometning" and you type in command line
> > something like that: "git svn info /somethingsrc" and as you see this
> > should end up with error. However "$path =~ s!\A\Q$toplevel\E/?!!;"
> > will just cut "/sometning" from "/somethingsrc" and and up with same
> > answer as for "svn git info src" which is not equivalent query.
> > 
> > Second scenario is something which worries me more: If your query look
> > like this: "git svn info /something//src" it will just end up with error
> > because it will set $path to "/src" witch is outside of repository.
> > 
> > Second scenario can be fixed with this:
> > 
> 
> Actualy this will be even better:

Thanks Andrej.  I'll queue that on top of mine.
Can you turn that into a proper commit message with Subject?
Thanks.
(The English-generating part of my brain is too tired)

> Signed-off-by: Andrej Manduch <amanduch@gmail.com>
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1483,6 +1483,7 @@ sub cmd_info {
>  			my @cmd = qw/rev-parse --show-toplevel/;
>  			command_oneline(\@cmd, STDERR => 0);
>  		};
> +		$path = canonicalize_path($path);
>  		$path =~ s!\A\Q$toplevel\E/?!!;
>  		$path = canonicalize_path($path);
>  	} else {

> Because this will have not problem with really weird query like: "git
> svn info /media/../media/something//src"

I've also started working on the following test cases,
will squash:

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 4f6e669..f16f323 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -84,6 +84,26 @@ test_expect_success 'info $(pwd)' '
 	     "$(sed -ne \"/^Path:/ s!/gitwc!!\" <actual.info-pwd)"
 	'
 
+test_expect_success 'info $(pwd)/../___wc' '
+	(cd svnwc; svn info "$(pwd)/../svnwc") >expected.info-pwd &&
+	(cd gitwc; git svn info "$(pwd)/../gitwc") >actual.info-pwd &&
+	grep -v ^Path: <expected.info-pwd >expected.info-np &&
+	grep -v ^Path: <actual.info-pwd >actual.info-np &&
+	test_cmp_info expected.info-np actual.info-np &&
+	test "$(sed -ne \"/^Path:/ s!/svnwc!!\" <expected.info-pwd)" = \
+	     "$(sed -ne \"/^Path:/ s!/gitwc!!\" <actual.info-pwd)"
+	'
+
+test_expect_success 'info $(pwd)/../___wc//file' '
+	(cd svnwc; svn info "$(pwd)/../svnwc//file") >expected.info-pwd &&
+	(cd gitwc; git svn info "$(pwd)/../gitwc//file") >actual.info-pwd &&
+	grep -v ^Path: <expected.info-pwd >expected.info-np &&
+	grep -v ^Path: <actual.info-pwd >actual.info-np &&
+	test_cmp_info expected.info-np actual.info-np &&
+	test "$(sed -ne \"/^Path:/ s!/svnwc!!\" <expected.info-pwd)" = \
+	     "$(sed -ne \"/^Path:/ s!/gitwc!!\" <actual.info-pwd)"
+	'
+
 test_expect_success 'info --url .' '
 	test "$(cd gitwc; git svn info --url .)" = "$quoted_svnrepo"
 	'
