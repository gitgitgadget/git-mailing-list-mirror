From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: t5541-http-push hanging
Date: Thu, 12 Nov 2009 00:18:26 -0500
Message-ID: <BA539267-B705-4BE3-BF69-DCE5FBD35CEA@gernhardtsoftware.com>
References: <B17AB159-E217-4E1F-BEA3-97E5892C13F4@gernhardtsoftware.com> <20091112044906.GQ11919@spearce.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 12 06:18:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8S4r-00081n-OQ
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 06:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbZKLFS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 00:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbZKLFSZ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 00:18:25 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:55002 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbZKLFSZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 00:18:25 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id CB91E1FFC087; Thu, 12 Nov 2009 05:18:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 016CF1FFC06B;
	Thu, 12 Nov 2009 05:18:17 +0000 (UTC)
In-Reply-To: <20091112044906.GQ11919@spearce.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132737>


On Nov 11, 2009, at 11:49 PM, Shawn O. Pearce wrote:

> Brian Gernhardt <brian@gernhardtsoftware.com> wrote:
>> My build script for git has been hanging at t5541.2 and I haven't had the tuits to discover why.  Here's what I've gotten so far, in case anyone can figure it out faster:
> ...
>> 	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone
> ...
>> [Wed Nov 11 06:19:39 2009] [error] [client 127.0.0.1] git-http-backend(59490) malloc: *** error for object 0x100200340: incorrect checksum for freed object - object was probably modified after being freed.
>> [Wed Nov 11 06:19:39 2009] [error] [client 127.0.0.1] *** set a breakpoint in malloc_error_break to debug
> 
> I can't reproduce this on 10.5.8.  Can you try running it in the
> debugger and putting a breakpoint where they suggest?  Maybe it
> will help give us some context information:
> 
>  REQUEST_METHOD=GET \
>  PATH_TRANSLATED=`pwd`/.git/info/refs \
>  QUERY_STRING=service=git-upload-pack \
>  gdb ./git-http-backend
> 
>  b malloc_error_break
>  run
> 
> I suspect that's where our failure is, the code path for the actual
> common negotiation and data transfer is shorter, and less likely
> to need to do a memory allocation... and therefore a free.

Interesting.  This command runs to completion.  In the test environment it gives:

Expires: Fri, 01 Jan 1980 00:00:00 GMT
Pragma: no-cache
Cache-Control: no-cache, max-age=0, must-revalidate
Content-Type: application/x-git-upload-pack-advertisement

001e# service=git-upload-pack
0000009b0c973ae9bd51902a28466f3850b543fa66a6aaf4 HEADmulti_ack thin-pack side-band side-band-64k ofs-delta shallow no-progress include-tag multi_ack_detailed
003f0c973ae9bd51902a28466f3850b543fa66a6aaf4 refs/heads/master
0000

(which looks right to me)

access.log has:
127.0.0.1 - - [12/Nov/2009:04:54:38 +0000] "GET /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1" 200 256
127.0.0.1 - - [12/Nov/2009:04:54:38 +0000] "POST /smart/test_repo.git/git-upload-pack HTTP/1.1" 500 538

After a bit of trial and error, I got this:

test_repo.git (BARE:master)$ REQUEST_METHOD=POST PATH_TRANSLATED=`pwd`/git-upload-pack gdb ../../../../../git-http-backend GNU gdb 6.3.50-20050815 (Apple version gdb-1344) (Fri Jul  3 01:19:56 UTC 2009)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "x86_64-apple-darwin"...Reading symbols for shared libraries ..
warning: Could not find object file "/sw/src/fink.build/libiconv-1.12-3/libiconv-1.12/lib/.libs/iconv.o" - no debug information available for "./iconv.c".


warning: Could not find object file "/sw/src/fink.build/libiconv-1.12-3/libiconv-1.12/lib/.libs/localcharset.o" - no debug information available for "./../libcharset/lib/localcharset.c".


warning: Could not find object file "/sw/src/fink.build/libiconv-1.12-3/libiconv-1.12/lib/.libs/relocatable.o" - no debug information available for "./relocatable.c".

.. done

(gdb) b malloc_error_break 
Breakpoint 1 at 0x4189374bb86951
(gdb) run
Starting program: /Users/brian/dev/git/git-http-backend 
Reading symbols for shared libraries +++. done
git-http-backend(2358) malloc: *** error for object 0x100200390: incorrect checksum for freed object - object was probably modified after being freed.
*** set a breakpoint in malloc_error_break to debug

Breakpoint 1, 0x00007fff84c19951 in malloc_error_break ()
(gdb) bt
#0  0x00007fff84c19951 in malloc_error_break ()
#1  0x00007fff84c1aaa8 in szone_error ()
#2  0x00007fff84b466e3 in tiny_free_list_remove_ptr ()
#3  0x00007fff84b44df7 in szone_realloc ()
#4  0x00007fff84b44b3b in malloc_zone_realloc ()
#5  0x00007fff84b50bd3 in realloc ()
#6  0x000000010004985f in xrealloc (ptr=0x100200370, size=66) at wrapper.c:59
#7  0x0000000100041372 in strbuf_grow (sb=0x7fff5fbfed70, extra=<value temporarily unavailable, due to optimizations>) at strbuf.c:61
#8  0x000000010001e194 in strbuf_addch [inlined] () at /Users/brian/dev/git/strbuf.h:95
#9  0x000000010001e194 in add_path (out=0x7fff5fbfed70, path=0x100200320 "/usr/local/libexec/git-core") at exec_cmd.c:95
#10 0x000000010001e229 in setup_path () at exec_cmd.c:104
#11 0x000000010000226d in main (argc=<value temporarily unavailable, due to optimizations>, argv=<value temporarily unavailable, due to optimizations>) at http-backend.c:641
(gdb) 

I'm lost as to why it's dying doing setup_path.  My guess is that some of the code before here is doing something bad to memory.

~~ Brian