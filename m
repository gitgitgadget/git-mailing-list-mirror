Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFAD02036B
	for <e@80x24.org>; Wed,  4 Oct 2017 04:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbdJDErc (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 00:47:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52556 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750909AbdJDErb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 00:47:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30C0FA09E9;
        Wed,  4 Oct 2017 00:47:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yb9sc0oLkI2ZfjLuDrwGjdsJHBA=; b=idbgzo
        ectYuPnMNVmLkZ7mds8rOX0Bu3ulcodSPfw030bYWaiMYdbFh4K6rfdAWh08ucTi
        cMdh3DX9zbJB/4gRaTtxFK+yNcnqO1RCXzPcGsorMJ3w64o82xaD4GDqzWtqzXg7
        +XBY0l3Q1q/YONPuRkTI8Ac9rfXDTS2k7+EP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SG1U6iv8TWL8uNoiLVXxdY+owDWcg41Q
        rQUX9ulVaLY5KYYQMANnz90befEkewepJKlucWSg077B+UWXz0FW+/t6CIHzSmX7
        u/GKGHY2sl/x+/ifhuW6TlDKgYu80cFAGnBQ4bhk6P2aZ8BsNsRGyQP+YNiJz3vt
        ru2deXyWCl0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27CE0A09E8;
        Wed,  4 Oct 2017 00:47:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 967DBA09E6;
        Wed,  4 Oct 2017 00:47:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Thomas Gummerer <t.gummerer@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] path.c: fix uninitialized memory access
References: <20171003195713.13395-1-t.gummerer@gmail.com>
        <20171003195713.13395-2-t.gummerer@gmail.com>
        <20171003224501.GD19555@aiede.mtv.corp.google.com>
        <20171003233040.2ws6kny3e4kypfub@sigill.intra.peff.net>
        <20171003233706.GH19555@aiede.mtv.corp.google.com>
Date:   Wed, 04 Oct 2017 13:47:29 +0900
In-Reply-To: <20171003233706.GH19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 3 Oct 2017 16:37:06 -0700")
Message-ID: <xmqqfuazecym.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2123D882-A8BF-11E7-AEDB-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>> On Tue, Oct 03, 2017 at 03:45:01PM -0700, Jonathan Nieder wrote:
>
>>> In other words, an alternative fix would be
>>> 
>>> 	if (*path == '.' && path[1] == '/') {
>>> 		...
>>> 	}
>>> 
>>> which would not require passing in 'len' or switching to index-based
>>> arithmetic.  I think I prefer it.  What do you think?
>>
>> Yes, I think that approach is much nicer. I think you could even use
>> skip_prefix. Unfortunately you have to play a few games with const-ness,
>> but I think the resulting signature for cleanup_path() is an
>> improvement:

To tie the loose end, here is what I'll queue.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Tue, 3 Oct 2017 19:30:40 -0400
Subject: [PATCH] path.c: fix uninitialized memory access

In cleanup_path we're passing in a char array, run a memcmp on it, and
run through it without ever checking if something is in the array in the
first place.  This can lead us to access uninitialized memory, for
example in t5541-http-push-smart.sh test 7, when run under valgrind:

==4423== Conditional jump or move depends on uninitialised value(s)
==4423==    at 0x242FA9: cleanup_path (path.c:35)
==4423==    by 0x242FA9: mkpath (path.c:456)
==4423==    by 0x256CC7: refname_match (refs.c:364)
==4423==    by 0x26C181: count_refspec_match (remote.c:1015)
==4423==    by 0x26C181: match_explicit_lhs (remote.c:1126)
==4423==    by 0x26C181: check_push_refs (remote.c:1409)
==4423==    by 0x2ABB4D: transport_push (transport.c:870)
==4423==    by 0x186703: push_with_options (push.c:332)
==4423==    by 0x18746D: do_push (push.c:409)
==4423==    by 0x18746D: cmd_push (push.c:566)
==4423==    by 0x1183E0: run_builtin (git.c:352)
==4423==    by 0x11973E: handle_builtin (git.c:539)
==4423==    by 0x11973E: run_argv (git.c:593)
==4423==    by 0x11973E: main (git.c:698)
==4423==  Uninitialised value was created by a heap allocation
==4423==    at 0x4C2CD8F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==4423==    by 0x4C2F195: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==4423==    by 0x2C196B: xrealloc (wrapper.c:137)
==4423==    by 0x29A30B: strbuf_grow (strbuf.c:66)
==4423==    by 0x29A30B: strbuf_vaddf (strbuf.c:277)
==4423==    by 0x242F9F: mkpath (path.c:454)
==4423==    by 0x256CC7: refname_match (refs.c:364)
==4423==    by 0x26C181: count_refspec_match (remote.c:1015)
==4423==    by 0x26C181: match_explicit_lhs (remote.c:1126)
==4423==    by 0x26C181: check_push_refs (remote.c:1409)
==4423==    by 0x2ABB4D: transport_push (transport.c:870)
==4423==    by 0x186703: push_with_options (push.c:332)
==4423==    by 0x18746D: do_push (push.c:409)
==4423==    by 0x18746D: cmd_push (push.c:566)
==4423==    by 0x1183E0: run_builtin (git.c:352)
==4423==    by 0x11973E: handle_builtin (git.c:539)
==4423==    by 0x11973E: run_argv (git.c:593)
==4423==    by 0x11973E: main (git.c:698)
==4423==

Avoid this by using skip_prefix(), which knows not to go beyond the
end of the string.

Reported-by: Thomas Gummerer <t.gummerer@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 path.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/path.c b/path.c
index e50d2befcf..2fecf854fe 100644
--- a/path.c
+++ b/path.c
@@ -33,11 +33,10 @@ static struct strbuf *get_pathname(void)
 	return sb;
 }
 
-static char *cleanup_path(char *path)
+static const char *cleanup_path(const char *path)
 {
 	/* Clean it up */
-	if (!memcmp(path, "./", 2)) {
-		path += 2;
+	if (skip_prefix(path, "./", &path)) {
 		while (*path == '/')
 			path++;
 	}
@@ -46,7 +45,7 @@ static char *cleanup_path(char *path)
 
 static void strbuf_cleanup_path(struct strbuf *sb)
 {
-	char *path = cleanup_path(sb->buf);
+	const char *path = cleanup_path(sb->buf);
 	if (path > sb->buf)
 		strbuf_remove(sb, 0, path - sb->buf);
 }
@@ -63,7 +62,7 @@ char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 		strlcpy(buf, bad_path, n);
 		return buf;
 	}
-	return cleanup_path(buf);
+	return (char *)cleanup_path(buf);
 }
 
 static int dir_prefix(const char *buf, const char *dir)
-- 
2.14.2-889-gd2948f6aa6

