From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] Speed up "git status" by caching untracked file info
Date: Tue, 22 Apr 2014 17:35:13 +0700
Message-ID: <CACsJy8AFDquHEajJQa_LWhtAMO-vHQbMCFuPV6UkGNZXTbANZw@mail.gmail.com>
References: <1397713918-22829-1-git-send-email-pclouds@gmail.com>
 <53563CB2.5030603@gmail.com> <CACsJy8AYyhZKBmL=z2H11Oemjw_YoUES0vYtB8s0HnMB+4uyVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 12:35:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcY3N-0004I8-2T
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 12:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbaDVKfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 06:35:48 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:49320 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121AbaDVKfo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2014 06:35:44 -0400
Received: by mail-qa0-f44.google.com with SMTP id hw13so4881990qab.3
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 03:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=McuH+zpzuYTXgRiVpPIrr372iOwtyXruhM/YlxofmvQ=;
        b=mkTsStQrnnh9D6YpINPOsfd+VkFQDPm6gsZDnmJeMBmRdm0uMC73lF5MpCNud6Pl1U
         Pcx21zHulUCfNUuFruVrv54uIMLwDbMAd0PeIqZ30HF13QE+c4/na/k91/gYQKvfQuy2
         q16j5Ve87q1/2TNmr3SvRS7JvgBQ7qMIzygzcKHLD2gc7qEkHILG4WpjtHh0ZzEIK02z
         rXMHrPuEmBoXmy/6tgjXntBoKoHaYWV7MG8aLs58R3qhh1ptYPQ0MmzhVZ57tdJ9ccT7
         94ipxWysymm38QiPP6rZ5lqs0WqGg+GSQywe4/OJCg3Z5o6bTx6TB6rolDEhCfAv1wPK
         kjeA==
X-Received: by 10.224.87.132 with SMTP id w4mr11081186qal.89.1398162943442;
 Tue, 22 Apr 2014 03:35:43 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Tue, 22 Apr 2014 03:35:13 -0700 (PDT)
In-Reply-To: <CACsJy8AYyhZKBmL=z2H11Oemjw_YoUES0vYtB8s0HnMB+4uyVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246728>

On Tue, Apr 22, 2014 at 5:13 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> IIRC name_hash.c::lazy_init_name_hash took ~100ms on my system, so hopefully you did a dummy 'cache_name_exists("anything")' before starting the measurement of the first run?
>
> No I didn't. Thanks for pointing it out. I'll see if I can reduce its time.

Well name-hash is only used when core.ignorecase is set. So it's
optional. Maybe we could save it in a separate index extension, but we
need to verify that the reader uses the same hash function as the
writer.

>> Similarly, the '--directory' option controls early returns from the directory scan (via read_directory_recursive's check_only argument), so you won't be able to get a full untracked files listing if the cache was recorded with '--directory'. Additionally, '--directory' aggregates the state at the topmost untracked directory, so that directory's cached state depends on all sub-directories as well...
>
> I missed this. We could ignore check_only if caching is enabled, but
> that does not sound really good. Let me think about it more..

We could save "check_only" to the cache as well. This way we don't
have to disable the check_only trick completely.

So we process a directory with check_only set, find one untracked
entry and stop short. We store check_only value and the status ("found
something") in addition to dir mtime. Next time we check the dir's
mtime. If it matches and is called with check_only set, we know there
is at least one untracked entry, that's enough to stop r_d_r and
return early. If dir mtime does not match, or r_d_r is called without
check_only, we ignore the cached data and fall back to opendir.

Sounds good?
-- 
Duy
