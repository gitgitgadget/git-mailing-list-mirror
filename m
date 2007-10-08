From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 09/13] Clear up the semantics of Series.new_patch
Date: Mon, 8 Oct 2007 14:16:10 +0100
Message-ID: <b0943d9e0710080616r36142946m3e24d2f6893287c9@mail.gmail.com>
References: <20070914222819.7001.55921.stgit@morpheus.local>
	 <20070914223154.7001.12254.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Oct 08 15:16:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IesT7-0000Rk-3U
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 15:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbXJHNQM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 09:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752916AbXJHNQM
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 09:16:12 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:36265 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbXJHNQL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Oct 2007 09:16:11 -0400
Received: by rv-out-0910.google.com with SMTP id k20so751529rvb
        for <git@vger.kernel.org>; Mon, 08 Oct 2007 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tk0+UFa2OkmF1C7x64WF0E4F7M7JKuQhM26BkfMVl2A=;
        b=e+aRwTvZ8HfqAKdojjhAQo8mcpU8NCYQcHLk9dj3MUhZzqcFmTEgUZYix4ccLHqEPlN/IDHEiCKhrmPJGOhJ2vescxGj4UD6A12viCmdy/N4Lj+XIv4Z2wCHz/soaEOU18nLCjF51wqFxEjSrBJi2DHHp577GSSbSuyASvmLVus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TxM2SHgKdUCJtIEc0iTh2dirWhgq+0/5FsyN0z3uETPXE8I5B50QpwkVU85mPDkhnDp/rM4jU4XYMrPie7YN1IFuoi8WT0NqDqNFSXMzun3lGjpTY1t7AWHrJycIU1FKZbmKtSOIMcLxJ6h4ZuvjGbpj5tyq1/+//Q1FKVKu34Y=
Received: by 10.140.250.14 with SMTP id x14mr2856318rvh.1191849370639;
        Mon, 08 Oct 2007 06:16:10 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Mon, 8 Oct 2007 06:16:10 -0700 (PDT)
In-Reply-To: <20070914223154.7001.12254.stgit@morpheus.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60319>

On 14/09/2007, David K=E5gedal <davidk@lysator.liu.se> wrote:
> This patch adds a number of assertions to document and verify the
> complex restrictions of the input parameters to the Series.new_patch
> function. It also adds the requirement that 'before_existing' and
> 'commit' cannot be true at the same time when calling it, instead of
> updating 'commit' inside the function.
[...]
> --- a/stgit/stack.py
> +++ b/stgit/stack.py
> @@ -833,9 +833,16 @@ class Series(PatchSet):
>                    author_name =3D None, author_email =3D None, autho=
r_date =3D None,
>                    committer_name =3D None, committer_email =3D None,
>                    before_existing =3D False):
> -        """Creates a new patch
> +        """Creates a new patch, either pointing to an existing commi=
t object,
> +        or by creating a new commit object.
>          """
>
> +        assert commit or (top and bottom)
> +        assert not before_existing or (top and bottom)
> +        assert not (commit and before_existing)
> +        assert (top and bottom) or (not top and not bottom)
> +        assert not top or (bottom =3D=3D git.get_commit(top).get_par=
ent())

The last assertion here prevents the use of 'stg pick --reverse'. This
command creates an unapplied patch with top and bottom reversed and
pushes it to force a three-way merge.

It seems to work OK if I comment it out but I wonder whether it will
break in the future with the planned removal of the top and bottom
files.

Thanks.

--=20
Catalin
