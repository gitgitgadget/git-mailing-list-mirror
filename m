From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Confused about sparse vs untracked-cache
Date: Thu, 30 Jul 2015 21:09:03 +0700
Message-ID: <CACsJy8C_PUq4htCSF=qUJ0HNWf-E4RGXJ2FuzbRhSRhLN2vrRg@mail.gmail.com>
References: <1438223527.18134.53.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 16:09:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKoWm-0000sw-3F
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 16:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbbG3OJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 10:09:34 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:33886 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbbG3OJd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 10:09:33 -0400
Received: by ioea135 with SMTP id a135so54722977ioe.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OsdjBKLyGJeK/F0iBjUTnkRXu+W7OMSFCGeflNkPutU=;
        b=eYIHZC/IeUSH/RuX6n+8pxWS5sqCJbQHEJeixAdmv3A9gHkoU5E+yrGvuSyxw7W933
         Dr9yJ/Hg73+hZV4N6Goc+1kvfGTUfMm0dkKhffstta52J3t8LJHouKOVP5rWAL+aAuCe
         UZK6UKz1TsNuDpuAXUDB0YK4FfNXSD5Uv7YWL26H+PbT5d4W+YnYxyRnA1nMFFftThQO
         8iEo6LVh2ejyKf2tGL9BFIni6lp1wo2K2tqnOglNcwco3VHzYOva9OwAhGHt0CWtESEC
         rD5md+QPHn6eyq9fj+pWausmcSVZBNXspU6HbqAqB4zhSA96Ga9vHDJrKme/id1vEDRJ
         nRSg==
X-Received: by 10.107.19.206 with SMTP id 75mr10534315iot.191.1438265372651;
 Thu, 30 Jul 2015 07:09:32 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Thu, 30 Jul 2015 07:09:03 -0700 (PDT)
In-Reply-To: <1438223527.18134.53.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274987>

On Thu, Jul 30, 2015 at 9:32 AM, David Turner <dturner@twopensource.com> wrote:
> I'm looking at dir.c, and there's a bit I'm confused about:
>
> prep_exclude() says:
>                      /*
>                       * .. and .gitignore does not exist before
>                       * (i.e. null exclude_sha1 and skip_worktree is
>                       * not set). Then we can skip loading .gitignore,
>                       * which would result in ENOENT anyway.
>                       * skip_worktree is taken care in read_directory()
>                       */
>                      !is_null_sha1(untracked->exclude_sha1))) {
>
> That "skip_worktree is taken care in read_directory()" appears to be
> referring to this bit of validate_untracked_cache():
>         /*
>          * An optimization in prep_exclude() does not play well with
>          * CE_SKIP_WORKTREE. It's a rare case anyway, if a single
>          * entry has that bit set, disable the whole untracked cache.
>          */
>         for (i = 0; i < active_nr; i++)
>                 if (ce_skip_worktree(active_cache[i]))
>                         return NULL;
> ------------
> I'm confused about why skip_worktree needs to be unset.  When I comment
> out the second snippet, all the tests still pass.  What was the reason
> behind that condition?  Is it really necessary?

This code is added in 27b099a (untracked cache: don't open
non-existent .gitignore - 2015-03-08) so it's about non-existent
.gitignore files. We have two cases: .gitignore does not exist, which
we want to avoid opening it, and .gitignore does not exist, but it's
in the index and is skip-worktree'd. We would want to call
add_excludes() anyway in the second case.

I think I followed that train of thought when I wrote this and to
avoid trouble, I just left skip-worktree case of out. But that
ce_skip_worktree() check in read_directory() is probably too strong.
All we need is disable the cache only when there's an .gitignore file
being skip-worktree'd. If we do that and make sure all .gitignore
files are not skip-worktree'd, the two can work toghether.

Back to the problem. The question is, is
is_null_sha1(untracked->exclude_sha1) enough to satisfy both cases? If
so, we don't have to disable the cache in the presence of
skip-worktree. I haven't stared at this code again long enough to be
confident, but I think we may be alright. exclude_sha1 should reflect
the true, effective .gitignore content, wherever it's from. So in
skip-worktree case, is_null_sha1(exclude_sha1) should only be true
when the entry does not exist in both worktree and index. There will
be an unnecessary open() in this case before the index version is
used, but that's probably ok.

No I don't think the tests cover skip-worktree + untracked cache
combination, so yeah it would pass.
-- 
Duy
