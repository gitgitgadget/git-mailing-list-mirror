From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/6] line-log.c: fix a memleak
Date: Mon, 30 Mar 2015 22:06:16 -0700
Message-ID: <xmqqsiclsqlz.fsf@gitster.dls.corp.google.com>
References: <1427764931-27745-1-git-send-email-sbeller@google.com>
	<1427764931-27745-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com, tr@thomasrast.ch
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:06:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcoNd-0007v1-28
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 07:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbbCaFGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 01:06:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750706AbbCaFGT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 01:06:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A3FB38006;
	Tue, 31 Mar 2015 01:06:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GX1lolyJbqmHbdC3IMsFA4wUlss=; b=K2htr7
	mKsrrHokBKn9O5thVjWAev4WISr65LK8NgnWPfNHq5OpofzcRwHKQjv3RYSv8Xt+
	xCOv0uWwuqI70n0L2+A70apFu8a9ZW21HYebTzu5r3SOMWHmnYb35GwGV0v9kkYW
	ACtNi4WyBJ8YsjzR2xYAs55OYa8ax8Y8oMWG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vIbN6se1q4f93FPqSEtWB9ci912zXntu
	EfzpEtOY0KXqRzyE1l/ds1ONyBNXxYJS1haza8uD4AQD/05LJSKh16hOMrhbPt7X
	J0oGx3oOt0DFQ+RiE4R2GFn+RUvxntrADNNX9LJCM7G3HeDhl/Pd7uOpNgBvNZiD
	vliXvtrFVIY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9415038005;
	Tue, 31 Mar 2015 01:06:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E00138003;
	Tue, 31 Mar 2015 01:06:17 -0400 (EDT)
In-Reply-To: <1427764931-27745-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 30 Mar 2015 18:22:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A9610C40-D763-11E4-8926-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266513>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  line-log.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/line-log.c b/line-log.c
> index b43ac58..db6e58d 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -1129,6 +1129,9 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
>  	changed = process_all_files(&parent_range, rev, &queue, range);
>  	if (parent)
>  		add_line_range(rev, parent, parent_range);
> +	else
> +		free_line_log_data(parent_range);
> +

Should this be in the else clause?  From a cursory scan
add-line-range feeds it to either line-log-data-merge or
line-log-data-copy to create "new" that is a separate thing from the
parent_range we are feeding it, and that copy is used by
add-decoration.  If add-line-range does not take ownership of
parent_range from us, shouldn't we be freeing it whether we called
it or not???

>  	return changed;
>  }
