From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --ff-only flag to git-merge
Date: Wed, 28 Jan 2009 13:12:57 -0800
Message-ID: <7vk58fm8x2.fsf@gitster.siamese.dyndns.org>
References: <1233147238-30082-1-git-send-email-nothingmuch@woobling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yuval Kogman <nothingmuch@woobling.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 22:15:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSHk0-0005OJ-Ab
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 22:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbZA1VNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 16:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbZA1VNH
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 16:13:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbZA1VND (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 16:13:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EBCCF9416B;
	Wed, 28 Jan 2009 16:13:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D930894169; Wed,
 28 Jan 2009 16:12:58 -0500 (EST)
In-Reply-To: <1233147238-30082-1-git-send-email-nothingmuch@woobling.org>
 (Yuval Kogman's message of "Wed, 28 Jan 2009 14:53:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 72423DE8-ED80-11DD-B0C0-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107577>

Yuval Kogman <nothingmuch@woobling.org> writes:

> This patch adds an --ff-only flag to git-merge. When specified git-merge
> will exit with an error whenver a merge will not be a simple fast
> forward, similar to the default behavior of git push.
> ---

Lacks a sign-off.

> @@ -167,6 +168,8 @@ static struct option builtin_merge_options[] = {
>  		"perform a commit if the merge succeeds (default)"),
>  	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
>  		"allow fast forward (default)"),
> +	OPT_BOOLEAN(0, "ff-only", &only_fast_forward,
> +		"allow only fast forward"),
>  	OPT_CALLBACK('s', "strategy", &use_strategies, "strategy",
>  		"merge strategy to use", option_parse_strategy),
>  	OPT_CALLBACK('m', "message", &merge_msg, "message",

After parse_options() returns, there are a few existing tests to reject
nonsensical combination of options.  I think there are some combinations
you would want to reject (for example, "--no-ff --ff-only" is an obvious
such nonsensical combination, but there may be others, such as giving a
strategy explicitly).

> @@ -1012,6 +1015,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		finish(o->sha1, msg.buf);
>  		drop_save();
>  		return 0;
> +	} else if ( only_fast_forward ) {
> +		printf("Merge is non fast forward, aborting.\n");
> +		return 1;
>  	} else if (!remoteheads->next && common->next)
>  		;

This is wrong for at least three reasons:

 * Style of "if (expression) {", somebody else already pointed out.

 * Only this case exits with 1, while others die() that exits with 128.

 * The placement of this misses the case where a merge of two unrelated
   histories is attempted.  You would need to also have a check at "No
   common ancestors found. We need a real merge." part.  The octopus
   codepath could also end up with a fast forward or up-to-date.
