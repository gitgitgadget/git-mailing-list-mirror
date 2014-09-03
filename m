From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC PATCH 1/1] am: add gitk patch format
Date: Wed, 3 Sep 2014 21:59:26 +1200
Message-ID: <CAFOYHZAFvqv49oFAv5w5S2Eaw_fpbvucuNvSs7O9rMw367AwXw@mail.gmail.com>
References: <1409736919-22341-1-git-send-email-judge.packham@gmail.com>
	<1409736919-22341-2-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Chris Packham <judge.packham@gmail.com>
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 12:17:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XP7cl-0003za-1j
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 12:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565AbaICKFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 06:05:30 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:43084 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbaICKF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 06:05:27 -0400
Received: by mail-pd0-f170.google.com with SMTP id r10so10825990pdi.29
        for <git@vger.kernel.org>; Wed, 03 Sep 2014 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kbTZsKtjaDyDJKiCpSdA15PMIFgDHo4JRB8JlYiMGxI=;
        b=ovF80rfBPlMfelLwJrlxeXmIozH+Nkpt7+4qMAGazP5bD16utnfowt/BDlCTiHmzM9
         9KQsyUaq4d8FcqX0VkTgrANKBYeOFRxR7nB2JpcvigVgD2Zi16HMhIY3woOx0otwfbpc
         pZIK85fJyMxNBsOoXeYGlYUP2nM94lCXpBnljTNkcjItVVXZFag0RkB3576Lzr6+krDj
         uUVuovihRU7vtM4bfonvlVDQ8k+7RLaWopYwhoEHd3GhcALuOiUpx6DoI4kwNaDijZlH
         FjXBTFfxMVSBVumzhe+JNJTcnTapmra16ykiGsths3C3hVzV+2We4lVK9ArQn+UAWIPa
         ZDcg==
X-Received: by 10.70.96.233 with SMTP id dv9mr13625269pdb.146.1409738366806;
 Wed, 03 Sep 2014 02:59:26 -0700 (PDT)
Received: by 10.70.36.6 with HTTP; Wed, 3 Sep 2014 02:59:26 -0700 (PDT)
In-Reply-To: <1409736919-22341-2-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256387>

Reviewing my own code.

On Wed, Sep 3, 2014 at 9:35 PM, Chris Packham <judge.packham@gmail.com> wrote:
> Patches created using gitk's "write commit to file" functionality (which
> uses 'git diff-tree -p --pretty' under the hood) need some massaging in
> order to apply cleanly. This consists of dropping the 'commit' line
> automatically determining the subject and removing leading whitespace.
>
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
>  Documentation/git-am.txt |    3 ++-
>  git-am.sh                |   35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 9adce37..b59d2b3 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -101,7 +101,8 @@ default.   You can use `--no-utf8` to override this.
>         By default the command will try to detect the patch format
>         automatically. This option allows the user to bypass the automatic
>         detection and specify the patch format that the patch(es) should be
> -       interpreted as. Valid formats are mbox, stgit, stgit-series and hg.
> +       interpreted as. Valid formats are mbox, stgit, stgit-series, hg and
> +       gitk.
>
>  -i::
>  --interactive::
> diff --git a/git-am.sh b/git-am.sh
> index ee61a77..73b0a86 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -227,6 +227,9 @@ check_patch_format () {
>                 "# HG changeset patch")
>                         patch_format=hg
>                         ;;
> +               'commit '*)
> +                       patch_format=gitk
> +                       ;;
>                 *)
>                         # if the second line is empty and the third is
>                         # a From, Author or Date entry, this is very
> @@ -357,6 +360,38 @@ split_patches () {
>                 this=
>                 msgnum=
>                 ;;
> +       gitk)
> +               # These patches are generates with 'git diff-tree -p --pretty'
> +               # we discard the 'commit' line, after that the first line not
> +               # starting with 'Author:' or 'Date:' is the subject. We also
> +               # need to strip leading whitespace from the message body.
> +               this=0
> +               for gitk in "$@"
> +               do
> +                       this=$(expr "$this" + 1)
> +                       msgnum=$(printf "%0${prec}d" $this)
> +                       @@PERL@@ -ne 'BEGIN { $subject = 0 }
> +                               s/^    // ;

This is a little too aggressive. It'll also chomp whitespace from the
diff context. We should probably check for the 'diff --git' line and
stop stripping whitespace.

> +                               if ($subject > 1) { print ; }
> +                               elsif (/^commit\s.*$/) { next ; }
> +                               elsif (/^\s+$/) { next ; }
> +                               elsif (/^Author:/) { s/Author/From/ ; print ;}
> +                               elsif (/^Date:/) { print ;}
> +                               elsif ($subject) {
> +                                       $subject = 2 ;
> +                                       print "\n" ;
> +                                       print ;
> +                               } else {
> +                                       print "Subject: ", $_ ;
> +                                       $subject = 1;
> +                               }
> +                       ' <"$gitk" >"$dotest/$msgnum" || clean_abort
> +
> +               done
> +               echo "$this" >"$dotest/last"
> +               this=
> +               msgnum=
> +               ;;
>         *)
>                 if test -n "$patch_format"
>                 then
> --
> 1.7.9.5
>
