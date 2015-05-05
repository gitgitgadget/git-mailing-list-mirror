From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prefix_path(): Unconditionally free result of prefix_path
Date: Tue, 05 May 2015 10:36:38 -0700
Message-ID: <xmqqr3qvdizd.fsf@gitster.dls.corp.google.com>
References: <1430766714-22368-1-git-send-email-sbeller@google.com>
	<20150505032158.GA23587@peff.net>
	<CAGZ79kZjeG8UG5ALE-KSO52fD5gJk4xks=VtSV9bHQVA=ST+5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 05 19:36:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypgm5-000471-S6
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 19:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762180AbbEERgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 13:36:48 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762162AbbEERgr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 13:36:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07B9A4ED7E;
	Tue,  5 May 2015 13:36:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0BT/uNBvQcn3I3fK4GXzMGhdkBY=; b=yhW3Jc
	WDIfNZbgZQZk+MAtIS2HmxwNcZgArsAoAELX6doho9jAV5nq+/o3imR2R2fR5PFY
	Yh6tf92rM17O78p1F06JA4KbDoL49KbLXdG7i6FJ9UtK4RmnsqC8UeJqE5garSl2
	LKQm40bS/HzH0WrH/49pQitcKnevaJ574J0ig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mvY/kSkyaqyGFAR+MUuN33Ppg5bjOx4k
	L0/717805/Xzu91Fotk4jyeXT9dsNqtjHLte7+/3LaO4sQjVv6MV2a2TIui+UHUE
	uCLpfKQELOtyyqNZd47ka/ZssdhfViX5M960tZX6mKwvv1w50P1bYbMZtliwXtbK
	7R7h0UxIcOg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E13E44ED7D;
	Tue,  5 May 2015 13:36:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 123C44ED7A;
	Tue,  5 May 2015 13:36:40 -0400 (EDT)
In-Reply-To: <CAGZ79kZjeG8UG5ALE-KSO52fD5gJk4xks=VtSV9bHQVA=ST+5Q@mail.gmail.com>
	(Stefan Beller's message of "Tue, 5 May 2015 09:28:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 499B1A48-F34D-11E4-B511-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268401>

Stefan Beller <sbeller@google.com> writes:

>> Should we also squash in these sites? I think they are adequately
>> covered under the proposed log message.
>
> That sounds good to me.
>>
>> Found by grepping for prefix_path calls. The only remainders are:
>>
>>   1. in blame, we assign the result to a const char that may also point
>>      straight into to argv, but we never actually free either way

The return value from add_prefix() that is what prefix_path()
returned eventually becomes scoreboard.path that needs to be kept
during the lifetime of the process, and I think there isn't much
point doing the "free() immediately before exiting".

>>   2. test-path-utils does not free at all, but we probably don't care
>>      either way

Anyway, here is what I'd queue for now.

-- >8 --
From: Stefan Beller <sbeller@google.com>
Date: Mon, 4 May 2015 12:11:54 -0700
Subject: [PATCH] prefix_path(): unconditionally free results in the callers

As of d089ebaa (setup: sanitize absolute and funny paths in
get_pathspec(), 2008-01-28), prefix_path() always returns a
newly allocated string, so callers should free its result.

Additionally, drop the const from variables to which the result of
the prefix_path() is assigned, so they can be free()'d without
having to cast-away the constness.

Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout-index.c | 10 ++++------
 builtin/update-index.c   | 13 ++++++-------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 9ca2da1..8028c37 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -241,7 +241,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	/* Check out named files first */
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
-		const char *p;
+		char *p;
 
 		if (all)
 			die("git checkout-index: don't mix '--all' and explicit filenames");
@@ -249,8 +249,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			die("git checkout-index: don't mix '--stdin' and explicit filenames");
 		p = prefix_path(prefix, prefix_length, arg);
 		checkout_file(p, prefix);
-		if (p < arg || p > arg + strlen(arg))
-			free((char *)p);
+		free(p);
 	}
 
 	if (read_from_stdin) {
@@ -260,7 +259,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			die("git checkout-index: don't mix '--all' and '--stdin'");
 
 		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
-			const char *p;
+			char *p;
 			if (line_termination && buf.buf[0] == '"') {
 				strbuf_reset(&nbuf);
 				if (unquote_c_style(&nbuf, buf.buf, NULL))
@@ -269,8 +268,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
 			checkout_file(p, prefix);
-			if (p < buf.buf || p > buf.buf + buf.len)
-				free((char *)p);
+			free(p);
 		}
 		strbuf_release(&nbuf);
 		strbuf_release(&buf);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6271b54..0665b31 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -532,10 +532,9 @@ static int do_unresolve(int ac, const char **av,
 
 	for (i = 1; i < ac; i++) {
 		const char *arg = av[i];
-		const char *p = prefix_path(prefix, prefix_length, arg);
+		char *p = prefix_path(prefix, prefix_length, arg);
 		err |= unresolve_one(p);
-		if (p < arg || p > arg + strlen(arg))
-			free((char *)p);
+		free(p);
 	}
 	return err;
 }
@@ -871,14 +870,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		case PARSE_OPT_DONE:
 		{
 			const char *path = ctx.argv[0];
-			const char *p;
+			char *p;
 
 			setup_work_tree();
 			p = prefix_path(prefix, prefix_length, path);
 			update_one(p);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
-			free((char *)p);
+			free(p);
 			ctx.argc--;
 			ctx.argv++;
 			break;
@@ -909,7 +908,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 		setup_work_tree();
 		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
-			const char *p;
+			char *p;
 			if (line_termination && buf.buf[0] == '"') {
 				strbuf_reset(&nbuf);
 				if (unquote_c_style(&nbuf, buf.buf, NULL))
@@ -920,7 +919,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			update_one(p);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
-			free((char *)p);
+			free(p);
 		}
 		strbuf_release(&nbuf);
 		strbuf_release(&buf);
-- 
2.4.0-311-gf1d9b8d
