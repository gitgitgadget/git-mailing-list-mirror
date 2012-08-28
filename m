From: Junio C Hamano <gitster@pobox.com>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Mon, 27 Aug 2012 18:50:00 -0700
Message-ID: <7va9xfpyyf.fsf@alter.siamese.dyndns.org>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
 <878vd5k7uu.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 28 03:50:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6AwZ-0000pU-FN
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 03:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291Ab2H1BuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 21:50:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48988 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942Ab2H1BuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 21:50:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C93898E4;
	Mon, 27 Aug 2012 21:50:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Zn2XkTDZhW23CuqaZ8XNCun5xE=; b=j0KiKH
	80ygcdc50GQUBotrMXKmkI1riVZQF1wZ6I5ebrlGM2kNjQJOqgRD0uA9ldvmOBO5
	dCdsWgUixZ4kuMms4iVoNNZ+Nj4zesdO9EOicrZ6BnNLfQnJMTmfipj5Ge1nDGf5
	Mfqt1x3o6weUHZoHNNDHLA2GWJLRo84C2nBAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=flYTVRclFHtXLY0BvP5QdDX/o2GTMlnB
	TeND05mXymQzjrGEXP2r0oprjma6taPnhW0I1x5IUE2ZOKreApeuUCV8rBUP+HuF
	3U2MF4/owt+SRCcqV5JNH+j951z9+BK4ahBeWzQUC07L/Z7iD301qCNURzBSZXAc
	xMY9LjyEoAc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56F4A98E3;
	Mon, 27 Aug 2012 21:50:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEE1C98DF; Mon, 27 Aug 2012
 21:50:01 -0400 (EDT)
In-Reply-To: <878vd5k7uu.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 23 Aug 2012 16:20:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE6F6BE0-F0B2-11E1-9EB7-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204396>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git i/commit.c w/commit.c
> index 65a8485..70427ab 100644
> --- i/commit.c
> +++ w/commit.c
> @@ -837,10 +837,13 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
>  	struct commit_list *bases, *b;
>  	int ret = 0;
>  
> -	if (num == 1)
> -		bases = get_merge_bases(commit, *reference, 1);
> -	else
> +	if (num != 1)
>  		die("not yet");
> +
> +	bases = merge_bases_many(commit, 1, reference);
> +	clear_commit_marks(commit, all_flags);
> +	clear_commit_marks(*reference, all_flags);
> +	
>  	for (b = bases; b; b = b->next) {
>  		if (!hashcmp(commit->object.sha1, b->item->object.sha1)) {
>  			ret = 1;

This ended up being part of the series I sent earlier, and I want to
assign authorship to you. As you did this as part of the discussion,
naturally the patch came without a sign-off.  Can we consider it
signed off?  Just saying "ok" is fine.

Thanks.
