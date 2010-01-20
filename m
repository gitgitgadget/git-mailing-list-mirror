From: John Koleszar <john.koleszar@on2.com>
Subject: [OT] git fsck uncovers hardware/kernel problem?
Date: Tue, 19 Jan 2010 21:54:46 -0500
Message-ID: <4B567076.8030405@on2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 20 04:10:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXQxP-0007tJ-PH
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 04:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab0ATDKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 22:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865Ab0ATDKA
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 22:10:00 -0500
Received: from mail.on2.com ([66.162.65.131]:48389 "EHLO on2.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753636Ab0ATDJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 22:09:59 -0500
X-Greylist: delayed 888 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2010 22:09:59 EST
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
X-On2-MailScanner-i: Found to be clean
X-On2-MailScanner-From: john.koleszar@on2.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137517>

Hi all,

I don't think that this is a git issue, but I've only reproduced it so 
far using git and I know there are people here that can point me in the 
right direction, so please forgive the off-topic post.

I was repairing a repo today that I thought was corrupt, and when I 
finished, it fsck'd ok but then ran into another corruption error when 
gc'ing it. I realized these errors were intermittent. I ran into this 
situation once before (same machine) and was time-pressed, so I rebooted 
and the problem went away. This time I have a little free time to 
investigate.

It looks like somehow my buffer cache is getting inconsistent with 
what's actually on the disk. I'm looking for input as to whether this is 
a kernel problem, bad memory, dieing hard disk, etc. This machine has 
been stable, and I've had no unexplained crashes or other noticeable 
data corruption. No errors from the kernel, no SMART errors. Only 
notable thing about the repos I was working on when this happened is 
that they were large -- exceeding the size of physical RAM. Lots of 
binary objects. The one I'm looking at now is about 3.8GB packed.

Please see below -- any pointers would be appreciated, including to a 
more appropriate list.

$ git fsck --full
error: inflate: data stream error (incorrect data check)
error: corrupt loose object '060a8f0255a4a0b76197056e959bb0ce37b90dae'
fatal: object 060a8f0255a4a0b76197056e959bb0ce37b90dae is corrupted

$ echo 3 | sudo tee /proc/sys/vm/drop_caches
Password:
3

$ git fsck --fullerror: inflate: data stream error (incorrect data check)
error: corrupt loose object '0905cc800a08a24c8d83132c4d346d8b47403a73'
fatal: object 0905cc800a08a24c8d83132c4d346d8b47403a73 is corrupted
# Note this is a different object

$ git fsck --fullerror: inflate: data stream error (incorrect data check)
error: corrupt loose object '0905cc800a08a24c8d83132c4d346d8b47403a73'
fatal: object 0905cc800a08a24c8d83132c4d346d8b47403a73 is corrupted
# but running again gives a consistent error until dropping caches again

$ echo 3 | sudo tee /proc/sys/vm/drop_caches
3

$ git fsck --full
error: inflate: data stream error (incorrect data check)
error: corrupt loose object '3e9a88bfea886dd4bd4af69870e33f115bc80985'
fatal: object 3e9a88bfea886dd4bd4af69870e33f115bc80985 is corrupted
# fsck progresses much farther this time.

$ sha1sum objects/3e/9a88bfea886dd4bd4af69870e33f115bc80985
acffc0e434297e5115b2491101d0a0260a20a1aa  
objects/3e/9a88bfea886dd4bd4af69870e33f115bc80985

$ echo 3 | sudo tee /proc/sys/vm/drop_caches
3

$ sha1sum objects/3e/9a88bfea886dd4bd4af69870e33f115bc80985
83a1291ecb9e2fd9ded509aefba2a3c474d259c2  
objects/3e/9a88bfea886dd4bd4af69870e33f115bc80985
# sha1sum is different, so this issue isn't limited to git

$ git cat-file blob 3e9a88bfea886dd4bd4af69870e33f115bc80985>/dev/null
# git's integrity checks pass on this file now.

$ uname -a
Linux cp-jk-linux 2.6.30-gentoo-r5 #3 SMP Wed Nov 4 12:53:38 EST 2009 
x86_64 Intel(R) Core(TM)2 CPU 6600 @ 2.40GHz GenuineIntel GNU/Linux

---
Thanks,
John
