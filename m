From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/16] blame: teach -L/RE/ to search from end of previous -L range
Date: Tue, 06 Aug 2013 14:45:15 -0700
Message-ID: <7vsiymebo4.fsf@alter.siamese.dyndns.org>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
	<1375797589-65308-10-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 23:45:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6p4Q-0000Hw-8D
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 23:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756959Ab3HFVpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 17:45:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756954Ab3HFVpS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 17:45:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBB973789E;
	Tue,  6 Aug 2013 21:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=80hkQdpgX93JqZ1uMPcLpSt6dhU=; b=XLatBG
	TUx5kcPt0dXDKJugQjuwxYdhVyaxxFHZamLHAD7Hie9rkWCUffk58SI92NXVSm7k
	yqiGKhxzEFt1UM9oSIKjN5UV1jrdvlysbbpef4VOExio9NlpNOG5/CXbEDuXO6c4
	QBeabTuvB2v2MrCXPoLsf3PHs5ojmcn0TYVs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vfhzHQPleCoUTZnHmhh8jR8AzYf+/NSz
	weUEGwxo/fhuw4hk0dhlcxmgvnYqh0myzEcW6Mfc9mFTHtlxG3Nk43TF/S4q2TZ0
	jLRjgFyxqC8O0akdFeFpMc8oRsRnnJVXIYg76GToOT+RXpTaGQcbIKC1mASQuQjp
	/TK6x3AVpYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE2D63789D;
	Tue,  6 Aug 2013 21:45:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E89B437899;
	Tue,  6 Aug 2013 21:45:16 +0000 (UTC)
In-Reply-To: <1375797589-65308-10-git-send-email-sunshine@sunshineco.com>
	(Eric Sunshine's message of "Tue, 6 Aug 2013 09:59:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B9E77EA-FEE1-11E2-894B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231788>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---

With the previous step, what this one does is fairly obvious and
straight-forward.  Looking good ;-)

>  builtin/blame.c     |  5 ++++-
>  t/annotate-tests.sh | 20 ++++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 7b084d8..1bf8056 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2280,6 +2280,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	int cmd_is_annotate = !strcmp(argv[0], "annotate");
>  	struct range_set ranges;
>  	unsigned int range_i;
> +	long anchor;
>  
>  	git_config(git_blame_config, NULL);
>  	init_revisions(&revs, NULL);
> @@ -2475,11 +2476,12 @@ parse_done:
>  	if (lno && !range_list.nr)
>  		string_list_append(&range_list, xstrdup("1"));
>  
> +	anchor = 1;
>  	range_set_init(&ranges, range_list.nr);
>  	for (range_i = 0; range_i < range_list.nr; ++range_i) {
>  		long bottom, top;
>  		if (parse_range_arg(range_list.items[range_i].string,
> -				    nth_line_cb, &sb, lno, 1,
> +				    nth_line_cb, &sb, lno, anchor,
>  				    &bottom, &top, sb.path))
>  			usage(blame_usage);
>  		if (lno < top || ((lno || bottom) && lno < bottom))
> @@ -2490,6 +2492,7 @@ parse_done:
>  			top = lno;
>  		bottom--;
>  		range_set_append_unsafe(&ranges, bottom, top);
> +		anchor = top + 1;
>  	}
>  	sort_and_merge_range_set(&ranges);
>  
> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index 77083d9..b963d36 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -303,6 +303,26 @@ test_expect_success 'blame -L multiple (superset/subset: unordered)' '
>  	check_count -L3,5 -L2,8 A 1 B 1 B1 1 B2 1 C 1 D 1 "A U Thor" 1
>  '
>  
> +test_expect_success 'blame -L /RE/ (relative)' '
> +	check_count -L3,3 -L/fox/ B1 1 B2 1 C 1 D 1 "A U Thor" 1
> +'
> +
> +test_expect_success 'blame -L /RE/ (relative: no preceding range)' '
> +	check_count -L/dog/ A 1 B 1 B1 1 B2 1 C 1 D 1 "A U Thor" 1
> +'
> +
> +test_expect_success 'blame -L /RE/ (relative: adjacent)' '
> +	check_count -L1,1 -L/dog/,+1 A 1 E 1
> +'
> +
> +test_expect_success 'blame -L /RE/ (relative: not found)' '
> +	test_must_fail $PROG -L4,4 -L/dog/ file
> +'
> +
> +test_expect_success 'blame -L /RE/ (relative: end-of-file)' '
> +	test_must_fail $PROG -L, -L/$/ file
> +'
> +
>  test_expect_success 'setup -L :regex' '
>  	tr Q "\\t" >hello.c <<-\EOF &&
>  	int main(int argc, const char *argv[])
