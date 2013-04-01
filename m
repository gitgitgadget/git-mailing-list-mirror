From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] checkout: add --no-widen for restoring files in
 sparse checkout mode
Date: Sun, 31 Mar 2013 21:48:16 -0700
Message-ID: <20130401044816.GI11704@elie.Belkin>
References: <1364101583-6035-1-git-send-email-pclouds@gmail.com>
 <1364637753-18785-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kirill.mueller@ivt.baug.ethz.ch,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 06:48:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMWft-0000YJ-Nl
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 06:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756891Ab3DAEsZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Apr 2013 00:48:25 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42921 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882Ab3DAEsY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Apr 2013 00:48:24 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl13so1130461pab.32
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 21:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fX3lz7p+aHolwdtxCYbCib93hnyzrelZvjEmNtEpffM=;
        b=ycJrE1bwIaTHt1xVlfGXo3iy89O8283tj6pSRKTVMM6kITYzXdR1Rsj8qaBpdJ0yFH
         CnSM56b5VMadCVz0S6grSm8DurCdcqQaVPO49KgjLW0LOc9UwD2wBi2mHF2gsFM7OLEZ
         Yw5Bwt4WcfGUNPcYzbzJEqWuSUJ7Vc0HyjzL6GODHFzaXR+6FnEMUNO3PDpw6fhPFZhj
         W/gx+LiiN3TzHIjN6Hv2IiTY350OzUPMWQWGquawXLBwxBFpSI6t+d0cVyu1Hwb9uwsH
         +QHBgqnlUo+qMrHtuNEuo87x5W1jvT/CM+0UV4/LdsaozbF6an9DLe8duIx17iXYvNUi
         Fn4w==
X-Received: by 10.66.184.203 with SMTP id ew11mr17133507pac.73.1364791704352;
        Sun, 31 Mar 2013 21:48:24 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id qa6sm12246651pbc.46.2013.03.31.21.48.21
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 31 Mar 2013 21:48:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1364637753-18785-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219668>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> "git checkout -- <paths>" is usually used to restore all modified
> files in <paths>. In sparse checkout mode, this command is overloaded
> with another meaning: to add back all files in <paths> that are
> excluded by sparse patterns.
>
> Add "--no-widen" option to do what normal mode does: restore all
> modified files and nothing else.

In an ideal world, I would like "git checkout --widen" to modify the
=2Egit/info/sparse-checkout file, to be able to do:

	git clone --sparse-checkout=3DDocumentation git://repo.or.cz/git.git
	cd git
	git checkout --widen -- README COPYING INSTALL

and hack on a tree with Documentation/, README, COPYING, and INSTALL
present with no actual code to distract.  And "git checkout --no-widen"
could be a way to ask to respect the existing sparse pattern.

This patch isn't about tweaking the sparse-checkout pattern; instead,
it's about how "git checkout" interacts with the skip-worktree bit.
Maybe a good name would be --respect-skip-worktree?

[...]
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -180,6 +180,17 @@ branch by running "git rm -rf ." from the top le=
vel of the working tree.
>  Afterwards you will be ready to prepare your new files, repopulating=
 the
>  working tree, by copying them from elsewhere, extracting a tarball, =
etc.
> =20
> +--no-widen::
> +	In sparse checkout mode, `git checkout -- <paths>` would
> +	update all entries matched by <paths> regardless of sparse
> +	patterns. This option only updates entries matched by <paths>
> +	and sparse patterns.
> +
> +--widen::
> +	Revert the effect of `--no-widen` if specified and make
> +	`git checkout -- <paths>` update all entries matched by
> +	<paths> regardless of sparse patterns.

Perhaps, combining the descriptions of the positive and negative forms:

	--respect-skip-worktree::
		By default, `git checkout -- <paths>` creates or updates files
		matching <paths> regardless of the skip-worktree bit.  This
		option makes 'git checkout' skips entries with the
		skip-worktree bit set, which can be useful in sparse checkout
		mode.

I'm afraid I can't imagine when --no-respect-skip-worktree would be
useful.  That can easily be a failure of my imagination, though.

What do you think?

Thanks,
Jonathan
