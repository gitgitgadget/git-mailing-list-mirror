From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: regression in multi-threaded git-pack-index
Date: Tue, 19 Mar 2013 17:11:22 +0100
Message-ID: <87obef2wut.fsf@pctrast.inf.ethz.ch>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
	<87hak74cse.fsf@pctrast.inf.ethz.ch>
	<87620n4clo.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Zager <szager@google.com>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 17:11:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHz8k-0006Dl-20
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 17:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656Ab3CSQL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 12:11:26 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:42808 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932436Ab3CSQLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 12:11:25 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 17:11:18 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.171.78) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 17:11:22 +0100
In-Reply-To: <87620n4clo.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
	"Tue, 19 Mar 2013 16:45:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.171.78]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218535>

Thomas Rast <trast@student.ethz.ch> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>>   (gdb) r index-pack --keep --stdin -v --pack_header=2,50757 <borked
>>   Starting program: /Users/trast/.local/bin/git index-pack --keep
>> --stdin -v --pack_header=2,50757 <borked
>>   Reading symbols for shared libraries +++........................ done
>>   Receiving objects: 100% (50757/50757), 24.52 MiB | 13.06 MiB/s, done.
>>   Resolving deltas:  25% (10568/42272)   
>>   Program received signal EXC_BAD_ACCESS, Could not access memory.
>>   Reason: KERN_PROTECTION_FAILURE at address: 0x000000014484dfe8
>>   [Switching to process 96573 thread 0x10f]
>>   0x000000010017ee20 in use_pack (p=0x100500f30, w_cursor=0x14484e1a0,
>> offset=69638148, left=0x0) at sha1_file.c:866
>>   866             if (!win || !in_window(win, offset)) {
>>
>> This seems to be a SIGBUS triggered by stack overflow, largely based on
>> the observation that
>>
>>   (gdb) p &p
>>   $6 = (struct packed_git **) 0x144748058
>
> Actually, scratch that; the stack depth is the same no matter what
> ulimits I put (up to 64MB).

Actually scratch that again.  It *is* a stack overflow, except that this
is a thread stack, for which the OS X defaults are 512kB apparently, as
opposed to 2MB on linux.

To wit:

  (gdb) p &p
  $11 = (struct packed_git **) 0x14484e058
  (gdb) bt -5
  #4093 0x0000000100054947 in find_unresolved_deltas (base=0x144e00000) at index-pack.c:930
  #4094 0x0000000100054a79 in resolve_base (obj=0x1011b08c0) at index-pack.c:961
  #4095 0x0000000100054ba5 in threaded_second_pass (data=0x100537dd0) at index-pack.c:984
  #4096 0x00007fff8ec8b8bf in _pthread_start ()
  #4097 0x00007fff8ec8eb75 in thread_start ()
  (gdb) f 4094
  #4094 0x0000000100054a79 in resolve_base (obj=0x1011b08c0) at index-pack.c:961
  961             find_unresolved_deltas(base_obj);
  (gdb) p &obj
  $12 = (struct object_entry **) 0x1448cdec8
  (gdb) p 0x14484e058-0x1448cdec8
  $13 = -523888
  (gdb) p 512*1024
  $14 = 524288

And indeed the following patch fixes it.  Sounds like the delta
unpacking needs a rewrite to support stackless operation.  Sigh.

diff --git i/builtin/index-pack.c w/builtin/index-pack.c
index 6be99e2..f73291f 100644
--- i/builtin/index-pack.c
+++ w/builtin/index-pack.c
@@ -1075,13 +1075,17 @@ static void resolve_deltas(void)
 	nr_dispatched = 0;
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
 		init_thread();
+		pthread_attr_t attr;
+		pthread_attr_init(&attr);
+		pthread_attr_setstacksize(&attr, 2*1024*1024);
 		for (i = 0; i < nr_threads; i++) {
-			int ret = pthread_create(&thread_data[i].thread, NULL,
+			int ret = pthread_create(&thread_data[i].thread, &attr,
 						 threaded_second_pass, thread_data + i);
 			if (ret)
 				die(_("unable to create thread: %s"),
 				    strerror(ret));
 		}
+		pthread_attr_destroy(&attr);
 		for (i = 0; i < nr_threads; i++)
 			pthread_join(thread_data[i].thread, NULL);
 		cleanup_thread();


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
