From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] t3312-notes-empty: Test that 'git notes' removes
 empty notes by default
Date: Tue, 4 Nov 2014 23:10:22 -0500
Message-ID: <CAPig+cT4-1bY5tq8KioC8Js3ZUfZCuFEwOZMeoPW4M_brK+QXw@mail.gmail.com>
References: <1415151175-1682-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>, jhf@trifork.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 05:10:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlrvV-0003WV-LL
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 05:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbaKEEKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 23:10:24 -0500
Received: from mail-yh0-f54.google.com ([209.85.213.54]:34880 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaKEEKX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 23:10:23 -0500
Received: by mail-yh0-f54.google.com with SMTP id t59so353290yho.41
        for <git@vger.kernel.org>; Tue, 04 Nov 2014 20:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ckKlvytg3ZzAPkj3Whu8EGMMdbJQu2gIxvunaoXKmrQ=;
        b=w6/sKDiwEUGEahnLeBlC0kQtPwqilTdkj+rMs6wdfMZtULRWQ9Rpcd79YNsoQmr3jf
         wgK/DjHhjq7Olyqc+bke4chsFb5KJxD/DBUKdXYaNSZeAPWU3nLrNd9IJ6PVCpoqZ9dj
         Jtg4u0DJwGTM3s8D3C8WJcRM9eFbpnMZBjKXF0tasjCz828zrJFPQj+Fpc+vXiwfF3vX
         PW9EcO0jJrrxSTXH09b/MnDzdn5qru5hi77W8MnH4l9e9dyyFS2sWu5c16Ga6AmxRnyS
         P8EHr1+9B1L6FmzD0nCr0V1yz2eTpe9uzsALwijellbhIuviJFqMWnVrKCa9Z/ycRXeU
         70Iw==
X-Received: by 10.236.100.115 with SMTP id y79mr6923729yhf.151.1415160622937;
 Tue, 04 Nov 2014 20:10:22 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Tue, 4 Nov 2014 20:10:22 -0800 (PST)
In-Reply-To: <1415151175-1682-1-git-send-email-johan@herland.net>
X-Google-Sender-Auth: bzN8gx3x_zLTIyV3W61sfvq-Ag4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 4, 2014 at 8:32 PM, Johan Herland <johan@herland.net> wrote:
> Add test cases documenting the current behavior when trying to
> add/append/edit empty notes. This is in preparation for adding
> --allow-empty; to allow empty notes to be stored.
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  t/t3312-notes-empty.sh | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100755 t/t3312-notes-empty.sh
>
> diff --git a/t/t3312-notes-empty.sh b/t/t3312-notes-empty.sh
> new file mode 100755
> index 0000000..2806d27
> --- /dev/null
> +++ b/t/t3312-notes-empty.sh
> @@ -0,0 +1,58 @@
> +#!/bin/sh
> +
> +test_description='Test adding/editing of empty notes'
> +. ./test-lib.sh
> +
> +cat >fake_editor.sh <<\EOF
> +#!/bin/sh
> +echo "$MSG" >"$1"
> +echo "$MSG" >& 2
> +EOF
> +chmod a+x fake_editor.sh

write_script() would allow you to drop the #!/bin/sh and chmod lines.

> +GIT_EDITOR=./fake_editor.sh
> +export GIT_EDITOR
> +
> +test_expect_success 'setup' '
> +       test_commit one &&
> +       empty_blob=$(git hash-object -w /dev/null)
> +'
> +
> +cleanup_notes() {
> +       git update-ref -d refs/notes/commits
> +}
> +
> +cat >expect_missing <<\EOF
> +commit d79ce1670bdcb76e6d1da2ae095e890ccb326ae9
> +Author: A U Thor <author@example.com>
> +Date:   Thu Apr 7 15:13:13 2005 -0700
> +
> +    one
> +EOF

Rather than hard-coding this output, generating it would make the test
script less fragile:

    git log -1 >expect_missing

> +verify_missing() {
> +       git log -1 > actual &&
> +       test_cmp expect_missing actual &&
> +       ! git notes list HEAD
> +}
> +
> +for cmd in \
> +       'add' \
> +       'add -F /dev/null' \
> +       'add -m ""' \
> +       'add -c "$empty_blob"' \
> +       'add -C "$empty_blob"' \
> +       'append' \
> +       'append -F /dev/null' \
> +       'append -m ""' \
> +       'append -c "$empty_blob"' \
> +       'append -C "$empty_blob"' \
> +       'edit'
> +do
> +       test_expect_success "'git notes $cmd' removes empty note" "
> +               cleanup_notes &&
> +               MSG= git notes $cmd &&
> +               verify_missing
> +       "
> +done

Each -c/-C case fails for me when trying to read $empty_object. For example:

fatal: Failed to read object 'e69de29bb2d1d6434b8b29ae775ad8c2e48c5391'.
not ok 5 - 'git notes add -c "$empty_blob"' removes empty note

> +
> +test_done
> --
> 2.0.0.rc4.501.gdaf83ca
