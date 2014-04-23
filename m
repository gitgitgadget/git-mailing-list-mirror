From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] Speed up "git status" by caching untracked file info
Date: Wed, 23 Apr 2014 07:52:46 +0700
Message-ID: <CACsJy8B1_L+hOSZ86W0h+3xyh=fvgcaMqxrSndMB-BY3Ks2Xug@mail.gmail.com>
References: <1397713918-22829-1-git-send-email-pclouds@gmail.com>
 <53563CB2.5030603@gmail.com> <CACsJy8AYyhZKBmL=z2H11Oemjw_YoUES0vYtB8s0HnMB+4uyVw@mail.gmail.com>
 <CACsJy8AFDquHEajJQa_LWhtAMO-vHQbMCFuPV6UkGNZXTbANZw@mail.gmail.com> <5356BB5B.90903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 02:53:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WclRB-0000V8-Ua
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 02:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbaDWAxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 20:53:18 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:58665 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbaDWAxR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2014 20:53:17 -0400
Received: by mail-qc0-f181.google.com with SMTP id x3so257198qcv.26
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 17:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ScQ8NrbnkuyMrlXXTj7XyUj/6B/X+qps+l0H9OXJsb4=;
        b=kbMxmiuZupVWMzhVw13qcHnX43ZftBI0d8/GqfF+zN47gDeg8Ys/REluSlUW1yeeEy
         aTXVx/iVPq3jG8sKXTAjCCIiqee62CiAlieGzTCy8zclgph4rc+k+mS/oB6kp6EEQDj6
         eiqpxaDs3dRzM2Y9ACbOCuG/JX8BLVb2NPlGxnxmdn3tL6I9YyJ3U/5WK8Nmb90Sj7C+
         tvinrH7RfgtrvcQXoymSvTNbpmJjlBlQLsd0IvyluSzkngUf/OmANZ4y/6m3R36kQrU9
         IlOVrICJ6IuumzlmK0mD6izJSPq9r142DR4HZjiLdvjYkKRBzdsXwByX0waMyUdiv0m6
         09iQ==
X-Received: by 10.224.136.74 with SMTP id q10mr47441704qat.78.1398214396229;
 Tue, 22 Apr 2014 17:53:16 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Tue, 22 Apr 2014 17:52:46 -0700 (PDT)
In-Reply-To: <5356BB5B.90903@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246808>

On Wed, Apr 23, 2014 at 1:56 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Am 22.04.2014 12:35, schrieb Duy Nguyen:
>> On Tue, Apr 22, 2014 at 5:13 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>> IIRC name_hash.c::lazy_init_name_hash took ~100ms on my system, so hopefully you did a dummy 'cache_name_exists("anything")' before starting the measurement of the first run?
>>>
>>> No I didn't. Thanks for pointing it out. I'll see if I can reduce its time.
>>
>> Well name-hash is only used when core.ignorecase is set. So it's
>> optional.
>
> This is only true for the case-insensitive directory hash. The file hash ('cache_file_exists') is always used to skip expensive excluded checks for tracked files.
>
> 'cache_file_exists' basically treats faster lookups for higher setup costs, which makes perfect sense when scanning the entire work tree. However, if most of the directory info is cached and just a few directories need refresh (and core.ignorecase=false), binary search ('cache_name_pos') may be better. The difficulty is to decide when to choose one over the other :-)

Right. The problem is even if untracked cache is used, we don't know
in advance how cache_file_exists calls we need to make. If .gitignore
changes, we could see how many directories are invalidated recursively
and that could be an indicator for favoring cache_file_exists over
cache_name_pos. It's harder when dir mtime changes, I suppose we could
be optimistic and stick to cache_name_pos until the number of calls
gets over a limit and turn to cache_file_exists. May backfire though..

>
>> Maybe we could save it in a separate index extension, but we
>> need to verify that the reader uses the same hash function as the
>> writer.
>>
>>>> Similarly, the '--directory' option controls early returns from the directory scan (via read_directory_recursive's check_only argument), so you won't be able to get a full untracked files listing if the cache was recorded with '--directory'. Additionally, '--directory' aggregates the state at the topmost untracked directory, so that directory's cached state depends on all sub-directories as well...
>>>
>>> I missed this. We could ignore check_only if caching is enabled, but
>>> that does not sound really good. Let me think about it more..
>>
>> We could save "check_only" to the cache as well. This way we don't
>> have to disable the check_only trick completely.
>>
>> So we process a directory with check_only set, find one untracked
>> entry and stop short. We store check_only value and the status ("found
>> something") in addition to dir mtime. Next time we check the dir's
>> mtime. If it matches and is called with check_only set, we know there
>> is at least one untracked entry, that's enough to stop r_d_r and
>> return early. If dir mtime does not match, or r_d_r is called without
>> check_only, we ignore the cached data and fall back to opendir.
>>
>> Sounds good?
>>
>
> What about untracked files in sub-directories? E.g. you have untracked dirs a/b with untracked file a/b/c, so normal 'git status' would list 'a/' as untracked.
> Now, 'rm a/b/c' would update mtime of b, but not of a, so you'd still list 'a/' as untracked. Same thing for 'echo "c" >a/b/.gitignore'.
>
> Your solution could work if you additionally cache the directories that had to be scanned to find that first untracked file (but you probably had that in mind anyway).

Basically all directories that are touched by r_d_r() will be cached.

> If the cache is only used for certain dir_struct.flags combinations, you can probably get around saving the check_only flag (which can only ever be true if both DIR_SHOW_OTHER_DIRECTORIES and DIR_HIDE_EMPTY_DIRECTORIES are set (which is the default for 'git status')).
-- 
Duy
