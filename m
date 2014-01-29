From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] diff: turn skip_stat_unmatch on selectively
Date: Wed, 29 Jan 2014 11:25:22 -0800
Message-ID: <xmqq61p2k2u5.fsf@gitster.dls.corp.google.com>
References: <1390632411-3596-3-git-send-email-pclouds@gmail.com>
	<1390863568-22656-1-git-send-email-pclouds@gmail.com>
	<xmqqd2jdm1jj.fsf@gitster.dls.corp.google.com>
	<xmqq7g9jlny6.fsf@gitster.dls.corp.google.com>
	<20140128235203.GA7788@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 29 20:25:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8alX-0001og-SD
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 20:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbaA2TZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 14:25:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62915 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122AbaA2TZe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 14:25:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A11EC665DD;
	Wed, 29 Jan 2014 14:25:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9tbMOctp9pCbyKMrW0j6wemyfR4=; b=GRoAvw
	57Hp1yoPMogmGNim/4v5q4EYGOA79P90TaVEU3+VggJr2Cq6L8RxGTsfbBlpbCfe
	Ubw9V71orc/2q1eIQj4tVITGOh1/EUhpat2iHBauDGdDl/KatpsjKAtYxMJjjOxV
	oGoV/eDwtxm8M+pEP0WKQ7j//By3iz1VVnLEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XvowxdKhvifPI7MBmRQ6VBe3deKU713t
	NlgyAhRleDguvX2nAVxkwObzuI7xXD3pAmltjwoW22RLyokmVRUm2vTJ4pp/bOgH
	bSYxp0EmCcpGVymdimsdqYDjgoYw50RPyxB67KenzwomZYXlda2B1BsRs7wdonlO
	5k2rwKUNUA8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82474665DC;
	Wed, 29 Jan 2014 14:25:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58FB6665D8;
	Wed, 29 Jan 2014 14:25:27 -0500 (EST)
In-Reply-To: <20140128235203.GA7788@lanh> (Duy Nguyen's message of "Wed, 29
	Jan 2014 06:52:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1BBCA4F4-891B-11E3-96D0-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241219>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Jan 28, 2014 at 02:51:45PM -0800, Junio C Hamano wrote:
>> >>  This replaces 'diff: turn off skip_stat_unmatch on "diff --cached"'
>> >>  The previous patch obviously leaves skip_stat_unmatch on in "diff
>> >>  <rev> <rev>" and maybe other cases.
>> >
>> > Oops, I lost track.  Sorry.
>> 
>> Together with {1,2}/3 applied on maint-1.8.4, this sems to break
>> t3417 (there may be others, but I didn't have time to check).
>
> My bad. I thought I covered all cases in my last patch (and didn't
> retest it!). It turns out I should have set skip_stat_unmatch in
> builtin_diff_b_f() too. This on top of 3/3 passes the tests

Thanks, will squash it in.

This however shows that the existing test *KNEW* that it was enough
to check just a few cases (especially, there is no reason to make
sure that blob vs file-in-working-tree case behaves sanely), because
the auto-refresh would kick in for all codepaths.  Now you are
making that assumption invalid, shouldn't the patch also split the
tests to cover individual cases?

> -- 8< --
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 88542d9..8ab5e3d 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -89,6 +89,7 @@ static int builtin_diff_b_f(struct rev_info *revs,
>  	if (blob[0].mode == S_IFINVALID)
>  		blob[0].mode = canon_mode(st.st_mode);
>  
> +	revs->diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
>  	stuff_change(&revs->diffopt,
>  		     blob[0].mode, canon_mode(st.st_mode),
>  		     blob[0].sha1, null_sha1,
> -- 8< --
