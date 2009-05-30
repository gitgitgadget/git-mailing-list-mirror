From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 3/3] http-push: send out fetch requests on queue
Date: Sat, 30 May 2009 11:17:55 +0200
Message-ID: <20090530091755.GA13578@localhost>
References: <49F1EA6D.8080406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 11:22:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAKm0-00042h-1b
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 11:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbZE3JST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 05:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbZE3JSS
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 05:18:18 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:37429 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbZE3JSR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 05:18:17 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 30 May 2009 11:18:16 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MAKhP-0005eM-8a; Sat, 30 May 2009 11:17:55 +0200
Content-Disposition: inline
In-Reply-To: <49F1EA6D.8080406@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 30 May 2009 09:18:16.0473 (UTC) FILETIME=[90A82890:01C9E107]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120340>

Hi,

On Sat, Apr 25, 2009 at 12:35:57AM +0800, Tay Ray Chuan wrote:
[...]
> --- a/http-push.c
> +++ b/http-push.c
> @@ -2300,6 +2322,7 @@ int main(int argc, char **argv)
>  	local_refs = get_local_heads();
>  	fprintf(stderr, "Fetching remote heads...\n");
>  	get_dav_remote_heads();
> +	run_request_queue();
> 
>  	/* Remove a remote branch if -d or -D was specified */
>  	if (delete_branch) {

The "http-push fetches packed objects" test of t5540 on pu either segfaults
or hangs indefinitely on my machine [1]. The bug is revealed by the added
line above in commit 0d71b15 (http-push: send out fetch requests on queue).

I have been trying to debug this, but I'm at a loss. Below are the backtrace
and an excerpt of the valgrind output with 0d71b15. See
http://gist.github.com/120453 for the full output. Note that the
segfault/hang does not happen if valgrind is used.

Can anybody reproduce this? Set GIT_TEST_HTTPD to enable this test.

Clemens

[1] Debian amd64 stable (mostly), libcurl version 17.18.2
---

(gdb) r
Starting program: /home/drizzd/fridge/linux/src/git/git-http-push --force
--verbose http://127.0.0.1:5540/test_repo_packed.git master
[Thread debugging using libthread_db enabled]
Getting pack list
Getting index for pack ecba592576b66d9aa805891d0a80a0133abd5f5d
Fetching remote heads...
  refs/
  refs/heads/
  fetch 9d498b0bbc2a25438e2fbd19081948da86028c23 for refs/heads/master
  refs/tags/
Fetching pack ecba592576b66d9aa805891d0a80a0133abd5f5d
 which contains 9d498b0bbc2a25438e2fbd19081948da86028c23
[New Thread 0x7f60404a9700 (LWP 21395)]

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7f60404a9700 (LWP 21395)]
0x00007f603f49245e in ?? () from /lib/libc.so.6
(gdb) bt
#0  0x00007f603f49245e in ?? () from /lib/libc.so.6
#1  0x00007f603f49104a in ftell () from /lib/libc.so.6
#2  0x0000000000409785 in run_active_slot (slot=0x6bab40) at http.c:536
#3  0x00000000004099f0 in finish_all_active_slots () at http.c:607
#4  0x000000000040f72f in run_request_queue () at http-push.c:2179
#5  0x000000000040fcb4 in main (argc=5, argv=0x7fff485cd748) at
http-push.c:2325


* checking known breakage: 
	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
		"$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_packed.git &&

	git clone $HTTPD_URL/test_repo_packed.git \
		"$ROOT_PATH"/test_repo_clone_packed &&

	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_packed.git &&
	 git --bare repack &&
	 git --bare prune-packed) &&

	# By reset, we force git to retrieve the packed object
	(cd "$ROOT_PATH"/test_repo_clone_packed &&
	 git reset --hard HEAD^ &&
	 git remote rm origin &&
	 git reflog expire --expire=0 --all &&
	 git prune &&
	 valgrind git-http-push --force --verbose $HTTPD_URL/test_repo_packed.git master)

got 9d498b0bbc2a25438e2fbd19081948da86028c23
walk 9d498b0bbc2a25438e2fbd19081948da86028c23
got 50b820aea6d3503362343cdc0e699b760c700b2b
got 0c973ae9bd51902a28466f3850b543fa66a6aaf4
got e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
walk 0c973ae9bd51902a28466f3850b543fa66a6aaf4
got 146e9fd4040abc05619b6c07a3a23cba27a2c722
Initialized empty Git repository in /home/drizzd/fridge/linux/src/git/t/trash directory.t5540-http-push/test_repo_clone_packed/.git/
HEAD is now at 0c973ae initial
==== Memcheck, a memory error detector.
==== Copyright (C) 2002-2007, and GNU GPL'd, by Julian Seward et al.
==== Using LibVEX rev 1854, a library for dynamic binary translation.
==== Copyright (C) 2004-2007, and GNU GPL'd, by OpenWorks LLP.
==== Using valgrind-3.3.1-Debian, a dynamic binary instrumentation framework.
==== Copyright (C) 2000-2007, and GNU GPL'd, by Julian Seward et al.
==== For more details, rerun with: -v
==== 
==== Invalid read of size 1
====    at 0x409EBE: xml_entities (http-push.c:192)
====    by 0x40DE29: locking_available (http-push.c:1619)
====    by 0x40FBCF: main (http-push.c:2297)
====  Address 0x80b94e4 is 0 bytes after a block of size 44 alloc'd
====    at 0x4C2260E: malloc (vg_replace_malloc.c:207)
====    by 0x44C4E4: xmalloc (wrapper.c:20)
====    by 0x40FB4D: main (http-push.c:2286)
Getting pack list
Getting index for pack ecba592576b66d9aa805891d0a80a0133abd5f5d
Fetching remote heads...
  refs/
  refs/heads/
  fetch 9d498b0bbc2a25438e2fbd19081948da86028c23 for refs/heads/master
  refs/tags/
Fetching pack ecba592576b66d9aa805891d0a80a0133abd5f5d
 which contains 9d498b0bbc2a25438e2fbd19081948da86028c23
==== 
==== Invalid read of size 2
====    at 0x5ABFFE1: ftell (in /lib/libc-2.7.so)
====    by 0x409784: run_active_slot (http.c:536)
====    by 0x4099EF: finish_all_active_slots (http.c:607)
====    by 0x40F72E: run_request_queue (http-push.c:2179)
====    by 0x40FCB3: main (http-push.c:2325)
====  Address 0x817c688 is 0 bytes inside a block of size 568 free'd
====    at 0x4C2130F: free (vg_replace_malloc.c:323)
====    by 0x5ABEDA0: fclose (in /lib/libc-2.7.so)
====    by 0x40BC64: finish_request (http-push.c:824)
====    by 0x40A0F4: process_response (http-push.c:257)
====    by 0x4099C4: finish_active_slot (http.c:598)
====    by 0x4088E3: process_curl_messages (http.c:101)
====    by 0x409709: step_active_slots (http.c:512)
====    by 0x40975A: run_active_slot (http.c:533)
====    by 0x4099EF: finish_all_active_slots (http.c:607)
====    by 0x40F72E: run_request_queue (http-push.c:2179)
====    by 0x40FCB3: main (http-push.c:2325)
[...]
==== Invalid read of size 4
====    at 0x5AC00AC: ftell (in /lib/libc-2.7.so)
====    by 0x409784: run_active_slot (http.c:536)
====    by 0x4099EF: finish_all_active_slots (http.c:607)
====    by 0x40F72E: run_request_queue (http-push.c:2179)
====    by 0x40FCB3: main (http-push.c:2325)
====  Address 0x817c768 is 224 bytes inside a block of size 568 free'd
====    at 0x4C2130F: free (vg_replace_malloc.c:323)
====    by 0x5ABEDA0: fclose (in /lib/libc-2.7.so)
====    by 0x40BC64: finish_request (http-push.c:824)
====    by 0x40A0F4: process_response (http-push.c:257)
====    by 0x4099C4: finish_active_slot (http.c:598)
====    by 0x4088E3: process_curl_messages (http.c:101)
====    by 0x409709: step_active_slots (http.c:512)
====    by 0x40975A: run_active_slot (http.c:533)
====    by 0x4099EF: finish_all_active_slots (http.c:607)
====    by 0x40F72E: run_request_queue (http-push.c:2179)
====    by 0x40FCB3: main (http-push.c:2325)
updating 'refs/heads/master'
  from 9d498b0bbc2a25438e2fbd19081948da86028c23
  to   0c973ae9bd51902a28466f3850b543fa66a6aaf4
    done
Updating remote server info
==== 
==== ERROR SUMMARY: 46 errors from 42 contexts (suppressed: 8 from 1)
==== malloc/free: in use at exit: 201,408 bytes in 54 blocks.
==== malloc/free: 2,976 allocs, 2,922 frees, 1,512,372 bytes allocated.
==== For counts of detected errors, rerun with: -v
==== searching for pointers to 54 not-freed blocks.
==== checked 648,992 bytes.
==== 
==== LEAK SUMMARY:
====    definitely lost: 10,463 bytes in 26 blocks.
====      possibly lost: 0 bytes in 0 blocks.
====    still reachable: 190,945 bytes in 28 blocks.
====         suppressed: 0 bytes in 0 blocks.
==== Rerun with --leak-check=full to see details of leaked memory.
*   FIXED 6: http-push fetches packed objects

* fixed 1 known breakage(s)
* still have 1 known breakage(s)
* passed all remaining 5 test(s)
