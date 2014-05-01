From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: split index: sparse warning
Date: Thu, 1 May 2014 07:12:02 +0700
Message-ID: <CACsJy8Ad+hfmJSgKX6O9FTXggUjyMkpJLzf=awnV5oFACsX+vQ@mail.gmail.com>
References: <53618AFA.6070602@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu May 01 02:12:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfecA-0006MZ-PL
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 02:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbaEAAMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 20:12:34 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:64014 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbaEAAMd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 20:12:33 -0400
Received: by mail-qa0-f48.google.com with SMTP id j15so2388869qaq.7
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 17:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BQOGFzwDn7y4YrQKsAEjCynIIhMC7UTqCPVfIv7mz5Q=;
        b=tC4xsRRG9igNHb09merw3oj6HyxGzq/ABz+xr09AleJ4YzIu4kIUDtqJ87AH2zxl3+
         1mBRVslofh9lCx0hV+PcSuHk8ZQDnSrN/u9dqD9PT5U4qoByhQp8z+WDOw5/cH+Jun1x
         R0SuBYgnHHN/MGFTc+Nlvfy5gPMf2UeePLBMpKWgIH7yP1yvm1RTNmhJlB9anEakTlTF
         mOA7G+4XZoelQLvEAIVjndmeXwUkU091P83C+Ryd3B4nOFCa5x68jLMB6Tz/TW+5pG7t
         rXvf2WHoTcS3o1s8t+wV6Iatlxe/ryy9Q34FwzlTq7IU0GBdcf1CrudoNdGIeWa/wSJo
         m20g==
X-Received: by 10.140.47.206 with SMTP id m72mr9113366qga.21.1398903153009;
 Wed, 30 Apr 2014 17:12:33 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Wed, 30 Apr 2014 17:12:02 -0700 (PDT)
In-Reply-To: <53618AFA.6070602@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247803>

On Thu, May 1, 2014 at 6:44 AM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
> Hi Duy,
>
> I haven't looked at your split-index series at all. However, sparse has
> nagged me to take a quick squint at the result of the series as it
> appears in the 'pu' branch.
>
> In particular, sparse complains thus:
>
>       SP sequencer.c
>   sequencer.c:690:49: error: incompatible types for operation (>=)
>   sequencer.c:690:49:    left side has type int ( extern [toplevel] *<noident> )( ... )
>   sequencer.c:690:49:    right side has type int
>
> ... which is fair enough; index_fd is, indeed, a function (pointer) and
> not an int file descriptor! The offending code looks like:
>
> 683 static void read_and_refresh_cache(struct replay_opts *opts)
> 684 {
> 685         static struct lock_file index_lock;
> 686         hold_locked_index(&index_lock, 0);
> 687         if (read_index_preload(&the_index, NULL) < 0)
> 688                 die(_("git %s: failed to read the index"), action_name(opts));
> 689         refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
> 690         if (the_index.cache_changed && index_fd >= 0) {
> 691                 if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
> 692                         die(_("git %s: failed to refresh the index"), action_name(opts));
> 693         }
> 694         rollback_lock_file(&index_lock);
> 695 }
>
>
> It seems that, in an earlier commit (33c297aa), index_fd was declared
> as a local int variable (hiding the global function) which was then
> initialised by a call to hold_locked_index().

Ugh.. after removing index_fd the local variable, index_fd now becomes
the function from sha1_file.c. Noted and will fix it in the next
reroll.
--
Duy
