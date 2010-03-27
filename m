From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] builtins: reset startup_info->have_run_setup_gitdir
 when unsetting up repository
Date: Sat, 27 Mar 2010 17:38:13 -0500
Message-ID: <20100327223813.GA5809@progeny.tock>
References: <1269681184-1992-1-git-send-email-pclouds@gmail.com>
 <1269681184-1992-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 23:38:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvedu-0008N7-SY
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 23:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab0C0Whx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Mar 2010 18:37:53 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:61308 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab0C0Whw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 18:37:52 -0400
Received: by gxk9 with SMTP id 9so697157gxk.8
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 15:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=G1zRHY1S5l6gtgoRzsweBehmy5dEx4NoGnyQsooysWE=;
        b=BE64VWzDqtdWZsYG6tviD51nNSh5qxmvQszXIILMojNac+axPbIOg2Ik2FUkzukZGZ
         s3BgvUjUW0EhQ8kvjhyBeb7WKdLDqSJll2rrPXbdR2wPkfzg32mLxJgX0b5JOI0mW7ER
         wLsXvnOxF6JyGUOnQ/LNdELZvNbtxq4rCKMcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mi5nupvelNDSJduRrQ/X+VAqngbo7uaWgk9VOu7h6BdDD+cKNV5BWUXiCCbAX5Iwgt
         luLOJiBCAopoAVUC2s/5wcS+4vli511b4/bMpTrpvXFcFeNOsfvtHG+2mmUTQOqE0fHv
         TdlXqGLLEFJyKIAa4MTcBj+KvDpkO4ctRjo90=
Received: by 10.101.139.8 with SMTP id r8mr4948120ann.60.1269729470784;
        Sat, 27 Mar 2010 15:37:50 -0700 (PDT)
Received: from progeny.tock (wireless-207-194.uchicago.edu [128.135.207.194])
        by mx.google.com with ESMTPS id 20sm2253117iwn.1.2010.03.27.15.37.49
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 15:37:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1269681184-1992-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143363>

Hi again,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> While at it, also reset repository_format_version to zero. When
> omitted, the format should be understood as the last supported
> version, i.e. zero. This is probably only used by "git init" or "git
> clone".
[...]
>  	/* Initialized in check_repository_format_version() */
> -	repository_format_version =3D 0xFF;
> +	repository_format_version =3D 0;

Good change, but wrong justification in my opinion.

v0.99.9l^2~54 (init-db: check template and repository format.,
2005-11-25) taught =E2=80=98git init-db=E2=80=99 to make sure that

  repository_format_version <=3D GIT_REPO_VERSION

before initializing a new repository.  repository_format_version was
being explicitly initialized globally to 0 at the time, presumably to
ensure tests like this always succeed when no repository format version
is declared (or in other words, the repository format for repositories
initialized before git v0.99.9l^2~56 is zero by convention).  As a happ=
y
side effect, that default takes care of the =E2=80=9Cno pre-existing re=
pository=E2=80=9D
case here.

The explicit initialization was removed in commit v1.4.3-rc1~230 (remov=
e
unnecessary initializations, 2006-08-15), since according to ANSI C it
is redundant.

So I think the convention is not =E2=80=9Cif in doubt, the repository h=
as
version GIT_REPO_VERSION=E2=80=9D but =E2=80=9Cif the repository lacks =
a
core.repositoryversion setting, it must be really old=E2=80=9D.

Jonathan
