From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: autoCRLF, git status, git-gui, what is the desired behavior?
Date: Sun, 25 Feb 2007 17:20:50 -0500
Message-ID: <45E20BC2.3000305@verizon.net>
References: <45E1E47C.5090908@verizon.net>	<7vlkimrp1f.fsf@assigned-by-dhcp.cox.net>	<7vfy8urngi.fsf@assigned-by-dhcp.cox.net>	<45E1FC1C.4090409@verizon.net> <7v649qrkzg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 25 23:21:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLRkB-0005U2-SP
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 23:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbXBYWVN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 17:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbXBYWVN
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 17:21:13 -0500
Received: from main.gmane.org ([80.91.229.2]:57307 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965160AbXBYWVM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 17:21:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HLRjm-0007io-DX
	for git@vger.kernel.org; Sun, 25 Feb 2007 23:20:59 +0100
Received: from pool-71-246-235-75.washdc.fios.verizon.net ([71.246.235.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Feb 2007 23:20:58 +0100
Received: from mdl123 by pool-71-246-235-75.washdc.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Feb 2007 23:20:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pool-71-246-235-75.washdc.fios.verizon.net
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <7v649qrkzg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40581>

Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@verizon.net> writes:
> 
>> ... Is it the case that
>> the size info stored in the index reflects the size of the blob rather
>> than of the working copy?
> 
> The size field among other fields is to cache the last lstat(2)
> information so that later "is the path modified?" question can
> be answered efficiently.  So the size should in general match
> both blob and filesystem but on CRLF filesystems it is compared
> against and updated with the data from the filesystem.  There
> could be a subtle bug that when updating an index entry we might
> be incorrectly storing the size of the blob, but I haven't
> checked.
> 
> 
> 
I instrumented read-cache.c with:

@@ -818,6 +822,8 @@ int read_cache_from(const char *path)
         struct cache_entry *ce = (struct cache_entry *) ((char *) 
cache_mmap + offset);
         offset = offset + ce_size(ce);
         active_cache[i] = ce;
+       printf("name: %s\n", ce->name);
+       printf("size: %u\n", ntohl(ce->ce_size)
     }
     index_file_timestamp = st.st_mtime;
     while (offset <= cache_mmap_size - 20 - 8) {

And I get, post commit:
name: foo
size: 21452

$ git-update-index
$ git-runstatus
...
name: foo
size: 20517
...

Note:  foo's size with lf endings is 20517
                   with crlf endings is 21452

So, what I think is happening:

I add a file with crlf endings: it gets converted to lf, but the file 
size with crlf is saved in the index.

Post commit, the file is replaced with lf endings in the working 
directory and now has size 205167. However, the index reflects the 
pre-converted file with crlf endings, not the post-converted with lf 
endings.

Remember: I have core.autocrlf=input, so all files have lf on output. 
Apparently the working file is updated by this process. The problem is 
the index is not updated to reflect that.

Mark
