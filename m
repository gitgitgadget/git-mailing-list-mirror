From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] test-lib-functions: detect test_when_finished in subshell
Date: Sun, 6 Sep 2015 05:51:43 -0400
Message-ID: <CAPig+cR+_nPFbJmOf3s90oB=Jedg1B3YgOCzSwWa8nwP8-QbeA@mail.gmail.com>
References: <20150905085429.GB25039@sigill.intra.peff.net>
	<cover.1441458341.git.john@keeping.me.uk>
	<59a8583f79c5ac4661f140262e01cd602286f740.1441458341.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Sep 06 11:51:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYWc1-0008KF-Kt
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 11:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbbIFJvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 05:51:46 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34459 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbbIFJvo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 05:51:44 -0400
Received: by ykdg206 with SMTP id g206so57599768ykd.1
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 02:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RyNn1+rZiwwIKBjmDqEhyjDYfDwRWS8pPrbUu8cZz00=;
        b=NWA6CQJEJpBxkU2KxaQhTCppjvI6BgKUNu5Aye2ZOmlgTdqqUiS3Wmillz3d4XKx51
         m0LG3cE1vk2DzrkifFjDBuO2NGnZFJk0Cv4ED3cQ1DCNY5i+nGb0HHbM1TqRkKFhPOOv
         mkHLVQ1h4QGGfR9aKGdn/mZItmhT/machrVKTsKT5DirxcxzK4+PRVl+2pTOxgAQerQP
         MprnfS3gAzn6qOmGttGZrxSv/ZRTJi8JLIA73nRFZTiZkciYB33W3FH95FOF/NVg8Kg8
         Qz9zzsx6WR8exy+uqsKaehlW2MLYThI9PxKwvNC5V0h+4I0HZn8s/6tabsk0UUmuKpp1
         etMg==
X-Received: by 10.170.161.85 with SMTP id c82mr14107287ykd.13.1441533103781;
 Sun, 06 Sep 2015 02:51:43 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 6 Sep 2015 02:51:43 -0700 (PDT)
In-Reply-To: <59a8583f79c5ac4661f140262e01cd602286f740.1441458341.git.john@keeping.me.uk>
X-Google-Sender-Auth: AcU6UyGNVwBm8C_VLVAh6Jd3P4s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277420>

On Sat, Sep 5, 2015 at 9:12 AM, John Keeping <john@keeping.me.uk> wrote:
> test_when_finished does nothing in a subshell because the change to
> test_cleanup does not affect the parent.
>
> There is no POSIX way to detect that we are in a subshell ($$ and $PPID
> are specified to remain unchanged), but we can detect it on Bash and
> fall back to ignoring the bug on other shells.

I'm not necessarily advocating this, but think it's worth mentioning
that an alternate solution would be to fix test_when_finished() to work
correctly in subshells rather than disallowing its use. This can be done
by having test_when_finished() collect the cleanup actions in a file
rather than in a shell variable.

Pros:
* works in subshells
* portable across all shells (no Bash special-case)
* one less rule (restriction) for test writers to remember

Cons:
* slower
* could interfere with tests expecting very specific 'trash' directory
  contents (but locating this file under .git might make it safe)

> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  t/test-lib-functions.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 0e80f37..6dffb8b 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -736,6 +736,11 @@ test_seq () {
>  # what went wrong.
>
>  test_when_finished () {
> +       # We cannot detect when we are in a subshell in general, but by
> +       # doing so on Bash is better than nothing (the test will
> +       # silently pass on other shells).
> +       test "${BASH_SUBSHELL-0}" = 0 ||
> +       error "bug in test script: test_when_finished does nothing in a subshell"
>         test_cleanup="{ $*
>                 } && (exit \"\$eval_ret\"); eval_ret=\$?; $test_cleanup"
>  }
> --
> 2.5.0.466.g9af26fa
