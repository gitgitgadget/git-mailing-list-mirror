From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman support for git
Date: Sun, 11 May 2014 07:21:11 +0700
Message-ID: <CACsJy8Cazm+6ixw3r8WYfdFYeD01Lmf0PSF0sdsh7PGy_6WDTQ@mail.gmail.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
 <CACsJy8B6AVOHH7HhreqvusQN=UFZzj1mkjqekrOb62Lmq_8VQw@mail.gmail.com> <1399747109.11843.137.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun May 11 02:21:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjHWU-0003sA-Jz
	for gcvg-git-2@plane.gmane.org; Sun, 11 May 2014 02:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757668AbaEKAVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 20:21:42 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:52233 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563AbaEKAVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 20:21:42 -0400
Received: by mail-qg0-f44.google.com with SMTP id i50so6227872qgf.3
        for <git@vger.kernel.org>; Sat, 10 May 2014 17:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ypJiP8iwX8ObaaoOiaR874GE8tBZYZw9+nSikIZAbgQ=;
        b=eYlsuayAu145tYOBaRPgPh6S18EnT/P3NYl8k3z14fqrh0AP8YNas7dzV/YiJlLKti
         kCcD534g4fBguAZszPYfmIkhfE24LlOOEvH/lswMVeewmzDnqyPjLOb/HVIw0U+IQFCn
         IqV1tdReca/NjbOKC7Z3EsjbUloCx4/W/c1/powWX+Qg7UmPAB3gNpcrKjqvU7sLYXlt
         q8PuXAGq7NG92Pe3kM95iSh2kjD1zQI5hV9DSYxciM29auwGGBBhMNwY+87O0NTHBq5o
         C50Bg0QHBEke3Lx/x0Q3+zq8POV7QYucpa88e3coLR1gfjX0zRghXqTTx+zEFCUK85Jt
         AcXQ==
X-Received: by 10.224.121.72 with SMTP id g8mr4570967qar.79.1399767701372;
 Sat, 10 May 2014 17:21:41 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Sat, 10 May 2014 17:21:11 -0700 (PDT)
In-Reply-To: <1399747109.11843.137.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248667>

On Sun, May 11, 2014 at 1:38 AM, David Turner <dturner@twopensource.com> wrote:
>> I got "warning: Watchman watch error: Got bad JSON from watchman
>> get-sockname: '[' or '{' expected near end of file". Any ideas what I
>> did wrong? I'm using watchman.git and libwatchman.git. check-0.9.11
>> and jansson-2.4 were installed by system (gentoo).
>
> What do you get from watchman get-sockname on the command-line?  Do the
> watchman tests pass?

Found the problem. "watchman" binary is not in $PATH but popen() did
not complain (or it did but your "2>/dev/null" in watchman_connect
suppressed it). BTW you need to update the array size of "expressions"
in test_watchman_misc().

So without watchman I got

   299.871ms read_index_from:1538 if (verify_hdr(hdr, mmap_size) < 0) go
   498.205ms cmd_status:1300 refresh_index(&the_index, REFRESH_QUIE
   796.050ms wt_status_collect:622 wt_status_collect_untracked(s)

and with watchman ("git status" ran several times to make sure it's cached)

   301.950ms read_index_from:1538 if (verify_hdr(hdr, mmap_size) < 0) go
    34.918ms  read_fs_cache:347 if (verify_hdr(hdr, mmap_size) < 0) go
  1564.096ms  watchman_load_fs_cache:628 update_fs_cache(istate, result);
   161.930ms cmd_status:1300 refresh_index(&the_index, REFRESH_QUIE
   251.614ms wt_status_collect:622 wt_status_collect_untracked(s)

Given the total time of "git status" without watchman is 1.9s,,
update_fs_cache() nearly matches that number alone. All that is spent
in the exclude update code in the function, but if you do
last_excluding_matching() anyway, why cache it?

I think we're paying lookup cost in refresh_index(). I forced CE_VALID
bit on as an experiment and refresh_index() went down to 33ms.

A bit surprised about wt_status_collect_untracked number. I verified
that last_excluding_matching() still runs (on the same number of
entries like in no-watchman case). Replacing fs_cache_open() in
add_excludes_from_file_to_list() to plain open() does not change the
number, so we probably won't need that (unless your worktree is filled
with .gitignore, which I doubt it's a norm). So about 500ms saved is
in opendir/readdir.. A simple/separate opendir/readdir/closedir
program confirms that (ugh!).
-- 
Duy
