From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/12] apply: run setup_git_directory_gently() sooner
Date: Sun, 15 Aug 2010 18:11:54 -0500
Message-ID: <20100815231154.GA3296@burratino>
References: <20100626192203.GA19973@burratino>
 <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
 <7v630hyf5r.fsf@alter.siamese.dyndns.org>
 <20100806023529.GB22369@burratino>
 <20100806030844.GJ22369@burratino>
 <AANLkTi=pAvJ=R9XVvo9fJqo6RPa+hn3dMfj2UGqTFCbU@mail.gmail.com>
 <AANLkTim6E8JFyjM=gdhbobm4sOskCJyHvT5oGj9fhoAd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 01:13:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkmOn-0008B7-0h
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 01:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185Ab0HOXNf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 19:13:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:32859 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab0HOXNe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 19:13:34 -0400
Received: by iwn7 with SMTP id 7so1041347iwn.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 16:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4ENgV4Xj81vCJE/GCEM6f3t/26ZjeIE6CzhA48cdWHg=;
        b=T2+ZWLaP+KEDd8qaLYUAnoLNRPngn96rCNYiihpky/9UXgx/Q5yFLAthv7Gp4NEtAX
         2PmAvMqsMumcyKpzi9WE8r/NC8qAgV8JLYFikX/zVQqOaQ98cia82QC592rooKPakMg7
         s/qgKdOQeawE++2bdLitI5vK7P8crRvSu/eIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=el9nGUJ9Z2fKuRzwfhdXnC6f71Ec14VeXZoVcC4ozhIUqIBvQUXphNSaytVOABnF61
         UiJ447DhT3pqkvyQOtd2dMANAcTKflFKDF/WjIbxHLidvvWcxFOFEUIIAXkzr6VWM4cY
         kIkXGudLKfF7NZT7APchWeNbpgV4Fyciky+Zk=
Received: by 10.231.174.136 with SMTP id t8mr4647335ibz.158.1281914013575;
        Sun, 15 Aug 2010 16:13:33 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm3870120ibk.9.2010.08.15.16.13.32
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 15 Aug 2010 16:13:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim6E8JFyjM=gdhbobm4sOskCJyHvT5oGj9fhoAd@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153628>

Nguyen Thai Ngoc Duy wrote:

> The patch loses prefix and git-apply couldn't find files on disk. Thi=
s
> patch may fix it. I'm running tests now.

Oh, good catch.  Thanks!

> diff --git a/builtin/apply.c b/builtin/apply.c
> index 6c4b747..29f4194 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -3779,7 +3779,7 @@ static int option_parse_directory(const struct
> option *opt,
>  	return 0;
>  }
>=20
> -int cmd_apply(int argc, const char **argv, const char *unused_prefix=
)
> +int cmd_apply(int argc, const char **argv, const char *prefix_)
>  {
>  	int i;
>  	int errs =3D 0;
> @@ -3856,6 +3856,7 @@ int cmd_apply(int argc, const char **argv, cons=
t
> char *unused_prefix)
>  		OPT_END()
>  	};
>=20
> +	prefix =3D prefix_;

This is why we shouldn=E2=80=99t be using globals so cavalierly. :)
