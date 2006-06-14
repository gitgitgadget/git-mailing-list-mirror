From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: oprofile on svn import
Date: Wed, 14 Jun 2006 15:25:46 -0400
Message-ID: <9e4733910606141225n11b406fte6229ea9993825dd@mail.gmail.com>
References: <9e4733910606131810ya6aa585m5d2349f651b01492@mail.gmail.com>
	 <9e4733910606131932w362c6ddcx5bf36ea5591feba1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 14 21:25:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqazu-0007Is-Ja
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 21:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWFNTZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 15:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWFNTZs
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 15:25:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:57254 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750879AbWFNTZr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 15:25:47 -0400
Received: by nz-out-0102.google.com with SMTP id s18so327198nze
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 12:25:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mZsxs0MqV0ErYunCWSjHqNXDnHAG9FDpHhedbFolwcmOtwndB0Ucg+0KVOIP4GFAdaFkdhsRZTaEW8HxW/fQ9be9MTjgwoUJrCZMubcGqA+tsykTS1fkUfGn3/Mp4Ekdd7nC5fqe3Oq61IGLvBelUcXdMPk2rPi4GKDWi4LgBLg=
Received: by 10.36.118.13 with SMTP id q13mr1550772nzc;
        Wed, 14 Jun 2006 12:25:46 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Wed, 14 Jun 2006 12:25:46 -0700 (PDT)
To: git <git@vger.kernel.org>
In-Reply-To: <9e4733910606131932w362c6ddcx5bf36ea5591feba1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21855>

Stats after 18 hours into git-svnimport. Process is now stuck in the
kernel 64% of the time. All of the kernel time is in page management.
Perl svnimport process is 290MB now.

My top candidates for causing the problem are the fork in the perl
code or the execing of a million tiny git processes.

The key low level git functions could be made into a library to avoid
the need to exec them continuously. The svn functions are libraries
and they hardly show up.

   606218  2.4143 /usr/local/bin/git-update-index
   127170  0.5065 /usr/local/bin/git-write-tree
    81153  0.3232 /usr/local/bin/git-read-tree
    13065  0.0520 /usr/local/bin/git-ls-files
     2624  0.0105 /usr/local/bin/git-hash-object
      754  0.0030 /usr/local/bin/git-commit-tree
      462  0.0018 /usr/local/bin/git-ls-tree
      398  0.0016 /usr/local/bin/git-rev-parse

versus

   102784  0.3641 /usr/lib/libsvn_subr-1.so.0.0.0
    70235  0.2488 /usr/lib/libsvn_fs_fs-1.so.0.0.0
    67081  0.2376 /usr/lib/libsvn_delta-1.so.0.0.0
      848  0.0030 /usr/lib/libsvn_swig_perl-1.so.0.0.0
      512  0.0018 /usr/lib/libsvn_ra_local-1.so.0.0.0
      350  0.0012 /usr/lib/libsvn_fs-1.so.0.0.0
      222 7.9e-04 /usr/lib/libsvn_repos-1.so.0.0.0
      124 4.4e-04 /usr/lib/libsvn_ra-1.so.0.0.0

------------------------------------------------------------------------------------------------------------

  4093890 64.3711 /home/good/vmlinux
   906014 14.2459 /lib/libcrypto.so.0.9.8a
   435744  6.8515 /lib/libc-2.4.so
   158325  2.4895 /usr/lib/libz.so.1.2.3
   139995  2.2012 /usr/local/bin/git-update-index
    75322  1.1843 /nvidia
    64349  1.0118 /usr/bin/oprofiled
    52825  0.8306 /usr/lib/perl5/5.8.8/i386-linux-thread-multi/CORE/libperl.so
    51930  0.8165 /usr/lib/libapr-1.so.0.2.2
    42771  0.6725 /usr/local/bin/git-read-tree
    37774  0.5939 /lib/ld-2.4.so
    34761  0.5466 /usr/local/bin/git-write-tree
    29560  0.4648 /usr/lib/libsvn_subr-1.so.0.0.0
    28210  0.4436 /usr/lib/libaprutil-1.so.0.2.2

-----------------------------------------------------------------------------------------------------------------

2471826  32.8741    copy_page_range
375260  18.2903  unmap_vmas
574208    7.6367  release_pages
572189    7.6098  page_remove_rmap
233367    3.1037  free_pages_and_swap_cache
191051    2.5409  get_page_from_freelist
169058    2.2484  unlock_page
162027    2.1549  vm_normal_page
155691    2.0706  swap_info_get
136324    1.8130  swap_duplicate
119227    1.5857  page_fault
99729     1.3263  page_waitqueue
49288     0.6555  remove_exclusive_swap_page
39611     0.5268  do_wp_page
39142     0.5206  __wake_up_bit
34384     0.4573  __copy_from_user_ll
31111     0.4138  __handle_mm_fault
29990     0.3989  find_get_page
29682     0.3948  do_page_fault


-- 
Jon Smirl
jonsmirl@gmail.com
