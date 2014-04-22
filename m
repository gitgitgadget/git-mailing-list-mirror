From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC] Speed up "git status" by caching untracked file info
Date: Tue, 22 Apr 2014 20:56:27 +0200
Message-ID: <5356BB5B.90903@gmail.com>
References: <1397713918-22829-1-git-send-email-pclouds@gmail.com> <53563CB2.5030603@gmail.com> <CACsJy8AYyhZKBmL=z2H11Oemjw_YoUES0vYtB8s0HnMB+4uyVw@mail.gmail.com> <CACsJy8AFDquHEajJQa_LWhtAMO-vHQbMCFuPV6UkGNZXTbANZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 20:56:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcfrv-00022H-VN
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 20:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbaDVS4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 14:56:31 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:43603 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbaDVS43 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 14:56:29 -0400
Received: by mail-ee0-f43.google.com with SMTP id e53so30690eek.16
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=K8vKmJ9mdDILtDgOVZ3GiroXprwrlx1utgnX/4FMzXc=;
        b=fj8F2YYbq9hDsArSJVbL7xV7YIlzZ0swiIwHsKXmqfMFmA4Mh8/Ca0/Sn/bj6rxcRI
         ekXHco9i0gNyblwlyKBYQurGaqN15c8Umvl9d1FDr5FkZ5AZkUnyzNjoRTb+ul2oXE9w
         FXAGE+LYH9u5s3ppyRohgk4B9+mHFNHqGLeZCtnRht0n9zbHQRwD2XBJV+rZM6dzagW/
         mAE/EXHVPF9tRMGdXllEpmI6L5R6+YcH7L+JKUQrcVaILFy37QxhT4KBqTfRul1boOoz
         769269xZ/oKXxxVw8uqu+ASoYdgBo9iejWPJhfV4x+RyueaIix9cgxk2mneJHVp7wH7m
         St6g==
X-Received: by 10.14.115.195 with SMTP id e43mr12692954eeh.76.1398192988082;
        Tue, 22 Apr 2014 11:56:28 -0700 (PDT)
Received: from [10.1.116.60] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id z48sm115442069eel.27.2014.04.22.11.56.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Apr 2014 11:56:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <CACsJy8AFDquHEajJQa_LWhtAMO-vHQbMCFuPV6UkGNZXTbANZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246769>

Am 22.04.2014 12:35, schrieb Duy Nguyen:
> On Tue, Apr 22, 2014 at 5:13 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> IIRC name_hash.c::lazy_init_name_hash took ~100ms on my system, so hopefully you did a dummy 'cache_name_exists("anything")' before starting the measurement of the first run?
>>
>> No I didn't. Thanks for pointing it out. I'll see if I can reduce its time.
> 
> Well name-hash is only used when core.ignorecase is set. So it's
> optional.

This is only true for the case-insensitive directory hash. The file hash ('cache_file_exists') is always used to skip expensive excluded checks for tracked files. 

'cache_file_exists' basically treats faster lookups for higher setup costs, which makes perfect sense when scanning the entire work tree. However, if most of the directory info is cached and just a few directories need refresh (and core.ignorecase=false), binary search ('cache_name_pos') may be better. The difficulty is to decide when to choose one over the other :-)

> Maybe we could save it in a separate index extension, but we
> need to verify that the reader uses the same hash function as the
> writer.
> 
>>> Similarly, the '--directory' option controls early returns from the directory scan (via read_directory_recursive's check_only argument), so you won't be able to get a full untracked files listing if the cache was recorded with '--directory'. Additionally, '--directory' aggregates the state at the topmost untracked directory, so that directory's cached state depends on all sub-directories as well...
>>
>> I missed this. We could ignore check_only if caching is enabled, but
>> that does not sound really good. Let me think about it more..
> 
> We could save "check_only" to the cache as well. This way we don't
> have to disable the check_only trick completely.
> 
> So we process a directory with check_only set, find one untracked
> entry and stop short. We store check_only value and the status ("found
> something") in addition to dir mtime. Next time we check the dir's
> mtime. If it matches and is called with check_only set, we know there
> is at least one untracked entry, that's enough to stop r_d_r and
> return early. If dir mtime does not match, or r_d_r is called without
> check_only, we ignore the cached data and fall back to opendir.
> 
> Sounds good?
> 

What about untracked files in sub-directories? E.g. you have untracked dirs a/b with untracked file a/b/c, so normal 'git status' would list 'a/' as untracked.
Now, 'rm a/b/c' would update mtime of b, but not of a, so you'd still list 'a/' as untracked. Same thing for 'echo "c" >a/b/.gitignore'.

Your solution could work if you additionally cache the directories that had to be scanned to find that first untracked file (but you probably had that in mind anyway).

If the cache is only used for certain dir_struct.flags combinations, you can probably get around saving the check_only flag (which can only ever be true if both DIR_SHOW_OTHER_DIRECTORIES and DIR_HIDE_EMPTY_DIRECTORIES are set (which is the default for 'git status')).
