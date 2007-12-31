From: Yannick Gingras <ygingras@ygingras.net>
Subject: Re: On the many files problem
Date: Mon, 31 Dec 2007 05:13:45 -0500
Message-ID: <873atjtbmu.fsf@enceladus.ygingras.net>
References: <87y7bdweca.fsf@enceladus.ygingras.net>
	<alpine.LFD.0.9999.0712291055470.2778@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Dec 31 11:14:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9HfA-0006pa-Ht
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 11:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbXLaKN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 05:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753631AbXLaKN6
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 05:13:58 -0500
Received: from mail.cooptel.qc.ca ([216.144.115.12]:45166 "EHLO
	amy.cooptel.qc.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751429AbXLaKN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 05:13:56 -0500
Received: (qmail 17346 invoked by uid 360); 31 Dec 2007 10:13:55 -0000
Received: from 216.144.118.66 by amy (envelope-from <ygingras@ygingras.net>, uid 301) with qmail-scanner-2.01 
 (clamdscan: 0.91.1/3957.  
 Clear:RC:1(216.144.118.66):. 
 Processed in 0.01907 secs); 31 Dec 2007 10:13:55 -0000
Received: from unknown (HELO verdandi.ygingras.net) (216.144.118.66)
  by smtp.cooptel.qc.ca with ESMTP; 31 Dec 2007 10:13:55 -0000
Received: from [192.168.0.15] (helo=enceladus.ygingras.net)
	by verdandi.ygingras.net with esmtp (Exim 4.50)
	id 1J9HeU-0007GJ-2h; Mon, 31 Dec 2007 05:13:54 -0500
Received: from enceladus (localhost [127.0.0.1])
	by enceladus.ygingras.net (Postfix) with ESMTP id A6A7318503;
	Mon, 31 Dec 2007 05:13:45 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0712291055470.2778@woody.linux-foundation.org> (Linus Torvalds's message of "Sat\, 29 Dec 2007 11\:12\:38 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: 192.168.0.15
X-SA-Exim-Rcpt-To: torvalds@linux-foundation.org, git@vger.kernel.org
X-SA-Exim-Mail-From: ygingras@ygingras.net
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on 
	verdandi.ygingras.net
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.5 tests=AWL autolearn=disabled 
	version=3.1.7
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on verdandi.ygingras.net)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69396>


Thanks to you and to Junio for your replies, 

Linus Torvalds <torvalds@linux-foundation.org> writes:
> No, no. The fastest way to store a bunch of files is to basically:
>
>  - make the filenames as small as possible
>
>    This improves density, and thus performance. You'll get more files to 
>    fit in a smaller directory, and filename compares etc will be faster 
>    too.
>
>    If you don't need hashes, but can do with smaller names (for example, 
>    your names are really just sequential, and you can use some base-64 
>    encoding to make them smaller than numbers), you'll always be better 
>    off.

This is really interesting and I would not have suspected it.  But it
begs the question: why does Git use the base-16 hash instead of the
base-64 hash?  

After your replies I took a serious look at Git's storage and there is
indeed not that many loose objects in a typical repo: most is kept
into packs.  So I guess Git doesn't need that much density and keeping
the filename in the format that is used in the UI probably helps power
users.

>  - store them in a good final order. This is debatable, but depending on 
>    your load and the filesystem, it can be better to make sure that you 
>    create all files in order, because performance can plummet if you start 
>    removing files later.
>
>    I suspect your benchmark *only* tested this case, 

That is true.

>    but if you want to check odder cases, try creating a huge
>    directory, and then deleting most files, and then adding a few
>    new ones. Some filesystems will take a huge hit because they'll
>    still scan the whole directory, even though it's mostly empty!
>
>    (Also, a "readdir() + stat()" loop will often get *much* worse access 
>    patterns if you've mixed deletions and creations)

This is something that will be interesting to benchmark later on.  So,
an application with a lot of turnaround, say a mail server, should
delete and re-create the directories from time to time?  I assume this
is specific to some file system types.

>  - it's generally *much* more efficient to have one large file that you 
>    read and seek in than having many small ones, so if you can change your 
>    load so that you don't have tons of files at all, you'll probably be 
>    better off. 

That makes a lot of sense.  

Thanks again for those clarifications.

-- 
Yannick Gingras
