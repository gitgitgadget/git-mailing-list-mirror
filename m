From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 21/48] merge-recursive: Fix recursive case with D/F
 conflict via add/add conflict
Date: Mon, 18 Jul 2011 16:40:13 -0700
Message-ID: <7vhb6jb1k2.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-22-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:40:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixQc-0003Wr-SP
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab1GRXki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:40:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38284 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853Ab1GRXkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:40:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 601AE420D;
	Mon, 18 Jul 2011 19:40:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=OUkGBD9IyTbmxNj5YDa6svCZGeg=; b=VOxqsMwbijv3CMZz5mE0
	9VOYr8fuSGw9Wsg4niDTX7BQvs6fygU9zycCKrotmDN3KwYjJ/oZuhu4xapngfVN
	1XOW6FW/kCy+Zw+hOLBNkcuh6S+kWxZlig5Q3It+/wVkXwUxaIn2de2/91vV/2P0
	ZnO931oSwkAdhCCt4niNQ0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mNbtO30XADZkrwxRttm7Gem9h4WjQkd69zoU+T2AgH41F2
	AhXBpaBiwx+yUKSnemuLgn2kR+43mlxC9FwWuZV047ugsGb0YV5gsOcO2NmFuJq7
	vPyQTkaxM9wSYzlu7W13v1KmXMD3WbYzzXu/vT0VOikR1K6Jjhbb9EkizlO0A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D18E420C;
	Mon, 18 Jul 2011 19:40:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C65C9420B; Mon, 18 Jul 2011
 19:40:15 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49D90520-B197-11E0-B023-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177429>

Elijah Newren <newren@gmail.com> writes:

> When a D/F conflict is introduced via an add/add conflict, when
> o->call_depth > 0 we need to ensure that the higher stage entry from the
> base stage is removed.


>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c                 |    2 ++
>  t/t6036-recursive-corner-cases.sh |    4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 7da6aa0..4771fb4 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1480,6 +1480,8 @@ static int process_df_entry(struct merge_options *o,
>  			       "Adding %s as %s",
>  			       conf, path, other_branch, path, new_path);
>  			update_file(o, 0, sha, mode, new_path);
> +			if (o->call_depth)
> +				remove_file_from_cache(path);

Puzzling... This codepath is inside

	if (lstat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
        	...

which _is_ all about the working tree. Why should the code even looking at
the working tree if it can be called for recursive virtual ancestor merge?
I'll keep reading the series, hoping that this is something that will be
fixed in a later patch (ah, 23/48 does that).

At the outermost merge, you would keep the made-up name "new_path" as well
as the original name "path"?

When you added "d/f" (file in a directory) and I added "d" (file), merging
your work to my tree with this code would result in

	d at stage #2 (no 0/1/3);
	d~madeupsuffix in the working tree;
        d/f at stage #3 (no 0/1/2); and
        d/f in the working tree.

right? I am not sure if you also have d-madeupsuffix in the index.

As I said in my review of an earlier patch for test suite, having "d" in
the index would be helpful to the user ("git diff" cannot be used to see
what's different) so we _might_ be better off leaving this instead:

	d-madeupsuffix at stage #2 (no 0/1/3);
	d~madeupsuffix in the working tree;
        d/f at stage #3 (no 0/1/2); and
        d/f in the working tree.

and removing "d" from the index even for the outermost merge.

Thanks.
