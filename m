From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman support for git
Date: Sat, 10 May 2014 15:16:49 +0700
Message-ID: <CACsJy8DVVpfYEmE8pSZNyXy1m5WRkdm08deW3EXgAy_0Gn72zw@mail.gmail.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat May 10 10:17:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wj2TJ-0006XG-1e
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 10:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbaEJIRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 04:17:23 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:33754 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbaEJIRU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 04:17:20 -0400
Received: by mail-qa0-f47.google.com with SMTP id s7so5115301qap.34
        for <git@vger.kernel.org>; Sat, 10 May 2014 01:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5lbny0bMp70hMqQHMB7lCGBuHCC+vc16zG6olM7jW4Q=;
        b=K3gfbDuj9eXhy0K10WxnrBId6/vVcTvN2Af2ufJ/XeORyNBhDNq35RaL5Do+vIGEZ7
         eyf1Iz3t1lYXhJ/VxpyI0WGNxbrGySP2Ze7SVnc0tDzXEDDiYp7vcJnxMfxTjCZ//IMg
         PrNe6Un6Y31R3xxhkrV2CbeQLuS2OCScKA60e3NLgDTWlcl1wiQTlhwoNobsvfxztt3q
         tqvVV/Fevibcqb0rLWhKKzE6Wv2KQSAPUM1EtkDUYl7ALRq8DK8aHyrmZY03q2O3PmGN
         UWdL5QkrP/0wuxQDB93DMwMsJsO08tOFdjiKrXYEs91gA9SwnHltOAs5h8kcf1VC/zct
         bGFA==
X-Received: by 10.229.192.7 with SMTP id do7mr21324033qcb.1.1399709839082;
 Sat, 10 May 2014 01:17:19 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Sat, 10 May 2014 01:16:49 -0700 (PDT)
In-Reply-To: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248652>

On Sat, May 3, 2014 at 6:14 AM,  <dturner@twopensource.com> wrote:
> The most sigificant patch uses Facebook's watchman daemon[1] to monitor
> the repository work tree for changes.  This makes allows git status
> to avoid traversing the entire work tree to find changes.

Some comments on this series. I still haven't been able to run it with
watchman so there are many guesses from my side.

First of all, when I set USE_WATCHMAN=Yes in config.mak I expect it to
work out of the box, provided that all dependencies are installed. I
still need to set WATCHMAN_LIBS for it to build because you only set
it with configure script. Would be nice to have a default value for
non-configure people too.

I'm not so happy that git now needs to link to libjansson.so and
libwatchman.so. I would load libwatchman.so at runtime only when
core.usewatchman is on, but this is more of personal taste.

I still prefer my old tracking model, where the majority of lstat() is
done by refresh operation and we only need to optimize those lstat
calls, not every single lstat statement in the code base. With that in
mind, I think you don't need to keep a fs cache on disk at all. All
you need to store (in the index) is the clock value from watchman.
After we parse the index, we perform a "since" query to get path names
(and perhaps "exists" and "mode" for later). Then we set CE_VALID bit
on entries that are _not_ in the query result. The remaining items
will be lstat'd by git (see [1] and read-cache.c changes onthe next
few patches). Assuming the number of updated files is reasonably
small, we won't  be punished by lookup time. To avoid write time cost
due to possible mass CE_VALID change, assuming split-index is already
used, we could store this bit separately as an extension and apply it
back at read time.

Your changes in dir.c. If I didn't misread it, you still do
last_exclude_matching when using fs-cache. That call is where all your
CPU is spent and probably explains why you didn't see big perf gain
with watchman. I think my untracked cache has dealt correctly with
caching in this area. So when you do the watchman query earlier, you
also check if any of the directories are updated and force using
untracked cache for the rest of the directories.

Hope it helps,
Duy

[1] http://thread.gmane.org/gmane.comp.version-control.git/240339
