From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH/RFC v3 7/9] write_entry(): use fstat() instead of lstat()
 when file is open
Date: Fri, 06 Feb 2009 12:06:57 +0100
Organization: private
Message-ID: <868wojq0xa.fsf@broadpark.no>
References: <cover.1233751281.git.barvik@broadpark.no>
 <21073c1f3f6c2c81b26a632f495325f5e7a7de5a.1233751281.git.barvik@broadpark.no>
 <49899FA4.2020003@viscovery.net> <7vfxiut57t.fsf@gitster.siamese.dyndns.org>
 <86tz7ayo51.fsf_-_@broadpark.no> <498A9FD3.2020601@viscovery.net>
 <alpine.DEB.1.00.0902051202440.7491@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 12:08:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOZS-0002kF-KA
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 12:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341AbZBFLHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 06:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754295AbZBFLHE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 06:07:04 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:51462 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbZBFLHD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 06:07:03 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEN00BLO5JNUE50@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Fri, 06 Feb 2009 12:06:59 +0100 (CET)
Received: from localhost ([80.203.29.216]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEN00INM5JMQ120@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Fri, 06 Feb 2009 12:06:59 +0100 (CET)
In-reply-to: <alpine.DEB.1.00.0902051202440.7491@intel-tinevez-2-302>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108682>

* On Thu, 5 Feb 2009, Johannes Sixt wrote:
|
|> Kjetil Barvik schrieb:
|> >   And, yes, since each lstat() call cost approximately 44 microseconds
|> >   compared to 12-16 for each lstat() on my Linux box, there was a little
|>                                ^^^^^^^ fstat()?
|> >   performance gain from this patch.
|> 
|> This does look like a good gain. But do you have hard numbers that back
|> the claim?

  __________________
  Test description

  I have used the following 8 git binaries:

$ for g in ./git_t*; do printf "$g => $($g --version)\n"; done
./git_t0 => git version 1.6.1.80.g7eb5
./git_t1 => git version 1.6.1.85.gbda6       <= added lstat_cache()
./git_t2 => git version 1.6.1.2.306.gc0f6f
./git_t3 => git version 1.6.1.2.307.g55385
./git_t4 => git version 1.6.1.2.308.g052a
./git_t5 => git version 1.6.1.2.310.g40dd2   <= added schedule_dir_for_removal()
./git_t6 => git version 1.6.1.2.313.g9deee
./git_t7 => git version 1.6.1.2.314.g0ad9    <= added this patch (7/9)

  Except for git_t7 all commits should be in origin/pu, so people should
  be able to do git show/diff/log on the last hex chars on the version-
  strings to see the differences.

  CFLAGS="-mtune=core2 -O2 -fomit-frame-pointer -fno-stack-protector -g0 -s"

  Each git_t* binary is run with args "checkout -q my-v.2.6.2[57]" for a
  total of 100 times (50/50 to my-v2.6.25/my-v2.6.27).  Before each run
  the test script sleeps 20 seconds to allow the disk to finish and
  being idle.  Time is collected by /usr/bin/time -o output-file prog.

  While the test script was run, the laptop with an Intel Core2 Duo 2
  GHz processor, was run without X and was otherwise idle.  The test
  script took 9 hours and 45 minutes to complete.

  __________________
  Test numbers

$ for ((t=0; $t<=7; t++)); do echo "git_t$t => $(parse_usr_bin_time_lines.pl git_t$t*)"; done
git_t0 =>  5.646 user  8.322 sys  25.579 real  54.6% CPU  faults:  0 major 39587 minor
git_t1 =>  5.631 user  6.826 sys  23.941 real  52.1% CPU  faults:  0 major 39901 minor
git_t2 =>  5.622 user  6.854 sys  24.036 real  52.1% CPU  faults:  0 major 39298 minor
git_t3 =>  5.636 user  6.867 sys  24.088 real  52.0% CPU  faults:  0 major 39786 minor
git_t4 =>  5.640 user  6.818 sys  24.006 real  52.0% CPU  faults:  0 major 39629 minor
git_t5 =>  5.642 user  6.552 sys  23.805 real  51.4% CPU  faults:  0 major 39707 minor
git_t6 =>  5.629 user  6.518 sys  22.981 real  53.0% CPU  faults:  0 major 40029 minor
git_t7 =>  5.629 user  6.051 sys  23.013 real  50.9% CPU  faults:  0 major 39451 minor

|> If you can squeeze out a 10% improvement on Linux with this patch, we
|> should take it, and if it turns out that it doesn't work on Windows, we
|> could trivially throw in an #ifdef MINGW (or even #ifdef WIN32 if Cygwin
|> is affected, too) that skips the fstat() optimization.

  For the system used time, the improvement was (- 6.518 6.051) = 0.467
  seconds, or (/ (* (- 6.518 6.051) 100.0) 6.518) = 7.2%, so not 10%.

  Funny to see that in:
     http://article.gmane.org/gmane.comp.version-control.git/107281

  I guessed the improvement to be (quote):
     "(* 14403 (- 44 12)) = 460 896 microseconds system time"

  So I missed only by a little over 6ms. :-)

* Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
| Of course, what we _really_ would do is to provide a flag, say, 
| FSTAT_UNRELIABLE and test for _that_ (after defining it in the Makefile 
| for the appropriate platforms).

  Or, maybe

     #define FSTAT_RELIABLE 1

  for Linux only?  Then we can change the if-test inside this patch to
  the following:

-  if (state->refresh_cache && !to_tempfile && !state->base_dir_len) {
+  if (state->refresh_cache && !to_tempfile && !state->base_dir_len && 
+      FSTAT_RELIABLE) {

  Then we do not have to have #if-defines inside the source code, only
  in one header file.

  But, question: is this patch worth the extra lines added to the source
  code?

  -- kjetil

  PS!  Junio, I think this patch series should be inside pu some days
       more, since things obviously needs more refinement and tests.
