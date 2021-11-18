Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78133C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 21:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52062611C4
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 21:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhKRVYi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 18 Nov 2021 16:24:38 -0500
Received: from mta-13-4.privateemail.com ([198.54.127.109]:49295 "EHLO
        MTA-13-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhKRVYh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 16:24:37 -0500
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id 2E07518000AF;
        Thu, 18 Nov 2021 16:21:36 -0500 (EST)
Received: from [192.168.0.46] (unknown [10.20.151.218])
        by mta-13.privateemail.com (Postfix) with ESMTPA id 5489718000B4;
        Thu, 18 Nov 2021 16:21:34 -0500 (EST)
Date:   Thu, 18 Nov 2021 16:21:19 -0500
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH v2] grep: avoid setting UTF mode when dangerous with PCRE
To:     Carlo Marcelo Arenas =?iso-8859-1?b?QmVs824=?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        =?iso-8859-1?b?UmVu6Q==?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>
Message-Id: <JZDS2R.2JB8M8ZCH6NX1@effective-light.com>
In-Reply-To: <20211117102329.95456-1-carenas@gmail.com>
References: <20211116110035.22140-1-carenas@gmail.com>
        <20211117102329.95456-1-carenas@gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Building on to your patch we can disable the feature if an older 
version of PCRE2 is used, like so:

diff --git a/pretty.c b/pretty.c
index 1af5b093ae..9bd3f61b30 100644
--- a/pretty.c
+++ b/pretty.c
@@ -451,8 +451,11 @@ static void append_line_with_color(struct strbuf 
*sb, struct grep_opt *opt,

  buf = line;
  eol = buf + linelen;
-
+#ifdef GIT_PCRE2_VERSION_10_34_OR_HIGHER
  if (!opt || !want_color(color) || opt->invert)
+#else
+ if (!opt || !want_color(color) || opt->invert || opt->pcre2)
+#endif
   goto end;

  line_color = opt->colors[GREP_COLOR_SELECTED];



On Wed, Nov 17 2021 at 02:23:29 AM -0800, Carlo Marcelo Arenas Belón 
<carenas@gmail.com> wrote:
> Since ae39ba431a (grep/pcre2: fix an edge case concerning ascii 
> patterns
> and UTF-8 data, 2021-10-15), PCRE2_UTF mode is enabled for cases 
> where it
> will trigger UTF-8 validation errors (as reported) or can result in
> undefined behaviour.
> 
> Our use of PCRE2 only allows searching through non UTF-8 validated 
> data
> safely through the use of the PCRE2_MATCH_INVALID_UTF flag, that is 
> only
> available after 10.34, so restrict the change to newer versions of 
> PCRE
> and revert to the old logic for older releases, which will still allow
> for matching not using UTF-8 for likely most usecases (as shown in the
> tests).
> 
> Fix one test that was using an expression that wouldn't fail without 
> the
> new code so it can be forced to fail if it is missing and restrict it 
> to
> run only for newer PCRE releases; while at it do some minor 
> refactoring
> to cleanup the fallout for when that test might be skipped or might
> succeed under the new conditions.
> 
> Keeping the overly complex and unnecessary logic for now, to reduce 
> risk
> but with the hope that it will be cleaned up later.
> 
> Helped-by: René Scharfe <l.s.r@web.de>
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> v2:
> * restrict the code at compile time instead of reverting
> * "fix" test to document  the behaviour under both PCRE code versions
> * update commit message to better explain the issue
> 
>  grep.c                          |  7 ++++++-
>  t/t7812-grep-icase-non-ascii.sh | 32 ++++++++++++++++++--------------
>  2 files changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/grep.c b/grep.c
> index f6e113e9f0..0126aa3db4 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -382,12 +382,17 @@ static void compile_pcre2_pattern(struct 
> grep_pat *p, const struct grep_opt *opt
>  		}
>  		options |= PCRE2_CASELESS;
>  	}
> +#ifdef GIT_PCRE2_VERSION_10_34_OR_HIGHER
>  	if ((!opt->ignore_locale && !has_non_ascii(p->pattern)) ||
>  	    (!opt->ignore_locale && is_utf8_locale() &&
>  	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
>  					    (p->fixed || p->is_fixed))))
>  		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
> -
> +#else
> +	if (!opt->ignore_locale && is_utf8_locale() && 
> has_non_ascii(p->pattern) &&
> +	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
> +		options |= PCRE2_UTF;
> +#endif
>  #ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER
>  	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 
> 10.36 */
>  	if (PCRE2_MATCH_INVALID_UTF && options & (PCRE2_UTF | 
> PCRE2_CASELESS))
> diff --git a/t/t7812-grep-icase-non-ascii.sh 
> b/t/t7812-grep-icase-non-ascii.sh
> index 22487d90fd..3bfe1ee728 100755
> --- a/t/t7812-grep-icase-non-ascii.sh
> +++ b/t/t7812-grep-icase-non-ascii.sh
> @@ -53,14 +53,27 @@ test_expect_success REGEX_LOCALE 'pickaxe -i on 
> non-ascii' '
>  	test_cmp expected actual
>  '
> 
> -test_expect_success GETTEXT_LOCALE,PCRE 'log --author with an ascii 
> pattern on UTF-8 data' '
> -	cat >expected <<-\EOF &&
> -	Author: <BOLD;RED>À Ú Thor<RESET> <author@example.com>
> -	EOF
> +test_expect_success GETTEXT_LOCALE,PCRE 'setup ascii pattern on 
> UTF-8 data' '
>  	test_write_lines "forth" >file4 &&
>  	git add file4 &&
>  	git commit --author="À Ú Thor <author@example.com>" -m sécond &&
> -	git log -1 --color=always --perl-regexp --author=".*Thor" >log &&
> +	test_write_lines "fifth" >file5 &&
> +	git add file5 &&
> +	GIT_COMMITTER_NAME="Ç O Mîtter" &&
> +	GIT_COMMITTER_EMAIL="committer@example.com" &&
> +	git -c i18n.commitEncoding=latin1 commit -m thïrd
> +'
> +
> +test_lazy_prereq PCRE2_MATCH_INVALID_UTF '
> +	test-tool pcre2-config has-PCRE2_MATCH_INVALID_UTF
> +'
> +
> +test_expect_success GETTEXT_LOCALE,PCRE,PCRE2_MATCH_INVALID_UTF 'log 
> --author with an ascii pattern on UTF-8 data' '
> +	cat >expected <<-\EOF &&
> +	Author: <BOLD;RED>A U Thor<RESET> <author@example.com>
> +	Author: <BOLD;RED>À Ú Thor<RESET> <author@example.com>
> +	EOF
> +	git log --color=always --perl-regexp --author=". . Thor" >log &&
>  	grep Author log >actual.raw &&
>  	test_decode_color <actual.raw >actual &&
>  	test_cmp expected actual
> @@ -70,11 +83,6 @@ test_expect_success GETTEXT_LOCALE,PCRE 'log 
> --committer with an ascii pattern o
>  	cat >expected <<-\EOF &&
>  	Commit:     Ç<BOLD;RED> O Mîtter <committer@example.com><RESET>
>  	EOF
> -	test_write_lines "fifth" >file5 &&
> -	git add file5 &&
> -	GIT_COMMITTER_NAME="Ç O Mîtter" &&
> -	GIT_COMMITTER_EMAIL="committer@example.com" &&
> -	git -c i18n.commitEncoding=latin1 commit -m thïrd &&
>  	git -c i18n.logOutputEncoding=latin1 log -1 --pretty=fuller 
> --color=always --perl-regexp --committer=" O.*" >log &&
>  	grep Commit: log >actual.raw &&
>  	test_decode_color <actual.raw >actual &&
> @@ -141,10 +149,6 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 
> 'PCRE v2: grep non-ASCII from invali
>  	test_cmp invalid-0xe5 actual
>  '
> 
> -test_lazy_prereq PCRE2_MATCH_INVALID_UTF '
> -	test-tool pcre2-config has-PCRE2_MATCH_INVALID_UTF
> -'
> -
>  test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII 
> from invalid UTF-8 data with -i' '
>  	test_might_fail git grep -hi "Æ" invalid-0x80 >actual &&
>  	test_might_fail git grep -hi "(*NO_JIT)Æ" invalid-0x80 >actual
> --
> 2.34.0.352.g07dee3c5e1
> 


