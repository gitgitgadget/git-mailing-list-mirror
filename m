From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git archive and glob pathspecs
Date: Wed, 3 Sep 2014 13:21:06 +0700
Message-ID: <CACsJy8BZBe1XV-uM8VHeGcDntn6vqJrNsWi6wTdQ1+fWAAsGFg@mail.gmail.com>
References: <7752133.8a4hJ4krff@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Wed Sep 03 08:21:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XP3wr-0001jK-Cq
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 08:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974AbaICGVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 02:21:37 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:61258 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbaICGVg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 02:21:36 -0400
Received: by mail-ig0-f182.google.com with SMTP id a13so8563886igq.9
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 23:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PGB51apSa2eb1xKYHkqgS2h9mUcRGOXs2Qdi5CgCY+o=;
        b=OEeu6KTEaak/U6fMlgho/y9ipV52+y3x0M/zikbO6T7z+cCzZNV4/dVHmQ1zmKlfmW
         62xhsUBZvKvkNFBxe+JnioHp2wb1inWPe4bttURWZ/THL0tV1MW/Gfp4Z+z1rW+HB6zb
         ZIk+H78SGvGbIEUgs55lIbPFFeLBlOAeokwQmNZiS7MX8521J95AQ9A+dQz9qpm/Ui+n
         b52Fe73+iCKcHqnOgJxk7klHv9jp7dFx24iRDkLFvhALKWrpDyEvXiuc926v/F8KTJhQ
         UVA2t/T0EAghsbeoO6tnlJS8jVqGQdpb+RZ+ddNPU6Z85Q6giIPDp7AZ+iTWatwOcGIV
         BRng==
X-Received: by 10.50.103.106 with SMTP id fv10mr4101386igb.40.1409725296168;
 Tue, 02 Sep 2014 23:21:36 -0700 (PDT)
Received: by 10.107.3.152 with HTTP; Tue, 2 Sep 2014 23:21:06 -0700 (PDT)
In-Reply-To: <7752133.8a4hJ4krff@al>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256380>

On Wed, Sep 3, 2014 at 5:17 AM, Peter Wu <peter@lekensteyn.nl> wrote:
> Hi,
>
> The `git archive` seems to accept a pathspec judging from the error message (git
> version 2.1.0):
>
>     git archive HEAD -- :x
>     fatal: pathspec 'x' did not match any files
>
> When I try to use deeper glob specs however, it throws an error (this also
> happens if I use `:(glob)**/Makefile`, tested in the git source tree):
>
>     $ git archive HEAD -- ':(glob)*/Makefile'
>     fatal: pathspec '*/Makefile' did not match any files
>
> Strange enough, command `git log -- ':(glob)*/Makefile'` works. Any idea what is
> wrong?

There may be something wrong. This patch seems to make it work for me,
but it includes lots of empty directories. I'll have a closer look
later (btw it's surprising that negative pathspec works too..)

diff --git a/archive.c b/archive.c
index 3fc0fb2..a5be58d 100644
--- a/archive.c
+++ b/archive.c
@@ -221,6 +221,7 @@ static int path_exists(struct tree *tree, const char *path)
  int ret;

  parse_pathspec(&pathspec, 0, 0, "", paths);
+ pathspec.recursive = 1;
  ret = read_tree_recursive(tree, "", 0, 0, &pathspec, reject_entry, NULL);
  free_pathspec(&pathspec);
  return ret != 0;
@@ -237,6 +238,7 @@ static void parse_pathspec_arg(const char **pathspec,
  parse_pathspec(&ar_args->pathspec, 0,
        PATHSPEC_PREFER_FULL,
        "", pathspec);
+ ar_args->pathspec.recursive = 1;
  if (pathspec) {
  while (*pathspec) {
  if (**pathspec && !path_exists(ar_args->tree, *pathspec))

-- 
Duy
