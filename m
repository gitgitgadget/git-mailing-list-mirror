From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Thu, 17 Oct 2013 12:29:26 -0700
Message-ID: <xmqqmwm71ysp.fsf@gitster.dls.corp.google.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com>
	<A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
	<660A536D-9993-4B81-B6FF-A113F9111570@gmail.com>
	<AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com>
	<79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com>
	<89A4E8C6-C233-49E2-8141-837ABDBBC976@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 21:29:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWtGI-0006af-LJ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 21:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759453Ab3JQT3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 15:29:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58738 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758121Ab3JQT33 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 15:29:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26B724B8F6;
	Thu, 17 Oct 2013 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u0Sr/alvnteVavEcLZTeQdSkXGE=; b=i+5L6N
	XHIPuai0Zw3GUfeIyuXvKpG4ZGbTzYDZW8nHweQC9zIwinl9JWax2L90r9NiODmU
	+/nTIao7N9eITXUuZL+v/vclO9he3ICvfiUsnQhQCtKkPldxgfW2ZzdrNwjmb8B2
	bh+R/lIvOpXDwFYGlmbv7lK5WdNPRi8Y3+e4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JRrJUemvema8pu5fbvB+reQQNeeIBdjM
	SSz8jBLSjuPeWB3UqbHI7pSQs31dKyBUlWop0CX9JIwtbjOivLMhNe6wf4umWsL0
	49yTPNbAGJafom79yWzyMW8wmirDwv51a6xpRnFoQO2WnGiImwIwNdGsaGdeeVMa
	82i5ohY1V8E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15FBE4B8F5;
	Thu, 17 Oct 2013 19:29:29 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 558E84B8EF;
	Thu, 17 Oct 2013 19:29:28 +0000 (UTC)
In-Reply-To: <89A4E8C6-C233-49E2-8141-837ABDBBC976@gmail.com> (Yoshioka
	Tsuneo's message of "Wed, 16 Oct 2013 12:53:44 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 706A739C-3762-11E3-BA6A-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236307>

Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:

> "git diff -M --stat" can detect rename and show renamed file name like
> "foofoofoo => barbarbar".
> Before this commit, this output is shortened always by omitting left most
> part like "...foo => barbarbar". So, if the destination filename is too long,
> source filename putting left or arrow can be totally omitted like
> "...barbarbar", without including any of "foofoofoo =>".
> In such a case where arrow symbol is omitted, there is no way to know
> whether the file is renamed or existed in the original.
> Make sure there is always an arrow, like "...foo => ...bar".
> The output can contain curly braces('{','}') for grouping.
> So, in general, the output format is "<pfx>{<mid_a> => <mid_b>}<sfx>"
> To keep arrow("=>"), try to omit <pfx> as long as possible at first
> because later part or changing part will be the more important part.
> If it is not enough, shorten <mid_a>, <mid_b>, and <sfx> trying to
> have the maximum length the same because those will be equally important.

I somehow find this solid wall of text extremely hard to
read. Adding a blank line as a paragraph break may make it easier to
read, perhaps.

Also it is customary in our history to omit the full-stop from the
patch title on the Subject: line.

> +	name_len = pfx->len + a_mid->len + b_mid->len + sfx->len + strlen(arrow)
> +		+ (use_curly_braces ? 2 : 0);
> +
> +	if (name_len <= name_width) {
> +		/* Everthing fits in name_width */
> +		return;
> +	}

Logic up to this point seems good; drop {} around a single statement
"return;", i.e.

	if (name_len <= name_width)
        	return; /* everything fits */

> +		} else {
> +			if (pfx->len > strlen(dots)) {
> +				/*
> +				 * Just omitting left of '{' is not enough
> +				 * name will be "...{SOMETHING}SOMETHING"
> +				 */
> +				strbuf_reset(pfx);
> +				strbuf_addstr(pfx, dots);
> +			}

(mental note) ... otherwise, i.e. with a short common prefix, the
final result will be "ab{SOMETHING}SOMETHING", which is also fine
for the purpose of the remainder of this function.

> +		}
> +	}
> +
> +	/* available length for a_mid, b_mid and sfx */
> +	len = name_width - strlen(arrow) - (use_curly_braces ? 2 : 0);
> +
> +	/* a_mid, b_mid, sfx will be have the same max, including ellipsis("..."). */
> +	part_length[0] = a_mid->len;
> +	part_length[1] = b_mid->len;
> +	part_length[2] = sfx->len;
> +
> +	qsort(part_length, sizeof(part_length)/sizeof(part_length[0]), sizeof(part_length[0])
> +		  , compare_size_t_descending_order);

In our code, comma does not come at the beginning of continued
line.

> +	if (part_length[1] + part_length[1] + part_length[2] <= len) {
> +		/*
> +		 * "{...foofoo => barbar}file"
> +		 * There is only one omitted part.
> +		 */
> +		max_part_len = len - part_length[1] - part_length[2];

It would be clearer to explicitly set remainder to zero here, and
omit the initialization of the variable.  That would make what the
three parts of if/elseif/else do more consistent.

> +	} else if (part_length[2] + part_length[2] + part_length[2] <= len) {
> +		/*
> +		 * "{...foofoo => ...barbar}file"
> +		 * There are 2 omitted parts.
> +		 */
> +		max_part_len = (len - part_length[2]) / 2;
> +		remainder_part_len = (len - part_length[2]) - max_part_len * 2;
> +	} else {
> +		/*
> +		 * "{...ofoo => ...rbar}...file"
> +		 * There are 3 omitted parts.
> +		 */
> +		max_part_len = len / 3;
> +		remainder_part_len = len - (max_part_len) * 3;
> +	}

I am not sure if distributing the burden of truncation equally to
three parts so that the resulting pieces are of similar lengths is
really a good idea.  Between these two

	{...SourceDirectory => ...nationDirectory}...ileThatWasMoved 
	{...ceDirectory => ...ionDirectory}nameOfTheFileThatWasMoved

that attempt to show that the file nameOfTheFileThatWasMoved was
moved from the longSourceDirectory to the DestinationDirectory, the
latter is much more informative, I would think.

> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
> index 2f327b7..03d6371 100755
> --- a/t/t4001-diff-rename.sh
> +++ b/t/t4001-diff-rename.sh
> @@ -156,4 +156,16 @@ test_expect_success 'rename pretty print common prefix and suffix overlap' '
>  	test_i18ngrep " d/f/{ => f}/e " output
>  '
>  
> +test_expect_success 'rename of very long path shows =>' '
> +	mkdir long_dirname_that_does_not_fit_in_a_single_line &&
> +	mkdir another_extremely_long_path_but_not_the_same_as_the_first &&
> +	cp path1 long_dirname*/ &&
> +	git add long_dirname*/path1 &&
> +	test_commit add_long_pathname &&
> +	git mv long_dirname*/path1 another_extremely_*/ &&
> +	test_commit move_long_pathname &&
> +	git diff -M --stat HEAD^ HEAD >output &&
> +	test_i18ngrep "=>.*path1" output

Does this have to be i18ngrep?  I had a feeling that we would not
want this part of the output localized, in which case "grep" may be
more appropriate.

> +'
> +
>  test_done
