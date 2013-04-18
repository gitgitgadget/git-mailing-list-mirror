From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] submodule: drop the top-level requirement
Date: Thu, 18 Apr 2013 19:54:24 -0400
Message-ID: <CAPig+cR7TS-sahgdZPkWkeE2Sy=GimGUVMSekgqtomWKfdiatA@mail.gmail.com>
References: <cover.1365539059.git.john@keeping.me.uk>
	<cover.1366314439.git.john@keeping.me.uk>
	<6e4122f3eedec3f520028b5598b78e0d59e5d12b.1366314439.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Apr 19 01:54:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USyet-0003cj-Hd
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967496Ab3DRXy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 19:54:27 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:52864 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967289Ab3DRXy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 19:54:26 -0400
Received: by mail-la0-f51.google.com with SMTP id fo13so1053879lab.10
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 16:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=a4+cfnsF4syPGNQgCRaWRS3ni5UqrTEjaK/DtV82anU=;
        b=WXpRgzS47BbecgL+nsDbMWZeg+SxuHNZYhJza/Kk/oYS/h6YXs0sQsIRZOpq0CKAZR
         vSL7Of7cb6x0T34ECsxXYdHALmxswd0r2XX4XuVplZa7upXF8Aov6Nr3dFaeMyvg40b1
         LFJmzseMVUFsdiuilrfcRWv3MtmZmlkEY81RkmGfjMzZdleuOODTRetMWb1C0jpH7OSM
         YYlIXpDkFzvUPl94VaX27xdzYkqlHCiFCaa95yzAygT8D4O+n7HGkAAjPZh9cA8w1xG1
         rMiLwHoGX4EeuTpQK4mQhASwsSV7oV1Tly0dUwTkps8gc9/eZTc2wlZhPDZX2QgknOko
         sxDw==
X-Received: by 10.152.6.229 with SMTP id e5mr6956628laa.6.1366329265020; Thu,
 18 Apr 2013 16:54:25 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Thu, 18 Apr 2013 16:54:24 -0700 (PDT)
In-Reply-To: <6e4122f3eedec3f520028b5598b78e0d59e5d12b.1366314439.git.john@keeping.me.uk>
X-Google-Sender-Auth: 8rXHI6Cmv3su-R3jU-FM1IFJmY4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221718>

On Thu, Apr 18, 2013 at 3:50 PM, John Keeping <john@keeping.me.uk> wrote:
> Use the new rev-parse --prefix option to process all paths given to the
> submodule command, dropping the requirement that it be run from the
> top-level of the repository.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index ff26535..ca0a6ab 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -212,6 +212,24 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
>         test_cmp empty untracked
>  '
>
> +test_expect_success 'submodule add in subdir' '

A particularly minor nit. Existing subdirectory-related tests in t7400
spell out "subdirectory" fully, so perhaps for consistency:
s/subdir/subdirectory/

> +       echo "refs/heads/master" >expect &&
> +       >empty &&
> +
> +       mkdir addtest/sub &&
> +       (
> +               cd addtest/sub &&
> +               git submodule add "$submodurl" ../realsubmod3 &&
> +               git submodule init
> +       ) &&
> +
> +       rm -f heads head untracked &&
> +       inspect addtest/realsubmod3 ../.. &&
> +       test_cmp expect heads &&
> +       test_cmp expect head &&
> +       test_cmp empty untracked
> +'
> +
>  test_expect_success 'setup - add an example entry to .gitmodules' '
>         GIT_CONFIG=.gitmodules \
>         git config submodule.example.url git://example.com/init.git
> @@ -319,6 +337,15 @@ test_expect_success 'status should be "up-to-date" after update' '
>         grep "^ $rev1" list
>  '
>
> +test_expect_success 'status works correctly from a subdirectory' '

Good: "subdirectory"

> +       mkdir sub &&
> +       (
> +               cd sub &&
> +               git submodule status >../list
> +       ) &&
> +       grep "^ $rev1" list
> +'
> +
>  test_expect_success 'status should be "modified" after submodule commit' '
>         (
>                 cd init &&
> diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> index 30b429e..992b66b 100755
> --- a/t/t7401-submodule-summary.sh
> +++ b/t/t7401-submodule-summary.sh
> @@ -45,6 +45,20 @@ EOF
>         test_cmp expected actual
>  "
>
> +test_expect_success 'run summary from subdir' '

t7401 does not have any existing subdirectory-related tests, but for
consistency with t7400, perhaps: s/subdir/subdirectory/

> +       mkdir sub &&
> +       (
> +               cd sub &&
> +               git submodule summary >../actual
> +       ) &&
> +       cat >expected <<-EOF &&
> +* ../sm1 0000000...$head1 (2):
> +  > Add foo2
> +
> +EOF
> +       test_cmp expected actual
> +'
> +
>  commit_file sm1 &&
>  head2=$(add_file sm1 foo3)
