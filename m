From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Improvements to git-archive tests and add_submodule_odb()
Date: Tue, 3 Dec 2013 04:26:05 -0500
Message-ID: <CAPig+cTUjvfWLC5vX0=BwtSDb613E9jMoyVXWp=de_Tyb5Ei7w@mail.gmail.com>
References: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
	<8143BEDD-8CFA-46ED-9B52-760BBB1DACE8@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Nick Townsend <nick.townsend@mac.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 10:26:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnmFD-0006jL-Lm
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 10:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166Ab3LCJ0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 04:26:10 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:51060 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab3LCJ0H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 04:26:07 -0500
Received: by mail-la0-f44.google.com with SMTP id ep20so9049294lab.31
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 01:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qLwhwXZk0tzw5D8TuLmhUv4xdFPRhUqpK7dOmbU8CbE=;
        b=FfqyyI6Y7YYoK7vDko7vPo+n9gThGPOJEcnIKte2TsLXjn5uhGI9U44iitJm5u+Bl9
         APDn+URaWl97oVqsLnjkl6NFS50v37KEwLtzV9Ut8ni8tPqIafypgUTZKq2t0WHbpngA
         FNyhQ2nnUwctCNV4dceRRs2+m1lHo3wbEBFM2e3AgNG54kgzcEaZk+YlqMYJZyeQ9wxk
         5FOchIXXxlZMAIZryvvq9xQdF+r46ca20KBEd7U6ij+qqa6s9gUB0XXkw0FzpvgCADy6
         5d4PSsyG6L2A4OM/88VMuliKEZsdxyPjWxAs4fx3Fr83x7Y6IB8ilPYXfpC6hTiTA3dE
         HNng==
X-Received: by 10.152.1.5 with SMTP id 5mr2943808lai.20.1386062766017; Tue, 03
 Dec 2013 01:26:06 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Tue, 3 Dec 2013 01:26:05 -0800 (PST)
In-Reply-To: <8143BEDD-8CFA-46ED-9B52-760BBB1DACE8@mac.com>
X-Google-Sender-Auth: KU8GJCXrUuyjib1f-LApWv7TlLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238679>

On Mon, Dec 2, 2013 at 7:16 PM, Nick Townsend <nick.townsend@mac.com> wrote:
> From: Nick Townsend <nick.townsend@mac.com>
> Date: Sat, 30 Nov 2013 16:54:20 -0800
> Subject: [PATCH 2/2] Additional git-archive tests
>
> Interplay between paths specified in three ways now tested:
> * After a : in the tree-ish,
> * As a pathspec in the command,
> * By virtue of the current working directory
>
> Note that these tests are based on the behaviours
> as found in 1.8.5. They may not be intentional.
> They were developed to regression test enhancements
> made to parse_treeish_arg() in archive.c
>
> Signed-off-by: Nick Townsend <nick.townsend@mac.com>
> ---
>  t/t5004-archive-corner-cases.sh | 67 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
> index 67f3b54..8b70e4a 100755
> --- a/t/t5004-archive-corner-cases.sh
> +++ b/t/t5004-archive-corner-cases.sh
> @@ -113,4 +113,71 @@ test_expect_success 'archive empty subtree by direct pathspec' '
>         check_dir extract sub
>  '
>
> +test_expect_success 'setup - repository with subdirs' '
> +       mkdir -p a/b/{c,d} &&

Unportable use of {foo,bar} notation. POSIX shells [1] will just
create a directory named "{c,d}". Better to spell it out:

    mkdir -p a/b/c a/b/d &&

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_13

> +       echo af >a/af &&
> +       echo bf >a/b/bf &&
> +       echo cf >a/b/c/cf &&
> +       git add a &&
> +       git commit -m "commit 1" &&
> +       git tag -a -m "rev-1" rev-1
> +'
> +
> +test_expect_success 'archive subtree from root by treeish' '
> +       git archive --format=tar HEAD:a >atreeroot.tar &&
> +       make_dir extract &&
> +       "$TAR" xf atreeroot.tar -C extract &&
> +       check_dir extract af b b/bf b/c b/c/cf
> +'
> +
> +test_expect_success 'archive subtree from root with pathspec' '
> +       git archive --format=tar HEAD a >atreepath.tar &&
> +       make_dir extract &&
> +       "$TAR" xf atreepath.tar -C extract &&
> +       check_dir extract a a/af a/b a/b/bf a/b/c a/b/c/cf
> +'
> +
> +test_expect_success 'archive subtree from root by 2-level treeish' '
> +       git archive --format=tar HEAD:a/b >abtreeroot.tar &&
> +       make_dir extract &&
> +       "$TAR" xf abtreeroot.tar -C extract &&
> +       check_dir extract bf c c/cf
> +'
> +
> +test_expect_success 'archive subtree from subdir' '
> +       cd a &&
> +       git archive --format=tar HEAD >../asubtree.tar &&
> +       cd .. &&
> +       make_dir extract &&
> +       "$TAR" xf asubtree.tar -C extract &&
> +       check_dir extract af b b/bf b/c b/c/cf
> +'

If git-archive fails, the subsequent 'cd ..' will not be invoked,
hence all tests following this one will fail since the current
directory has not been restored. If you place the 'cd a' in a
subshell, then the current directory remains unchanged for commands
outside the subshell (and you can drop the 'cd ..'):

    (
    cd a &&
    git archive ...
    ) &&
    make_dir ...
    ...

Ditto for the remaining tests which share this problem.

> +
> +test_expect_success 'archive subtree from subdir with treeish' '
> +       cd a &&
> +       git archive --format=tar HEAD:./b >../absubtree.tar &&
> +       cd .. &&
> +       make_dir extract &&
> +       "$TAR" xf absubtree.tar -C extract &&
> +       check_dir extract bf c c/cf
> +'
> +
> +test_expect_success 'archive subtree from subdir with treeish and pathspec' '
> +       cd a &&
> +       git archive --format=tar HEAD:./b c >../absubtree.tar &&
> +       cd .. &&
> +       make_dir extract &&
> +       "$TAR" xf absubtree.tar -C extract &&
> +       check_dir extract c c/cf
> +'
> +
> +test_expect_success 'archive subtree from subdir with alt treeish' '
> +       cd a &&
> +       git archive --format=tar HEAD:b >../abxsubtree.tar &&
> +       cd .. &&
> +       make_dir extract &&
> +       "$TAR" xf abxsubtree.tar -C extract &&
> +       check_dir extract bf c c/cf
> +'
> +
>  test_done
> --
> 1.8.5.4.g9d8cd78.dirty
