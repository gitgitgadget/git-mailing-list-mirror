From: Brian Downing <bdowning@lavos.net>
Subject: Re: Serious performance regression in diff between 1.6.6 and 1.7.0
Date: Thu, 10 Jun 2010 12:08:04 -0500
Message-ID: <20100610170804.GB2635@glaurung.lavos.net>
References: <20100610001005.GA2635@glaurung.lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 19:08:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMlEk-0003On-U6
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 19:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759611Ab0FJRIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 13:08:09 -0400
Received: from glaurung.lavos.net ([69.162.133.92]:56089 "EHLO
	glaurung.lavos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759546Ab0FJRII (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 13:08:08 -0400
Received: by glaurung.lavos.net (Postfix, from userid 1000)
	id AEC1E7417D; Thu, 10 Jun 2010 12:08:04 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20100610001005.GA2635@glaurung.lavos.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148893>

On Wed, Jun 09, 2010 at 07:10:05PM -0500, Brian Downing wrote:
> I've stumbled across a pretty serious performance regression in "git
> diff" for a large (187456 files checked out on HEAD) repository of mine.

[...]

> It is more than 10x worse for my case here:
> 
> before 730f72840cc50c523fe4cdd796ea2d2fc4571a28:
> 0.30user 0.50system 0:00.81elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> 
> 730f72840cc50c523fe4cdd796ea2d2fc4571a28:
> 5.58user 0.40system 0:05.98elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k

Here's a little more profiling information (from the bad case).  I ran this a
couple of times to see what oprofile said.  Sorry about the lack of non-Git
symbols:

CPU: Core 2, speed 2668 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Clock cycles when not halted) with a unit mask of 0x00 (Unhalted core cycles) count 100000
samples  %        image name               app name                 symbol name
499255   62.8497  git-diff                 git-diff                 df_name_compare
110561   13.9182  git-diff                 git-diff                 do_compare_entry
54508     6.8619  no-vmlinux               git-diff                 (no symbols)
33741     4.2476  no-vmlinux               no-vmlinux               (no symbols)
23724     2.9865  git-diff                 git-diff                 ce_in_traverse_path
11767     1.4813  libcrypto.so.0.9.8       git-diff                 (no symbols)
10511     1.3232  git-diff                 git-diff                 find_cache_pos

I also ran this through callgrind to see how often the above were called:

        Calls  Symbol
  -----------  -------------------
      197,958  unpack_callback
      208,460  find_cache_pos
   37,308,336  ce_in_traverse_path
  156,950,469  do_compare_entry
  156,950,469  df_name_compare

Hope this helps.

-bcd
