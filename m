From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/10] clean: support cleaning sparse checkout with -S
Date: Mon, 15 Nov 2010 15:30:59 -0600
Message-ID: <20101115213059.GJ16385@burratino>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 22:31:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI6eN-0004oP-F3
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 22:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758378Ab0KOVbi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 16:31:38 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50055 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab0KOVbh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 16:31:37 -0500
Received: by vws13 with SMTP id 13so1959072vws.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 13:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uDBTA1nbzd8Nkzw9QG0Bygx3Z6+aL9uFed8YaGetzak=;
        b=Jb+7QBLhcl0/vm2z/knkrR7NTNgkReEB4TgGOEeSiXJownrgEK031doiY7xDzoOCZQ
         JkDWdzwm1+sCepDDkOI04yG5dPVEngJG5KDx/DPqONDRfV/7tHHDRRzNc56Iv1jYg67l
         IPc+X3DS7jm3+8AZI9z5O9ignT8JDJjx/doa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cRCauqlfMWqn/VM0gOj2Rjd+e/UwCsZLM6olqV6ayeFkt9QbUD/g9V50w7oTmzENO3
         oiG5Xtb00QQFPhwgfI8pCxSP7bAYMXcELKfY2PvgpnNhfgRSHS4HhXL/QEvfDfe8I+Nc
         K36m029GgIb4BPi7rFi7Qd5VcnmAwIrncwYYw=
Received: by 10.220.181.140 with SMTP id by12mr1569057vcb.201.1289856696973;
        Mon, 15 Nov 2010 13:31:36 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id p28sm142248vcr.46.2010.11.15.13.31.33
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 13:31:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289817410-32470-11-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161516>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>                                                              Files
> that match the index exactly will be cleaned without "-f".

Hmm, that's new.  Seems fine, though; a person using -S would be
forwarned.

> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working t=
ree
>  SYNOPSIS
>  --------
>  [verse]
> -'git clean' [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>=
=2E..
> +'git clean' [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X | -S] [--] <=
path>...

So -S and -x don't combine?

> =20
>  DESCRIPTION
>  -----------
> @@ -61,6 +61,10 @@ OPTIONS
>  	Remove only files ignored by git.  This may be useful to rebuild
>  	everything from scratch, but keep manually created files.
> =20
> +-S::
> +	Remove files tracked by git but are outside of sparse checkout.
> +	Files that match the index exactly will be removed even when
> +	'-f' is not given and clean.requireForce is no.

Does "no" mean "yes" here?

Probably worth mentioning that -S does not apply here.

Would it be worth adding a -s/--clean-full-worktree option to
complete the analogy to -X?

> --- a/builtin/clean.c
> +++ b/builtin/clean.c

Not reading the code or tests because I'm trusting that I wouldn't
need to use this command. :)

Thanks, sparse checkout is looking sane now.
