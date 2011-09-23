From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 2/5] git-p4: handle utf16 filetype properly
Date: Fri, 23 Sep 2011 19:01:11 +0100
Message-ID: <4E7CC967.8010502@diamand.org>
References: <20110918012634.GA4578@arf.padd.com> <20110918012831.GB4619@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>,
	Chris Li <git@chrisli.org>, Junio C Hamano <gitster@pobox.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 20:01:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7A3s-0000Ef-RN
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 20:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892Ab1IWSBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 14:01:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64902 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab1IWSBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 14:01:15 -0400
Received: by wyg34 with SMTP id 34so4203049wyg.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 11:01:14 -0700 (PDT)
Received: by 10.216.1.200 with SMTP id 50mr6026059wed.33.1316800874192;
        Fri, 23 Sep 2011 11:01:14 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id gd6sm17568850wbb.1.2011.09.23.11.01.12
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 11:01:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <20110918012831.GB4619@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181982>

On 18/09/11 02:28, Pete Wyckoff wrote:
> One of the filetypes that p4 supports is utf16.  Its behavior is
> odd in this case.  The data delivered through "p4 -G print" is
> not encoded in utf16, although "p4 print -o" will produce the
> proper utf16-encoded file.
>
> When dealing with this filetype, discard the data from -G, and
> intstead read the contents directly.

"intstead" - should be "instead", or perhaps "int32_tstead".



>
> An alternate approach would be to try to encode the data in
> python.  That worked for true utf16 files, but for other files
> marked as utf16, p4 delivers mangled text in no recognizable encoding.
>
> Add a test case to check utf16 handling, and +k and +ko handling.
>
> Reported-by: Chris Li<git@chrisli.org>
> Signed-off-by: Pete Wyckoff<pw@padd.com>
> ---
>   contrib/fast-import/git-p4 |   11 +++++
>   t/t9802-git-p4-filetype.sh |  107 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 118 insertions(+), 0 deletions(-)
>   create mode 100755 t/t9802-git-p4-filetype.sh
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 2f7b270..e69caf3 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -1238,6 +1238,15 @@ class P4Sync(Command, P4UserMap):
>               data = ''.join(contents)
>               contents = [data[:-1]]
>
> +        if file['type'].startswith("utf16"):
> +            # p4 delivers different text in the python output to -G
> +            # than it does when using "print -o", or normal p4 client
> +            # operations.  utf16 is converted to ascii or utf8, perhaps.
> +            # But ascii text saved as -t utf16 is completely mangled.
> +            # Invoke print -o to get the real contents.
> +            text = p4_read_pipe('print -q -o - "%s"' % file['depotFile'])
> +            contents = [ text ]
> +
>           if self.isWindows and file["type"].endswith("text"):
>               mangled = []
>               for data in contents:
> @@ -1245,6 +1254,8 @@ class P4Sync(Command, P4UserMap):
>                   mangled.append(data)
>               contents = mangled
>
> +        # Note that we do not try to de-mangle keywords on utf16 files,
> +        # even though in theory somebody may want that.
>           if file['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
>               contents = map(lambda text: re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text), contents)
>           elif file['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
> diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
> new file mode 100755
> index 0000000..f112eaa
> --- /dev/null
> +++ b/t/t9802-git-p4-filetype.sh
> @@ -0,0 +1,107 @@
> +#!/bin/sh
> +
> +test_description='git-p4 p4 filetype tests'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +	kill_p4d || :&&
> +	start_p4d&&
> +	cd "$TRASH_DIRECTORY"
> +'
> +
> +test_expect_success 'utf-16 file create' '
> +	cd "$cli"&&
> +
> +	# p4 saves this verbatim
> +	echo -e "three\nline\ntext">  f-ascii&&
> +	p4 add -t text f-ascii&&
> +
> +	# p4 adds \377\376 header
> +	cp f-ascii f-ascii-as-utf16&&
> +	p4 add -t utf16 f-ascii-as-utf16&&
> +
> +	# p4 saves this exactly as iconv produced it
> +	echo -e "three\nline\ntext" | iconv -f ascii -t utf-16>  f-utf16&&
> +	p4 add -t utf16 f-utf16&&
> +
> +	# this also is unchanged
> +	cp f-utf16 f-utf16-as-text&&
> +	p4 add -t text f-utf16-as-text&&
> +
> +	p4 submit -d "f files"&&
> +
> +	# force update of client files
> +	p4 sync -f&&
> +	cd "$TRASH_DIRECTORY"
> +'
> +
> +test_expect_success 'utf-16 file test' '
> +	test_when_finished cleanup_git&&
> +	"$GITP4" clone --dest="$git" //depot@all&&
> +	cd "$git"&&
> +
> +	cmp "$cli/f-ascii" f-ascii&&
> +	cmp "$cli/f-ascii-as-utf16" f-ascii-as-utf16&&
> +	cmp "$cli/f-utf16" f-utf16&&
> +	cmp "$cli/f-utf16-as-text" f-utf16-as-text
> +'
> +
> +test_expect_success 'keyword file create' '
> +	cd "$cli"&&
> +
> +	echo -e "id\n\$Id\$\n\$Author\$\ntext">  k-text-k&&
> +	p4 add -t text+k k-text-k&&
> +
> +	cp k-text-k k-text-ko&&
> +	p4 add -t text+ko k-text-ko&&
> +
> +	cat k-text-k | iconv -f ascii -t utf-16>  k-utf16-k&&
> +	p4 add -t utf16+k k-utf16-k&&
> +
> +	cp k-utf16-k k-utf16-ko&&
> +	p4 add -t utf16+ko k-utf16-ko&&
> +
> +	p4 submit -d "k files"&&
> +	p4 sync -f&&
> +	cd "$TRASH_DIRECTORY"
> +'
> +
> +ko_smush() {
> +	cat>smush.py<<-EOF&&
> +	import re, sys
> +	sys.stdout.write(re.sub(r'(?i)\\\$(Id|Header):[^$]*\\\$', r'$\1$', sys.stdin.read()))
> +	EOF
> +	python smush.py<  "$1"
> +}
> +
> +k_smush() {
> +	cat>smush.py<<-EOF&&
> +	import re, sys
> +	sys.stdout.write(re.sub(r'(?i)\\\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\\\$', r'$\1$', sys.stdin.read()))
> +	EOF
> +	python smush.py<  "$1"
> +}
> +
> +test_expect_success 'keyword file test' '
> +	test_when_finished cleanup_git&&
> +	"$GITP4" clone --dest="$git" //depot@all&&
> +	cd "$git"&&
> +
> +	# text, ensure unexpanded
> +	k_smush "$cli/k-text-k">  cli-k-text-k-smush&&
> +	cmp cli-k-text-k-smush k-text-k&&
> +	ko_smush "$cli/k-text-ko">  cli-k-text-ko-smush&&
> +	cmp cli-k-text-ko-smush k-text-ko&&
> +
> +	# utf16, even though p4 expands keywords, git-p4 does not
> +	# try to undo that
> +	cmp "$cli/k-utf16-k" k-utf16-k&&
> +	cmp "$cli/k-utf16-ko" k-utf16-ko
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
