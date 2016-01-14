From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11] ls-files: add eol diagnostics
Date: Thu, 14 Jan 2016 11:34:14 -0800
Message-ID: <xmqqr3hkj6q1.fsf@gitster.mtv.corp.google.com>
References: <1452788241-9879-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Thu Jan 14 20:34:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJnfT-0003Wv-D4
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 20:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbcANTeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 14:34:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752702AbcANTeW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 14:34:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2468E3ADD5;
	Thu, 14 Jan 2016 14:34:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QpAwaELMJc27k1r/1Ac4+nJ3upI=; b=X1+pe2
	S6huG+YutCHTLKXUsBu/F0qPST8g/kaE71B66psdS7LwEcQdPLfK3/+HGaQKdHMS
	2CbCvrgAwKZGaVo2t/nKW5/egWR3AaFqGyPOgsuxqxLwvGITdt9b0JGq+lLVbuke
	EHab+ofKvFLKxhieEpdpKOZ9MGQ0bVH0AqfGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mPnKl/eLlWfOwUd38QP+quE9Sei2s/dq
	hYEkS99E5ks1+orZ4eVcfK2vIZRZakZKsa46tCfx+KCtiDcv+GGUXmj0hd6AcnTA
	O8DvjYbEU7r9viX8vB5o70Ac6NUtX6Ks2j2Lxgls2YN5d+wSNGkYDlG8ZvqT9y/k
	tMQpBMlfgPc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A8B73ADD4;
	Thu, 14 Jan 2016 14:34:16 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6A4383ADD3;
	Thu, 14 Jan 2016 14:34:15 -0500 (EST)
In-Reply-To: <1452788241-9879-1-git-send-email-tboegi@web.de> (tboegi@web.de's
	message of "Thu, 14 Jan 2016 17:17:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CBDA0A1C-BAF5-11E5-8E29-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284083>

tboegi@web.de writes:

>  - removed src=crlf_false_attr as commented out in the review,

I probably missed that exchange; I do not recall seeing that comment.

> +'git ls-files --eol' will show
> +	i/<eolinfo><SPACES>w/<eolinfo><SPACES>attr/<eolattr><SPACES><file>

I think this should be:

    i/<eolinfo><SPACES>w/<eolinfo><SPACES>attr/<eolattr><SPACES><TAB><file>

Whether you like it or not, people write scripts to parse textual
output primarily meant for humans.  "ls-files -s" output, for
example, uses tab just before the pathname even though it uses a
space between the mode and the object name for this exact reason.

> +		/* Align the print for the longest possible values (see convert.c)
> +			 i/binary w/binary attr/text eol=crlf */

	/*
         * We write our multi-line comments
         * like this.
         */

> +		if (line_terminator == '\n')
> +			printf("i/%-6s w/%-6s attr/%-13s ", i_txt, w_txt, a_txt);
> +		else
> +			printf("i/%s\tw/%s\tattr/%s\t", i_txt, w_txt, a_txt);
> +	}
> +}



> diff --git a/convert.c b/convert.c
> index 814e814..ae766bd 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -13,6 +13,11 @@
>   * translation when the "text" attribute or "auto_crlf" option is set.
>   */
>  
> +/* Stat bits: When BIN is set, the txt bits are unset */
> +#define CONVERT_STAT_BITS_TXT_LF    0x1
> +#define CONVERT_STAT_BITS_TXT_CRLF  0x2
> +#define CONVERT_STAT_BITS_BIN       0x4
> +
>  enum crlf_action {
>  	CRLF_GUESS = -1,
>  	CRLF_BINARY = 0,
> @@ -75,26 +80,75 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
>  
>  /*
>   * The same heuristics as diff.c::mmfile_is_binary()
> + * We treat files with bare CR as binary
>   */
> -static int is_binary(unsigned long size, struct text_stat *stats)
> +static inline int convert_is_binary(unsigned long size, const struct text_stat *stats)

Please articulate the justification for this inlining with data (or
just keep it out-of-line as before).

>  {
> -
> +	if (stats->cr != stats->crlf)
> +		return 1;
>  	if (stats->nul)
>  		return 1;
>  	if ((stats->printable >> 7) < stats->nonprintable)
>  		return 1;
> -	/*
> -	 * Other heuristics? Average line length might be relevant,
> -	 * as might LF vs CR vs CRLF counts..
> -	 *
> -	 * NOTE! It might be normal to have a low ratio of CRLF to LF
> -	 * (somebody starts with a LF-only file and edits it with an editor
> -	 * that adds CRLF only to lines that are added..). But do  we
> -	 * want to support CR-only? Probably not.
> -	 */
>  	return 0;
>  }
>  
> +static unsigned int gather_convert_stats(const char *data, unsigned long size)
> +{
> +	struct text_stat stats;
> +	if (!data || !size)
> +		return 0;
> +	gather_stats(data, size, &stats);
> +	if (convert_is_binary(size, &stats))
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
> +
> +static const char *gather_convert_stats_ascii(const char *data, unsigned long size)
> +{
> +	unsigned int convert_stats = gather_convert_stats(data, size);
> +
> +	if (convert_stats & CONVERT_STAT_BITS_BIN)
> +		return "binary";

It is true and correct that we do not do EOL conversion on text
files that have a lone CR, but I think it is misleading to tell the
users that such files are "binary".  We do not refrain from showing
the textual diff for such files, for example.

To put it another way, we do not do EOL conversion for truly
'binary' files, but there are (mostly) text files that are not
binary that we do not do EOL conversion on.  And you want to tell
the user if EOL conversion would happen to each file.  It is not
correct to label "this file is binary" merely because you do not do
EOL conversion.  Perhaps define a new "literal" class that is a
superset of "binary" and use that as the label?  I am not suggesting
that "ls-files --eol" should show "i/binary" for truly binary files
and "i/literal" for a non-binary file with lone CRs.  For the
purpose of "--eol", you only care about "literal", so you do not
even have to have "binary" class at all.

> +# Should be the last test case: remove some files from the worktree
> +# This test assumes that "rm" can remove staged files

I do not see the point of the second line.  In what situation is
"rm" allowed to refuse to remove files that are added to the index?

> +test_expect_success 'ls-files --eol -d -z' '
> +	rm crlf_false_attr__CRLF.txt crlf_false_attr__CRLF_mix_LF.txt crlf_false_attr__LF.txt .gitattributes &&
> +	cat >expect <<-\EOF &&
> +	i/crlf w/ crlf_false_attr__CRLF.txt
> +	i/lf w/ .gitattributes
> +	i/lf w/ crlf_false_attr__LF.txt
> +	i/mixed w/ crlf_false_attr__CRLF_mix_LF.txt
> +	EOF
> +	git ls-files --eol -z -d |
> +	tr "\000" "\n" |
> +	sed -e "s!attr/[^	]*!!g" -e "s/	/ /g" -e "s/  */ /g" |
> +	sort >actual &&
> +	test_cmp expect actual &&
> +	rm expect actual

Please do not add useless "clean-up" like this last "rm".

> +'
> +
>  test_done
