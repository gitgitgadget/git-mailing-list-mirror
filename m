From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: more meaningful Message-ID
Date: Tue, 05 Apr 2016 14:10:06 -0700
Message-ID: <xmqqinzv224x.fsf@gitster.mtv.corp.google.com>
References: <20160405193952.5849-1-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 05 23:10:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anYEs-0006Rv-7H
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 23:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbcDEVKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 17:10:11 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751320AbcDEVKK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 17:10:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7AB075367A;
	Tue,  5 Apr 2016 17:10:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3XQ+Lz7GLX34fRDEeBlkowX3gWs=; b=nqPG/h
	nhVP+AF5lqaZV6GJv1Dm7ev9ThN3V4g5kVPmL/sMPAvjPynfjBqUDV0pfKaIRYm6
	/uqUbf9F41j/K9AJ4ZBrq/nVb41vslStv7hrNHFGbTIOyKyPqs9ifKg7RIo97A/y
	OBhzm4WcDJxovds33Pzqnfe3AWMN/cT71CdYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LFpcCd7QZzlBtqxOQGd8WEfmhEPwBTJk
	12GVbq/KEJtHNmXCudpAYy58tozlj1jnJH0w4G+h5s3AJK5ws3X1PqIqS4xOkNWh
	v4WtjWozgM4hXlGDd9kUNoSOWb5l/5PGy9VRWPo/TUarbwrJhheYgwXXlJGHoRoc
	APUCLEUWTCc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 72DB553678;
	Tue,  5 Apr 2016 17:10:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E4A4153677;
	Tue,  5 Apr 2016 17:10:07 -0400 (EDT)
In-Reply-To: <20160405193952.5849-1-normalperson@yhbt.net> (Eric Wong's
	message of "Tue, 5 Apr 2016 19:39:52 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C67BDC0E-FB72-11E5-8941-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290811>

Eric Wong <normalperson@yhbt.net> writes:

> Using a YYYYmmddHHMMSS date representation is more meaningful to
> humans, especially when used for lookups on NNTP servers or linking
> to archive sites via Message-ID (e.g. mid.gmane.org or
> mid.mail-archive.com).  This timestamp format more easily gives a
> reader of the URL itself a rough date of a linked message compared
> to having them calculate the seconds since the Unix epoch.
>
> Furthermore, having the MUA name in the Message-ID seems to be a
> rare oddity I haven't noticed outside of git-send-email.  We
> already have an optional X-Mailer header field to advertise for
> us, so extending the Message-ID by 15 characters can make for
> unpleasant Message-ID-based URLs to archive sites.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---

Sounds like a sensible goal.  Just a few comments.

 - Is it safe to assume that we always can use POSIX::strftime(), or
   do we need some fallback?  I am guessing that this is safe, as
   POSIX has been part of the core modules for a long time, and the
   script does "use 5.008" upfront.

 - It is my understanding that, as "use" is a compilation-time
   thing, hiding it inside a block does not help reducing the
   start-up overhead (people can use "require" if they want to do a
   lazy loading and optionally a fallback).  Is my Perl5 outdated?
   Otherwise, let's have it near the beginning of the script, close
   to where we use Term::ReadLine and others.

Thanks.

>  git-send-email.perl | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index d356901..23141e7 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -949,7 +949,8 @@ my ($message_id_stamp, $message_id_serial);
>  sub make_message_id {
>  	my $uniq;
>  	if (!defined $message_id_stamp) {
> -		$message_id_stamp = sprintf("%s-%s", time, $$);
> +		use POSIX qw/strftime/;
> +		$message_id_stamp = strftime("%Y%m%d%H%M%S.$$", gmtime(time));
>  		$message_id_serial = 0;
>  	}
>  	$message_id_serial++;
> @@ -964,7 +965,7 @@ sub make_message_id {
>  		require Sys::Hostname;
>  		$du_part = 'user@' . Sys::Hostname::hostname();
>  	}
> -	my $message_id_template = "<%s-git-send-email-%s>";
> +	my $message_id_template = "<%s-%s>";
>  	$message_id = sprintf($message_id_template, $uniq, $du_part);
>  	#print "new message id = $message_id\n"; # Was useful for debugging
>  }
