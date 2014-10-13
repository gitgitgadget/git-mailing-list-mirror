From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Remove spurious 'no threads support' warnings
Date: Mon, 13 Oct 2014 12:54:52 -0700
Message-ID: <xmqqbnpf3fub.fsf@gitster.dls.corp.google.com>
References: <d2df2f619967ea7ba9625868b9c77d79a1190665.1413038338.git.etienne.buira@gmail.com>
	<8d057560e40fb5edaa3a32f204718c5e561a207a.1413038338.git.etienne.buira@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Etienne Buira <etienne.buira@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 21:55:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdlhs-0004Fj-NU
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 21:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbaJMTy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 15:54:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751207AbaJMTy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 15:54:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CD551674A;
	Mon, 13 Oct 2014 15:54:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uhPrmrQZAkhNyDt4hEY7LzXJEzQ=; b=DGdtax
	c6ULL1PFg6TE2UICwmKaDJ6AMstvvxuXFLjbd9h76ZAaNN0TnC37A8uNXP3duoMJ
	kGG60vVxcTRGD9x7gdSIR1O2CDkk6Yg69bBE1GoKVXHebuDiRvMhpX/WYlldQIqz
	MVEMafjj2v8YWvf2TSJdsxXssN07BfNJMXEYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BN9CpaZcLmugA0iDgfgHyln1gwZ1zkl9
	6mAJjjp4GWnIQcrb8ViryTvkxqrF5B/sNdzB9lI+PDS+AyPXNpwjTbxHJiV7vo5e
	/dlgLNTOe09CG9+lPYUZFpA4b56i17Zg94l7xTOrExW7tnZBnS2zIhTnXVQkkoUS
	CrKzyTN6WRk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 340B616748;
	Mon, 13 Oct 2014 15:54:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD91316747;
	Mon, 13 Oct 2014 15:54:53 -0400 (EDT)
In-Reply-To: <8d057560e40fb5edaa3a32f204718c5e561a207a.1413038338.git.etienne.buira@gmail.com>
	(Etienne Buira's message of "Sat, 11 Oct 2014 16:46:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CCB9A380-5312-11E4-8AEC-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Etienne Buira <etienne.buira@gmail.com> writes:

> Threads count being defaulted to 0 (autodetect), and --disable-pthreads
> build checking that thread count==1, there were spurious warnings about
> threads being ignored, despite not specified on command line/conf.
>
> Fixes tests 5521 and 5526 that were broken in --disable-pthreads builds
> because of those warnings.
>
> Signed-off-by: Etienne Buira <etienne.buira@gmail.com>
> ---

I am not sure if this is the right fix.

Shouldn't a --threads=0 from the command line (when there is a
pack.threads configuration hardcoding some number to override it)
give a chance to the auto detection codepath to ask online_cpus()
and receive 1 on NO_PTHREADS build to avoid triggering the same
warning you are squelching with this patch?

That is, something like this instead, perhaps?

-- >8 --
Subject: [PATCH] pack-objects: set number of threads before checking and warning

Under NO_PTHREADS build, we warn when delta_search_threads is not
set to 1, because that is the only sensible value on a single
threaded build.

However, the auto detection that kicks in when that variable is set
to 0 (e.g. there is no configuration variable or command line option,
or an explicit --threads=0 is given from the command line to override
the pack.threads configuration to force auto-detection) was not done
before the condition to issue this warning was tested.

Move the auto-detection code and place it at an appropriate spot.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c | 6 ++++--
 thread-utils.h         | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d391934..a715237 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1972,8 +1972,6 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 
 	init_threaded_search();
 
-	if (!delta_search_threads)	/* --threads=0 means autodetect */
-		delta_search_threads = online_cpus();
 	if (delta_search_threads <= 1) {
 		find_deltas(list, &list_size, window, depth, processed);
 		cleanup_threaded_search();
@@ -2685,6 +2683,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		pack_compression_level = Z_DEFAULT_COMPRESSION;
 	else if (pack_compression_level < 0 || pack_compression_level > Z_BEST_COMPRESSION)
 		die("bad pack compression level %d", pack_compression_level);
+
+	if (!delta_search_threads)	/* --threads=0 means autodetect */
+		delta_search_threads = online_cpus();
+
 #ifdef NO_PTHREADS
 	if (delta_search_threads != 1)
 		warning("no threads support, ignoring --threads");
diff --git a/thread-utils.h b/thread-utils.h
index 6fb98c3..d9a769d 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -7,5 +7,9 @@
 extern int online_cpus(void);
 extern int init_recursive_mutex(pthread_mutex_t*);
 
+#else
+
+#define online_cpus() 1
+
 #endif
 #endif /* THREAD_COMPAT_H */
-- 
2.1.2-468-g1a77c5b
