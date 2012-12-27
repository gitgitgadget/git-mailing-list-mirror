From: Martin Fick <mfick@codeaurora.org>
Subject: Lockless Refs?  (Was [PATCH] refs: do not use cached refs in repack_without_ref)
Date: Thu, 27 Dec 2012 16:11:51 -0700
Organization: CAF
Message-ID: <201212271611.52203.mfick@codeaurora.org>
References: <20121221080449.GA21741@sigill.intra.peff.net> <50DAB447.8000101@alum.mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 28 00:12:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToMcs-0002Tg-A5
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 00:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab2L0XMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 18:12:16 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:12298 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab2L0XMO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 18:12:14 -0500
X-IronPort-AV: E=Sophos;i="4.84,365,1355126400"; 
   d="scan'208";a="16778112"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Dec 2012 15:11:59 -0800
Received: from mfick-laptop.localnet (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id CA4AB10004B1;
	Thu, 27 Dec 2012 15:11:56 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-41-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <50DAB447.8000101@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212216>

On Wednesday, December 26, 2012 01:24:39 am Michael Haggerty 
wrote:
> ... lots of discussion about ref locking...

It concerns me that git uses any locking at all, even for 
refs since it has the potential to leave around stale locks. 

For a single user repo this is not a big deal, the lock can 
always be cleaned up manually (and it is a rare occurrence).  
However, in a multi user server environment, possibly even 
from multiple hosts over a shared filesystem such as NFS, 
stale locks could lead to serious downtime and risky recovery 
(since it is currently hard to figure out if a lock really is 
stale).  Even though stale locks are probably rare even today 
in the larger shared repo case, as git scales to even larger 
shared repositories, this will eventually become more of a 
problem *1.  Naturally, this has me thinking that git should 
possibly consider moving towards a lockless design for refs 
in the long term.

I realize this is hard and that git needs to support many 
different filesystems with different semantics.  I had an idea I 
think may be close to a functional lockless design for loose 
refs (one piece at a time) that I thought I should propose, 
just to get the ball rolling, even if it is just going to be 
found to be flawed (I realize that history suggests that such 
schemes usually are).  I hope that it does not make use of 
any semantics which are not currently expected from git of 
filesystems.  I think it relies only on the ability to rename 
a file atomically, and the ability to scan the contents of a 
directory reliably to detect the "ordered" existence of files.

My idea is based on using filenames to store sha1s instead of 
file contents.  To do this, the sha1 one of a ref would be 
stored in a file in a directory named after the loose ref.  I 
believe this would then make it possible to have lockless 
atomic ref updates by renaming the file.

To more fully illustrate the idea, imagine that any file 
(except for the null file) in the directory will represent the 
value of the ref with its name, then the following 
transitions can represent atomic state changes to a refs 
value and existence:

1) To update the value from a known value to a new value 
atomically, simply rename the file to the new value.  This 
operation should only succeed if the file exists and is still 
named old value before the rename.  This should even be 
faster than today's approach, especially on remote filesystems 
since it would require only 1 round trip in the success case 
instead of 3!

2) To delete the ref, simply delete the filename representing 
the current value of the ref.  This ensures that you are 
deleting the ref from a specific value.  I am not sure if git 
needs to be able to delete refs without knowing their values?  
If so, this would require reading the value and looping until 
the delete succeeds, this may be a bit slow for a constantly 
updated ref, but likely a rare situation (and not likely 
worse than trying to acquire the ref-lock today).  Overall, 
this again would likely be faster than today's approach.

3) To create a ref, it must be renamed from the null file (sha 
0000...) to the new value just as if it were being updated 
from any other value, but there is one extra condition: 
before renaming the null file, a full directory scan must be 
done to ensure that the null file is the only file in the 
directory (this condition exists because creating the 
directory and null file cannot be atomic unless the filesystem 
supports atomic directory renames, an expectation git does 
not currently make).  I am not sure how this compares to 
today's approach, but including the setup costs (described 
below), I suspect it is slower.

While this outlines the state changes, some additional 
operations may be needed to setup some starting conditions 
and to clean things up. But these operations could/should be 
performed by any process/thread and would not cause any state 
changes to the ref existence or value.  For example, when 
creating a ref, the ref directory would need to be created 
and the null file needs to be created.  Whenever a null file is 
detected in the directory at the same time as another file, it 
should be deleted.   Whenever the directory is empty, it may 
be deleted (perhaps after a grace period to reduce retries 
during ref creation unless the process just deleted the ref).

I don't know how this new scheme could be made to work with 
the current scheme, it seems like perhaps new git releases 
could be made to understand both the old and the new, and a 
config option could be used to tell it which method to write 
new refs with.  Since in this new scheme ref directory names 
would conflict with old ref filenames, this would likely 
prevent both schemes from erroneously being used 
simultaneously (so they shouldn't corrupt each other), except 
for the fact that refs can be nested in directories which 
confuses things a bit.  I am not sure what a good solution to 
this is?

What did I miss, where are my flaws?  Does anyone else share 
my concern for stale locks?  How could we similarly eliminate 
locks for the packed-refs file?

-Martin


*1 We have been concerned with stale locks in the Gerrit 
community when trying to design atomic cross repository 
updates.  Of course, while a lockless solution eliminates 
stale locks, it might make it impossible to do atomic cross 
repository updates since all of our solutions so far need 
locks. :(
