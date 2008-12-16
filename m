From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: don't use too many threads with few
 objects
Date: Mon, 15 Dec 2008 17:15:44 -0800
Message-ID: <7vy6ygudhb.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0812111524370.14328@xanadu.home>
 <20081213133238.GA6718@sigill.intra.peff.net>
 <alpine.LFD.2.00.0812131456040.30035@xanadu.home>
 <e2b179460812151038y5a39b33cv1d7b41faf10563e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mike Ralphson" <mike.ralphson@gmail.com>,
	"Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 16 02:17:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCOYk-0004TC-2X
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 02:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbYLPBP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 20:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbYLPBP4
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 20:15:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbYLPBP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 20:15:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A1561A5C1;
	Mon, 15 Dec 2008 20:15:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2EFC81A5AA; Mon,
 15 Dec 2008 20:15:45 -0500 (EST)
In-Reply-To: <e2b179460812151038y5a39b33cv1d7b41faf10563e@mail.gmail.com>
 (Mike Ralphson's message of "Mon, 15 Dec 2008 18:38:18 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 14D67A68-CB0F-11DD-A4A9-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103227>

"Mike Ralphson" <mike.ralphson@gmail.com> writes:

> 2008/12/13 Nicolas Pitre <nico@cam.org>
>>
>> If there are few objects to deltify, they might be split amongst threads
>> so that there is simply no other objects left to delta against within
>> the same thread.  Let's use the same 2*window treshold as used for the
>> final load balancing to allow extra threads to be created.
>>
>> This fixes the benign t5300 test failure.
>
> Even with this I'm seeing failures in t5302 which I think are probably
> related to 43cc2b42
> ...
> *   ok 2: pack-objects with index version 1
>
> * expecting success: pack2=$(git pack-objects --index-version=2 test-2
> <obj-list) &&
>      git verify-pack -v "test-2-${pack2}.pack"
> 0106e17481932f5c223fafadc1d26abc6adf40d6 blob   57 90 850531 1
> 69e0b8ef8cda369575b6801c6ed47daf09aa3c62
> ...
> fff3a3a92d2268a464dbdcd00fc055885ee3cba9 blob   8196 8210 187404
> chain length = 1: 109 objects
> chain length = 2: 10 objects
> chain length = 3: 10 objects
> chain length = 4: 10 objects
> chain length = 5: 10 objects
> chain length = 6: 10 objects
> chain length = 7: 10 objects
> chain length = 8: 10 objects
> chain length = 9: 9 objects
> test-2-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack: ok
> *   ok 3: pack-objects with index version 2
>
> * expecting success: cmp "test-1-${pack1}.pack" "test-2-${pack2}.pack"
> test-1-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack
> test-2-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack differ: char
> 10236, line 32
> * FAIL 4: both packs should be identical
> 	cmp "test-1-${pack1}.pack" "test-2-${pack2}.pack"

This is interesting.  The same set of objects are packed with the
identical list of objects stored in obj-list and the only difference
between test #2 and test #3 are the format of the .idx file they produce.
Yet they are producing different .pack file?

And this does not fail with 'master' on Mike's AIX, but with 'next' that
has the threaded delta search.

Since the list of objects packed (obj-list in the test script) contains
302 objects, which is way bigger than the window size, I can understand
that packing with or without threading would produce different results.

Even though depending on the timings of how worker threads complete
assigned work and grab more work for them, two otherwise identical runs,
even with the same set of parameters, could assign different set of
objects to different threads.  But as far as I can see, the same set of
objects should go to the same chunk, and the only difference should be
which thread gets which chunk, and I do not see how that could affect the
outcome.  Puzzled...

Perhaps the two runs are seeing different number of CPUs (hence threads)
available?  That would then change the distribution of the work itself
(i.e. what slice of obj-list goes as a single chunk to be processed) and
would affect the outcome.

Does the second test this patch adds fail?

 t/t5302-pack-index.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git i/t/t5302-pack-index.sh w/t/t5302-pack-index.sh
index 884e242..bd5db03 100755
--- i/t/t5302-pack-index.sh
+++ w/t/t5302-pack-index.sh
@@ -39,6 +39,17 @@ test_expect_success \
      git verify-pack -v "test-1-${pack1}.pack"'
 
 test_expect_success \
+    'pack-objects with index version 1 (again)' \
+    'pack1=$(git pack-objects --index-version=1 test-1again <obj-list) &&
+     git verify-pack -v "test-1again-${pack1}.pack"'
+
+test_expect_success 'both should match' '
+	cmp "test-1-${pack1}.pack" "test-1again-${pack1}.pack"
+'
+
+exit
+
+test_expect_success \
     'pack-objects with index version 2' \
     'pack2=$(git pack-objects --index-version=2 test-2 <obj-list) &&
      git verify-pack -v "test-2-${pack2}.pack"'
