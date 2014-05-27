From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/5] commit test: Use write_script
Date: Tue, 27 May 2014 18:30:42 -0400
Message-ID: <CAPig+cQt0mfBTChw8y=2Jg3rNsSr+neDCresptBafPDQixseXA@mail.gmail.com>
References: <20140525062427.GA94219@sirius.att.net>
	<1401130586-93105-1-git-send-email-caleb@calebthompson.io>
	<1401130586-93105-4-git-send-email-caleb@calebthompson.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Caleb Thompson <cjaysson@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 00:30:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpPtQ-0006Ol-6y
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 00:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbaE0Wao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 18:30:44 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:57824 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbaE0Wan (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 18:30:43 -0400
Received: by mail-yk0-f172.google.com with SMTP id 79so7700612ykr.17
        for <git@vger.kernel.org>; Tue, 27 May 2014 15:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1WGl7H67cWiREPleIQcQWjnvkRLk2vAG8g0kJNdjkk0=;
        b=UkDcl7JlBPAqA2mhFvm2yFCnJjYoXYvMv2N5jofFNvGxIgPYou28T28zIdj2S4jI8n
         SM2zLPbgzFqPxP/t6wSr2qeNdsBHmafa9YZJGzOepk+WbRnqpSL1tyk18Rsdw6gsXUPY
         n35G0NlwvmuL5WBf3OdWQbrZ1kqLIcdobhfzdbrNE82TUgbE6rtss8FQ6bGCiu2Fd6Mr
         TvmN56vOYJu+HK7e2+NVf5ZXGK5MKfXuNN297e/XvjBCCGygJMBD0SnEvZXaVWHEVbfj
         xCGU9aEkqmw27bprRCTLIzo0mlzsISvAcDO04omMnORXHklVC6dLP5wdwSQqLr/gjYlA
         fQpA==
X-Received: by 10.236.134.169 with SMTP id s29mr6802727yhi.4.1401229842749;
 Tue, 27 May 2014 15:30:42 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Tue, 27 May 2014 15:30:42 -0700 (PDT)
In-Reply-To: <1401130586-93105-4-git-send-email-caleb@calebthompson.io>
X-Google-Sender-Auth: 6rXpySpV0NezpjoZbDEqhQ4V6Ss
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250243>

On Mon, May 26, 2014 at 2:56 PM, Caleb Thompson <cjaysson@gmail.com> wrote:
> Use write_script from t/test-lib-functions instead of cat, shebang, and
> chmod.
>
> Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
> ---
>  t/t7507-commit-verbose.sh | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 3b06d73..e62d921 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -3,11 +3,9 @@
>  test_description='verbose commit template'
>  . ./test-lib.sh
>
> -cat >check-for-diff <<EOF
> -#!$SHELL_PATH
> -exec grep '^diff --git' "\$1"
> +write_script check-for-diff <<-EOF
> +       exec grep '^diff --git' "\$1"

Food for thought:

The original code used <<EOF since it needed $SHELL_PATH to be
evaluated at script creation time, and took special care to escape $1
in the 'grep' invocation since $1 should be evaluated only at script
execution time.

With the change to write_script(), nothing within the here-doc
requires evaluation, yet you are still using the evaluating <<-EOF
form (and manually escaping $1). The intent might be clearer if you
switch to <<-\EOF which suppresses evaluation (and drop the manual
escaping of $1).

The same observation applies to the new write_script() invocation to
create check-for-no-diff in patch 5.

>  EOF
> -chmod +x check-for-diff
>  test_set_editor "$(pwd)/check-for-diff"
>
>  cat >message <<'EOF'
> --
> 1.9.3
