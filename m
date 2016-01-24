From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 09/19] mingw: accomodate t0060-path-utils for MSYS2
Date: Sun, 24 Jan 2016 20:51:04 +0100
Message-ID: <56A52B28.8010304@kdbg.org>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
 <12c030323940de4a0845eda9bdd7b67c4e90864a.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 24 20:51:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNQhO-0005IQ-Io
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 20:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbcAXTvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 14:51:09 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:52342 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbcAXTvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 14:51:08 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3ppQ1N70VXz5tlD;
	Sun, 24 Jan 2016 20:51:04 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 22AD951EF;
	Sun, 24 Jan 2016 20:51:04 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <12c030323940de4a0845eda9bdd7b67c4e90864a.1453650173.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284691>

Am 24.01.2016 um 16:44 schrieb Johannes Schindelin:
> On Windows, there are no POSIX paths, only Windows ones (an absolute
> Windows path looks like "C:\Program Files\Git\ReleaseNotes.html", under
> most circumstances, forward slashes are also allowed and synonymous to
> backslashes).
> 
> So when a POSIX shell (such as MSYS2's Bash, which is used by Git for
> Windows to execute all those shell scripts that are part of Git) passes
> a POSIX path to test-path-utils.exe (which is not POSIX-aware), the path
> is translated into a Windows path. For example, /etc/profile becomes
> C:/Program Files/Git/etc/profile.
> 
> This path translation poses a problem when passing the root directory as
> parameter to test-path-utils.exe, as it is not well defined whether the
> translated root directory should end in a slash or not. MSys1 stripped
> the trailing slash, but MSYS2 does not.
> 
> To work with both behaviors, we simply test what the current system does
> in the beginning of t0060-path-utils.sh and then adjust the expected
> longest ancestor length accordingly.
> 
> Originally, the Git for Windows project patched MSYS2's runtime to
> accomodate Git's regression test, but we really should do it the other
> way round.
> 
> Thanks to Ray Donnelly for his patient help with this issue.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   t/t0060-path-utils.sh | 37 ++++++++++++++++++++++---------------
>   1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index f0152a7..89d03e7 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -7,6 +7,13 @@ test_description='Test various path utilities'
>   
>   . ./test-lib.sh
>   
> +# On Windows, the root directory "/" is translated into a Windows directory.
> +# As it is not well-defined whether that Windows directory should end in a
> +# slash or not, let's test for that and adjust our expected longest ancestor
> +# length accordingly.
> +root_offset=0
> +case "$(test-path-utils print_path /)" in ?*/) root_offset=-1;; esac
> +
>   norm_path() {
>   	expected=$(test-path-utils print_path "$2")
>   	test_expect_success $3 "normalize path: $1 => $2" \

In t0060-path-utils.sh, I currently find this:

# On Windows, we are using MSYS's bash, which mangles the paths.
# Absolute paths are anchored at the MSYS installation directory,
# which means that the path / accounts for this many characters:
rootoff=$(test-path-utils normalize_path_copy / | wc -c)
# Account for the trailing LF:
if test $rootoff = 2; then
	rootoff=	# we are on Unix
else
	rootoff=$(($rootoff-1))
fi

ancestor() {
	# We do some math with the expected ancestor length.
	expected=$3
	if test -n "$rootoff" && test "x$expected" != x-1; then
		expected=$(($expected+$rootoff))
	fi
	test_expect_success "longest ancestor: $1 $2 => $expected" \
	"actual=\$(test-path-utils longest_ancestor_length '$1' '$2') &&
	 test \"\$actual\" = '$expected'"
}

Furthermore, since you are modifying only cases where the expected
value is not -1 and we already have a check for this case in the
helper function, wouldn't it be simpler to merge the offset that your
case needs with the one that we already have?

> @@ -112,30 +119,30 @@ norm_path /d1/.../d2 /d1/.../d2
>   norm_path /d1/..././../d2 /d1/d2
>   
>   ancestor / / -1
> -ancestor /foo / 0
> +ancestor /foo / $root_offset
>   ancestor /foo /fo -1
>   ancestor /foo /foo -1
>   ancestor /foo /bar -1
>   ancestor /foo /foo/bar -1
>   ancestor /foo /foo:/bar -1
> -ancestor /foo /:/foo:/bar 0
> -ancestor /foo /foo:/:/bar 0
> -ancestor /foo /:/bar:/foo 0
> -ancestor /foo/bar / 0
> +ancestor /foo /:/foo:/bar $root_offset
> +ancestor /foo /foo:/:/bar $root_offset
> +ancestor /foo /:/bar:/foo $root_offset
> +ancestor /foo/bar / $root_offset
>   ancestor /foo/bar /fo -1
> -ancestor /foo/bar /foo 4
> +ancestor /foo/bar /foo $((4+$root_offset))
>   ancestor /foo/bar /foo/ba -1
> -ancestor /foo/bar /:/fo 0
> -ancestor /foo/bar /foo:/foo/ba 4
> +ancestor /foo/bar /:/fo $root_offset
> +ancestor /foo/bar /foo:/foo/ba $((4+$root_offset))
>   ancestor /foo/bar /bar -1
>   ancestor /foo/bar /fo -1
> -ancestor /foo/bar /foo:/bar 4
> -ancestor /foo/bar /:/foo:/bar 4
> -ancestor /foo/bar /foo:/:/bar 4
> -ancestor /foo/bar /:/bar:/fo 0
> -ancestor /foo/bar /:/bar 0
> -ancestor /foo/bar /foo 4
> -ancestor /foo/bar /foo:/bar 4
> +ancestor /foo/bar /foo:/bar $((4+$root_offset))
> +ancestor /foo/bar /:/foo:/bar $((4+$root_offset))
> +ancestor /foo/bar /foo:/:/bar $((4+$root_offset))
> +ancestor /foo/bar /:/bar:/fo $root_offset
> +ancestor /foo/bar /:/bar $root_offset
> +ancestor /foo/bar /foo $((4+$root_offset))
> +ancestor /foo/bar /foo:/bar $((4+$root_offset))
>   ancestor /foo/bar /bar -1
>   
>   test_expect_success 'strip_path_suffix' '
> 
