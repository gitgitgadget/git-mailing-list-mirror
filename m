From: newren <newren@gmail.com>
Subject: Fwd: [PATCH/RFC 3/3] merge-recursive: Tolerate missing file when HEAD
 is up to date
Date: Fri, 24 Jan 2014 11:37:12 -0800
Message-ID: <CABPp-BE-p=FfJRtTXjoRhfSt2JwxniNdda-5=CvGN3cBXU15MA@mail.gmail.com>
References: <CABPp-BGAsrrjcZxVirzKU_VEyUM1U=4TFj18CieKKE7==c7v2A@mail.gmail.com>
	<cover.1390574980.git.brad.king@kitware.com>
	<5e5bfe752655c39fca626811972af9d0a90ddab9.1390574981.git.brad.king@kitware.com>
	<CABPp-BEK9+_ebRiodCp59DHJZExYn3N1jjtBsikSmwt-s_v_0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 24 20:37:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6mZ5-0000Xs-0A
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 20:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbaAXThO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 14:37:14 -0500
Received: from mail-oa0-f45.google.com ([209.85.219.45]:34157 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbaAXThN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 14:37:13 -0500
Received: by mail-oa0-f45.google.com with SMTP id i11so4269298oag.18
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 11:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=PylKizbz00SZojdr2mO9Mvpjwhgbs97rcNddGpTcC80=;
        b=aYgir8AS3e2hTZgxshhEPl0DZANtqgsFCogh765gZpjdzuxxNn/Rh15ZGo8GCt0ntU
         IRz5Z2vGJO1x61c2DYluEHFPrb7MP/32Tky+k4oZQi/hh+KOeI/r6BJMX/ZL73+McPgw
         efsKEP11ebj2lfD5r06el+ht9vA5akI3WfWwdq/2j9bH98y+z8+ILsdudVxQPMLPJiRR
         y6SdkJE5cbTHDXOIZUMDbBseT9stcu2KbcwxTQ9J5GksB+6IPGISnErnKatI42feLo/u
         rThHazvFWNt6HHKi2MGFaJXZWWZo+d0W46P7VtDyAn2TGdj6YlN+bkVNqIJwQmjCniMV
         4xng==
X-Received: by 10.182.135.194 with SMTP id pu2mr13564561obb.38.1390592232504;
 Fri, 24 Jan 2014 11:37:12 -0800 (PST)
Received: by 10.64.9.136 with HTTP; Fri, 24 Jan 2014 11:37:12 -0800 (PST)
In-Reply-To: <CABPp-BEK9+_ebRiodCp59DHJZExYn3N1jjtBsikSmwt-s_v_0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241023>

[The copy of my message to the list bounced; trying to resend...]

Hi,

Thanks for flagging this problem, providing a clear testcase, and working on it.

On Fri, Jan 24, 2014 at 7:01 AM, Brad King <brad.king@kitware.com> wrote:
>
> Teach add_cacheinfo to optionally tolerate make_cache_entry failure when
> the reason is ENOENT from lstat.  Tell it to do so in the call path when
> the entry from HEAD is known to be up to date.
>
> This fixes the 'merge-recursive w/ empty work tree - ours has rename'
> case in t3030-merge-recursive.

While this change does work for the particular new testcase you
provided, there's a more complex case where merge-recursive is failing
that is not yet found in the testsuite and not fully reflected with
your new test.  In particular, if you combine your special case of an
empty work tree with other special cases such as renames across a D/F
conflict, then git merge will fail and your change would merely
suppress part of the error messages.

To make this concrete, try modifying the 'merging with triple rename
across D/F conflict'  testcase in t6031-merge-recursive.sh (an example
that should merge cleanly) to remove all files from the working tree
right before the merge (which shoudln't affect whether the merge is
clean).  Currently, git merge will fail with:

error: addinfo_cache failed for path 'sub1/file3'
error: addinfo_cache failed for path 'sub1/file2'
error: addinfo_cache failed for path 'sub1/file1'
sub1/file1: unmerged (ac3e272b72bbf89def8657766b855d0656630ed4)
sub1/file2: unmerged (637f0347d31dad180d6fc7f6720c187b05a8754c)
sub1/file3: unmerged (27d10cc8d0f10540c1fce1aa6de5e8f3e6b655ba)
fatal: git write-tree failed to write a tree

Your patch would remove the first 3 error messages, but leave the
deeper problem.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 4394c44..6a2b962 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -198,13 +198,18 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
>  }
>
>  static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
> -               const char *path, int stage, int refresh, int options)
> +                        const char *path, int stage, int refresh,
> +                        int options, int noent_okay)
>  {
>         struct cache_entry *ce;
> +       int cache_errno = 0;
>         ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path,
> -                             stage, refresh, NULL);
> -       if (!ce)
> +                             stage, refresh, &cache_errno);
> +       if (!ce) {
> +               if(cache_errno == ENOENT && noent_okay)
> +                       return 0;
>                 return error(_("addinfo_cache failed for path '%s'"), path);
> +       }
>         return add_cache_entry(ce, options);
>  }


This is the crux of the change and the one you referred to in the
commit message.  However, we don't really want add_cacheinfo to
tolerate failure to create a cache entry; we need one.  We just want
add_cacheinfo to be tolerant of failure to refresh the stat-timestamp
for the new cache entry if there is no associated file on disk.  Said
another way, we need a new cache entry back from make_cache_entry() in
all cases, it's just that we want the stat information refreshed if
and only if the file happens to exist in the working tree.  (We could
just stat the file in the working tree, but that seems a waste since
make_cache_entry() will stat it again when it exists.  In fact, the
stat in make_cache_entry() is also a bit of a waste because this is
the case when we know that before the merge started the file already
had the right contents and thus we ought to be able to get the right
timestamp for that particular file from the cache entry of the index
from before the merge even began.  But I don't know how to access
that.)

Elijah
