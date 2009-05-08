From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re:
Date: Fri, 08 May 2009 12:43:52 -0500
Message-ID: <OWEdfN5mNBoNl1TcdOvhhNfi_nLsao-aFrHkz_rNtuX_4lqXHisfcQ@cipher.nrlssc.navy.mil>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504> <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <81b0412b0905080117v3aad0c44o7b3bbcc7fe70d3b1@mail.gmail.com> <alpine.LFD.2.01.0905080734260.4983@localhost.localdomain> <eFUCK0_CEtLa6Qvg6X1SqHmCgRnY3_3dy3OCJK26lGP-_kDRyWtlRA@cipher.nrlssc.navy.mil> <alpine.LFD.2.01.0905080857130.4983@localhost.localdomain> <Ah7lj3UWxgwxNiQs6kqiiVurulv4F00ssWrb3OzfTrXYlK8ZBCSBOQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Bevan Watkiss <bevan.watkiss@cloakware.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 08 19:44:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2U7s-00005O-8o
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 19:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853AbZEHRok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 13:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753656AbZEHRok
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 13:44:40 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46788 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbZEHRoj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 13:44:39 -0400
Received: by mail.nrlssc.navy.mil id n48HhrV0008664; Fri, 8 May 2009 12:43:53 -0500
In-Reply-To: <Ah7lj3UWxgwxNiQs6kqiiVurulv4F00ssWrb3OzfTrXYlK8ZBCSBOQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 08 May 2009 17:43:53.0409 (UTC) FILETIME=[8DCABB10:01C9D004]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118620>

Brandon Casey wrote:
> Linus Torvalds wrote:
>> And 
>> the preloading sounds like it hits serialization overhead in the kernel, 
>> which I'm not at all surprised at, but not being surprised doesn't mean 
>> that I'm not interested to hear where it is.
>>
>> The Linux VFS dcache itself should scale better than that (but who knows - 
>> cacheline ping-pong due to lock contention can easily cause a 10x slowdown 
>> even without being _totally_ contended all the time). So I would _suspect_ 
>> that it's some NFS lock that you're seeing, but I'd love to know more.
>>
>> Btw, those system times are pretty high to begin with, so I'd love to know 
>> kernel version and see a profile even without the parallel case and 
>> presumably lock contention.

Here's an strace of 'git checkout':

Before (cold cache):
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 98.60    6.365501         111     57432           lstat64
  0.50    0.031984         359        89         2 close
  0.25    0.015818         115       137        77 open
  0.12    0.007670          23       339           write
  0.09    0.005631         110        51           munmap
  0.08    0.004873          49        99        69 stat64
  0.07    0.004771         140        34        15 access
  0.05    0.003083         280        11         5 waitpid
  0.05    0.002973          10       284           brk
  0.04    0.002816         469         6           execve
<snip>

After (cold cache, no lstat fix, just cache_preload):
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 90.90   23.717981         413     57432           lstat64
  8.72    2.273917      162423        14         2 futex
  0.12    0.032241         948        34           close
  0.04    0.011507         202        57           munmap
  0.04    0.009648         132        73           mmap2
  0.03    0.008508         149        57        20 open
  0.03    0.007771         311        25           mprotect
  0.03    0.007758         388        20           clone
  0.03    0.007548          23       334           write
  0.02    0.005247         262        20        10 access

-brandon
