From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] blame: introduce -u/--unique option
Date: Wed, 09 Mar 2011 11:45:28 -0800
Message-ID: <7vy64o9ixz.fsf@alter.siamese.dyndns.org>
References: <1299581951-4670-1-git-send-email-namhyung@gmail.com>
 <1299581951-4670-2-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 20:45:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxPKL-0004VF-4b
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 20:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321Ab1CITpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 14:45:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab1CITpi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 14:45:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CBE4D3784;
	Wed,  9 Mar 2011 14:47:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XVBvmcK2MJmTcaXExdrtYnDS+V8=; b=MXaaMU
	/hgMN5emruWfKx89mR0GgSKyjo1+GRgLwrCf+vpiXhycZOhwehY6+eYvT0W7RTkS
	nbIifT9vRvxOSOcz+SI0rLeemKgN2prYB2rmB2TdKrOJYqfa2ti9QN5R2p7bMcBP
	K+mdJCH8hrzxhBphJAw8KXLQGlwObBg1p+Lzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kG1JwVGUgvBPwi7RUdAwQbJc3njeN2S1
	WX1fMG7aUEPLXSu7FnKG70wiVY+C/i1IYlCO3iiiUtDqVSBU01R8lgffQhIsgKlB
	1Xa3mFTMRK1TmPhdp0Rdn7liVP4Kla6iqNHrEYN+2k6ize6slSZehTS5tDO96Mr2
	q+DGXTu0840=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A9FDA3783;
	Wed,  9 Mar 2011 14:47:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B3F053782; Wed,  9 Mar 2011
 14:46:58 -0500 (EST)
In-Reply-To: <1299581951-4670-2-git-send-email-namhyung@gmail.com> (Namhyung
 Kim's message of "Tue, 8 Mar 2011 19:59:11 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00877C58-4A86-11E0-8725-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168748>

Namhyung Kim <namhyung@gmail.com> writes:

> -u/--unique option will find and use minimum length of unique
> SHA-1 name. If -l option is specified also, it will have higher
> priority, IOW git blame will use full 40-length SHA-1 name.

> @@ -1867,6 +1878,10 @@ static void find_alignment(struct scoreboard *sb, int *option)
>  			longest_dst_lines = num;
>  		if (largest_score < ent_score(sb, e))
>  			largest_score = ent_score(sb, e);
> +		sha1 = find_unique_abbrev(suspect->commit->object.sha1,
> +					  MINIMUM_ABBREV);
> +		if (longest_uniq_sha1 < strlen(sha1))
> +			longest_uniq_sha1 = strlen(sha1);

The logic to determine and keep track of the longuest-unique looks
correct, but I was hoping that we already have an easy optimization
codepath to do this only once per commit, not for every blame-entry in the
result.  Doesn't the code have a similar optimization to figure out the
necessary number of columns to show author names (I haven't read the code
recently, though)?

Also we might find that the performance impact of doing this may be so
miniscule that it is not worth wasting a short option name.  If we were to
use an option, I was actually hoping that the option would let the users
specify a value different from the hardcoded 8 at the same time.  E.g.

    git blame --abbrev=8 ;# current default with uniquefy applied
    git blame --abbrev=4 ;# equivalent to your "blame -u"

Can we have a benchmark of this feature in a largish and busy file in a
project with a deep history?
