From: Alex Blewitt <alex.blewitt@gmail.com>
Subject: git rebase failing when using ZFS partition on Mac OS X
Date: Wed, 6 May 2009 22:14:11 +0100
Message-ID: <1FF266A7-CD80-4471-A837-D64007EE530A@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 23:14:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1oRc-0006kq-W6
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 23:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081AbZEFVOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 17:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755910AbZEFVOO
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 17:14:14 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:61978 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357AbZEFVOO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 17:14:14 -0400
Received: by ewy24 with SMTP id 24so583571ewy.37
        for <git@vger.kernel.org>; Wed, 06 May 2009 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date:cc
         :x-mailer;
        bh=OzbEPdJUJm/fk65Pe0RTz0sZ5zZXBXGL5HfkiO6vA04=;
        b=aOZ6dOSb1Eo6XBVI71Bmglz8TCIEX1mk7HaEsR/xoU9o71r0MoVE0G4aFQX3ImHKdp
         bDCABmaGQP5RUrDYNQdwaRtZMNjll6ym+2IDM0JXMNGrlGqf0wP5kqN3+VhTHPINkTya
         cuu3jBbhmGxVqaW/zYVPz3pXG3tgwn+VbPFig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:cc:x-mailer;
        b=ezzyAbQ66oqhtEKGyONIu+h8mpQ1OiU0nc2MKhNto7+WvrHsRM/pqI+sQCFgVS3d6c
         3FHisYdVXecscBwl9J1aF0MTCS/G1GKU2Ni603ipC8nJyBeQxgUlxkx8JsxMSbo6/alw
         ZJV/xoxp2p+dTK6x1rQaPG3pyhDCpxjPblGOI=
Received: by 10.210.134.6 with SMTP id h6mr6567260ebd.47.1241644453289;
        Wed, 06 May 2009 14:14:13 -0700 (PDT)
Received: from apple.int.bandlem.com (server.bandlem.com [217.155.97.60])
        by mx.google.com with ESMTPS id 24sm4789815eyx.43.2009.05.06.14.14.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 14:14:12 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118392>

I've found out why git rebase wasn't working for me. It appears to be  
something to do with the fact that the filesystem is running on ZFS  
(and frankly, could well be a ZFS bug). I'd be loathe to move away  
from ZFS generally but it would be good to find out why it's  
complaining.

apple:egit alex$ git status
# On branch master
# Your branch is ahead of 'origin/master' by 3 commits.
#
nothing to commit (working directory clean)
apple:egit alex$ git rebase -i HEAD~1
Working tree is dirty

Here's what running a stat on TODO (an arbitrary file at the head of  
the project) gives on a ZFS mounted file:

apple:egit alex$ stat -r TODO
754974724 135333 0100644 1 1000 100 0 2179 1241639236 1241034917  
1241639236 1241034917 2560 5 0 TODO
apple:egit alex$ stat TODO
754974724 135333 -rw-r--r-- 1 alex bandlem 0 2179 "May  6 20:47:16  
2009" "Apr 29 20:55:17 2009" "May  6 20:47:16 2009" "Apr 29 20:55:17  
2009" 2560 5 0 TODO

Here's what running a stat on the same file on an HFS partition gives:

apple:egit alex$ stat -r TODO
234881026 930759 0100644 1 1000 0 0 2179 1241643695 1241034917  
1241643690 1241034917 4096 8 0 TODO
apple:egit alex$ stat TODO
234881026 930759 -rw-r--r-- 1 alex wheel 0 2179 "May  6 22:01:35 2009"  
"Apr 29 20:55:17 2009" "May  6 22:01:30 2009" "Apr 29 20:55:17 2009"  
4096 8 0 TODO

These are repeatable; if I re-run this periodically, it doesn't seem  
to change. However, I wonder if there's any dependency on an 'inode'  
or similar, which doesn't really have a comparable concept in ZFS.

Is there any more information that I can provide to assist with  
finding out what's going on?

Alex
