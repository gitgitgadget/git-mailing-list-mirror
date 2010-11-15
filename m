From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/10] checkout: add --full to fully populate working
 directory
Date: Mon, 15 Nov 2010 15:23:11 -0600
Message-ID: <20101115212311.GI16385@burratino>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 22:24:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI6Wp-0000kZ-HP
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 22:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933808Ab0KOVXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 16:23:51 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56136 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933799Ab0KOVXt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 16:23:49 -0500
Received: by vws13 with SMTP id 13so1950952vws.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 13:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aNm751jcJaK4umfOCVKDUy4HnGE84Abnxzfdfn9WTi0=;
        b=IGThXtklo9+vAjBhMZ+MfkAVfyhZEbgirpJUu+ZbmeDfcPGQa8q6l2MV/JnAgsNn5V
         lfkgXKh+8HtVc53s9s4Y7dy17X+AcuxQ9oaFajw/mbG+by1Mw9zGsECLTmOavQcK+Ykk
         2lLbpI3QinjB+jgCXa6dQpd03f7qTkgEXix7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=csifCqF4SWjR/dfMzqhld6692jWheFZHosF5Ej8IS/nlr14Cu1t1fqTucoSoseQESS
         HQINmN/ExhGC1otnGgtKxvpoTA2vcQR8B2ch6oaxRUILpwM/Jp7chjKLU4u0/kZokUyc
         g80HfOdZWc3OcaSPE6Vd6AJeAyULcM5x2kD00=
Received: by 10.220.186.72 with SMTP id cr8mr1487607vcb.76.1289856228177;
        Mon, 15 Nov 2010 13:23:48 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id j22sm140183vcr.31.2010.11.15.13.23.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 13:23:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289817410-32470-9-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161515>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<star=
t_point>]
>  'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-i=
sh>] [--] <paths>...
>  'git checkout' --patch [<tree-ish>] [--] [<paths>...]
> -'git checkout' -S
> +'git checkout' [-S|--full]

Brackets mean "optional".

> @@ -184,6 +184,10 @@ edits from your current working tree.
>  	$GIT_DIR/info/sparse-checkout. The working directory is also
>  	updated. An empty file will abort the process.
> =20
> +--full:
> +	Reset $GIT_DIR/info/sparse-checkout to include everything and
> +	update working directory accordingly.

Maybe say something about "widen" and "whole project"?

> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -952,8 +957,20 @@ no_reference:
>  	if (opts.writeout_stage)
>  		die("--ours/--theirs is incompatible with switching branches.");
> =20
> -	if (update_sparse_checkout)
> -		edit_info_sparse_checkout();
> +	if (update_sparse_checkout) {
> +		if (full_checkout) {
> +			FILE *fp =3D fopen(git_path("info/sparse-checkout"), "w+");

What should --full --edit-worktree-shape-or-whatever-that-was-called do=
?

> --- a/t/t1011-read-tree-sparse-checkout.sh
> +++ b/t/t1011-read-tree-sparse-checkout.sh
> @@ -202,4 +202,11 @@ EOF
>  	test ! -f init.t
>  '
> =20
> +test_expect_success 'git checkout --full' '
> +	git checkout --full &&
> +	grep "^\*$" .git/info/sparse-checkout &&
> +	test -f sub/added &&
> +	test -f init.t

Probably worth checking that that's the only pattern in the file so
short-circuiting happens.
