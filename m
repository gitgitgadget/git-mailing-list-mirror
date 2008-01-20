From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sun, 20 Jan 2008 22:40:38 +0100
Message-ID: <65FCA357-7F7E-4FE0-A423-2528A43B915D@zib.de>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org> <alpine.LSU.1.00.0801200142170.5731@racer.site> <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de> <alpine.LFD.1.00.0801200942191.2957@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 22:40:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGhu1-00008x-UL
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 22:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbYATVj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 16:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755538AbYATVj7
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 16:39:59 -0500
Received: from mailer.zib.de ([130.73.108.11]:57770 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755477AbYATVj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 16:39:58 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0KLdcZb017862;
	Sun, 20 Jan 2008 22:39:42 +0100 (CET)
Received: from [192.168.178.21] (brln-4db91f4c.pool.einsundeins.de [77.185.31.76])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0KLdb1W016170
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 20 Jan 2008 22:39:37 +0100 (MET)
In-Reply-To: <alpine.LFD.1.00.0801200942191.2957@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71192>


On Jan 20, 2008, at 7:20 PM, Linus Torvalds wrote:

>
> On Sun, 20 Jan 2008, Steffen Prohaska wrote:
>
> So your test-case does have relatively more overhead (compared to  
> what got
> optimized) than the numbers I quoted.

I cloned the kernel tree and measured these numbers:

Best time before:

     $ time git commit >/dev/null
     real    0m1.487s
     user    0m0.786s
     sys     0m0.696s

Best time after:

     $ time git commit >/dev/null
     real    0m1.087s
     user    0m0.578s
     sys     0m0.508s


> We also do know that while Linux has a very low-overhead lstat(),  
> the real
> problem on OS X has been the memory management, not the filesystem.  
> We had
> some case where the page fault overhead was something like two  
> orders of
> magnitude bigger, didn't we?
>
> (Yeah - just checked. Commit 6d2fa7f1b489c65e677c18eda5c144dbc5d614ab:
> "index-pack usage of mmap() is unacceptably slower.."). That took a  
> minute
> on Linux, and an hour on OS X)
>
> It would be good to have a system-level profile of something like  
> this. On
> Linux, it's now mostly in user space with "git commit", and oprofile
> shows:

[...]

I used Mac OS X's Sampler to collect some statistics.

It took me some time to find out about and work around an
annoying limitation.  Sampler is not capable of simply sampling a
full run of a process but needs to be manually stopped before the
process terminates.  You literally have to push a button before
the process exits--what a crazy tool.  I worked around this by
adding a sleep(100) instruction.  Sampler allows you to prune the
samples collected in mach_wait_until() and the relative numbers
should be fine.

Here is what I have.

Before Junio's and your patch, lstat dominates with 25%:

# Report - Timed Samples for git-commit
# Samples < 20 have been filtered
# Generated from the visible portion of the outline view
+ 25% lstat
| + 25% lstat
| | - 17% wt_status_print
| | - 8.4% refresh_index
+ 16% getdirentries
| + 16% getdirentries
| | - 16% read_directory_recursive
+ 10% fnmatch
| + 10% fnmatch
| | + 10% excluded
| | | - 10% read_directory_recursive
+ 9.7% sha1_block_data_order
| + 9.7% sha1_block_data_order
| | + 9.7% SHA1_Update
| | | + 8.0% read_index_from
| | | | - 6.8% wt_read_cache
| | | - 1.6% ce_write
+ 8.6% cache_name_compare
| + 8.6% cache_name_compare
| | - 6.9% cmp_cache_name_compare
| | - 1.6% index_name_pos
- 5.2% __mmap
- 3.2% open
+ 2.0% excluded
| + 2.0% excluded
| | - 2.0% read_directory_recursive
- 1.6% mbrtowc_l
- 1.5% find_pack_entry_one
- 1.4% cmp_cache_name_compare
- 1.3% qsort



After your patches getdirentries and fnmatch dominate:

# Report - Timed Samples for git-commit
# Samples < 20 have been filtered
# Generated from the visible portion of the outline view
+ 29% getdirentries
| + 29% getdirentries
| | - 29% read_directory_recursive
+ 19% fnmatch
| + 19% fnmatch
| | + 19% excluded
| | | - 19% read_directory_recursive
+ 9.6% lstat
| + 9.6% lstat
| | - 9.5% refresh_index
+ 5.5% open
| + 5.5% open
| | + 3.9% excluded
| | | - 3.9% read_directory_recursive
| | - 1.6% read_directory_recursive
+ 3.9% cache_name_compare
| + 3.9% cache_name_compare
| | - 3.8% index_name_pos
+ 3.0% sha1_block_data_order
| + 3.0% sha1_block_data_order
| | + 3.0% SHA1_Update
| | | - 1.6% read_index_from
+ 2.8% excluded
| + 2.8% excluded
| | - 2.8% read_directory_recursive
- 2.5% __memcpy
- 1.9% strcmp
- 1.6% close
- 1.4% fnmatch1


The reports above were created with Sampler's "Invert call tree"
option, while the next one is generated without this option.

# Report - Timed Samples for git-commit
# Samples < 20 have been filtered
# Generated from the visible portion of the outline view
+ 85% run_status
| + 85% wt_status_print
| | + 73% read_directory
| | | + 73% read_directory_recursive
| | | | + 73% read_directory_recursive
| | | | | + 71% read_directory_recursive
| | | | | | + 44% read_directory_recursive
| | | | | | | + 15% excluded
| | | | | | | | - 12% fnmatch
| | | | | | | | - 1.6% open
| | | | | | | - 12% getdirentries
| | | | | | | + 10% read_directory_recursive
| | | | | | | | - 4.0% getdirentries
| | | | | | | | - 2.6% excluded
| | | | | | | |   1.7% read_directory_recursive
| | | | | | | - 2.6% dir_add_name
| | | | | | + 14% excluded
| | | | | | | - 11% fnmatch
| | | | | | - 8.0% getdirentries
| | | | | | - 1.6% dir_add_name
| | - 11% run_diff_index
+ 15% prepare_index
| + 10% refresh_index
| | - 9.7% lstat
| - 2.5% write_index
| - 1.9% read_index

With this kind of report you can see how the running time is
distributed over the different functions called by cmd_commit().


> and one thing to look out for would be that some of these things  
> might be
> relatively much more costly on other systems.
>
> fnmatch? It's certainly visible on Linux, I wonder if the Windows/OSX
> version is more expensive due to trying to be case-insensitive or
> something?

So roughly 50% of the running time is spent in getdirentries
and fnmatch on the MacBook Pro I used to run these tests.

	Steffen
