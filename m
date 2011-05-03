From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] diff: introduce --stat-lines to limit the stat
 lines
Date: Tue, 03 May 2011 11:47:33 -0700
Message-ID: <7vfwoviptm.fsf@alter.siamese.dyndns.org>
References: <7vmxj6s22r.fsf@alter.siamese.dyndns.org>
 <102e117f7a9f7fd6e652f23d5630db973e8e52b8.1304419588.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 03 20:47:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHKdQ-00049d-DA
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 20:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab1ECSrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 14:47:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab1ECSrm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 14:47:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6C07E3C9F;
	Tue,  3 May 2011 14:49:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T3cDA9W5mF2/xmv5yl/DAr6lR7E=; b=mrce5D
	/jI4gGkxMdurNCtl5UleOTTM6HhXu1BarsTuFbwEQHT+El7kKFdst2OdY9ObscQA
	NakDbWZ3RUhpR8W3k1HaVfHthCs0bNWeR/daGh37IMnB9nAd0Oz3PHym7vP4gb+p
	Yb8J1Hh4I3+CKghKCa448YuvhgzyNQLRmQ33A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PHnP0G8j5bvg/tlkhfeB+fU6p5mHDAkY
	XOUFjI7A575mOrFknn0asFvRrA5U/ZzJ+9rLrQLs3Dey3iEKXF9aWh1+eHbqmj32
	z6SvunjqF3Yy+sKwJBl3vLtX+w9XT9mmAR3X/HJViE+toUKASE8Q7oDtLkisv+Nf
	hTduBChCjwI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A1F43C9D;
	Tue,  3 May 2011 14:49:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2B6103C9C; Tue,  3 May 2011
 14:49:37 -0400 (EDT)
In-Reply-To: <102e117f7a9f7fd6e652f23d5630db973e8e52b8.1304419588.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 3 May 2011 12:46:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A9E3FF4-75B6-11E0-BB73-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172682>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> In the case with <count>+1 items one may argue whether it makes more sense to
> ignore the user wish and output all <count>+1 lines, or <count> lines (as
> requested) plus the "..." line.

I think that is a must if we care about consistency. fmt-merge-msg should
already do this (I remember being careful about this particular case when
I wrote its first version, but I do not know it has regressed as I do not
remember writing tests for this boundary case---my bad ;-).

> (I saw the suggestion about N-2...2 just now. Would work also, but I guess
> we would do this in more cases then, as Junio indicated.)

It is not clear what you mean by N-2...2 but if you are referring to my
"first N-1 entries, dots and the last one, to make the total N+1 lines
that show N entries", then yes I think it would make sense to do that also
in fmt-merge-msg.c::shortlog() as well as here.  But that would be a
separate topic.

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 34f0145..000eae0 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -48,11 +48,14 @@ endif::git-format-patch[]
>  --patience::
>  	Generate a diff using the "patience diff" algorithm.
>  
> ---stat[=<width>[,<name-width>]]::
> +--stat[=<width>[,<name-width>[,<count>]]]::
>  	Generate a diffstat.  You can override the default
>  	output width for 80-column terminal by `--stat=<width>`.
>  	The width of the filename part can be controlled by
>  	giving another width to it separated by a comma.
> +	By giving a third parameter `<count>`, you can limit the
> +	output to the first `<count>` lines, followed by
> +	`...` if there are more.

Does an empty-string <count> mean "use default" (currently "no limit")?
This matters when we teach a new parameter to --stat and make the above:

	--stat=[=<width>[,<name-width>[,<count>[,<nitfol>]]]]

> +	for (i = count; i < data->nr; i++) {
> +		uintmax_t added = data->files[i]->added;
> +		uintmax_t deleted = data->files[i]->deleted;
> +		if (!data->files[i]->is_renamed &&
> +			 (added + deleted == 0)) {
> +			total_files--;
> +			continue;
> +		}
> +		adds += added;
> +		dels += deleted;
> +	}
>  	fprintf(options->file, "%s", line_prefix);
>  	fprintf(options->file,
>  	       " %d files changed, %d insertions(+), %d deletions(-)\n",

This is culling the output of what is in struct diffstat that we have
already spent cycles to possibly fill thousands of entries.  I first
thought it may make sense to also tweak the loop in diff_flush() that runs
diff_flush_stat() to all filepairs to run it only on the first <count>
(and later the first <count-1> and the last) filepairs, but we have to
show the short-stat summary at the end, so this cannot be avoided.

What happens when I say "diff --numstat --stat-count=4"?

Should it error out upon seeing a limit that is not infinite, or should it
also elide the lines in its output?
