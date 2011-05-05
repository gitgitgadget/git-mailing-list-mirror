From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Intermittent Failures in t1450-fsck (Bisected)
Date: Thu, 5 May 2011 17:07:54 -0400
Message-ID: <1A288BE9-F001-4CAD-8A89-4B4D6F0F246B@silverinsanity.com>
References: <115C364B-E910-4A9C-949E-3B10E5E6116C@silverinsanity.com> <2838BCC7-FB14-401B-9498-D0FB78C98D91@silverinsanity.com> <20110505093226.GA29595@sigill.intra.peff.net> <60194977-A4A9-4E18-9878-C1CDE77B75C2@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:08:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI5mo-0000Uw-9n
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 23:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab1EEVId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 17:08:33 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38668 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab1EEVIc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 17:08:32 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id EE9791FFC134; Thu,  5 May 2011 21:08:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id E57EC1FFC0F6;
	Thu,  5 May 2011 21:07:56 +0000 (UTC)
In-Reply-To: <60194977-A4A9-4E18-9878-C1CDE77B75C2@silverinsanity.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172915>


On May 5, 2011, at 4:04 PM, Brian Gernhardt wrote:

> On May 5, 2011, at 5:32 AM, Jeff King wrote:
> 
>> Given that the problem seems racy and intermittent, have you tried
>> running under valgrind?
> 
> This is on my OS X laptop and last I knew valgrind was very buggy on OS X, so I've never tried it.  I'll install it now and see if I can get anything useful out of it.

I will note the test _reliably_ fails when run in parallel with other tests.

Under valgrind I get the following error.  I will note that attempting to run the full test suite with valgrind gives lots of similar errors in many tests.  (All conditional jump in deflate, allocated in write_loose_object.)

==14187== Conditional jump or move depends on uninitialised value(s)
==14187==    at 0x100209B3B: deflateEnd (in /usr/lib/libz.1.2.3.dylib)
==14187==    by 0x10020ABF6: deflateSetDictionary (in /usr/lib/libz.1.2.3.dylib)
==14187==    by 0x10020B914: deflate (in /usr/lib/libz.1.2.3.dylib)
==14187==    by 0x1000FA631: write_loose_object (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x1000FA8C8: write_sha1_file (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x1000FACFB: index_mem (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x1000FAE95: index_fd (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x100038258: hash_fd (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x1000386AA: cmd_hash_object (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x1000016BC: run_builtin (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x10000186E: handle_internal_command (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x10000195F: run_argv (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==  Uninitialised value was created by a heap allocation
==14187==    at 0x1001F5345: malloc (vg_replace_malloc.c:236)
==14187==    by 0x10020A0FB: deflateInit2_ (in /usr/lib/libz.1.2.3.dylib)
==14187==    by 0x10020A264: deflateInit_ (in /usr/lib/libz.1.2.3.dylib)
==14187==    by 0x1000FA588: write_loose_object (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x1000FA8C8: write_sha1_file (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x1000FACFB: index_mem (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x1000FAE95: index_fd (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x100038258: hash_fd (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x1000386AA: cmd_hash_object (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x1000016BC: run_builtin (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x10000186E: handle_internal_command (in /Users/brian/dev/git/t/valgrind/../../git)
==14187==    by 0x10000195F: run_argv (in /Users/brian/dev/git/t/valgrind/../../git)
==14187== 
{
   <insert_a_suppression_name_here>
   Memcheck:Cond
   fun:deflateEnd
   fun:deflateSetDictionary
   fun:deflate
   fun:write_loose_object
   fun:write_sha1_file
   fun:index_mem
   fun:index_fd
   fun:hash_fd
   fun:cmd_hash_object
   fun:run_builtin
   fun:handle_internal_command
   fun:run_argv
}
