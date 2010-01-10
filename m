From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Use $(git rev-parse --show-toplevel) in
 cd_to_toplevel()
Date: Sun, 10 Jan 2010 04:11:54 -0600
Message-ID: <20100110101154.GA18138@progeny.tock>
References: <alpine.LNX.2.00.1001102016380.2560@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Sun Jan 10 11:15:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTupx-000692-9I
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 11:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab0AJKLt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jan 2010 05:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590Ab0AJKLt
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 05:11:49 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:46282 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519Ab0AJKLs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 05:11:48 -0500
Received: by yxe17 with SMTP id 17so19615148yxe.33
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 02:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9cwr6iAerZLyTfLfGgF6cw2c4CEBhL10LsX0gdScLAs=;
        b=hrdECMIRvZL8XzICynucXHpl+COmYG8r/tB+ylrGlqSzIVJJljHdvtbB4LqoVMEuLb
         9ZK17fjc69c4/fwaSgXx9FmYdbTnw9/lxxmjY3Xc6d1IAVux9WwaDpLAxtdwGcjy6N1s
         KrxKtitRjDYG2XAg0fN08G0TlpOoC2HO92CU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KefsmWTcKaKyS6qFipNcBnbB8mMB8mV52yaUGtW/crChAoD8ar25hn7oqKxNbrd6q+
         lgv57nI66DRoGG7DGNHJ3PXC3ru/YRDELkha9zV1zO69pdhLMmc106b6kQbeTLKYd6N8
         81jbIXbUN2NTgHDiFuWkQL1GlJI1wPuDtpUig=
Received: by 10.101.167.16 with SMTP id u16mr8685164ano.170.1263118307316;
        Sun, 10 Jan 2010 02:11:47 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2534853iwn.13.2010.01.10.02.11.46
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Jan 2010 02:11:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1001102016380.2560@vqena.qenxr.bet.am>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136564>

Steven Drake wrote:

> 'cd -P' is not supported by all shell implementations.

Makes sense.

git already does not handle those cases where 'cd "$(pwd)"' fails
while 'cd .' does not, so your patch shouldn=E2=80=99t break anything. =
[1]

> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index dfcb807..3cbec05 100755
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -120,16 +120,10 @@ is_bare_repository () {
>  }
> =20
>  cd_to_toplevel () {
> -	cdup=3D$(git rev-parse --show-cdup)
> -	if test ! -z "$cdup"
> +	if test ! -z "$(git rev-parse --show-cdup)"
>  	then
> -		# The "-P" option says to follow "physical" directory
> -		# structure instead of following symbolic links.  When cdup is
> -		# "../", this means following the ".." entry in the current
> -		# directory instead textually removing a symlink path element
> -		# from the PWD shell variable.  The "-P" behavior is more
> -		# consistent with the C-style chdir used by most of Git.
> -		cd -P "$cdup" || {
> +		cdup=3D$(git rev-parse --show-toplevel)
> +		cd "$cdup" || {

Why not 'cdup=3D$(git rev-parse --show-toplevel) && cd "$cdup"'
unconditionally?  That would avoid having to look for the .git dir
twice and would mirror setup_work_tree() a bit more closely.

Avoiding -P not only improves portability but makes the function
easier to understand.  I like it.

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/135563/focus=
=3D135571
