From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] WIP: Report intra-test progress with TAP subtests
Date: Wed, 11 Aug 2010 00:28:30 -0500
Message-ID: <20100811052830.GA1355@burratino>
References: <1281473829-2102-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 07:30:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj3tE-0008Fq-Ny
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 07:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab0HKFaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 01:30:07 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58090 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab0HKFaF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 01:30:05 -0400
Received: by gwb20 with SMTP id 20so3945202gwb.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 22:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XmgapndIvFfEm602ufUFdL7v3CSCxazTuEJl2N5PTgk=;
        b=H2WYIiwq7ysDB538LzTYYhDoIJ/X8LkFWhp0McSJDez7kdIz6rlyl1orU5YZYcl3PA
         iPwYdQW1dIS+TzIN+jPM4VR+WUHlxHuxhkmul1zeRQR8LhSZh5/EvfksrwUZU1jSr1N1
         Iu8QCY4kCo/clae1HGiLAATZTLVpSrPL4WkqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KnZkE2jJVLw4GGVM/OeNJA0XJq6HOeY9VXk9u8CPXQ6PGVis4ViqoR3ISwC9umAtmN
         68wLZMLGJR4L9oy2G24feeHcz9dnQJIDWjN2s6DEodcB+CaItDUP9mQzGwery3IHWjcG
         0qjYDIeExM8tpjt/SasjXnXNhdWKKFGFqbei8=
Received: by 10.101.20.3 with SMTP id x3mr8629186ani.116.1281504600217;
        Tue, 10 Aug 2010 22:30:00 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u14sm11894243ann.0.2010.08.10.22.29.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 22:29:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281473829-2102-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153189>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Here's an attempt at that, I've convented test_commit, test_merge and
> test_cmp to report intra-test progress. The only problem is that it
> doesn't quite work.

I forgot to say: thanks for the demonstration.  This is neat stuff.

> 	eval >&3 2>&4 "$1"
>=20
> So when you run it you'll just get:
>=20
>     $ ./t0100-previous.sh
>         1..1
>     ok 1 - branch -d @{-1}
>     ok 2 - branch -d @{-12} when there is not enough switches yet
>         1..2
>     ok 3 - merge @{-1}
>     ok 4 - merge @{-1} when there is not enough switches yet
>     # passed all 4 test(s)
>     1..4
>=20
> Is there some filedescriptor saving/redirection magic I can do within
> the subtest code to print things to the *real* stdout and stderr

Descriptor 5 is a pass-through for stdout: see v0.99.5~24^2~4
(Trapping exit in tests, 2005-08-10).

Do you need a pass-through for stderr, too, or was that theoretical?

> @@ -290,20 +295,38 @@ test_tick () {
> =20
>  test_commit () {
>  	file=3D${2:-"$1.t"}
> -	echo "${3-$1}" > "$file" &&
> -	git add "$file" &&
> -	test_tick &&
> -	git commit -m "$1" &&
> -	git tag "$1"
> +	subtest_count=3D$(($subtest_count + 1))
> +
> +	if echo "${3-$1}" > "$file" &&
> +		git add "$file" &&
> +		test_tick &&
> +		git commit -m "$1" &&
> +		git tag "$1"
> +	then
> +		test_ok_ "test_commit file:<$file> message:<$1> contents<${3-$1}>"
> +		true
> +	else
> +		test_failure_ "test_commit file:<$file> message:<$1> contents<${3-=
$1}>"
> +		true
> +	fi

This would make the test continue after the subtest, right?  Is that
intended?
