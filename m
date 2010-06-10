From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Misterious warning about file system boundaries [It's a bug,
 not a mystery.]
Date: Thu, 10 Jun 2010 11:05:08 +0200
Message-ID: <4C10AAC4.90405@drmicha.warpmail.net>
References: <4C0FF7B9.8040007@drmicha.warpmail.net> <4C109C4F.1030809@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jun 10 11:05:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMdhr-0001HB-2V
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 11:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758674Ab0FJJFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 05:05:42 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:41787 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752931Ab0FJJFl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 05:05:41 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C9184F82CD;
	Thu, 10 Jun 2010 05:05:40 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 10 Jun 2010 05:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=G5AFaL35mXx8gtqdluKw000ojzk=; b=C8VVRRcHPml2imRdtPHF56OFar1pNsBAld0ebOyBjkC+t9bj9GDSHxxd19IJniLW7hCZsemjGguZ5S/0bTp6D0y6TVOqiUEfE8HwL658DYawDu10UtszT/WYUKR7nbQ9An2KXfBQYJTHVXOL6eMr5JLT88MEliRiCp66ciGEU5I=
X-Sasl-enc: 853alE626GhIgXjMbtBq9mnTWYSPtr1shcoAoMOHWJT4 1276160740
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 20E9744E2D;
	Thu, 10 Jun 2010 05:05:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100610 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <4C109C4F.1030809@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148844>

Andreas Ericsson venit, vidit, dixit 10.06.2010 10:03:
> On 06/09/2010 10:21 PM, Michael J Gruber wrote:
>> Heya,
>>
>> now what is going on here? After upgrading to current next I get
>>
>> warning: working tree spans across filesystems but
>> GIT_DISCOVERY_ACROSS_FILESYSTEM is not set.
>>
>> in several repos, such as my local git.git repo. That is certainly on a
>> single file system only (ext4 over lvm over luks, all on one partition,
>> Fedora 13). I also get this for another repo, but not for every repo. It
>> goes away when I set the var and comes back when I don't set it, of course.
>>
>> Although I haven't bisected this should be due to
>> 52b98a7 (write-index: check and warn when worktree crosses a filesystem
>> boundary, 2010-04-04).
>>
>> How does the code detect a file system boundary, and where could it go
>> wrong?
>>
> 
> According to the patch, it checks if the device id recorded from stat(2)
> is the same for all files and, if not, warns about it.
> 
> It seems that your interpretation of "one partition" differs from that
> reported by the kernel. Why that is so, I have no idea.
> 

I'm sorry, but "my interpretation"? WTF? This is all on
/home/mjg/src/git which has no bind mounts whatsoever.

I actually mixed up my / and /home situation above, /home is even
simpler: single ext3 over luks dm device over single "real" partition.
All of this (except for single ext3 part.) should not matter, of course.

I bisected it just be sure, and it boils down to 9780e62 which is the
commit merging 52b98a7 to next.

git ls-files|xargs stat -c "%d %D" |sort|uniq

gives

64772 fd04

which is, in particular, 1 device only. Now, here comes funny. After
changing write_index() to print the two ce_dev's which differ, i.e.
printf("%d %d\n", ce->ce_dev, cache[first_valid_ent]->ce_dev);
 I have:

./git-status -s|sort|uniq -c
warning: working tree spans across filesystems but
GIT_DISCOVERY_ACROSS_FILESYSTEM is not set.
    150 64770 64772
    662 64771 64772
      1  M read-cache.c

WTF???

git reset --hard doesn't help this.

rm .git/index && git reset does help.

So, it seems that nowadays not even "reset --hard" refreshes the index
completely. After a reboot your device IDs may change, of course, and
files on the same file system will have different ce_dev values in the
index depending on when their index entry was refreshed last.

I really don't know how to fix this (other than by refreshing stat info
in write_index() before warning). Debugging it was quite an exercise
already.

Also, having git reset --index do the equivalent of "rm .git/index &&
git reset" might be good to have.

I'm keeping the bad index, btw, so that I can test a possible future fix.

Michael
