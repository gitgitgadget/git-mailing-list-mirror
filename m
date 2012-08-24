From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Fri, 24 Aug 2012 18:42:19 +0700
Message-ID: <CACsJy8DJLmNWDNhGczk_0qDngHxDgQMh7zskxJXTqLGQ8gwugw@mail.gmail.com>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
 <878vd5k7uu.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 24 13:42:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4sHx-0008UP-JC
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 13:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab2HXLmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 07:42:52 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46058 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab2HXLmu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 07:42:50 -0400
Received: by ialo24 with SMTP id o24so3239302ial.19
        for <git@vger.kernel.org>; Fri, 24 Aug 2012 04:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dJxs4BDVC0Xz2LHKdOAfBIzg+l9NDLqCi+Gcb9uMJhE=;
        b=i7/3M+ZqHucRJ1hG+gCzMhZVDt9tPqBwUrl8mx/GXJN4EVlAjzFKoZyaN4X1BwU0jG
         m7PT8jS0DaC0oDDFNstvS+nV7P5n9oAPyeyFgzr8POWh1bNtRUMec6gQ8hqygxn0EM/y
         ab7w8sEZJTakWCGolVQqgCMsJXbuK39tRg3hWYYEpfMbGE7q00P4kHGB9srkJ/9c0mR2
         HnRH8uIJ+mceOsWl7nJpsGAFJPGjYEDwAO1retYsipHVEfpIFHVEOBe122d8zNpIkB8b
         da2srdKwDqsoqd4xCht20ivlDyO+sV+uicXXnR/YMfSWUUXOs86N/j/cTXoOm729K8Sp
         v9Rw==
Received: by 10.50.214.1 with SMTP id nw1mr1831196igc.2.1345808569983; Fri, 24
 Aug 2012 04:42:49 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Fri, 24 Aug 2012 04:42:19 -0700 (PDT)
In-Reply-To: <878vd5k7uu.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204205>

On Thu, Aug 23, 2012 at 9:20 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> At the very least it should be possible to change in_merge_bases() to
> not do any of the post-filtering; perhaps like the patch below.  It
> passes the test suite.  The whole "merge bases of A and a list of Bs"
> thing is blowing my overheated mind, though, so I'm not able to convince
> myself that it is correct in all cases.
>
> diff --git i/commit.c w/commit.c
> index 65a8485..70427ab 100644
> --- i/commit.c
> +++ w/commit.c
> @@ -837,10 +837,13 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
>         struct commit_list *bases, *b;
>         int ret = 0;
>
> -       if (num == 1)
> -               bases = get_merge_bases(commit, *reference, 1);
> -       else
> +       if (num != 1)
>                 die("not yet");
> +
> +       bases = merge_bases_many(commit, 1, reference);
> +       clear_commit_marks(commit, all_flags);
> +       clear_commit_marks(*reference, all_flags);
> +
>         for (b = bases; b; b = b->next) {
>                 if (!hashcmp(commit->object.sha1, b->item->object.sha1)) {
>                         ret = 1;

Without looking into detail (as I'm not familiar with this code), this
patch does not help much. Without the patch:

$ time ./git merge-base a4f2db3 b95a282
ed36e5bd41f7192e42e9b4c573875a343a9daf48

real    0m19.988s
user    0m19.797s
sys     0m0.082s

With the patch:

$ time ./git merge-base a4f2db3 b95a282
ed36e5bd41f7192e42e9b4c573875a343a9daf48

real    0m19.560s
user    0m19.448s
sys     0m0.037s
-- 
Duy
