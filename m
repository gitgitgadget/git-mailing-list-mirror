From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] config: teach "git config --file -" to read from the
 standard input
Date: Sat, 15 Feb 2014 21:12:29 -0500
Message-ID: <CAPig+cSRgpABwzC36FoBst52hCOPieMBTvsTx9CPFoHifHG9yg@mail.gmail.com>
References: <1392421053-937-1-git-send-email-kirill@shutemov.name>
	<1392421053-937-3-git-send-email-kirill@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-From: git-owner@vger.kernel.org Sun Feb 16 03:12:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WErDe-0007QW-Al
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 03:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbaBPCMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 21:12:30 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:54029 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbaBPCMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 21:12:30 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so13032244yhl.23
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 18:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CoSzKVe8hIHVBGfJwj/YExShXf8KuEEtDHBapT00L4A=;
        b=H5CC62fI76kngLQLMFgDUFVIt6a9xL4GwmfKRjngd4luPd88HUkWNE3Z3l5CNGUDhE
         JevXA7Ad6Y7N8H7YPYEWJnxmp0gLVhYzioYh1fUB6wLApboFDLIZJQ1lUxFFrwMOGQBB
         bTL6DgRV8w2TfMUebq3juVofSk36l2uYuiBJi7Fm3/32eeYcqghnaJCYT/vgLLDC7awc
         rtJGxVjGaNzLPIjL1/g+B2XZRjXjrZ/twJubuoeH0W/FhUx2XlmFFYBoN7sDIqxvraq+
         brMs9ri2SN7ymVk71ODhBKpH08PHPZSI4vOzMOCCgbZBFuzXGOEb/m2MDIYKYea36LTU
         yRmA==
X-Received: by 10.236.122.99 with SMTP id s63mr17230026yhh.19.1392516749537;
 Sat, 15 Feb 2014 18:12:29 -0800 (PST)
Received: by 10.170.189.143 with HTTP; Sat, 15 Feb 2014 18:12:29 -0800 (PST)
In-Reply-To: <1392421053-937-3-git-send-email-kirill@shutemov.name>
X-Google-Sender-Auth: Cokn-xpsyFGu86DjtqYIs_913d4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242205>

On Fri, Feb 14, 2014 at 6:37 PM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> The patch extends git config --file interface to allow read config from
> stdin.
>
> Editing stdin or setting value in stdin is an error.
>
> Include by absolute path is allowed in stdin config, but not by relative
> path.
>
> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
> ---
> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index a70707620f14..fda6555024c5 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -122,6 +122,20 @@ test_expect_success 'relative includes from command line fail' '
>         test_must_fail git -c include.path=one config test.one
>  '
>
> +test_expect_success 'absolute includes from stdin work' '
> +       echo "[test]one = 1" >one &&
> +       echo 1 >expect &&
> +       echo "[include]path=\"$PWD/one\"" |

To be Windows-friendly, you may want to use $(pwd). Quoting from t/README:

   When a test checks for an absolute path that a git command generated,
   construct the expected value using $(pwd) rather than $PWD,
   $TEST_DIRECTORY, or $TRASH_DIRECTORY. It makes a difference on
   Windows, where the shell (MSYS bash) mangles absolute path names.
   For details, see the commit message of 4114156ae9.

> +       git config --file - test.one >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'relative includes from stdin line fail' '
> +       echo "[test]one = 1" >one &&
> +       echo "[include]path=one" |
> +       test_must_fail git config --file - test.one
> +'
> +
>  test_expect_success 'include cycles are detected' '
>         cat >.gitconfig <<-\EOF &&
>         [test]value = gitconfig
> --
> 1.8.5.2
