From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test-lib: Multi-prereq support only checked the last
 prereq
Date: Tue, 10 Aug 2010 20:43:25 -0500
Message-ID: <20100811014325.GA4169@burratino>
References: <1281482511-2461-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 03:45:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj0NJ-0001jJ-Di
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 03:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758292Ab0HKBo5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 21:44:57 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37587 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757981Ab0HKBoz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 21:44:55 -0400
Received: by qyk36 with SMTP id 36so38966qyk.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 18:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fqbXPOyseq94E1B81GzgvpvAUtVhjnYkZpAeFLhHDzc=;
        b=BTt5Q38V7ZrUnTBMG4lA21CzdL0r+V8vhAWA1yNtlsAaGBVu2qvEleakmgNtt/vDqY
         EByC63fxcsiqGG7mrlIA3lyQAZLG7aqqREd5eNX+4rmb8nMIp4BBzkK8pJrtf9SKZ/iT
         YhopUa8rVdiA6SPBHGoqKTsRmOMSNStte9Kkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YXxhrMNd4mHbhL/T0CTEM19CvI8hz3urkJZg1ZzBhNYycWV19ickslTd3p2K+KOpwv
         REMk/at0e8iraLKu++j/sS3RE7aRFy5JjZ5nUIopmPCT7Tff6kBbKBbY3WaoEL793r+4
         wHhqSQn6cm4CjpOl+3APeyAJvHo4bLpW3IJJE=
Received: by 10.220.87.69 with SMTP id v5mr10954125vcl.133.1281491094629;
        Tue, 10 Aug 2010 18:44:54 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id m9sm1735509vcz.17.2010.08.10.18.44.53
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 18:44:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281482511-2461-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153183>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The clever for-loop (which I blindly copied from Junio)

You did not copy his =E2=80=9Creturn=E2=80=9D statement, though. :)

> +++ b/t/test-lib.sh
> @@ -337,15 +337,30 @@ test_have_prereq () {
>  	IFS=3D,
>  	set -- $*
>  	IFS=3D$save_IFS
> +
> +	total_prereq=3D0
> +	ok_prereq=3D0
> +	missing_prereq=3D
> +
>  	for prerequisite
>  	do
> +		total_prereq=3D$(($total_prereq + 1))
>  		case $satisfied in
>  		*" $prerequisite "*)
> -			: yes, have it ;;
> +			ok_prereq=3D$(($ok_prereq + 1))
> +			;;
>  		*)
> -			! : nope ;;
> +			# Keep a list of missing prerequisites
> +			if test -z "$missing_prereq"
> +			then
> +				missing_prereq=3D$prerequisite
> +			else
> +				missing_prereq=3D"$prerequisite,$missing_prereq"
> +			fi
>  		esac
>  	done
> +
> +	test $total_prereq =3D $ok_prereq
>  }

Wouldn=E2=80=99t

-		! : nope ;;
+		return 1 ;;

be simpler?

This and a small cleanup, including a test that catches this, are at
http://thread.gmane.org/gmane.comp.version-control.git/152814/focus=3D1=
52875

Hope that helps,
Jonathan
