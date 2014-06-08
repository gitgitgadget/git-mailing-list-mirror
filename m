From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] completion: Handle '!f() { ... }; f' aliases
Date: Sun, 8 Jun 2014 05:02:43 -0400
Message-ID: <CAPig+cQKtVoc7X2SBE8L1pSpnwQxkmFF6pL2PL-7RUoFq5h8gw@mail.gmail.com>
References: <1402150221-25548-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jun 08 11:02:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtZ07-0007bU-JG
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jun 2014 11:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbaFHJCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2014 05:02:45 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:48597 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbaFHJCo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2014 05:02:44 -0400
Received: by mail-yk0-f181.google.com with SMTP id 9so330678ykp.12
        for <git@vger.kernel.org>; Sun, 08 Jun 2014 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cJP+qWUOu9rIEO3zWgHGy7k0SOQ+QH3MiTe6liEQN8Y=;
        b=HOSpAOgHkqaOkBes30r18iYDHdThHQjaZAKkFPtOiRRF23+dWVItPuoVsUP2Pn89FF
         yrcxsWbU3AY7NkCgg6wnnGn75nFfb4z3917QaF/9yuxa5NLw5FX4ZkMUzQv+okOJ9QK2
         MzuxshIlKHODepHpj3LtpIEhHOLz++hKOoL13fcIlnSughh8w19DJvqyJM0+dL++4wJJ
         EilPl8iS82MtsG3Se2wNN26W/bxMla8AFCdb30zoRM2ifJoRuJR0R6n0htk6D3rU1RdP
         wIIFQEPv8IPpp2jSzj35MgtHqbzqI4boIdjzCzZv9AbHITT09qFCy8vJ7MmvUu4C7Ge0
         Bc6w==
X-Received: by 10.236.135.228 with SMTP id u64mr1854529yhi.18.1402218163209;
 Sun, 08 Jun 2014 02:02:43 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Sun, 8 Jun 2014 02:02:43 -0700 (PDT)
In-Reply-To: <1402150221-25548-1-git-send-email-prohaska@zib.de>
X-Google-Sender-Auth: cOImv5r2Ia8VXuNnB5fAbPEhxk8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251049>

On Sat, Jun 7, 2014 at 10:10 AM, Steffen Prohaska <prohaska@zib.de> wrote:
> '!f() { ... }; f' is a recommended pattern to declare more complex
> aliases (see git wiki [1]).  This commit teaches the completion to
> handle them.
>
> When determining which completion to use for an alias, the opening brace
> is now ignored in order to continue the search for a git command inside
> the function body.  For example, the alias '!f() { git commit ... }' now
> triggers commit completion.  Previously, the search stopped on '{', and
> the completion tried it to determine how to complete, which obviously
> was useless.
>
> Furthermore, the null command ':' is now skipped, so that it can be used
> as a workaround to declare the desired completion style.  For example,
> the alias '!f() { : git commit ; if ...  ' now triggers commit
> completion.
>
> [1] https://git.wiki.kernel.org/index.php/Aliases
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 2d4beb5..ea48681 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -550,6 +550,26 @@ test_expect_success 'complete files' '
>         test_completion "git add mom" "momified"
>  '
>
> +test_expect_success 'completion uses <cmd> completion for alias !f() { VAR=val git <cmd> ... }' '
> +       git config alias.co "!f() { VAR=val git checkout ... ; } f" &&

test_config would be an appropriate replacement for "git config" +
"git config --unset".

> +       test_completion "git co m" <<-\EOF &&
> +       master Z
> +       mybranch Z
> +       mytag Z
> +       EOF
> +       git config --unset alias.co
> +'
> +
> +test_expect_success 'completion used <cmd> completion for alias !f() { : git <cmd> ; ... }' '
> +       git config alias.co "!f() { : git checkout ; if ... } f" &&

Ditto.

> +       test_completion "git co m" <<-\EOF &&
> +       master Z
> +       mybranch Z
> +       mytag Z
> +       EOF
> +       git config --unset alias.co
> +'
> +
>  test_expect_failure 'complete with tilde expansion' '
>         git init tmp && cd tmp &&
>         test_when_finished "cd .. && rm -rf tmp" &&
> --
> 2.0.0.244.g4e8e734
