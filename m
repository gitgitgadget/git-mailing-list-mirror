From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9F] ls-files: Add eol diagnostics
Date: Thu, 07 Jan 2016 12:33:18 -0800
Message-ID: <xmqqh9ip3zap.fsf@gitster.mtv.corp.google.com>
References: <1452179858-17791-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Thu Jan 07 21:33:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHHFO-000836-Kz
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 21:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbcAGUdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 15:33:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752157AbcAGUdV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 15:33:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A51223A131;
	Thu,  7 Jan 2016 15:33:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4NeoOug6YUTi+MRX9lLQWjza28c=; b=Kqp+7z
	WIdwu1CFUKw7iLGEx0ZG/nTxcU2xN14w3yUYRdEJ3BRv0FD+krn1xY32oWDcFzUY
	y6Hjg2QACr+3cBhCzAtOpqj1GE4VVi0US8i0C7zqonUOqMHIYzR1ZT4J5tkX7sWH
	rm31bpfzbDk4mCJoJpCLJSs9fwszhxGo126UM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RJHZRKHzX/dQmI3R0LFqU0+oCVDZrwnJ
	l8U2Yysazhr3mhX4PwvnOy11+lBkcaoFa+xmk/6fLO1I/asPPYkLiDieo2RYIcb0
	Jl4a21uOHdsuEUt1+CUK5EkfpwXqA8ehM431/X0OBcR8Rd5Ibl8DiYgsBkz8vurc
	OQ7SlPFykK8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9AAB13A130;
	Thu,  7 Jan 2016 15:33:20 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EEF603A12F;
	Thu,  7 Jan 2016 15:33:19 -0500 (EST)
In-Reply-To: <1452179858-17791-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Thu, 7 Jan 2016 16:17:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3AC56EA-B57D-11E5-A3C7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283505>

tboegi@web.de writes:

> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index e26f01f..e231266 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
>  'git ls-files' [-z] [-t] [-v]
>  		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
>  		(-[c|d|o|i|s|u|k|m])*
> +		[--eol]
>  		[-x <pattern>|--exclude=<pattern>]
>  		[-X <file>|--exclude-from=<file>]
>  		[--exclude-per-directory=<file>]
> @@ -147,6 +148,19 @@ a space) at the start of each line:
>  	possible for manual inspection; the exact format may change at
>  	any time.
>  
> +--eol::
> +	Show line endings (<eolinfo>) and the text/eol attributes (<texteolattr>) of files.

This line looks overly long.

I think s/<texteolattr>/<eolattr>/ is needed to match what is shown
in the example that appears later in the documentation.

> +	<eolinfo> is the file content identification used by Git when
> +	the "text" attribute is "auto" or "" and core.autocrlf != false.
> ++
> +<eolinfo> is either "" (when the the info is not available"), or one of "binary",
> +"none", "lf", "crlf" or "mixed".
> ++
> +The <texteolattr> can be "", "-text", "text", "text=auto", "eol=lf", "eol=crlf".
> ++
> +Both the content in the index ("i/") and the content in the working tree ("w/")
> +are shown for regular files, followed by the <texteolattr> ("attr/").
> +

This makes the reader wonder what should happen for non-regular
files.  Are they omitted from the output?  Are they shown but lack
these three fields?  Only i/ and w/ are missing but the attribute
that would have applied to them if they were regular files are
shown?  Something else?

> @@ -161,6 +175,15 @@ which case it outputs:
>  
>          [<tag> ]<mode> <object> <stage> <file>
>  
> +'git ls-files --eol' will show
> +	i/<eolinfo> w/<eolinfo> attr/<eolattr> <file>
> +
> +'git ls-files --eol -o' will show
> +	i/          w/<eolinfo> attr/<eolattr> <file>
> +
> +'git ls-files --eol -s' will show
> +[<tag> ]<mode> <object> <stage> i/<eolinfo> w/<eolinfo> attr/<eolattr> <file>
> +
>  'git ls-files --unmerged' and 'git ls-files --stage' can be used to examine
>  detailed information on unmerged paths.
>  
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index b6a7cb0..73b2ba6 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -27,6 +27,7 @@ static int show_killed;
>  static int show_valid_bit;
>  static int line_terminator = '\n';
>  static int debug_mode;
> +static int show_eol;
>  
>  static const char *prefix;
>  static int max_prefix_len;
> @@ -47,6 +48,21 @@ static const char *tag_modified = "";
>  static const char *tag_skip_worktree = "";
>  static const char *tag_resolve_undo = "";
>  
> +static void write_eolinfo(const struct cache_entry *ce, const char *path)
> +{
> +	struct stat st;
> +	const char *i_txt = "";
> +	const char *w_txt = "";
> +	if (!show_eol)
> +		return;
> +	if (ce && S_ISREG(ce->ce_mode))
> +		i_txt = get_cached_convert_stats_ascii(ce->name);
> +	if (!lstat(path, &st) && S_ISREG(st.st_mode))
> +		w_txt = get_wt_convert_stats_ascii(path);
> +	printf("i/%-6s w/%-6s attr/%-9s ", i_txt, w_txt,
> +				 get_convert_attr_ascii(path));
> +}

This should interact with "-z" output mode in a more sensible way to
allow easier machine parsing, no?  Aligning them with "%-<N>s" forces
the parsing scripts to strip excess spaces, and separating the fields
with hardcoded SP even more so.

> diff --git a/convert.c b/convert.c
> index 814e814..3b805fa 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -13,6 +13,11 @@
>   * translation when the "text" attribute or "auto_crlf" option is set.
>   */
>  
> +/* Stat bits: When BIN is set, the txt bits are unset */
> +#define CONVERT_STAT_BITS_TXT_LF   (1)
> +#define CONVERT_STAT_BITS_TXT_CRLF (2)
> +#define CONVERT_STAT_BITS_BIN      (4)
> +

What are these parentheses doing aroud the constants?  Drop them.
Write the bit patterns in either hex or octal; if these are
enumerations, they should stay in decimal.

>  enum crlf_action {
>  	CRLF_GUESS = -1,
>  	CRLF_BINARY = 0,
> @@ -95,6 +100,62 @@ static int is_binary(unsigned long size, struct text_stat *stats)
>  	return 0;
>  }
>  
> +static unsigned int gather_convert_stats(const char *data, unsigned long size)
> +{
> +	struct text_stat stats;
> +	if (!data || !size)
> +		return 0;
> +	gather_stats(data, size, &stats);
> +	if (is_binary(size, &stats) || stats.cr != stats.crlf)
> +		return CONVERT_STAT_BITS_BIN;
> +	else if (stats.crlf && stats.crlf == stats.lf)
> +		return CONVERT_STAT_BITS_TXT_CRLF;
> +	else if (stats.crlf && stats.lf)
> +		return CONVERT_STAT_BITS_TXT_CRLF | CONVERT_STAT_BITS_TXT_LF;
> +	else if (stats.lf)
> +		return CONVERT_STAT_BITS_TXT_LF;
> +	else
> +		return 0;
> +}

I'd imagine that this is attempting to match the existing logic of
what Git actually does.  Shouldn't that existing logic share the
code with this function to avoid the two implemetations drifting
apart, or would that be too much work?

> +static const char *gather_convert_stats_ascii(const char *data, unsigned long size)
> +{
> +	unsigned int convert_stats = gather_convert_stats(data, size);
> +
> +	if (convert_stats & CONVERT_STAT_BITS_BIN)
> +		return "binary";
> +	switch (convert_stats) {
> +		case CONVERT_STAT_BITS_TXT_LF:
> +			return "lf";

These case labels and their statements are indented one level too deep.

> +		case CONVERT_STAT_BITS_TXT_CRLF:
> +			return "crlf";
> +		case CONVERT_STAT_BITS_TXT_LF | CONVERT_STAT_BITS_TXT_CRLF:
> +			return "mixed";
> +		default:
> +			return "none";
> +	}
> +}

> @@ -777,6 +838,30 @@ int would_convert_to_git_filter_fd(const char *path)
>  	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
>  }
>  
> +const char *get_convert_attr_ascii(const char *path)
> +{
> +	struct conv_attrs ca;
> +	enum crlf_action crlf_action;
> +
> +	convert_attrs(&ca, path);
> +	crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
> +	switch (crlf_action) {
> +		case CRLF_GUESS:
> +			return "";

Likewise.

> +stats_ascii () {
> +	case "$1" in
> +		LF)
> +		echo lf

Likewise.

> @@ -214,6 +239,20 @@ checkout_files () {
>  		fi
>  	done
>  
> +	test_expect_success "ls-files --eol $lfname ${pfx}LF.txt" "

Hmmmm, by opening the executable part of test_expect_success with
double quote, you are interpolating the variables in it before the
test_expect_success function even starts to run.  It may happen to
be correct in this script to do so, but it adds more mental burden
to readers (and more importantly, those who will be modifying this
script in the future).

> +		test_when_finished 'rm e expect actual' &&
> +		cat >e <<-EOF &&
> +		i/crlf w/$(stats_ascii $crlfname) ${src}CRLF.txt
> +		i/mixed w/$(stats_ascii $lfmixcrlf) ${src}CRLF_mix_LF.txt
> +		i/lf w/$(stats_ascii $lfname) ${src}LF.txt
> +		i/binary w/$(stats_ascii $lfmixcr) ${src}LF_mix_CR.txt
> +		i/binary w/$(stats_ascii $crlfnul) ${src}CRLF_nul.txt
> +		i/binary w/$(stats_ascii $crlfnul) ${src}LF_nul.txt
> +		EOF
> +		sort <e >expect &&

Do you even use 'e' after this step?  Why not just produce 'expect'
directly by feeding the here-doc directly to sort?

> @@ -231,7 +270,41 @@ checkout_files () {
>  	"
>  }
> ...
> +	cat >e <<-\EOF &&
> +	...
> +	EOF
> +	sort <e >expect &&

Likewise.

> +	cat >expect <<-\EOF &&
> +	i/crlf w/ crlf_false_attr__CRLF.txt
> +	i/lf w/ .gitattributes
> +	i/lf w/ crlf_false_attr__LF.txt
> +	i/mixed w/ crlf_false_attr__CRLF_mix_LF.txt
> +	EOF

Here, there is no need to sort?

> +	git ls-files --eol -d | sed -e 's!attr/[=a-z-]*!!g' -e 's/  */ /g' | sort >actual &&

Write each component of the pipe on a separate line, i.e.

	git ls-files --eol -d |
	sed -e 's!attr/[=a-z-]*!!g' -e 's/  */ /g' |
	sort >actual &&

Again, the only reason you might want to use "" around the
executable part of test_expect_success here is to use '' around the
sed scripts here, but I do not think there is anything funny there
that requires single quotes, i.e.

	test_expect_success 'title' '
        	...
		git ls-files --eol -d |
                sed -e "s|attr/[=a-z-]*||g" -e "s/  */ /g" |
                sort >actual &&
		..
	'

would match our existing convention better.

> +	test_cmp expect actual &&
> +	rm expect actual

Why the final "rm"?

> +"
> +
>  test_done
