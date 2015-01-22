From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v4 14/33] Use "git check-ref-format" to validate patch
 names.
Date: Thu, 22 Jan 2015 09:18:52 -0500
Message-ID: <20150122141851.GC101460@meili.jeffnet.31bits.net>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
 <1400450409-30998-15-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 15:19:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEIb6-0000Q4-0d
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 15:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbbAVOS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 09:18:56 -0500
Received: from josefsipek.net ([71.174.113.7]:1663 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbbAVOSz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 09:18:55 -0500
Received: from meili.jeffnet.31bits.net (unknown [172.31.0.119])
	by josefsipek.net (Postfix) with ESMTPSA id E66FE5567A;
	Thu, 22 Jan 2015 09:18:53 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1400450409-30998-15-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262835>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Sun, May 18, 2014 at 11:59:50PM +0200, Per Cederqvist wrote:
> The valid_patchname now lets "git check-ref-format" do its job instead
> of trying (and failing) to implement the same rules.  See
> git-check-ref-format(1) for a list of the rules.  Re-implement rules
> added to "git check-ref-format" after Git 1.5.0, so that guilt rejects
> the same names no matter what version of Git we are using (but
> versions prior to 1.5.0 are not supported).
> 
> Refer to the git-check-ref-format(1) man page in the error messages
> produced when valid_patchname indicates that the name is bad.
> 
> Added testcases that breaks most of the rules in that man-page.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt                |  46 +++++-
>  guilt-fork           |   2 +-
>  guilt-import         |   2 +-
>  guilt-new            |   2 +-
>  regression/t-025.out | 426 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  regression/t-025.sh  |  12 +-
>  regression/t-032.out |   4 +-
>  7 files changed, 474 insertions(+), 20 deletions(-)
> 
> diff --git a/guilt b/guilt
> index 3fc524e..9567a78 100755
> --- a/guilt
> +++ b/guilt
> @@ -132,14 +132,50 @@ fi
>  # usage: valid_patchname <patchname>
>  valid_patchname()
>  {
> +	# Once we only support Git 1.7.8 and newer, the command below
> +	# could be replaced with:
> +	#
> +	#     git check-ref-format --allow-onelevel "$1"
> +	#
> +	# Instead, we arbitrarily prepend one level.  The result
> +	# should be the same, and this is portable to all existing
> +	# versions of Git.
> +	git check-ref-format a/"$1"
> +	if [ $? -ne 0 ]; then
> +		return 1
> +	fi
> +
> +	# We want to reject all names that Git 2.0.0 rejects.  In case
> +	# we are running an older version, we explicitly check some
> +	# cases that were added to Git after version 1.5.0.  This code
> +	# aims to support Git version 1.5.0 and newer.
> +
> +	# Git 1.7.6.4 and newer rejects the DEL character.
> +	if [ `echo "$1"|tr -d '\177'` != "$1" ]; then
> +		return 1
> +	fi
> +
> +	# Git 1.7.8 and newer rejects refs that start or end with
> +	# slash or contain multiple adjacent slashes.
>  	case "$1" in
> -		/*|./*|../*|*/./*|*/../*|*/.|*/..|*/|*\ *|*\	*)
> +		/*|*/|*//*)
>  			return 1;;
> -		*:*)
> -			return 1;;
> -		*)
> -			return 0;;
>  	esac
> +
> +	# Git 1.7.8 and newer rejects refname components that end in
> +	# .lock.
> +	case "$1" in
> +		*.lock/*|*.lock)
> +			return 1;;
> +	esac
> +
> +	# Git 1.8.5 and newer rejects refnames that are made up of the
> +	# single character "@".
> +	if [ "$1" = "@" ]; then
> +		return 1
> +	fi
> +
> +	return 0
>  }
>  
>  get_branch()
> diff --git a/guilt-fork b/guilt-fork
> index a85d391..6447e55 100755
> --- a/guilt-fork
> +++ b/guilt-fork
> @@ -37,7 +37,7 @@ else
>  fi
>  
>  if ! valid_patchname "$newpatch"; then
> -	die "The specified patch name contains invalid characters (:)."
> +	die "The specified patch name is invalid according to git-check-ref-format(1)."
>  fi
>  
>  if [ -e "$GUILT_DIR/$branch/$newpatch" ]; then
> diff --git a/guilt-import b/guilt-import
> index 3e9b3bb..928e325 100755
> --- a/guilt-import
> +++ b/guilt-import
> @@ -40,7 +40,7 @@ if [ -e "$GUILT_DIR/$branch/$newname" ]; then
>  fi
>  
>  if ! valid_patchname "$newname"; then
> -	die "The specified patch name contains invalid characters (:)."
> +	die "The specified patch name is invalid according to git-check-ref-format(1)."
>  fi
>  
>  # create any directories as needed
> diff --git a/guilt-new b/guilt-new
> index 9528438..9f7fa44 100755
> --- a/guilt-new
> +++ b/guilt-new
> @@ -64,7 +64,7 @@ fi
>  
>  if ! valid_patchname "$patch"; then
>  	disp "Patchname is invalid." >&2
> -	die "it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace"
> +	die "It must follow the rules in git-check-ref-format(1)."
>  fi
>  
>  # create any directories as needed
> diff --git a/regression/t-025.out b/regression/t-025.out
> index 7811ab1..01bc406 100644
> --- a/regression/t-025.out
> +++ b/regression/t-025.out
> @@ -141,7 +141,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
>  r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
>  % guilt new white space
>  Patchname is invalid.
> -it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
> +It must follow the rules in git-check-ref-format(1).
>  % list_files
>  d .git/patches
>  d .git/patches/master
> @@ -211,7 +211,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
>  r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
>  % guilt new /abc
>  Patchname is invalid.
> -it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
> +It must follow the rules in git-check-ref-format(1).
>  % list_files
>  d .git/patches
>  d .git/patches/master
> @@ -235,7 +235,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
>  r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
>  % guilt new ./blah
>  Patchname is invalid.
> -it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
> +It must follow the rules in git-check-ref-format(1).
>  % list_files
>  d .git/patches
>  d .git/patches/master
> @@ -259,7 +259,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
>  r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
>  % guilt new ../blah
>  Patchname is invalid.
> -it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
> +It must follow the rules in git-check-ref-format(1).
>  % list_files
>  d .git/patches
>  d .git/patches/master
> @@ -283,7 +283,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
>  r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
>  % guilt new abc/./blah
>  Patchname is invalid.
> -it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
> +It must follow the rules in git-check-ref-format(1).
>  % list_files
>  d .git/patches
>  d .git/patches/master
> @@ -307,7 +307,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
>  r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
>  % guilt new abc/../blah
>  Patchname is invalid.
> -it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
> +It must follow the rules in git-check-ref-format(1).
>  % list_files
>  d .git/patches
>  d .git/patches/master
> @@ -331,7 +331,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
>  r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
>  % guilt new abc/.
>  Patchname is invalid.
> -it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
> +It must follow the rules in git-check-ref-format(1).
>  % list_files
>  d .git/patches
>  d .git/patches/master
> @@ -355,7 +355,7 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
>  r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
>  % guilt new abc/..
>  Patchname is invalid.
> -it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
> +It must follow the rules in git-check-ref-format(1).
>  % list_files
>  d .git/patches
>  d .git/patches/master
> @@ -379,7 +379,415 @@ f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
>  r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
>  % guilt new abc/
>  Patchname is invalid.
> -it cannot begin with '/', './' or '../', or contain /./, /../, or whitespace
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new abc.lock
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new a/b.lock/c
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new cr
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new ctrl-a
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new formfeed
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new del
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new tilde~
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new caret^
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new colon:
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new questionmark?
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new asterisk*
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new open[bracket
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new consecutive//slashes
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new trailing-dot.
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new bad@{seq
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new @
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
> +% list_files
> +d .git/patches
> +d .git/patches/master
> +d .git/patches/master/dir
> +d .git/patches/master/dir/subdir
> +d .git/refs/patches
> +d .git/refs/patches/master
> +d .git/refs/patches/master/dir
> +d .git/refs/patches/master/dir/subdir
> +f 1ef04b4f4149870b3f06b5f99b9d9fc260cebc67  .git/patches/master/series
> +f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
> +f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
> +f 7ce0ecd062afe46bf743d0d63dbe79e18774fe03  .git/patches/master/status
> +f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> +f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/append
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/dir/subdir/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/file
> +f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/prepend
> +r acdeef96ee30eb34bbbf65d11de5cf7da4b5fee8  .git/refs/patches/master/prepend
> +% guilt new backslash\
> +Patchname is invalid.
> +It must follow the rules in git-check-ref-format(1).
>  % list_files
>  d .git/patches
>  d .git/patches/master
> diff --git a/regression/t-025.sh b/regression/t-025.sh
> index 985fed4..8c439fc 100755
> --- a/regression/t-025.sh
> +++ b/regression/t-025.sh
> @@ -43,7 +43,17 @@ shouldfail guilt new "white space"
>  
>  cmd list_files
>  
> -for pname in prepend mode /abc ./blah ../blah abc/./blah abc/../blah abc/. abc/.. abc/ ; do
> +b()
> +{
> +    printf "%b" "$1"
> +}
> +
> +for pname in prepend mode /abc ./blah ../blah abc/./blah abc/../blah abc/. \
> +	abc/.. abc/ abc.lock a/b.lock/c `b 'cr\r'` `b 'ctrl-a\001'` \
> +	`b 'formfeed\f'` `b 'del\177'` "tilde~" "caret^" "colon:" \
> +	"questionmark?" "asterisk*" "open[bracket" "consecutive//slashes" \
> +	"trailing-dot." "bad@{seq" "@" "backslash\\"
> +do
>  	shouldfail guilt new "$pname"
>  
>  	cmd list_files
> diff --git a/regression/t-032.out b/regression/t-032.out
> index 53f0370..4e65db0 100644
> --- a/regression/t-032.out
> +++ b/regression/t-032.out
> @@ -1,7 +1,7 @@
>  % setup_repo
>  % touch foo foo:baz
>  % guilt import -P foo:bar foo
> -The specified patch name contains invalid characters (:).
> +The specified patch name is invalid according to git-check-ref-format(1).
>  % guilt import -P foo:bar foo2
>  Specified file does not exist.
>  % guilt import -P foo foo2
> @@ -15,4 +15,4 @@ Already tracking a patch under that name.
>  Already tracking a patch under that name.
>  % guilt import -P foo,bar foo
>  % guilt import foo:baz
> -The specified patch name contains invalid characters (:).
> +The specified patch name is invalid according to git-check-ref-format(1).
> -- 
> 1.8.3.1
> 

-- 
What is the difference between Mechanical Engineers and Civil Engineers?
Mechanical Engineers build weapons, Civil Engineers build targets.
