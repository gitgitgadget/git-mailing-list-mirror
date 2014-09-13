From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: git archive and glob pathspecs
Date: Sat, 13 Sep 2014 12:36:03 +0200
Message-ID: <6687757.cFzdCVORFi@al>
References: <7752133.8a4hJ4krff@al> <CACsJy8BZBe1XV-uM8VHeGcDntn6vqJrNsWi6wTdQ1+fWAAsGFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 12:36:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSkgn-0004B7-Iw
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 12:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbaIMKgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 06:36:09 -0400
Received: from lekensteyn.nl ([178.21.112.251]:54240 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbaIMKgI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 06:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=LF7RdxSaKtxeNb/l9qVlgyALg2pkYJoBv+BFCT5d0wU=;
	b=R1Su2JP3o4/C7xdSh2HHj9DnlZ2ZkwZuIYsoasQgA6sEhCBd4wnfhDfXRrrxTQpKqKxzJw5XkT3caCJYIPzntH756M/VEj2jzz8171BbCVz+2xO9C3RtHN5GM1EQCf608M4bCUWuJldoMbIM26uiOh+FrYOTK0REWqCRlq9D9pE3y1bvBIaSwa8kz2/kiYv1soVhMXxjN1MM6+yMAJrg4Lk1j/mLANzSWI+kfONkrBrKxsbMEwtFaVVqIH65L8F0ZrZv/Z2WdZNzQ7s45mTPRVDzEL+L8keuqDn+hub4IRY/9PAdQ3LPdWDeTkBL0vALO6+mzVItVG6nEDmm7bfzOg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1XSkgW-0002uU-N2; Sat, 13 Sep 2014 12:36:05 +0200
User-Agent: KMail/4.13.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.0; x86_64; ; )
In-Reply-To: <CACsJy8BZBe1XV-uM8VHeGcDntn6vqJrNsWi6wTdQ1+fWAAsGFg@mail.gmail.com>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256960>

On Wednesday 03 September 2014 13:21:06 Duy Nguyen wrote:
> On Wed, Sep 3, 2014 at 5:17 AM, Peter Wu <peter@lekensteyn.nl> wrote:
> > Hi,
> >
> > The `git archive` seems to accept a pathspec judging from the error message (git
> > version 2.1.0):
> >
> >     git archive HEAD -- :x
> >     fatal: pathspec 'x' did not match any files
> >
> > When I try to use deeper glob specs however, it throws an error (this also
> > happens if I use `:(glob)**/Makefile`, tested in the git source tree):
> >
> >     $ git archive HEAD -- ':(glob)*/Makefile'
> >     fatal: pathspec '*/Makefile' did not match any files
> >
> > Strange enough, command `git log -- ':(glob)*/Makefile'` works. Any idea what is
> > wrong?
> 
> There may be something wrong. This patch seems to make it work for me,
> but it includes lots of empty directories. I'll have a closer look
> later (btw it's surprising that negative pathspec works too..)

I can confirm that this patch shows Makefile's, but also includes a lot of empty
directories.

As for why this happens, my guess is that write_archive_entries() recurses the
full tree and adds every encountered directory (via read_tree_1, via
write_archive_entry()).

To fix this, write_archive (write_tar_archive, etc.) should be taught to handle
glob patterns, or parse_pathspec should expand globs (and then
parse_pathspec_arg might have to validate the remaining patterns).

Kind regards,
Peter

> diff --git a/archive.c b/archive.c
> index 3fc0fb2..a5be58d 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -221,6 +221,7 @@ static int path_exists(struct tree *tree, const char *path)
>   int ret;
> 
>   parse_pathspec(&pathspec, 0, 0, "", paths);
> + pathspec.recursive = 1;
>   ret = read_tree_recursive(tree, "", 0, 0, &pathspec, reject_entry, NULL);
>   free_pathspec(&pathspec);
>   return ret != 0;
> @@ -237,6 +238,7 @@ static void parse_pathspec_arg(const char **pathspec,
>   parse_pathspec(&ar_args->pathspec, 0,
>         PATHSPEC_PREFER_FULL,
>         "", pathspec);
> + ar_args->pathspec.recursive = 1;
>   if (pathspec) {
>   while (*pathspec) {
>   if (**pathspec && !path_exists(ar_args->tree, *pathspec))
