From: Kjetil Barvik <barvik@broadpark.no>
Subject: 'git checkout' and unlink() calls (was: Re: )
Date: Fri, 08 May 2009 18:47:46 +0200
Organization: private
Message-ID: <86y6t77d8t.fsf_-_@broadpark.no>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504>
 <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com>
 <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504>
 <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain>
 <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
 <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain>
 <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain>
 <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Bevan Watkiss <bevan.watkiss@cloakware.com>,
	'Alex Riesen' <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 08 18:48:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2TFj-00076y-KQ
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 18:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbZEHQso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 12:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753034AbZEHQsn
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 12:48:43 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:41552 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbZEHQsm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 12:48:42 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KJC000DP4156RE0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Fri, 08 May 2009 18:48:41 +0200 (CEST)
Received: from localhost ([80.202.166.61]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KJC005IN413HPE0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Fri, 08 May 2009 18:48:41 +0200 (CEST)
In-reply-to: <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118618>

* Linus Torvalds <torvalds@linux-foundation.org> writes:
| So here's a better patch. It should cut down the 'lstat()' calls from
| "git checkout" a lot.
|
| It looks obvious enough, and it passes testing (and now "git checkout"
| only does about as many lstat's as there are files in the repository,
| and they seem to all be properly asynchronous if 'core.preloadindex'
| is set.

  I did a test by switching from v2.6.27 to v2.6.25, and now the only
  "lstat()-difference" between with and without the -q option is 2
  lstat() calls extra done without the -q option.  And, compared to over
  41 000 lstat() calls, that is not noticable. Very good!

| Somebody should check. It would be interesting to hear about whether
| this makes a performance impact, especially with slow filesystems
| and/or other operating systems that have a relatively higher cost for
| 'lstat()'.

  Below is a table which is output from

      strace -o result -T git checkout my-v2.6.25   /* from my-v2.6.27 */

  where the "result" file is run through a perl script to pretty print it:

TOTAL        113988 100.000% OK:107252 NOT:  6736   6.263578 sec   55 usec/call
lstat64       41114  36.069% OK: 35829 NOT:  5285   0.710936 sec   17 usec/call
open          15027  13.183% OK: 13872 NOT:  1155   0.559302 sec   37 usec/call
unlink        14379  12.614% OK: 14374 NOT:     5   3.720167 sec  259 usec/call
write         14207  12.464% OK: 14207 NOT:     0   0.754196 sec   53 usec/call
close         13872  12.170% OK: 13872 NOT:     0   0.185572 sec   13 usec/call
fstat64       13862  12.161% OK: 13862 NOT:     0   0.169952 sec   12 usec/call
rmdir           551   0.483% OK:   269 NOT:   282   0.035534 sec   64 usec/call
brk             510   0.447% OK:   510 NOT:     0   0.014804 sec   29 usec/call
mkdir           174   0.153% OK:   174 NOT:     0   0.102625 sec  590 usec/call
mmap2           102   0.089% OK:   102 NOT:     0   0.001725 sec   17 usec/call
read             68   0.060% OK:    68 NOT:     0   0.000999 sec   15 usec/call
munmap           61   0.054% OK:    61 NOT:     0   0.005037 sec   83 usec/call
access           20   0.018% OK:    12 NOT:     8   0.000348 sec   17 usec/call
mprotect         13   0.011% OK:    13 NOT:     0   0.000193 sec   15 usec/call
stat64            7   0.006% OK:     7 NOT:     0   0.000109 sec   16 usec/call
getcwd            3   0.003% OK:     3 NOT:     0   0.000053 sec   18 usec/call
chdir             3   0.003% OK:     3 NOT:     0   0.000048 sec   16 usec/call
fcntl64           3   0.003% OK:     3 NOT:     0   0.000036 sec   12 usec/call
rename            2   0.002% OK:     2 NOT:     0   0.001553 sec  776 usec/call
setitimer         2   0.002% OK:     2 NOT:     0   0.000028 sec   14 usec/call
getdents64        2   0.002% OK:     2 NOT:     0   0.000039 sec   20 usec/call
uname             1   0.001% OK:     1 NOT:     0   0.000013 sec   13 usec/call
time              1   0.001% OK:     1 NOT:     0   0.000011 sec   11 usec/call
futex             1   0.001% OK:     1 NOT:     0   0.000013 sec   13 usec/call
readlink          1   0.001% OK:     0 NOT:     1   0.000018 sec   18 usec/call
execve            1   0.001% OK:     1 NOT:     0   0.000256 sec  256 usec/call
getrlimit         1   0.001% OK:     1 NOT:     0   0.000011 sec   11 usec/call

  So, if the numbers from strace is trustable, 0.71 seconds is used on
  41 114 calls to lstat64().  But, look at the unlink line, where each
  call took 259 microseconds (= 0.259 milliseconds), and all 14 379
  calls took 3.72 seconds.

  It should be noted that when switching branch the other way (from .25
  to .27), the unlink() calls used less time (below 160 microseconds
  each).  Also note that the above was tested by only 3 runs.  Warm
  cache.  ext4 disk partition with git compiled with the USE_NSEC=1
  option.

  Most (all?) of the unlink() calls seems to be from the following lines
  from the checkout_entry() funciton in entry.c

	/*
	 * We unlink the old file, to get the new one with the
	 * right permissions (including umask, which is nasty
	 * to emulate by hand - much easier to let the system
	 * just do the right thing)
	 */
	if (S_ISDIR(st.st_mode)) {
		/* If it is a gitlink, leave it alone! */
		if (S_ISGITLINK(ce->ce_mode))
			return 0;
		if (!state->force)
			return error("%s is a directory", path);
		remove_subtree(path);
	} else if (unlink(path))
		return error("unable to unlink old '%s' (%s)", path, strerror(errno));

  -- kjetil
