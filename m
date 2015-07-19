From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] Fix sed usage in tests to work around broken xpg4/sed
 on Solaris
Date: Sun, 19 Jul 2015 08:54:57 +0200
Message-ID: <55AB49C1.8010105@kdbg.org>
References: <1437232892-27978-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 08:55:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGiVB-0006gp-Rw
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 08:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbbGSGzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 02:55:03 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:45297 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751846AbbGSGzC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 02:55:02 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3mYxl70LhDz5tl9;
	Sun, 19 Jul 2015 08:54:58 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id B8CC152BE;
	Sun, 19 Jul 2015 08:54:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <1437232892-27978-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274202>

Am 18.07.2015 um 17:21 schrieb Ben Walton:
> The space following the last / in a sed command caused Solaris'
> xpg4/sed to fail, claiming the program was garbled and exit with
> status 2:
>
> % echo 'foo' | /usr/xpg4/bin/sed -e 's/foo/bar/ '
> sed: command garbled: s/foo/bar/
> % echo $?
> 2
>
> Fix this by simply removing the unnecessary space.
>
> Additionally, in 99094a7a, a trivial && breakage was fixed. This
> exposed a problem with the test when run on Solaris with xpg4/sed that
> had gone silently undetected since its introduction in
> e4bd10b2. Solaris' sed executes the requested substitution but prints
> a warning about the missing newline at the end of the file and exits
> with status 2.
>
> % echo "CHANGE_ME" | \
> tr -d "\\012" | /usr/xpg4/bin/sed -e 's/CHANGE_ME/change_me/'
> sed: Missing newline at end of file standard input.
> change_me
> % echo $?
> 2
>
> To work around this, use perl to execute the substitution instead. By
> using inplace replacement, we can subsequently drop the mv command.
>
> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---
>   t/t5601-clone.sh                       |    2 +-
>   t/t9500-gitweb-standalone-no-errors.sh |    3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index fa6be3c..2583f84 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -445,7 +445,7 @@ test_expect_success 'clone ssh://host.xz:22/~repo' '
>   #IPv6
>   for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]: [user@::1] [user@::1]:
>   do
> -	ehost=$(echo $tuah | sed -e "s/1]:/1]/ " | tr -d "\133\135")
> +	ehost=$(echo $tuah | sed -e "s/1]:/1]/" | tr -d "\133\135")

Can this not be rewritten as

	ehost=$(echo $tuah | sed -e "s/1]:/1]/" -e "s/[][]//g")

But I admit that it looks like black magic without a comment...

>   	test_expect_success "clone ssh://$tuah/home/user/repo" "
>   	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
>   	"
> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> index e94b2f1..eb264f9 100755
> --- a/t/t9500-gitweb-standalone-no-errors.sh
> +++ b/t/t9500-gitweb-standalone-no-errors.sh
> @@ -290,8 +290,7 @@ test_expect_success 'setup incomplete lines' '
>   	echo "incomplete" | tr -d "\\012" >>file &&
>   	git commit -a -m "Add incomplete line" &&
>   	git tag incomplete_lines_add &&
> -	sed -e s/CHANGE_ME/change_me/ <file >file+ &&
> -	mv -f file+ file &&
> +	perl -pi -e "s/CHANGE_ME/change_me/" file &&

This is problematic. On Windows, perl -i fails when no backup file 
extension is specified because perl attempts to replace a file that is 
still open; that does not work on Windows. This should work, but I 
haven't tested, yet:

	perl -pi.bak -e "s/CHANGE_ME/change_me/" file &&

>   	git commit -a -m "Incomplete context line" &&
>   	git tag incomplete_lines_ctx &&
>   	echo "Dominus regit me," >file &&
>

-- Hannes
