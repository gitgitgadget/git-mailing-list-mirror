From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 19/19] reset [--mixed]: use diff-based reset whether or not pathspec was given
Date: Mon, 14 Jan 2013 21:47:51 -0800
Message-ID: <1358228871-7142-20-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:49:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzOQ-0007EL-JP
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810Ab3AOFsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:48:35 -0500
Received: from mail-qa0-f73.google.com ([209.85.216.73]:49985 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab3AOFs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:48:28 -0500
Received: by mail-qa0-f73.google.com with SMTP id a19so345051qad.4
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=fcoY3evfiNpANlHH0AMT8ZZ4YvPs5ZPeDqp9rhTh6ZI=;
        b=V2U8No1JdpUNt1UErH+oBOw8ZOLPWlE5bt2WtLKkU9UwNjCzaqOicwpGJ0uGlUhd7D
         gX3Mp6r9dG7Rwx+SJsFC52UxHaPpLdj67jBZp4h7p8uNETPBrELJfrwTzg4Tab+bwD7O
         02beOG4OVBvt5IHvP+7gpnZhraD/3bQsyHZvmmvwwWn7Fl6woTdbrivEKrg9Yo7f7slD
         Ym8+SGudHCSuFx9njMc2o+dQEKObseg+FAm3qyTIRk6VkVgXI9z1KC/sJEE6I51KVnwD
         mDJZt2tMPyFQkzeqxsTkDryY2ABs8avtEkq9Cwr8XYbfG6DjlpPc6Ew3nLIjErzxFjOg
         g5+g==
X-Received: by 10.236.120.70 with SMTP id o46mr47793580yhh.39.1358228907209;
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id r6si817626yhc.7.2013.01.14.21.48.27
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 1E3E8820055;
	Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id D1ABD1019AE; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQnFLTGXSVd4iMKz540uPPMjIGYeBcpWyszoTKbn8OjsIO59u7XTrbqVkmnxRpqs8MoNd/g25qrJqwqDcz7sCMZRWSUyB/FTRiUhZillCc7Zmk1vQlbutG0n28HT3X1LvBaHO7Ny5rDApFVgEUazrthSUVLZYLhqAZq7sx9JCmrlYktaj/gKnmxbevrV3Tu/ls0JfxZV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213580>

Thanks to b65982b (Optimize "diff-index --cached" using cache-tree,
2009-05-20), resetting with paths is much faster than resetting
without paths. Some timings for the linux-2.6 repo to illustrate this
(best of five, warm cache):

        reset       reset .
real    0m0.219s    0m0.080s
user    0m0.140s    0m0.040s
sys     0m0.070s    0m0.030s

These two commands should do the same thing, so instead of having the
user type the trailing " ." to get the faster do_diff_cache()-based
implementation, always use it when doing a mixed reset, with or
without paths (so "git reset $rev" would also be faster).

Timing "git reset" shows that it indeed becomes as fast as
"git reset ." after this patch.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
It seems like a better solution would be for unpack_trees() learn the
same tricks as do_diff_cache(). I'm leaving that a challange for the
reader :-). I did have a look a unpack_trees(), but it looked rather
overwhelming.

 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 45b01eb..921afbe 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -322,7 +322,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type != SOFT) {
 		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 		int newfd = hold_locked_index(lock, 1);
-		if (pathspec) {
+		if (reset_type == MIXED) {
 			if (read_from_tree(pathspec, sha1))
 				return 1;
 		} else {
-- 
1.8.1.1.454.gce43f05
