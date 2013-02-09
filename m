From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Fix get_tz_offset to properly handle DST boundary
 cases
Date: Sat, 09 Feb 2013 14:58:08 -0800
Message-ID: <7vip61umbj.fsf@alter.siamese.dyndns.org>
References: <1360446418-12280-1-git-send-email-bdwalton@gmail.com>
 <1360446418-12280-3-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 23:58:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4JNU-0004V7-Ft
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 23:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760852Ab3BIW6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 17:58:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39691 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758291Ab3BIW6M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 17:58:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1575C609;
	Sat,  9 Feb 2013 17:58:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b0QRyHJXynKiTrqR2dBa950vjTI=; b=APHfjM
	A0gP3SyE7Sp+7qlGQaaoNr7fXkFi0fvwMoR8RByT4c+OEo/Kbn9z89TYw1pjVIMm
	DD/tgwjBARQWuQuHz3y4ERX7Zc0jarm0D2dRfuUPIuygcoxipB6g/4jxOlD4K7Lt
	MSgZq0SppC7h7gyfoZp4vIjSei8S6y3doat3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=duutWguDuxoe3Rg+zrQdJgw5Zti4h+fO
	dizTaEvCo1vkRSAhZB1YOjHkKhJgpvDgY16+CzBe6s1xqhfkeIw7/MHSvcD6SXKB
	qqKEY2gjPzRu37ygQOEldiwh+sTot+X1eRNL4QhFaVOM/Ix8yj9ohMekJ1CTV4UH
	vZlUekEA9S8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B654AC608;
	Sat,  9 Feb 2013 17:58:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4831FC607; Sat,  9 Feb 2013
 17:58:11 -0500 (EST)
In-Reply-To: <1360446418-12280-3-git-send-email-bdwalton@gmail.com> (Ben
 Walton's message of "Sat, 9 Feb 2013 21:46:57 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D667A02-730C-11E2-B957-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215879>

Ben Walton <bdwalton@gmail.com> writes:

> When passed a local time that was on the boundary of a DST change,
> get_tz_offset returned a GMT offset that was incorrect (off by one
> hour).  This is because the time was converted to GMT and then back to
> a time stamp via timelocal() which cannot disambiguate boundary cases
> as noted in its documentation.
>
> Modify this algorithm, using an approach suggested by Junio C Hamano
> that obtains the GMT time stamp by using timegm(localtime()) instead
> of timelocal(gmtime()).  This avoids the ambigious conversion and
> allows a correct time to be returned on every occassion.

I'll reword the log message a bit to explain why the updated logic
is right and also refer to the message that has the suggestion.  o

The implemmentation is a bit dense to my taste, but looks correct (I
had to think about the comparison to come up with the value of the
$sign, though).

Thanks.

> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---
>  perl/Git.pm |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 5649bcc..a56d1e7 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -103,7 +103,7 @@ use Error qw(:try);
>  use Cwd qw(abs_path cwd);
>  use IPC::Open2 qw(open2);
>  use Fcntl qw(SEEK_SET SEEK_CUR);
> -use Time::Local qw(timelocal);
> +use Time::Local qw(timegm);
>  }
>  
>  
> @@ -528,8 +528,8 @@ If TIME is not supplied, the current local time is used.
>  sub get_tz_offset {
>  	# some systmes don't handle or mishandle %z, so be creative.
>  	my $t = shift || time;
> -	my $gm = timelocal(gmtime($t));
> -	my $sign = qw( + + - )[ $t <=> $gm ];
> +	my $gm = timegm(localtime($t));
> +	my $sign = qw( + + - )[ $gm <=> $t ];
>  	return sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
>  }
