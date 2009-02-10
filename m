From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Mon, 09 Feb 2009 17:44:38 -0800
Message-ID: <7vr627qd4p.fsf@gitster.siamese.dyndns.org>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 02:46:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWhhU-0000wF-Df
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 02:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbZBJBor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 20:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbZBJBop
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 20:44:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbZBJBop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 20:44:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A04F9878C;
	Mon,  9 Feb 2009 20:44:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F0AF39878B; Mon,
  9 Feb 2009 20:44:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 641F0258-F714-11DD-83AC-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109174>

Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:

> Adding git 'shortstatus --mini' to PS1 is not noticeable or 1sec
> maximum in my tree. As a worst case it takes 10secs in a clone
> of WebKit.git.

Frankly, I think having to spend one second to add only one or two bits to
PS1 is simply spending one second too much.

> diff --git a/builtin-commit.c b/builtin-commit.c
> index d6a3a62..9267d26 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -821,6 +827,88 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  	return argc;
>  }
>  
> +int cmd_shortstatus(int argc, const char **argv, const char *prefix)
> +{
> +	struct wt_status s;
> +	int i;
> +	int c, a, u;
> +
> +	c = a = u = 0;
> +
> +	argc = parse_and_validate_options(argc, argv, builtin_shortstatus_usage, prefix);
> +	read_cache();
> +	refresh_cache(REFRESH_QUIET);
> +	wt_status_prepare(&s);
> +	wt_status_collect_changes(&s);
> +	if (mini) {
> +		for (i = 0; i < s.change.nr; i++) {
> +			struct wt_status_change_data *d;
> +			struct string_list_item *it;
> +
> +			it = &(s.change.items[i]);
> +			d = it->util;
> +			switch (d->index_status) {
> +				case DIFF_STATUS_ADDED:
> +					a = 1;
> +					break;
> +				case 0:
> +				case DIFF_STATUS_COPIED:
> +				case DIFF_STATUS_DELETED:
> +				case DIFF_STATUS_MODIFIED:
> +				case DIFF_STATUS_RENAMED:
> +				case DIFF_STATUS_TYPE_CHANGED:
> +					c = 1;
> +					break;

If you at the end discard information by squashing renamed, copied,
deleted and modified into a single "changed" category, I do not think you
would want wt_status_collect_changes() to spend the cost of rename
detection in the first place.  Sure, you can tell between "git mv old new"
and "git add new", because you won't show "+" for "new" if you run rename
detection, but that is about the only thing I think you are getting.

Is it worth extra 1 second (or 10 seconds)?

What are you really trying to achieve?  Do you want to see if you have any
change to the index since you checked out?  Do you want to further tell
the user that the work tree has more changes that are not staged yet
(which --mini does not seem to do)?

Do you really need more than "diff-index --cached --exit-code" in your
$PS1 code, and so why?  Does the added feature your "shortstatus --mini"
offers over "diff-index --cached --exit-code" justify the latency penalty
to the user?
