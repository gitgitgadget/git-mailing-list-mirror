From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 2.2.2 annotate crash (strbuf.c:32)
Date: Mon, 09 Feb 2015 12:50:35 -0800
Message-ID: <xmqq7fvqbyhw.fsf@gitster.dls.corp.google.com>
References: <54D7D634.2050807@aegee.org> <20150209012858.GB21072@peff.net>
	<CAPig+cQ7iYq_c_MstfsMzArCZFM_0ORRa8Gi-YckaeZiWKN=4w@mail.gmail.com>
	<54D88D03.1090501@aegee.org> <20150209184612.GA4327@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dilyan Palauzov <dilyan.palauzov@aegee.org>, git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 21:50:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKvI9-00012r-Bu
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 21:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbbBIUuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 15:50:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932594AbbBIUun (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 15:50:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 200EA3523C;
	Mon,  9 Feb 2015 15:50:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VK1txbONeHzt46X8ufwSnmYmA5Q=; b=LJbruQ
	qR7qcfvOMby78DkGmiw2RjoaHLKnkX08oeLqiq9iuKU1td0s1ZraSZ2qR08zDD5s
	MK67WapOmTHB2re3EolVcZXrr1Rhal+oIOJAKX4ufs1y8GfXdOK/yq9SdaTJDFM1
	O01wQHyzyjpsMndzu3ASltiIL5fxCRMNOLVnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HoSv7Zs7Ns0KR13msWYG1sK7WRR4zAmX
	B2ekMgHFlN8LtsXVMjyizKYjku3eiFCkwc419cMXeuJoZ9qOrrmMdNKywYZtPWU6
	fRV4zii6Pzucy/ZmV+cjma9GoI9FQsqWujxfMXGPLd8zkx8Qlnka1QqHPxaBCRgv
	mNHzpKlbT2U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 085883523A;
	Mon,  9 Feb 2015 15:50:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5856C3522D;
	Mon,  9 Feb 2015 15:50:37 -0500 (EST)
In-Reply-To: <20150209184612.GA4327@flurp.local> (Eric Sunshine's message of
	"Mon, 9 Feb 2015 13:46:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4CDB01DE-B09D-11E4-9D5B-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263595>

Eric Sunshine <sunshine@sunshineco.com> writes:

> There is a bit of suspicious code in builtin/blame.c where it is
> destroying the commit_info without ever initializing it,...

Good eyes.  I wonder why the compiler does not notice it.

It seems that this came from ea02ffa3 (mailmap:
simplify map_user() interface, 2013-01-05) and dates back to 1.8.2
or so.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 303e217..a3cc972 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2085,7 +2085,6 @@ static void find_alignment(struct scoreboard *sb, int *option)
>  
>  	for (e = sb->ent; e; e = e->next) {
>  		struct origin *suspect = e->suspect;
> -		struct commit_info ci;
>  		int num;
>  
>  		if (compute_auto_abbrev)
> @@ -2096,6 +2095,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
>  		if (longest_file < num)
>  			longest_file = num;
>  		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
> +			struct commit_info ci;
>  			suspect->commit->object.flags |= METAINFO_SHOWN;
>  			get_commit_info(suspect->commit, &ci, 1);
>  			if (*option & OUTPUT_SHOW_EMAIL)
> @@ -2104,6 +2104,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
>  				num = utf8_strwidth(ci.author.buf);
>  			if (longest_author < num)
>  				longest_author = num;
> +			commit_info_destroy(&ci);
>  		}
>  		num = e->s_lno + e->num_lines;
>  		if (longest_src_lines < num)
> @@ -2113,8 +2114,6 @@ static void find_alignment(struct scoreboard *sb, int *option)
>  			longest_dst_lines = num;
>  		if (largest_score < ent_score(sb, e))
>  			largest_score = ent_score(sb, e);
> -
> -		commit_info_destroy(&ci);
>  	}
>  	max_orig_digits = decimal_width(longest_src_lines);
>  	max_digits = decimal_width(longest_dst_lines);
