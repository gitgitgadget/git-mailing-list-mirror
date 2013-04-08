From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] gitweb: Fix utf8 encoding for blob_plain,
 blobdiff_plain, commitdiff_plain, and patch
Date: Mon, 08 Apr 2013 14:58:47 -0700
Message-ID: <7vd2u4vg4o.fsf@alter.siamese.dyndns.org>
References: <m2zjx8bxaj.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To: jk@blackdown.de (=?utf-8?Q?J=C3=BCrgen?= Kreileder)
X-From: git-owner@vger.kernel.org Mon Apr 08 23:58:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPK5X-0004O1-Tg
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936362Ab3DHV6u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Apr 2013 17:58:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59139 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935031Ab3DHV6u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Apr 2013 17:58:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A6DB143F5;
	Mon,  8 Apr 2013 21:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=j8kbrooZVOnG
	Iy6buzS7bzi4VYc=; b=m8jpftSH8A6m1t4lmuhkAJxrmLogxNrKPhVvIQOxGTY/
	hbRNH0TBBeQwvjJ82KcSxyV1686GwyOc5Q4Ua810zqRGBekAqEhu+snXcW6jQ4zp
	Uf4jVoWuRHYp34lDkczlWt2S6ThvGgmg91LsIgl4M0IO74D+rle5CmjfryQ7vus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RJ0kdf
	NRRQ+4qnKYuw4EHa0X7ytg8NT4OBRhRFY/sNgVwDyiel+fil3s5joe1wmd8KrxN0
	Lq1kUKThLYGg4DLp97YtJbVCsu+TzFTJlJQGtfQ9wykPIwOEKAY7ihpw9b8t6SQQ
	Zd4AltGTbUtFoywTQgKNb9XoyFebYUVFlXDME=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81C0C143F4;
	Mon,  8 Apr 2013 21:58:49 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9405143EF; Mon,  8 Apr
 2013 21:58:48 +0000 (UTC)
In-Reply-To: <m2zjx8bxaj.fsf@blackdown.de> (=?utf-8?Q?=22J=C3=BCrgen?=
 Kreileder"'s message of "Mon, 08 Apr 2013 22:08:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E0088FA-A097-11E2-A2D3-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220529>

jk@blackdown.de (J=C3=BCrgen Kreileder) writes:

> Fixes the encoding for several _plain actions and for text/* and */*+=
xml blobs.=20
>
> Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
> ---

Thanks, will queue but not hold until I hear something from Jakub.

>  gitweb/gitweb.perl |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1309196..9cfe5b5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3823,7 +3823,7 @@ sub blob_contenttype {
>  	my ($fd, $file_name, $type) =3D @_;
> =20
>  	$type ||=3D blob_mimetype($fd, $file_name);
> -	if ($type eq 'text/plain' && defined $default_text_plain_charset) {
> +	if (($type =3D~ m!^text/\w[-\w]*$! || $type =3D~ m!^\w[-\w]*/\w[-\w=
]*\+xml$!) && defined $default_text_plain_charset) {
>  		$type .=3D "; charset=3D$default_text_plain_charset";
>  	}
> =20
> @@ -7637,7 +7637,9 @@ sub git_blobdiff {
>  			last if $line =3D~ m!^\+\+\+!;
>  		}
>  		local $/ =3D undef;
> +		binmode STDOUT, ':raw';
>  		print <$fd>;
> +		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
>  		close $fd;
>  	}
>  }
> @@ -7884,12 +7886,16 @@ sub git_commitdiff {
> =20
>  	} elsif ($format eq 'plain') {
>  		local $/ =3D undef;
> +		binmode STDOUT, ':raw';
>  		print <$fd>;
> +		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
>  		close $fd
>  			or print "Reading git-diff-tree failed\n";
>  	} elsif ($format eq 'patch') {
>  		local $/ =3D undef;
> +		binmode STDOUT, ':raw';
>  		print <$fd>;
> +		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
>  		close $fd
>  			or print "Reading git-format-patch failed\n";
>  	}
