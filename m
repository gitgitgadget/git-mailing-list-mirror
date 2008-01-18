From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 21:30:06 -0500
Message-ID: <20080118023005.GS24004@spearce.org>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org> <7vodblpmyc.fsf@gitster.siamese.dyndns.org> <20080117091558.GA8341@hashpling.org> <478F3367.8050307@viscovery.net> <20080117110132.GB12285@hashpling.org> <478F4CDC.2090703@viscovery.net> <7vbq7jkixg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Charles Bailey <charles@hashpling.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 03:31:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFh0R-0000HW-Ni
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 03:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520AbYARCa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 21:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758718AbYARCaZ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 21:30:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37535 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758527AbYARCaW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 21:30:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JFgzU-0003KQ-F0; Thu, 17 Jan 2008 21:29:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3CBB920FBCC; Thu, 17 Jan 2008 21:30:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vbq7jkixg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70952>

Junio C Hamano <gitster@pobox.com> wrote:
> I ran strace and found that fast-import retains three windows to
> the same data that was opened while the pack was still being
> built (i.e. the filename is still tmp_pack_XXXXXX) when it dies:
> 
>     {next = 0x6f6d20, base = 0x6f77a0 "PACK", offset = 0, len = 907,
>      last_used = 9, inuse_cnt = 0}
>     {next = 0x728630, base = 0x6f7160 "PACK", offset = 0, len = 500, 
>       last_used = 5, inuse_cnt = 0}
>     {next = 0x0, base = 0x6f6d50 "PACK", offset = 0, len = 261, 
>       last_used = 1, inuse_cnt = 0}

Ouch.  Hmm, well, maybe it shouldn't keep three windows open to
the same part of the file, but with different lengths.  :)

But that's another issue.
 
> The following patch seems to fix the issue for me, but this is
> primarily meant for discussion,

I agree the patch should fix this particular issue and the
performance difference it will cause is minor enough to not be
worth discussing further.  But I have one minor comment (please
see it below).

> as I do not quite understand why
> the same issue does not manifest itself when NO_MMAP is not
> used.

When NO_MMAP is off (we are actually using the OS's true mmap)
the data is updated into the window when the file is written,
as the window is backed by the OS's filesystem cache.

If the data access is outside of the window (past the offset of
the longest window, here 907) we would just open a new window to
the relevant region of the file.  But when it is inside the window,
the window being backed by the filesystem cache saved us.  In the
case of NO_MMAP this doesn't work, so we get a failure later during
object access.

In particular if you look at gfi_unpack_entry() (which is where
we cause windows to be opened on the file being created) we tell
sha1_file.c it has 20 bytes available in the window *beyond* the
actual end of the file.  This is due to an assumption within the
windowing code of sha1_file.c that we always have the packfile
footer at the end of the file, so all windowing code assumes it
has at least 20 bytes from the start of a window that it can access
without needing to perform additional bounds checking.

So what's happening here is we are adding objects into the file,
some of which may have their data appearing in the trailing 20 bytes
of some prior window.  If that happens the cached window looks like
it can be used to access the data, but it really cannot be in the
NO_MMAP case as those trailing 20 bytes of the window are all \0's.

The astute reader may wonder how gfi_unpack_entry() works when
NO_MMAP is being used.  It doesn't for that last 20 bytes of
any window.  Which has me thinking that Junio's patch alone isn't
enough to make fast-import work correctly under NO_MMAP.

> diff --git a/fast-import.c b/fast-import.c
> index 3609c24..bd0ddb1 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -926,7 +926,13 @@ static void end_packfile(void)
>  		new_p = add_packed_git(idx_name, strlen(idx_name), 1);
>  		if (!new_p)
>  			die("core git rejected index %s", idx_name);
> -		new_p->windows = old_p->windows;
> +		while (old_p->windows) {
> +			struct pack_window *w = old_p->windows;
> +			munmap(w->base, w->len);
> +			old_p->windows = w->next;
> +			free(w);
> +		}
> +		new_p->windows = NULL;

This assignment of NULL should not be necessary.  add_packed_git()
already does this for us on new_p so we do not need to repeat it
here in fast-import.

>  		all_packs[pack_id] = new_p;
>  		install_packed_git(new_p);
>  

-- 
Shawn.
