From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Quilt vs. StGIT Performance
Date: Tue, 04 Oct 2005 10:09:30 +0100
Message-ID: <tnxirwdfy2d.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 04 11:09:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMio0-0008Qo-MH
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 11:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVJDJJq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 05:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVJDJJq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 05:09:46 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:47762 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751151AbVJDJJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 05:09:45 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j9499XSV005749;
	Tue, 4 Oct 2005 10:09:33 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id KAA08573;
	Tue, 4 Oct 2005 10:09:32 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.3]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 4 Oct 2005 10:09:32 +0100
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 04 Oct 2005 09:09:32.0172 (UTC) FILETIME=[5517ACC0:01C5C8C3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9670>

I ran some benchmarks on both Quilt and StGIT (only the push/pop
operations) with the -mm series (2.6.14-rc2-mm2, 566 patches). All the
patches were refreshed since GIT does not support fuzzy patches. The
tools output was directed to /dev/null (a slight advantage for Quilt
since it prints more information). For the StGIT benchmarks, the base
of the stack was modified before each 'stg push -a' command because
otherwise pushing would just fast-forward the patches (timing similar
to the pop command).

As you can see below, 'quilt push' is much faster than 'stg push'. The
profiling information on the latest snapshot shows that StGIT spends
most of the time (~75%) in git-write-tree (which calculates the SHA1
value of the index file after every push). Unfortunately, this cannot
be avoided (otherwise, we would simply re-write Quilt).

There are other advantages of StGIT vs. Quilt but I won't go through
them in this e-mail. For huge number of patches, it's up to you to
decide whether speed is more important than the other StGIT features.


Quilt vs. StGIT (push/pop)
==========================

No. patches:   566 (linux-2.6.14-rc2-mm2)
Machine:       P4 @ 2.5GHz, 512MB RAM, WDC IDE disk
OS:            Linux 2.6.8-2-686 #1 Thu May 19 17:53:30 JST 2005 i686 GNU/Linux
StGIT version: snapshot of 2005-10-04
Quilt version: 0.39-2 (on Debian)
GIT version:   0.99.8.GIT

       run 1     run 2     run 3     run 4     run 5    average   per patch
---------------------------------------------------------------------------
stg push
---------------------------------------------------------------------------
real  4:56.261  4:07.660  3:37.361  4:20.393  4:16.312  4:15.597  0.452s
user  1:44.004  1:44.051  1:44.047  1:43.802  1:43.718  1:43.924
sys   0:49.803  0:49.812  0:49.458  0:49.714  0:49.954  0:49.748
---------------------------------------------------------------------------
stg pop
---------------------------------------------------------------------------
real  0:27.918  0:14.123  0:17.280  0:45.767  0:26.957  0:26.409  0.047s
user  0:01.857  0:01.852  0:01.864  0:01.883  0:01.867  0:01.865
sys   0:00.761  0:00.703  0:00.680  0:00.796  0:00.740  0:00.736
---------------------------------------------------------------------------
quilt push
---------------------------------------------------------------------------
real  1:00.584  0:36.191  0:34.728  0:24.723  0:30.498  0:37.345  0.066s
user  0:05.687  0:05.551  0:05.632  0:05.591  0:05.618  0:05.616
sys   0:07.835  0:07.588  0:07.454  0:07.536  0:07.552  0:07.593
---------------------------------------------------------------------------
quilt pop
---------------------------------------------------------------------------
real  0:55.772  0:44.721  0:45.503  0:58.081  0:51.621  0:51.140  0.090s
user  0:13.606  0:13.601  0:13.646  0:13.725  0:13.590  0:13.634
sys   0:24.813  0:24.762  0:24.697  0:24.658  0:24.833  0:24.750


-- 
Catalin
