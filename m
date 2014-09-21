From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 22/32] checkout: support checking out into a new
 working directory
Date: Sat, 20 Sep 2014 23:10:47 -0400
Message-ID: <CAPig+cRbfxUHmxbxxXLw=WKuV3JvBPEhuT4CvrZEOhWR-fbMHQ@mail.gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
	<1410388928-32265-1-git-send-email-pclouds@gmail.com>
	<1410388928-32265-23-git-send-email-pclouds@gmail.com>
	<5411B98C.1090905@xiplink.com>
	<20140921024101.GA6275@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 05:11:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVXYD-0005xJ-Q3
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 05:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbaIUDKt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2014 23:10:49 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:63630 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbaIUDKs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Sep 2014 23:10:48 -0400
Received: by mail-yh0-f46.google.com with SMTP id 29so412022yhl.5
        for <git@vger.kernel.org>; Sat, 20 Sep 2014 20:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=CM6/DaXUHzpN5rB9qhvC7kfV+3fFfwGlsZE5wJjjj5k=;
        b=M4qfW2rgCWkoUclSZZDjprkmLg9MKalWGmRoHp9UBSreeenN36sWyvsr8WYrABYbuo
         Yam9B9YLJ6475J0ukIDcIgpxUINnNyQjxWRkv0l4HfhvlyYtmCZEEAkUF1u6m1bjbG7y
         Hore+2OJez/9jKagVUM0nFxeAEAVP3QrJMrIbaSBt/wPJU29WD2OShWC83praEr1ADbz
         OPcMAKNOb+/h9gwooS4TbTJUra98gLcAj1q8GBAeWzZ0zwXStc+uSBKcKhbqc0GHwo1D
         fVvKC1HQbndJNnMS/StEPMNtmzSorjW/bvJKn1WgJV84PkiKNtBhgcI+QwHqLDyw+W7L
         NTxQ==
X-Received: by 10.236.63.198 with SMTP id a46mr16252678yhd.28.1411269047544;
 Sat, 20 Sep 2014 20:10:47 -0700 (PDT)
Received: by 10.170.68.68 with HTTP; Sat, 20 Sep 2014 20:10:47 -0700 (PDT)
In-Reply-To: <20140921024101.GA6275@lanh>
X-Google-Sender-Auth: aMkso48-1FSYIPRSgqz2RdT1Ykc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257338>

On Sat, Sep 20, 2014 at 10:41 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Sep 11, 2014 at 11:02:36AM -0400, Marc Branchaud wrote:
>> Um, didn't you say in [1] that you'd use the text I posted in [2]?
>>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/256446
>> [2] http://article.gmane.org/gmane.comp.version-control.git/256323
>
> That's the problem with updating a bit one day and a bit another
> day. Thanks for checking. Does this look ok?
>
> -- 8< --
> Subject: [PATCH] checkout: support checking out into a new working di=
rectory
>
> "git checkout --to" sets up a new working directory with a .git file
> pointing to $GIT_DIR/worktrees/<id>. It then executes "git checkout"
> again on the new worktree with the same arguments except "--to" is
> taken out. The second checkout execution, which is not contaminated
> with any info from the current repository, will actually check out an=
d
> everything that normal "git checkout" does.
>
> Helped-by: Marc Branchaud <marcnarc@xiplink.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index 33ad2ad..c101575 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -388,6 +395,45 @@ $ git reflog -2 HEAD # or
>  $ git log -g -2 HEAD
>  ------------
>
> +MULTIPLE WORKING TREES
> +----------------------
> +
> +A git repository can support multiple working trees, allowing you to=
 check
> +out more than one branch at a time.  With `git checkout --to` a new =
working
> +tree is associated with the repository.  This new working tree is ca=
lled a
> +"linked working tree" as opposed to the "main working tree" prepared=
 by "git
> +init" or "git clone".  A repository has one main working tree (if it=
's not a
> +bare repository) and zero or more linked working trees.
> +
> +Each linked working tree has a private sub-directory in the reposito=
ry's
> +$GIT_DIR/worktrees directory.  The private sub-directory's name is u=
sually
> +the base name of the linked working tree's path, possibly appended w=
ith a
> +number to make it unique.  For example, when `$GIT_DIR=3D/path/main/=
=2Egit` the
> +command `git checkout --to /path/other/test-next next` creates the l=
inked
> +working tree in `/path/other/test-next` and also creates a
> +`$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/tes=
t-next1`
> +if `test-next` is already taken).
> +
> +Within a linked working tree, $GIT_DIR is set to point to this priva=
te
> +directory (e.g. `/path/main/.git/worktrees/test-next` in the example=
) and
> +$GIT_COMMON_DIR is set to point back to the main working tree's $GIT=
_DIR
> +(e.g. `/path/main/.git`). These settings are made in a `.git` file l=
ocated at
> +the top directory of the linked working tree.
> +
> +Path resolution via `git rev-parse --git-path` uses either
> +$GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, in t=
he
> +linked working tree `git rev-parse --git-path HEAD` returns
> +`/path/main/.git/worktrees/test-next/HEAD` (not
> +`/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `=
git
> +rev-parse --git-path refs/heads/master` uses
> +$GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
> +since refs are shared across all working trees.
> +
> +See linkgit:gitrepository-layout[5] for more information. The rule o=
f
> +thumb is do not make any assumption about whether a path belongs to
> +$GIT_DIR or $GIT_COMMON_DIR when you need to directly access somethi=
ng
> +inside $GIT_DIR. Use `git rev-parse --git-path` to get the final pat=
h.

Would it make sense for this "rule of thumb" summary to be presented
first, and then the explanation of that rule after, rather than the
reverse as is currently the case?

> diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
> new file mode 100755
> index 0000000..8c73b18
> --- /dev/null
> +++ b/t/t2025-checkout-to.sh
> @@ -0,0 +1,63 @@
> +test_expect_success 'checkout --to from a linked checkout' '
> +       (
> +               cd here &&
> +               git checkout --to nested-here master

Broken &&-chain.

> +               cd nested-here &&
> +               git fsck
> +       )
> +'
> +
> +test_expect_success 'checkout --to a new worktree creating new branc=
h' '
> +       git checkout --to there -b newmaster master &&
> +       (
> +               cd there &&
> +               test_cmp ../init.t init.t &&
> +               git symbolic-ref HEAD >actual &&
> +               echo refs/heads/newmaster >expect &&
> +               test_cmp expect actual &&
> +               git fsck
> +       )
> +'
> +
> +test_done
> --
> 2.1.0.rc0.78.gc0d8480
