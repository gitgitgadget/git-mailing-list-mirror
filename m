From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff: support --root --cached combination
Date: Fri, 29 Oct 2010 05:19:59 -0500
Message-ID: <20101029101959.GA27662@burratino>
References: <1288346087-20263-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 12:20:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBm4G-0001tC-Hv
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 12:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659Ab0J2KUK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 06:20:10 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:63121 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab0J2KUI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 06:20:08 -0400
Received: by qyk10 with SMTP id 10so3235220qyk.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 03:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vdDyBLXuFlL9qOAqD+EsOnwFuJVNbqT7vX5BvD+AAyM=;
        b=jsfpzlS/vjp1hFiZwSLC38jMK8InSMUTZuDrkQEZa5bHxfZkM7uglt7dI9KPYPbitv
         0tIeWE/cKJsL8zclsYXa+XkEN8M2Hq7+XkI43pa4wHWNkv/1SDitJjkWYr2mdtBhrASB
         81CgITPpoB/eADWFhd5yxa9b3gWPqaD5Qcipo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XvWIwXilz65OTB67w5g+wwFKxwf2vjLj8Hla84ocQr7VXuC4hNnA7+KRmlumX+eeVW
         WT0mB1zB6ktqITAn9EpmaX+eoH8C71RFNJfmhnUXjvpHq3BWMhHlO0XSHKxWLu7aaeDw
         +WuVTYpGbIr+JKzqw9VeB44MeNUA0cozKVrww=
Received: by 10.229.183.21 with SMTP id ce21mr578783qcb.197.1288347607433;
        Fri, 29 Oct 2010 03:20:07 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id c8sm1596289yha.13.2010.10.29.03.20.05
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 03:20:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288346087-20263-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160325>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>  I have a ritual of doing "git dic" (short for diff --cached) before
>  committing and does not want to break it, even on new repos.
>=20
>  Looks like a good thing and no harm to the rest of the world.

This explanation belongs in the commit message, methinks.

> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -330,8 +330,13 @@ int cmd_diff(int argc, const char **argv, const =
char *prefix)
>  			else if (!strcmp(arg, "--cached") ||
>  				 !strcmp(arg, "--staged")) {
>  				add_head_to_pending(&rev);
> -				if (!rev.pending.nr)
> -					die("No HEAD commit to compare with (yet)");
> +				if (!rev.pending.nr) {
> +					struct object *obj;
> +					if (!rev.show_root_diff)
> +						die("No HEAD commit to compare with (yet)");

How does this condition get tripped?  The code allowing "[log]
showroot" to be set to false is only invoked by the log family of
commands.

Using --root as the backward-compatibility option seems like
an abuse of language, anyway.  "git diff --cached" has two
meanings:

 1. show changes to be committed

    1b. show what git show --format=3D" " would say after a commit

 2. show differences between the index and the commit named by the
    (implicit) HEAD argument

With interpretation (1b), --root should be respected, and the output
should be empty (!), not an error, when "[log] showroot" is false.

With interpretation (2), --root should not be respected, and an
attempt to diff --cached in an unborn branch should be an error.

(1a) and (1b) are the only useful interpretations.  So for simplicity,
would it make sense to drop the "if ()" for --root and make

> +test_expect_success 'diff --cached' '
> +	test_must_fail git diff --cached
> +'

fail?

> +					obj =3D (struct object*)lookup_tree((unsigned char*)EMPTY_TREE_=
SHA1_BIN);

	struct tree *tree =3D lookup_tree((const unsigned char *) ...
	obj =3D &tree->object;

might be more clear (and robust against future layout changes).
