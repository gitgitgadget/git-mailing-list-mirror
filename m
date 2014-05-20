From: Junio C Hamano <gitster@pobox.com>
Subject: Re: format-patch crashes with a huge patchset
Date: Tue, 20 May 2014 10:41:58 -0700
Message-ID: <xmqqa9ac1h5l.fsf@gitster.dls.corp.google.com>
References: <20140519193556.GA987@redhat.com>
	<20140520064920.GB5222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 20 19:42:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmo3H-0003hT-06
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 19:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbaETRmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 13:42:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54578 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319AbaETRmF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 13:42:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8381F1825C;
	Tue, 20 May 2014 13:42:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/tKFGJh+8AixQb12UrtF0swU70w=; b=gdShaH
	+yqO2xoyJ4Lhj7yfTgHJ/jVh1eI3/tDTGBLfQFryLT5h5eReaQdoocn5x6A+pM+M
	TnJrbZ+iWgcn73T/lRpjUhHvZTJadGl0PNIjhxbM4/Bm++FaQrHvoA04WAK9bZXK
	YCDYi51P24d/c/vBrlqL/4KPQQqwzkYX/M6tM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h56IYfVHPqS8SeercpC/R2P8r/y2ARwv
	q41I1IO4ezKOXwbxHNcMmcIIZzN6tZCZoJJOD9fdV929/CSyxgfwzW7tDWSKADmm
	ssSMd0r/FqEJqBdpieLv7kS5pIPTIZOzbPWQj28U2VdIggEaLAeI+q0DnFy8vckc
	DAyGpg3o4/Q=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 77D391825B;
	Tue, 20 May 2014 13:42:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EDB2118255;
	Tue, 20 May 2014 13:41:59 -0400 (EDT)
In-Reply-To: <20140520064920.GB5222@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 20 May 2014 02:49:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0BB315C0-E046-11E3-A1F1-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249710>

Jeff King <peff@peff.net> writes:

> On Mon, May 19, 2014 at 10:35:56PM +0300, Michael S. Tsirkin wrote:
>
>> I tried to fump the whole history of qemu with format-patch.
>> It crashes both with v2.0.0-rc2-21-g6087111
>> and with git 1.8.3.1:
>> 
>> ~/opt/libexec/git-core/git-format-patch --follow -o patches/all
>> e63c3dc74bfb90e4522d075d0d5a7600c5145745..
>
> You can't use "--follow" without specifying a single pathspec. Running
> "git log --follow" notices and blocks this, but format-patch doesn't
> (and segfaults later when the follow code assumes there is a pathspec).
>
> I think we need:

Looks sensible.  Intrestingly enough, this dates all the way back to
the original 750f7b66 (Finally implement "git log --follow",
2007-06-19).

Re-reading the log message of that commit was amusing for other
reasons, by the way (the most interesting part comes after "One
thing to look out for:" and especially "Put another way:").

> -- >8 --
> Subject: move "--follow needs one pathspec" rule to diff_setup_done
>
> Because of the way "--follow" is implemented, we must have
> exactly one pathspec. "git log" enforces this restriction,
> but other users of the revision traversal code do not. For
> example, "git format-patch --follow" will segfault during
> try_to_follow_renames, as we have no pathspecs at all.
>
> We can push this check down into diff_setup_done, which is
> probably a better place anyway. It is the diff code that
> introduces this restriction, so other parts of the code
> should not need to care themselves.
>
> Reported-by: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I didn't include a test, as I don't think the current behavior is what
> we want in the long run. That is, it would be nice if eventually
> --follow learned to be more flexible. Any test for this would
> necessarily be looking for the opposite of that behavior. But maybe it's
> worth it to just have in the meantime, and anyone who works on --follow
> can rip out the test.
>
>  builtin/log.c | 8 ++------
>  diff.c        | 3 +++
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 39e8836..3b6a6bb 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -158,13 +158,9 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  	if (rev->show_notes)
>  		init_display_notes(&rev->notes_opt);
>  
> -	if (rev->diffopt.pickaxe || rev->diffopt.filter)
> +	if (rev->diffopt.pickaxe || rev->diffopt.filter ||
> +	    DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES))
>  		rev->always_show_header = 0;
> -	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
> -		rev->always_show_header = 0;
> -		if (rev->diffopt.pathspec.nr != 1)
> -			usage("git logs can only follow renames on one pathname at a time");
> -	}
>  
>  	if (source)
>  		rev->show_source = 1;
> diff --git a/diff.c b/diff.c
> index f72769a..68bb8c5 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3325,6 +3325,9 @@ void diff_setup_done(struct diff_options *options)
>  	}
>  
>  	options->diff_path_counter = 0;
> +
> +	if (DIFF_OPT_TST(options, FOLLOW_RENAMES) && options->pathspec.nr != 1)
> +		die(_("--follow requires exactly one pathspec"));
>  }
>  
>  static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
