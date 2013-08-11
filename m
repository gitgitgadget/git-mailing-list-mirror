From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: Fix occasional truncation of symlink contents.
Date: Sun, 11 Aug 2013 07:57:38 -0400
Message-ID: <20130811115738.GA26658@padd.com>
References: <1375967858-10615-1-git-send-email-ajuncu@ixiacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexandru Juncu <ajuncu@ixiacom.com>,
	Alex Badea <abadea@ixiacom.com>
To: Alexandru Juncu <alexj@rosedu.org>
X-From: git-owner@vger.kernel.org Sun Aug 11 13:57:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8UHR-00007H-E1
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 13:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab3HKL5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 07:57:43 -0400
Received: from honk.padd.com ([74.3.171.149]:52427 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198Ab3HKL5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 07:57:42 -0400
Received: from arf.padd.com (unknown [50.105.10.190])
	by honk.padd.com (Postfix) with ESMTPSA id 692D42B8F;
	Sun, 11 Aug 2013 04:57:41 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 833DD22983; Sun, 11 Aug 2013 07:57:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1375967858-10615-1-git-send-email-ajuncu@ixiacom.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232134>

alexj@rosedu.org wrote on Thu, 08 Aug 2013 16:17 +0300:
> Symlink contents in p4 print sometimes have a trailing
> new line character, but sometimes it doesn't. git-p4
> should only remove the last character if that character
> is '\n'.

Your patch looks fine, and harmless if symlinks continue
to have \n on the end.  I'd like to understand a bit why
this behavior is different for you, though.  Could you do
this test on a symlink in your depot?

Here //depot/symlink points to "symlink-target".  You can
see the \n in position 0o332 below.  What happens on a
symlink in your repo?

    arf-git-test$ p4 fstat //depot/symlink
    ... depotFile //depot/symlink
    ... clientFile /dev/shm/trash directory.t9802-git-p4-filetype/cli/symlink
    ... isMapped 
    ... headAction add
    ... headType symlink
    ... headTime 1376221978
    ... headRev 1
    ... headChange 6
    ... headModTime 1376221978
    ... haveRev 1

    arf-git-test$ p4 -G print //depot/symlink | od -c
    0000000   {   s 004  \0  \0  \0   c   o   d   e   s 004  \0  \0  \0   s
    0000020   t   a   t   s  \t  \0  \0  \0   d   e   p   o   t   F   i   l
    0000040   e   s 017  \0  \0  \0   /   /   d   e   p   o   t   /   s   y
    0000060   m   l   i   n   k   s 003  \0  \0  \0   r   e   v   s 001  \0
    0000100  \0  \0   1   s 006  \0  \0  \0   c   h   a   n   g   e   s 001
    0000120  \0  \0  \0   6   s 006  \0  \0  \0   a   c   t   i   o   n   s
    0000140 003  \0  \0  \0   a   d   d   s 004  \0  \0  \0   t   y   p   e
    0000160   s  \a  \0  \0  \0   s   y   m   l   i   n   k   s 004  \0  \0
    0000200  \0   t   i   m   e   s  \n  \0  \0  \0   1   3   7   6   2   2
    0000220   1   9   7   8   s  \b  \0  \0  \0   f   i   l   e   S   i   z
    0000240   e   s 002  \0  \0  \0   1   5   0   {   s 004  \0  \0  \0   c
    0000260   o   d   e   s 006  \0  \0  \0   b   i   n   a   r   y   s 004
    0000300  \0  \0  \0   d   a   t   a   s 017  \0  \0  \0   s   y   m   l
    0000320   i   n   k   -   t   a   r   g   e   t  \n   0   {   s 004  \0
    0000340  \0  \0   c   o   d   e   s 006  \0  \0  \0   b   i   n   a   r
    0000360   y   s 004  \0  \0  \0   d   a   t   a   s  \0  \0  \0  \0   0
    0000400

Also, what version is your server, from "p4 info":

    Server version: P4D/LINUX26X86_64/2013.1/610569 (2013/03/19)

		-- Pete


> Signed-off-by: Alex Juncu <ajuncu@ixiacom.com>
> Signed-off-by: Alex Badea <abadea@ixiacom.com>
> ---
>  git-p4.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index 31e71ff..a53a6dc 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2180,9 +2180,13 @@ class P4Sync(Command, P4UserMap):
>              git_mode = "100755"
>          if type_base == "symlink":
>              git_mode = "120000"
> -            # p4 print on a symlink contains "target\n"; remove the newline
> +            # p4 print on a symlink sometimes contains "target\n";
> +            # if it does, remove the newline
>              data = ''.join(contents)
> -            contents = [data[:-1]]
> +            if data[-1] == '\n':
> +                contents = [data[:-1]]
> +            else:
> +                contents = [data]
>  
>          if type_base == "utf16":
>              # p4 delivers different text in the python output to -G
> -- 
> 1.8.4.rc0.1.g8f6a3e5
