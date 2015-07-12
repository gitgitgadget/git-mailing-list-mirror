From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] rev-parse --parseopt: allow [*=?!] in argument hints
Date: Sun, 12 Jul 2015 19:22:34 +0100
Organization: OPDS
Message-ID: <E1A07B6921124F5B8B6537C21556BD86@PhilipOakley>
References: <1436693990-2908-1-git-send-email-ilya.bobyr@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Pierre Habouzit" <madcoder@debian.org>,
	"Ilya Bobyr" <ilya.bobyr@gmail.com>
To: <ilya.bobyr@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 12 20:22:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZELtG-0007qB-WC
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 20:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbbGLSWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 14:22:09 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:7391 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750890AbbGLSWI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jul 2015 14:22:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DVaQA6r6JVPEsrBlxbgxRUaYZQbbVzggyDZQQEAoEbC00BAQEBAQEHAQEBAUEkG0EBAgKDWAUBAQEBAgEIAQEdER4BASELAgMFAgEDFQELJRQBBAgSBgcDFAYBEggCAQIDAYgIAwoMCbgbiSwNhVgBCwEfi0yCTYFvSoMegRQFhwmFIziHTQGBBoNihTWBZ5FHhyOBCYMZPTGBBoFFAQEB
X-IPAS-Result: A2DVaQA6r6JVPEsrBlxbgxRUaYZQbbVzggyDZQQEAoEbC00BAQEBAQEHAQEBAUEkG0EBAgKDWAUBAQEBAgEIAQEdER4BASELAgMFAgEDFQELJRQBBAgSBgcDFAYBEggCAQIDAYgIAwoMCbgbiSwNhVgBCwEfi0yCTYFvSoMegRQFhwmFIziHTQGBBoNihTWBZ5FHhyOBCYMZPTGBBoFFAQEB
X-Header: TalkTalk
X-IronPort-AV: E=Sophos;i="5.15,457,1432594800"; 
   d="scan'208";a="543933050"
Received: from host-92-6-43-75.as43234.net (HELO PhilipOakley) ([92.6.43.75])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 12 Jul 2015 19:22:04 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273900>

From: <ilya.bobyr@gmail.com> Sent: Sunday, July 12, 2015 10:39 AM
> From: Ilya Bobyr <ilya.bobyr@gmail.com>
>
> It is not very likely that any of the "*=?!" Characters would be 
> useful
> in the argument short or long names.  On the other hand, there are
> already argument hints that contain the "=" sign.  It used to be
> impossible to include any of the "*=?!" signs in the arguments hints
> before.

I found this difficult to parse, and had to check the man pages to 
understand the proposal, which were nearly as bad (for me).

Perhaps:
"In the 'git rev-parse' parseopt mode, the the short and long options 
<opt-spec> cannot contain any of the terminating flag characters "*=?!". 
This restriction does not apply to the argument name hint <arg-hint> 
which is space terminated.

Allow flag characters in the <arg-hint>, after the arg-hint's initial 
non flag character."

Would that be a correct understanding?
--
Philip

>
> Added test case with equals sign in the argument hint and updated the
> test to perform all the operations in test_expect_success matching the
> t\README requirements and allowing commands like
>
>    ./t1502-rev-parse-parseopt.sh --run=1-2
>
> to stop at the test case 2 without any further modification of the 
> test
> state area.
>
> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
> ---
> builtin/rev-parse.c           | 36 ++++++++--------
> t/t1502-rev-parse-parseopt.sh | 97 
> ++++++++++++++++++++++++++-----------------
> 2 files changed, 77 insertions(+), 56 deletions(-)
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index b623239..205ea67 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -423,17 +423,25 @@ static int cmd_parseopt(int argc, const char 
> **argv, const char *prefix)
>  o->flags = PARSE_OPT_NOARG;
>  o->callback = &parseopt_dump;
>
> - /* Possible argument name hint */
> + /* parse names, type and the hint */
>  end = s;
> - while (s > sb.buf && strchr("*=?!", s[-1]) == NULL)
> - --s;
> - if (s != sb.buf && s != end)
> - o->argh = xmemdupz(s, end - s);
> - if (s == sb.buf)
> - s = end;
> + s = sb.buf;
> +
> + /* name(s) */
> + while (s < end && strchr("*=?!", *s) == NULL)
> + ++s;
> +
> + if (s - sb.buf == 1) /* short option only */
> + o->short_name = *sb.buf;
> + else if (sb.buf[1] != ',') /* long option only */
> + o->long_name = xmemdupz(sb.buf, s - sb.buf);
> + else {
> + o->short_name = *sb.buf;
> + o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
> + }
>
> - while (s > sb.buf && strchr("*=?!", s[-1])) {
> - switch (*--s) {
> + while (s < end && strchr("*=?!", *s)) {
> + switch (*s++) {
>  case '=':
>  o->flags &= ~PARSE_OPT_NOARG;
>  break;
> @@ -450,14 +458,8 @@ static int cmd_parseopt(int argc, const char 
> **argv, const char *prefix)
>  }
>  }
>
> - if (s - sb.buf == 1) /* short option only */
> - o->short_name = *sb.buf;
> - else if (sb.buf[1] != ',') /* long option only */
> - o->long_name = xmemdupz(sb.buf, s - sb.buf);
> - else {
> - o->short_name = *sb.buf;
> - o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
> - }
> + if (s < end)
> + o->argh = xmemdupz(s, end - s);
>  }
>  strbuf_release(&sb);
>
> diff --git a/t/t1502-rev-parse-parseopt.sh 
> b/t/t1502-rev-parse-parseopt.sh
> index ebe7c3b..d5e5720 100755
> --- a/t/t1502-rev-parse-parseopt.sh
> +++ b/t/t1502-rev-parse-parseopt.sh
> @@ -3,7 +3,39 @@
> test_description='test git rev-parse --parseopt'
> . ./test-lib.sh
>
> -sed -e 's/^|//' >expect <<\END_EXPECT
> +test_expect_success 'setup optionspec' '
> + sed -e "s/^|//" >optionspec <<\EOF
> +|some-command [options] <args>...
> +|
> +|some-command does foo and bar!
> +|--
> +|h,help    show the help
> +|
> +|foo       some nifty option --foo
> +|bar=      some cool option --bar with an argument
> +|b,baz     a short and long option
> +|
> +| An option group Header
> +|C?        option C with an optional argument
> +|d,data?   short and long option with an optional argument
> +|
> +| Argument hints
> +|B=arg     short option required argument
> +|bar2=arg  long option required argument
> +|e,fuz=with-space  short and long option required argument
> +|s?some    short option optional argument
> +|long?data long option optional argument
> +|g,fluf?path     short and long option optional argument
> +|longest=very-long-argument-hint  a very long argument hint
> +|pair=key=value  with an equals sign in the hint
> +|
> +|Extras
> +|extra1    line above used to cause a segfault but no longer does
> +EOF
> +'
> +
> +test_expect_success 'test --parseopt help output' '
> + sed -e "s/^|//" >expect <<\END_EXPECT &&
> |cat <<\EOF
> |usage: some-command [options] <args>...
> |
> @@ -28,49 +60,22 @@ sed -e 's/^|//' >expect <<\END_EXPECT
> |    -g, --fluf[=<path>]   short and long option optional argument
> |    --longest <very-long-argument-hint>
> |                          a very long argument hint
> +|    --pair <key=value>    with an equals sign in the hint
> |
> |Extras
> |    --extra1              line above used to cause a segfault but no 
> longer does
> |
> |EOF
> END_EXPECT
> -
> -sed -e 's/^|//' >optionspec <<\EOF
> -|some-command [options] <args>...
> -|
> -|some-command does foo and bar!
> -|--
> -|h,help    show the help
> -|
> -|foo       some nifty option --foo
> -|bar=      some cool option --bar with an argument
> -|b,baz     a short and long option
> -|
> -| An option group Header
> -|C?        option C with an optional argument
> -|d,data?   short and long option with an optional argument
> -|
> -| Argument hints
> -|B=arg     short option required argument
> -|bar2=arg  long option required argument
> -|e,fuz=with-space  short and long option required argument
> -|s?some    short option optional argument
> -|long?data long option optional argument
> -|g,fluf?path     short and long option optional argument
> -|longest=very-long-argument-hint  a very long argument hint
> -|
> -|Extras
> -|extra1    line above used to cause a segfault but no longer does
> -EOF
> -
> -test_expect_success 'test --parseopt help output' '
>  test_expect_code 129 git rev-parse --parseopt -- -h > output < 
> optionspec &&
>  test_i18ncmp expect output
> '
>
> -cat > expect <<EOF
> +test_expect_success 'setup expect.1' "
> + cat > expect <<EOF
> set -- --foo --bar 'ham' -b -- 'arg'
> EOF
> +"
>
> test_expect_success 'test --parseopt' '
>  git rev-parse --parseopt -- --foo --bar=ham --baz arg < optionspec > 
> output &&
> @@ -82,9 +87,11 @@ test_expect_success 'test --parseopt with mixed 
> options and arguments' '
>  test_cmp expect output
> '
>
> -cat > expect <<EOF
> +test_expect_success 'setup expect.2' "
> + cat > expect <<EOF
> set -- --foo -- 'arg' '--bar=ham'
> EOF
> +"
>
> test_expect_success 'test --parseopt with --' '
>  git rev-parse --parseopt -- --foo -- arg --bar=ham < optionspec > 
> output &&
> @@ -96,54 +103,66 @@ test_expect_success 
> 'test --parseopt --stop-at-non-option' '
>  test_cmp expect output
> '
>
> -cat > expect <<EOF
> +test_expect_success 'setup expect.3' "
> + cat > expect <<EOF
> set -- --foo -- '--' 'arg' '--bar=ham'
> EOF
> +"
>
> test_expect_success 'test --parseopt --keep-dashdash' '
>  git rev-parse --parseopt --keep-dashdash -- --foo -- arg --bar=ham < 
> optionspec > output &&
>  test_cmp expect output
> '
>
> -cat >expect <<EOF
> +test_expect_success 'setup expect.4' "
> + cat >expect <<EOF
> set -- --foo -- '--' 'arg' '--spam=ham'
> EOF
> +"
>
> test_expect_success 
> 'test --parseopt --keep-dashdash --stop-at-non-option with --' '
>  git 
> rev-parse --parseopt --keep-dashdash --stop-at-non-option -- --foo --  
> arg --spam=ham <optionspec >output &&
>  test_cmp expect output
> '
>
> -cat > expect <<EOF
> +test_expect_success 'setup expect.5' "
> + cat > expect <<EOF
> set -- --foo -- 'arg' '--spam=ham'
> EOF
> +"
>
> test_expect_success 
> 'test --parseopt --keep-dashdash --stop-at-non-option without --' '
>  git 
> rev-parse --parseopt --keep-dashdash --stop-at-non-option -- --foo 
> arg --spam=ham <optionspec >output &&
>  test_cmp expect output
> '
>
> -cat > expect <<EOF
> +test_expect_success 'setup expect.6' "
> + cat > expect <<EOF
> set -- --foo --bar='z' --baz -C'Z' --data='A' -- 'arg'
> EOF
> +"
>
> test_expect_success 'test --parseopt --stuck-long' '
>  git rev-parse --parseopt --stuck-long -- --foo --bar=z -b arg -CZ -dA 
> <optionspec >output &&
>  test_cmp expect output
> '
>
> -cat > expect <<EOF
> +test_expect_success 'setup expect.7' "
> + cat > expect <<EOF
> set -- --data='' -C --baz -- 'arg'
> EOF
> +"
>
> test_expect_success 'test --parseopt --stuck-long and empty optional 
> argument' '
>  git rev-parse --parseopt --stuck-long -- --data= arg -C -b 
> <optionspec >output &&
>  test_cmp expect output
> '
>
> -cat > expect <<EOF
> +test_expect_success 'setup expect.8' "
> + cat > expect <<EOF
> set -- --data --baz -- 'arg'
> EOF
> +"
>
> test_expect_success 'test --parseopt --stuck-long and long option with 
> unset optional argument' '
>  git rev-parse --parseopt --stuck-long -- --data arg -b <optionspec 
>  >output &&
> -- 
> 2.4.5
>
