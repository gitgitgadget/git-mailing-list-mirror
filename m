From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/2] diff: add test for --no-index executed outside repo
Date: Mon, 16 Dec 2013 20:23:29 +0100
Message-ID: <1387221810-32374-1-git-send-email-t.gummerer@gmail.com>
References: <xmqqtxe8pu05.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 20:24:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsdmV-0003bI-RG
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 20:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993Ab3LPTYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 14:24:39 -0500
Received: from mail-bk0-f41.google.com ([209.85.214.41]:39254 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826Ab3LPTYi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 14:24:38 -0500
Received: by mail-bk0-f41.google.com with SMTP id v15so2530271bkz.28
        for <git@vger.kernel.org>; Mon, 16 Dec 2013 11:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cbqZWJZBVdvP3GXQA0a7srEH7Foye6DmIU8aRGFYQ6g=;
        b=dE8MNfNsi0xZiejwunV4HA3pFJ2PnupFFNlokubGcAF77km1/Nbw5Du21wyo+LXeoy
         QY7gwSpfhzUkKOEh4VnaYnXbQHPxxro+PONjuQVW4wabcOKhw3+fyL9ukre/M5HK2ZKz
         kjkdDnCWsK3NxY/CqsszxsdUz3vxcRKMTCwhp+aV0r28dfmLiUymtZ1v9TzEHqh4C3X/
         bm+71ReuzaFlUbPQL+Gsy9zQHev51MuBRexoYzXmN/rqeGsghaeNz2w6DIF8whCWMZM8
         0b1Y3BmbimDZsDxHt8hzdHV8waGzI1z+oDEvhUtKF4X5bLF1XLIf84OBv3VaSAy+ViMK
         wfog==
X-Received: by 10.204.100.9 with SMTP id w9mr806828bkn.131.1387221877399;
        Mon, 16 Dec 2013 11:24:37 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::1b8d])
        by mx.google.com with ESMTPSA id t2sm11344993bkh.3.2013.12.16.11.24.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2013 11:24:35 -0800 (PST)
X-Mailer: git-send-email 1.8.5.4.g8639e57
In-Reply-To: <xmqqtxe8pu05.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239351>

470faf9 diff: move no-index detection to builtin/diff.c breaks the error
message for "git diff --no-index", when the command is executed outside
of a git repository and the wrong number of arguments are given. 6df5762
diff: don't read index when --no-index is given fixes the problem.

Add a test to guard against similar breakages in the future.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

>> Thanks, I've missed that one.  It only happens when run outside a git
>> repository, but the same  comments still apply.  Will fix and send a
>> re-roll.
>
> Please don't, as the last round has already been pushed on 'next'.

Sorry about that, should have checked first.

> An incremental change on top would also illustrate more clearly what
> breakage needed to be fixed, which would be another good thing. It
> could even come with a new test that makes sure that the above
> command line is diagnosed correctly as a mistake ;-).

The breakage is actually fixed with the second patch as described in
the commit message above, so here is just a test against future
breakages.  This test only works when the test root is outside of a
git repository, as otherwise nongit will not be set.  Is there another
way to write it?

t/t4053-diff-no-index.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 077c775..eb4f380 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -44,4 +44,11 @@ test_expect_success 'git diff outside repo with broken index' '
 	)
 '
 
+test_expect_success 'git diff --no-index executed outside repo gives correct error message' '
+	rm -rf .git &&
+	test_must_fail git diff --no-index a b b 2>actual.err &&
+	echo "usage: git diff --no-index <path> <path>" >expect.err &&
+	test_cmp expect.err actual.err
+'
+
 test_done
-- 
1.8.5.4.g8639e57
