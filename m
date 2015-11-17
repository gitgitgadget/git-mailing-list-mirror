From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] sendemail: teach git-send-email to dump alias names
Date: Tue, 17 Nov 2015 03:07:38 -0500
Message-ID: <CAPig+cSfk0Xj8Wft6VbnOXtkc43eLZBv7g99AYFdgdGfFQ2nzQ@mail.gmail.com>
References: <1447720166-9941-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 09:07:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZybIm-0003AS-SC
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 09:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbbKQIHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 03:07:40 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36298 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbbKQIHj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 03:07:39 -0500
Received: by vkha189 with SMTP id a189so59805vkh.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 00:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bmZC9AYAXkWB5DunvMuPe8SiSktuRFnz4noQBfNLA0M=;
        b=Yt96PkSbxaghmo1P65OlZnJyVbCmgF3S7zkHoD+uNaycv3IdZZQEAZarqEIwJocyAI
         +1BT5y8hbUXZ0gbJeh/2LND+oDqiQm3CViikq7QNPPny6I6iRr2UROqoALYNDWnavBfT
         KJURCr6LTgjIl8UDOYg8UM1kk0hB7ibwAkW2hjFknHx7H8JtmFvM9WCyz92JSfw+iH0X
         Px/KITSzieb1UEJ53G/BX4DOYmcIpPpT/7owYKmNWeCkKWdFAT15Oh1RNgDwYNtddhPv
         Ybgmf4j+iTUo+cjdy6pFctmZTrIeYA7yfTzbAgX2ptsTAB1YoKayknoHbjekYR81E0RE
         ZqrQ==
X-Received: by 10.31.16.213 with SMTP id 82mr2275982vkq.117.1447747658811;
 Tue, 17 Nov 2015 00:07:38 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Tue, 17 Nov 2015 00:07:38 -0800 (PST)
In-Reply-To: <1447720166-9941-1-git-send-email-jacob.e.keller@intel.com>
X-Google-Sender-Auth: wnuKs3CqxpCNOhd5b94YxInOC2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281384>

On Mon, Nov 16, 2015 at 7:29 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> Add an option "dump-aliases" which changes the default behavior of

It would be easier to understand that this is a new command-line
option (as opposed to a configuration or other option) if you spelled
it --dump-aliases (with the leading dashes) rather than
"dump-aliases".

> git-send-email. This mode will simply read the alias files configured by
> sendemail.aliasesfile and sendemail.aliasfiletype and dump a list of all
> configured aliases, one per line. The intended use case for this option
> is the bash-completion script which will use it to autocomplete aliases
> on the options which take addresses.
>
> Add some tests for the new option.

I think this patch adds only a single test (not "tests").

> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> @@ -10,6 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git send-email' [options] <file|directory|rev-list options>...
> +'git send-email' --list-aliases

s/list/dump/

>  DESCRIPTION
> @@ -387,6 +388,15 @@ default to '--validate'.
>         Send emails even if safety checks would prevent it.
>
>
> +Information
> +~~~~~~~~~~~
> +
> +--dump-aliases::
> +       Instead of the standard operation, dump all aliases found in the
> +       configured alias file(s), followed by its expansion. See
> +       'sendemail.aliasesfile' for more information about aliases.

This doesn't describe the actual format of the output. "followed by"
could mean the same line or it could mean that all expansions are
jumbled together on the next line, or that each expansion has a line
of its own. A more detailed explanation would be helpful.

However, see my other email where I discuss possibly punting on the
alias expansions (or perhaps dumping them in an unambiguous format).

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> @@ -1579,6 +1579,24 @@ test_sendmail_aliases () {
> +test_sendmail_dump_aliases () {
> +       msg="$1" && shift &&
> +       expect="$@" &&
> +       cat >.tmp-email-aliases &&
> +
> +       test_expect_success $PREREQ "$msg" '
> +               clean_fake_sendmail && rm -fr outdir &&
> +               git config --replace-all sendemail.aliasesfile \
> +                       "$(pwd)/.tmp-email-aliases" &&
> +               git config sendemail.aliasfiletype sendmail &&
> +               git send-email --dump-aliases 2>errors >out &&
> +               for i in $expect
> +               do
> +                       grep "$i" out || return 1
> +               done
> +       '
> +}

I suppose your inspiration for this new function was
test_sendmail_aliases() which was added by 514554c (t9001: refactor
sendmail aliases test infrastructure, 2015-05-31). While it made sense
to introduce test_sendmail_aliases() since it is needed by several
tests, this new function, test_sendmail_dump_aliases(), is used by
only one test. Unfortunately, this sort of function is uglier and more
difficult to understand than the equivalent code embedded directly in
the test itself. Therefore, if you don't expect to add more tests of
--dump-aliases, then I recommend just incorporating this code directly
into the test so as to avoid burdening reviewers and future readers of
the code with unnecessary complexity.

Also, this isn't really testing that the output of --dump-aliases has
the expected format; it's only testing if some name appears *anywhere*
in the output, which is likely way too loose (especially since alias
expansions are included in the output).

>  test_sendmail_aliases 'sendemail.aliasfiletype=sendmail' \
>         'awol@example\.com' \
>         'bob@example\.com' \
> @@ -1593,6 +1611,21 @@ test_sendmail_aliases 'sendemail.aliasfiletype=sendmail' \
>         bcgrp: bob, chloe, Other <o@example.com>
>         EOF
>
> +test_sendmail_dump_aliases '--dump-alias-names sendemail.aliasfiletype=sendmail' \

s/dump-alias-names/dump-aliases/

Also, what's "sendemail.aliasfiletype=sendmail" doing in the title of
this test? (I presume you copy/pasted it from the preceding test.)
Since --dump-alises is independent of the aliases file type, it's
actively misleading to mention 'aliasefiletype' and 'sendmail' in the
test title, thus it should be removed.

> +       'alice' \
> +       'bob' \
> +       'chloe' \
> +       'abgroup' \
> +       'bcgrp' <<-\EOF
> +       alice: Alice W Land <awol@example.com>
> +       bob: Robert Bobbyton <bob@example.com>
> +       # this is a comment
> +          # this is also a comment

I realize that you copied this from the preceding test, however,
having these comment lines here is distracting and a bit misleading
since they are superfluous to this test. Keep the test lean and
meaningful (to readers) by including only content relevant to what is
being tested.

> +       chloe: chloe@example.com
> +       abgroup: alice, bob
> +       bcgrp: bob, chloe, Other <o@example.com>
> +       EOF

I'm a bit unhappy about how this new test got plopped right in the
middle of the four tests which employ test_sendmail_aliases(),
breaking the flow of those tests for anyone reading the code. Please
move this test outside of that block of tests.

>  test_sendmail_aliases 'sendmail aliases line folding' \
>         alice1 \
>         bob1 bob2 \
> --
> 2.6.3.491.g3e3f6ce
