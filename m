From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git stash: status from current dir not top dir?
Date: Sat, 12 Mar 2011 09:57:46 +0100
Message-ID: <4D7B358A.5010101@gmail.com>
References: <4D7A8AC9.1030506@gmail.com> <20110311223232.GA21410@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 12 09:58:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyKeQ-0005su-0U
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 09:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304Ab1CLI57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 03:57:59 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41769 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab1CLI56 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 03:57:58 -0500
Received: by fxm17 with SMTP id 17so1660338fxm.19
        for <git@vger.kernel.org>; Sat, 12 Mar 2011 00:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=K1M29PWdkehzyqcxZzyp1dDuOymnIiibJaYBV3Sk9LI=;
        b=ImjE3PbXl/EWTOay+LKg3wx5sswfmmFoeLEQxPJQgfm4BWWDTi1lXtgQvz/Lv16hT0
         jL0NOR+y72Y3x5rH+8yAJV374yRE/PKNPAHdtXpg0UDB3sy6+WzaQv01ISIP7J8TBc0E
         TIESWrjyIusFmnfB0SXBwswJM/BSbEXQhjF9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=vsusl1yrh+mH0A+MpMPQbG3z+RQKBhpOD3klfim2LQkRWvuhf3RtyT4OLeZbGQJ9/X
         7ORvY/jaDciXiaFf2ewPlL1HwvKxvn4Bwq/EEmfbcd+6Y2bC+IMkppYosPJzPEVj8ya7
         zz+uVZeGkpHCkgaSrnr5E2W96HmRrCgWhWNtM=
Received: by 10.223.143.86 with SMTP id t22mr1171772fau.78.1299920277519;
        Sat, 12 Mar 2011 00:57:57 -0800 (PST)
Received: from [192.168.1.101] (buh202.neoplus.adsl.tpnet.pl [83.29.179.202])
        by mx.google.com with ESMTPS id y11sm2234237fam.39.2011.03.12.00.57.53
        (version=SSLv3 cipher=OTHER);
        Sat, 12 Mar 2011 00:57:56 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <20110311223232.GA21410@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168937>


Thanks for review,
attaching patch with updated commit message.

W dniu 11.03.2011 23:32, Jeff King pisze:
> On Fri, Mar 11, 2011 at 09:49:13PM +0100, Piotr Krukowiecki wrote:
> 
>> But "git stash apply" shows status from root of git repository.
>> This is misleading because you can't copy and paste the paths.
> 
> Yeah, I am inclined to call it a bug. git-status will show the status of
> the whole tree from wherever you are, and people who want full paths
> will have status.relativePaths turned off, anyway. So I think your
> proposed semantics are more natural.

I think it's better this way too, one thing that made me doubt if this is 
intended or not is fact that git-commit also shows paths relative to root
dir...
 
>> This patch tries to fix git-stash.sh to show status relative to 
>> current directory. I can resend the patch with better commit message.
> 
> Yes, please. There is lots of nice discussion in your email but none of
> it in the commit message. :)

Didn't want to duplicate ;)

> 
>> diff --git a/git-stash.sh b/git-stash.sh
>> index 7561b37..586c12f 100755
>> --- a/git-stash.sh
>> +++ b/git-stash.sh
>> @@ -12,6 +12,7 @@ USAGE="list [<options>]
>>  
>>  SUBDIRECTORY_OK=Yes
>>  OPTIONS_SPEC=
>> +START_DIR=`pwd`
>>  . git-sh-setup
>>  require_work_tree
>>  cd_to_toplevel
>> @@ -394,7 +395,7 @@ apply_stash () {
>>  		then
>>  			squelch='>/dev/null 2>&1'
>>  		fi
>> -		eval "git status $squelch" || :
>> +		(cd "$START_DIR" && eval "git status $squelch") || :
>>  	else
>>  		# Merge conflict; keep the exit status from merge-recursive
>>  		status=$?
> 
> This fix looks reasonable to me. The other option would be to avoid
> cd_to_toplevel at the beginning (which I am not sure why we really need
> in the first place, but presumably some code paths rely on it), but it's
> probably not worth the risk of introducing new confusing bugs.
> 
> -Peff
---8<---
From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date: Fri, 11 Mar 2011 20:50:49 +0100
Subject: [PATCH] git stash: show status relative to current directory

git status shows modified paths relative to current directory, so it's
possible to copy&paste them directly, even if you're in a subdirectory.

But "git stash apply" always shows status from root of git repository.
This is misleading because you can't use the paths without modifications.

This is caused by changing directory to root of repository at the
beginning of git stash.

This patch makes git stash show status relative to current directory.
Instead of removing the "cd to toplevel", which would affect whole
script and might have other side-effects, the fix is to change directory
temporarily back to original dir just before displaying status.

Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
---
 git-stash.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 7561b37..b59c201 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -12,6 +12,7 @@ USAGE="list [<options>]
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
+START_DIR=`pwd`
 . git-sh-setup
 require_work_tree
 cd_to_toplevel
@@ -394,7 +395,7 @@ apply_stash () {
 		then
 			squelch='>/dev/null 2>&1'
 		fi
-		eval "git status $squelch" || :
+		(cd "$START_DIR" && eval "git status $squelch") || :
 	else
 		# Merge conflict; keep the exit status from merge-recursive
 		status=$?
-- 
1.7.4.1.228.g9e388
