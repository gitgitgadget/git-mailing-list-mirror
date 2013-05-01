From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] get_sha1: prefer 40-hex ref name over 40-hex SHA-1
Date: Wed, 1 May 2013 11:43:27 -0700
Message-ID: <20130501184327.GM24467@google.com>
References: <1367377282-9862-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:44:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXc1C-0001CL-JW
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab3EASod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 May 2013 14:44:33 -0400
Received: from mail-da0-f44.google.com ([209.85.210.44]:51561 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756053Ab3EASnb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:43:31 -0400
Received: by mail-da0-f44.google.com with SMTP id z20so767691dae.31
        for <git@vger.kernel.org>; Wed, 01 May 2013 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RgtmRrKYaQJGBGHYuWH65u4x+hRemKyh32JPVdhjDOc=;
        b=s1om0kDljA8v9BTV/LXl20Sw5IC9+QYB+7d1M3vbZIkIDOtw/BKHypWbGg9lKLh1fw
         9XEVrAhzdpe5xl3/gEstv+FFem/aghs1VaMz19k3UAgkPqxxfyVkK3hSFkqkZkfuNgv/
         sklfiqZ1Vj6SEaw736dWEgdSlUocasp7BtOqb9D4lXcD2iMAlCJetffrto3P5MBL5deC
         oWrPP0M3DI2AnsQIqHU8khZSFkOyfWiZ73h4sck+Jwn192BIZE+AfGAbx17kme5PWK7I
         v84AUHT0xtaAyFszA6QT9HyUbzkZiT0/e4DCAdGbqZcea96HJbilREpgTkyC/D+4u/x7
         lW2w==
X-Received: by 10.68.164.33 with SMTP id yn1mr5446683pbb.71.1367433811372;
        Wed, 01 May 2013 11:43:31 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id aj6sm3942759pbd.14.2013.05.01.11.43.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 May 2013 11:43:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1367377282-9862-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223120>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>                                              "git rev-parse 1234" wil=
l
> resolve refs/heads/1234 if exists even if there is an unambiguous
> SHA-1 starting with 1234. However if it's full SHA-1, the SHA-1 takes
> precedence and refs with the same name are ignored.

That's an important feature for safety.  When a script has created an
object or learned about it some other way, as long as it doesn't
abbreviate its name it can be sure that git commands will not
misunderstand it.

So I think this is a bad change.  Maybe check-ref-format should
reject 40-hexdigit refnames?

[...]
> --- a/t/t1512-rev-parse-disambiguation.sh
> +++ b/t/t1512-rev-parse-disambiguation.sh
> @@ -261,4 +261,19 @@ test_expect_success 'rev-parse --disambiguate' '
>  	test "$(sed -e "s/^\(.........\).*/\1/" actual | sort -u)" =3D 0000=
00000
>  '
> =20
> +test_expect_success 'rev-parse 20-hex ref' '
> +	REF=3D`git rev-parse HEAD` &&
> +	VAL=3D`echo| git commit-tree 4b825dc642cb6eb9a060e54bf8d69288fbee49=
04` &&
> +	git update-ref refs/heads/$REF $VAL &&
> +	test `git rev-parse $REF` =3D $VAL
> +'

This is a good thing to test.  Nit: outside of t0000, please use

	empty_tree=3D$(git mktree </dev/null) &&

instead of hard-coding the hash.  Otherwise you are making my life
hard when I write md5git. :)  And more importantly, this makes the
meaning of the test easier to understand by reading it.

Thanks,
Jonathan
