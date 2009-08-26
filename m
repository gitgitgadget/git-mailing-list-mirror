From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Wed, 26 Aug 2009 16:39:10 -0700
Message-ID: <7v1vmycfhd.fsf@alter.siamese.dyndns.org>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com>
 <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com>
 <20090825184525.GC23731@coredump.intra.peff.net>
 <7vprajmp16.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Tom Preston-Werner <tom@mojombo.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Tom Werner <mojombo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 01:39:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgS5Z-0001q7-GK
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 01:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbZHZXj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 19:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752112AbZHZXj0
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 19:39:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42734 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZHZXj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 19:39:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2AA9B38CAF;
	Wed, 26 Aug 2009 19:39:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yPfU93dWhkDuuVVfDkjQZ44VsTE=; b=SN6zu1
	RPVBNbAssCDcAAd9yGNDNX2ycdYVB585eOXO9snNKfrOjDzaay4fBC/JYH+fYBj4
	9gnEDAUKlYwPlY7a+kWlhvQ3q2rrnZPJStfnlOInQrIwFNnpn8irw5TdOJaP1/iN
	tWF3ZHcNMypFscUcCiFgJ8fjpDmgi+cqVL5DE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YBO9Nb/HpLq37gz50FzVGrJTxMLobnvA
	9C603Glb/PXW2sX4thngs9XFmEPpuHIPpFPkaAda7ejDbApmRha+bubOkjhU5Fxw
	iMfYInMGnTr7ouN6BZBfArWBMLwxlUPwi+KPKlBfmAnzFoXFEVQhuDBaZs0pXJgg
	NTc3JiRVvy4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA48138CAD;
	Wed, 26 Aug 2009 19:39:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6F93D38CAC; Wed, 26 Aug 2009
 19:39:12 -0400 (EDT)
In-Reply-To: <7vprajmp16.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 25 Aug 2009 16\:50\:29 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE44D8AA-9299-11DE-A0FD-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127120>

Junio C Hamano <gitster@pobox.com> writes:

>> Is there any other information that might be useful to other non-GitHub
>> users of the hook? The only thing I can think of is the list of refs
>> that were fetched.
>
> I do not think that information is available.  "want" will tell you what
> object they want, but that does not necessarily uniquey translate to a
> ref.
>
> If we are allowed to talk about asking for the moon, and if one of the
> primary reason for this new hook is statistics, it would be useful to see
> the number of bytes given, where the fetch-pack came from, and if we are
> using git-daemon virtual hosting which of our domain served the request.

I briefly looked at upload-pack.c.

As I said, the names of the refs asked is not available but in that file,
create_pack_file() should be able to gather transfer statistics (timeing
and bytes transferred).  It also has access to the want_obj[]/have_obj[]
array, so it should be able to keep the rev-list parameters to be fed to
the hook if it wanted to (and with that information you could recreate the
exact pack data later if necessary).

And want_obj[]/have_obj[] information is much more useful than a crude
"fetch/clone" distinction.  You can not just tell if the clients have
nothing, but how stale they are.

So at a minimum, if this is primarily meant as a statistics hook, I would
suggest the hook not to take _any_ argument, but is fed the information
from its command line in the following form, one piece of information per
line, from the very beginning:

	want 40-byte SHA-1	- what were in want_obj[] array
	have 40-byte SHA-1	- what were in have_obj[] array


As long as the hook scripts are written to ignore lines they do not
understand, in later rounds, we should also be able to feed two more
pieces of information with minimum modification to create_pack_file():

	time float	- number of seconds create_pack_file spent,
	size decimal	- number of bytes transferred

Here is an illustration patch.

 upload-pack.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 4d8be83..69a6f46 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -141,8 +141,60 @@ static int do_rev_list(int fd, void *create_full_pack)
 	return 0;
 }
 
+static int feed_obj_to_hook(const char *label, struct object_array *oa, int i, int fd)
+{
+	int cnt;
+	char buf[512];
+
+	cnt = sprintf(buf, "%s %s\n", label,
+		      sha1_to_hex(oa->objects[i].item->sha1));
+	return write_in_full(fd, buf, cnt) != cnt;
+}
+
+static int run_post_upload_pack_hook(size_t total, struct timeval *tv)
+{
+	const char *argv[2];
+	struct child_process proc;
+	int err, i;
+	int cnt;
+	char buf[512];
+
+	argv[0] = "hooks/post-upload-pack";
+	argv[1] = NULL;
+
+	if (access(argv[0], X_OK) < 0)
+		return 0;
+
+	memset(&proc, 0, sizeof(proc));
+	proc.argv = argv;
+	proc.in = -1;
+	proc.stdout_to_stderr = 1;
+	err = start_command(&proc);
+	if (err)
+		return err;
+	for (i = 0; !err && i < want_obj.nr; i++)
+		err |= feed_obj_to_hook("want", &want_obj, i, proc.in);
+	for (i = 0; !err && i < have_obj.nr; i++)
+		err |= feed_obj_to_hook("have", &have_obj, i, proc.in);
+	if (!err) {
+		cnt = sprintf(buf, "time %ld.%06ld\n",
+			      (long)tv->tv_sec, (long)tv->tv_usec);
+		err |= (write_in_full(proc.in, buf, cnt) != cnt);
+	}
+	if (!err) {
+		cnt = sprintf(buf, "size %ld\n", (long)total);
+		err |= (write_in_full(proc.in, buf, cnt) != cnt);
+	}
+	if (close(proc.in))
+		err = 1;
+	if (finish_command(&proc))
+		err = 1;
+	return err;
+}
+
 static void create_pack_file(void)
 {
+	struct timeval start_tv, tv;
 	struct async rev_list;
 	struct child_process pack_objects;
 	int create_full_pack = (nr_our_refs == want_obj.nr && !have_obj.nr);
@@ -150,10 +202,12 @@ static void create_pack_file(void)
 	char abort_msg[] = "aborting due to possible repository "
 		"corruption on the remote side.";
 	int buffered = -1;
-	ssize_t sz;
+	ssize_t sz, total_sz;
 	const char *argv[10];
 	int arg = 0;
 
+	gettimeofday(&start_tv, NULL);
+	total_sz = 0;
 	if (shallow_nr) {
 		rev_list.proc = do_rev_list;
 		rev_list.data = 0;
@@ -262,7 +316,7 @@ static void create_pack_file(void)
 			sz = xread(pack_objects.out, cp,
 				  sizeof(data) - outsz);
 			if (0 < sz)
-					;
+				total_sz += sz;
 			else if (sz == 0) {
 				close(pack_objects.out);
 				pack_objects.out = -1;
@@ -314,6 +368,16 @@ static void create_pack_file(void)
 	}
 	if (use_sideband)
 		packet_flush(1);
+
+	gettimeofday(&tv, NULL);
+	tv.tv_sec -= start_tv.tv_sec;
+	if (tv.tv_usec < start_tv.tv_usec) {
+		tv.tv_sec--;
+		tv.tv_usec += 1000000;
+	}
+	tv.tv_usec -= start_tv.tv_usec;
+	if (run_post_upload_pack_hook(total_sz, &tv))
+		warning("post-upload-hook failed");
 	return;
 
  fail:
