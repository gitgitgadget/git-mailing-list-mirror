From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] push: old receive-pack does not understand --quiet
Date: Sun, 04 Sep 2011 20:01:22 -0700
Message-ID: <7vmxejy9od.fsf@alter.siamese.dyndns.org>
References: <20110903105723.GA16304@tin.tmux.org>
 <1315067656-2846-1-git-send-email-drizzd@aon.at>
 <1315067656-2846-4-git-send-email-drizzd@aon.at>
 <7vy5y3yb6x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, tobiasu@tmux.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 05:01:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0PRM-0004e7-47
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 05:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356Ab1IEDBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 23:01:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47097 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229Ab1IEDBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 23:01:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E86434A0F;
	Sun,  4 Sep 2011 23:01:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cZVkseSI62OqngYf8YHe/XzSNmQ=; b=bK5mIH
	vWPJENG5EOuSTykAh9hDVoZWhYLdHwYpA84oWVH6Zpe/FpUpHJaoIbeV0jvzl9Br
	1rpWhu7sJ0f28/jIsNen8pPGsd9C7jccpAx3XbmBJKYzKQpBFzjPFRGShqTRrTDW
	qntdaaTDwR5CFIULMaMZL0+ac8BAIzDkbpSP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wd36NInZCbgeE6le5y/hoY8s9rmiJ4Vy
	8BLrkoozFYSfn0R/0eQDtld6gPrmnn2ID5N/SjBBlxxO2CgI39ABHRrwv6nKtSPH
	WoWeBZIsxGv7I51XoKx+9Zw76hC2ACJ2xzNuzeuFjfg2s0HEYDcYg02fXoaFmqiS
	kUm8DJTHzu0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF5104A0E;
	Sun,  4 Sep 2011 23:01:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10E1F4A0A; Sun,  4 Sep 2011
 23:01:23 -0400 (EDT)
In-Reply-To: <7vy5y3yb6x.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 04 Sep 2011 19:28:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56EAAD46-D76B-11E0-B284-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180714>

Junio C Hamano <gitster@pobox.com> writes:

> Clemens Buchacher <drizzd@aon.at> writes:
> ...
>> @@ -636,6 +637,8 @@ static struct command *read_head_info(void)
>>  				report_status = 1;
>>  			if (strstr(refname + reflen + 1, "side-band-64k"))
>>  				use_sideband = LARGE_PACKET_MAX;
>> +			if (strstr(refname + reflen + 1, "quiet"))
>> +				quiet = 1;
>
> Side note.
>
> We may want to make sure that this is not part of a different token word
> (if we knew better, we would have written the other side so that we can
> just test against " quiet ", but that is not possible, sigh...).

... but we can do this.

-- >8 --
Subject: [PATCH] server_supports(): parse feature list more carefully

We have been carefully choosing feature names used in the protocol
extensions so that the vocabulary does not contain a word that is a
substring of another word, so it is not a real problem, but we have
recently added "quiet" feature word, which would mean we cannot later
add some other word with "quiet" (e.g. "quiet-push"), which is awkward.

Let's make sure that we can eventually be able to do so by teaching the
clients and servers that feature words consist of non whitespace
letters. This parser also allows us to later add features with parameters
e.g. "feature=1.5" (parameter values need to be quoted for whitespaces,
but we will worry about the detauls when we do introduce them).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c |    7 ++++---
 cache.h                |    1 +
 connect.c              |   23 +++++++++++++++++++++--
 upload-pack.c          |   22 +++++++++++++---------
 4 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b71a1ca..927f307 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -600,11 +600,12 @@ static struct command *read_head_info(void)
 		refname = line + 82;
 		reflen = strlen(refname);
 		if (reflen + 82 < len) {
-			if (strstr(refname + reflen + 1, "report-status"))
+			const char *feature_list = refname + reflen + 1;
+			if (parse_feature_request(feature_list, "report-status"))
 				report_status = 1;
-			if (strstr(refname + reflen + 1, "side-band-64k"))
+			if (parse_feature_request(feature_list, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
-			if (strstr(refname + reflen + 1, "quiet"))
+			if (parse_feature_request(feature_list, "quiet"))
 				quiet = 1;
 		}
 		cmd = xcalloc(1, sizeof(struct command) + len - 80);
diff --git a/cache.h b/cache.h
index e11cf6a..2933d04 100644
--- a/cache.h
+++ b/cache.h
@@ -996,6 +996,7 @@ struct extra_have_objects {
 };
 extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags, struct extra_have_objects *);
 extern int server_supports(const char *feature);
+extern const char *parse_feature_request(const char *features, const char *feature);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
diff --git a/connect.c b/connect.c
index 2119c3f..2184fd8 100644
--- a/connect.c
+++ b/connect.c
@@ -104,8 +104,27 @@ struct ref **get_remote_heads(int in, struct ref **list,
 
 int server_supports(const char *feature)
 {
-	return server_capabilities &&
-		strstr(server_capabilities, feature) != NULL;
+	return !!parse_feature_request(server_capabilities, feature);
+}
+
+const char *parse_feature_request(const char *feature_list, const char *feature)
+{
+	int len;
+
+	if (!feature_list)
+		return NULL;
+
+	len = strlen(feature);
+	while (*feature_list) {
+		const char *found = strstr(feature_list, feature);
+		if (!found)
+			return NULL;
+		if ((feature_list == found || isspace(found[-1])) &&
+		    (!found[len] || isspace(found[len]) || found[len] == '='))
+			return found;
+		feature_list = found + 1;
+	}
+	return NULL;
 }
 
 int path_match(const char *path, int nr, char **match)
diff --git a/upload-pack.c b/upload-pack.c
index ce5cbbe..a47a556 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -509,6 +509,7 @@ static void receive_needs(void)
 		write_str_in_full(debug_fd, "#S\n");
 	for (;;) {
 		struct object *o;
+		const char *features;
 		unsigned char sha1_buf[20];
 		len = packet_read_line(0, line, sizeof(line));
 		reset_timeout();
@@ -540,23 +541,26 @@ static void receive_needs(void)
 		    get_sha1_hex(line+5, sha1_buf))
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
-		if (strstr(line+45, "multi_ack_detailed"))
+
+		features = line + 45;
+
+		if (parse_feature_request(features, "multi_ack_detailed"))
 			multi_ack = 2;
-		else if (strstr(line+45, "multi_ack"))
+		else if (parse_feature_request(features, "multi_ack"))
 			multi_ack = 1;
-		if (strstr(line+45, "no-done"))
+		if (parse_feature_request(features, "no-done"))
 			no_done = 1;
-		if (strstr(line+45, "thin-pack"))
+		if (parse_feature_request(features, "thin-pack"))
 			use_thin_pack = 1;
-		if (strstr(line+45, "ofs-delta"))
+		if (parse_feature_request(features, "ofs-delta"))
 			use_ofs_delta = 1;
-		if (strstr(line+45, "side-band-64k"))
+		if (parse_feature_request(features, "side-band-64k"))
 			use_sideband = LARGE_PACKET_MAX;
-		else if (strstr(line+45, "side-band"))
+		else if (parse_feature_request(features, "side-band"))
 			use_sideband = DEFAULT_PACKET_MAX;
-		if (strstr(line+45, "no-progress"))
+		if (parse_feature_request(features, "no-progress"))
 			no_progress = 1;
-		if (strstr(line+45, "include-tag"))
+		if (parse_feature_request(features, "include-tag"))
 			use_include_tag = 1;
 
 		/* We have sent all our refs already, and the other end
-- 
1.7.7.rc0.175.gb3212
