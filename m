From: Anders Darander <anders.darander@gmail.com>
Subject: Re: git stash takes excessively long when many untracked files present
Date: Tue, 13 Aug 2013 19:36:59 +0200
Message-ID: <1fc732a7-6b63-4d75-960f-0b1c6cf9c70e@email.android.com>
References: <20130810214453.GA5719@jtriplet-mobl1> <loom.20130813T120243-481@post.gmane.org> <7v7gfpy0wy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 19:37:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9IWy-0006Lc-6N
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 19:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759068Ab3HMRhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 13:37:08 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:49449 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759005Ab3HMRhH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 13:37:07 -0400
Received: by mail-la0-f51.google.com with SMTP id fp13so6083221lab.10
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=Val9WzMTBzwONzVCyQFPPgEVv63K0utD0GVc83sqM3c=;
        b=hPN8oJPknOLfA/hZ8XXYr0JOEmAjoeY70V7gXtwE+MenNLH2ZBj2zM2KRzkAP/ASzq
         yNJzFW7cCNahdVMNJEpuYQuOr3N4bTevBKB6sos7ZpAxreUibZks7ZUbgzlbbcpcgAyQ
         bb/VVbBjRD/SkYRAy808K/rnzZyfA760H239zhxh1SGYnvVknzZyjlPeydOXNOmng4xL
         gPcLJs8xUKm/4JiNbrxdS0S8Z+ICTqLKBlghmEJ62KNlHxZuAu94P3Dvj9PpER1Yltvv
         UkskjTNAdBk+cCjDrxIHukjJWxVJD/CQWBHZl1E5RdqcozYNC079pdt4GTvZZyAt7ho+
         CPUQ==
X-Received: by 10.152.30.74 with SMTP id q10mr4766539lah.27.1376415425635;
        Tue, 13 Aug 2013 10:37:05 -0700 (PDT)
Received: from [192.168.0.19] (c83-252-253-85.bredband.comhem.se. [83.252.253.85])
        by mx.google.com with ESMTPSA id i9sm14333671lba.0.2013.08.13.10.37.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 Aug 2013 10:37:04 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <7v7gfpy0wy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232238>



(I'm resending this as Gmail added some html parts...) 

Junio C Hamano <gitster@pobox.com> wrote:
>Anders Darander <anders.darander@gmail.com> writes:
>
>> diff --git a/git-stash.sh b/git-stash.sh
>> index 85c9e2c..e5a2043 100755
>> --- a/git-stash.sh
>> +++ b/git-stash.sh
>> @@ -263,7 +263,7 @@ save_stash () {
>>                 exit 0
>>         fi
>>         if test -z "$untracked$force" &&
>> -          test -n "$(git ls-files --killed | head -n 1)"
>> +          test -n "$(git ls-files --killed --directory | head -n 1)"
>>         then
>>                 say "$(gettext "The following untracked files would
>NOT be 
>> saved
>>                 test -n "$GIT_QUIET" || git ls-files --killed | sed 
>> 's/^/\t/'
>> -------------------------------------------
>>
>> It seems to work in my extremely limited testing. Though, I'm pretty
>sure 
>> that there'll be quite a few error cases... (Especially, as I just
>made
>> a naive attempt at patching git-stash, so I could go on with a few
>other 
>> things).
>
>I am not sure adding "--directory" there is safe.  Aren't there
>cases where saving a stash and going back to the committed state
>will involve killing no directories, but some files?  If your local
>change is to remove a directory and files in it from your working
>tree and then deposit a newly created file at the path where the
>directory was in the HEAD, stashing that local change and then going
>back to the HEAD will involve removing the new file from the working
>tree, and unless you have "git add"ed the new file, it will be lost.

Yes, it's more than likely that there are some real issues with adding - -directory here. I just realised that in the specific case I needed to run stash, I could do that by adding either of -u or -f as options. Obviously, 

>> Do anyone have any better idea on how to approach this?
>
>Teaching "ls-files" to leave early once it seens even a single
>output is probably a possibility.

Would that mean that we're able to fail early? That's certainly an improvement, but not a working situation.

In my case, running stash in an OpenEmbedded checkout (including untracked directories for builds and caches), I gave up waiting on stash running ls-files after running at 100% for more than 12 minutes. Git status returned after a couple of seconds.

>>> I see a lot of room for optimization here.  Most importantly, git
>>> ls-files --killed really doesn't need to look at any directory entry
>>> unless something in the index would conflict with it.
>
>This observation probably is correct, even though I didn't think
>about it long enough.

I'd think that something like this is needed. As the index should be rather small, compared to e.g. some large untracked directory.

Cheers, 
Anders 


.
