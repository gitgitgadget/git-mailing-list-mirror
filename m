From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv2 8/9] checkout-index: Fix negations of even numbers of -n
Date: Wed, 31 Jul 2013 18:28:36 +0200
Message-ID: <1375288117-1576-9-git-send-email-stefanbeller@googlemail.com>
References: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 18:29:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ZGq-00084w-FN
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 18:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244Ab3GaQ2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 12:28:45 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:57012 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197Ab3GaQ2l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 12:28:41 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so469956eek.13
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 09:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HM9FsHvm6wUi0A3hDPyarri8tiYp9y1ikCU0Klvr+2I=;
        b=fBnR0RWponAnv2Hxb3Hnjh/tYINugHutoL7Km7XCcD52V/nLgwk4lyN+JE6XtTnPeG
         frNDB38gpirPe56VWjEVc8BT8S+cIKCQCF3wu77w4YXZXxU86oA48wn+kpL9gHL3/F5V
         /CprMFfamEvDvYHOfYTJqyfDJLgq489d61Xc3pfUbIBwbW2cqI+fh7vmiCOIGfDyeMt0
         HsmG4t0Q4UGEDxwf4VXEK4v9/ICVsF7X9sqLCszgcs+1a1OYM5BeyX86W6WsO7LvAkL5
         yLklCoB76KJa0jtk/c2crj6weBguIafaq1sOLNjcdmxKu4Yx78sSoEF/Qyuq5ZZWfHzN
         psJA==
X-Received: by 10.15.51.202 with SMTP id n50mr68928650eew.39.1375288119567;
        Wed, 31 Jul 2013 09:28:39 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id n5sm3726952eed.9.2013.07.31.09.28.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 09:28:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
In-Reply-To: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231426>

The --no-create was parsed with OPT_BOOLEAN, which has a counting up
logic implemented. Since b04ba2bb (parse-options: deprecate OPT_BOOLEAN,
2011-09-27) the OPT_BOOLEAN is deprecated and is only a define:
	/* Deprecated synonym */
	#define OPTION_BOOLEAN OPTION_COUNTUP

However the variable not_new, which can be counted up by giving multiple
--no-create multiple times, is used to set a bit in the struct checkout
bitfield (defined in cache.h:969, declared at builtin/checkout-index.c:19):

	state.not_new = not_new;

When assigning a value other than 0 or 1 to a bit, all leading digits but
the last are ignored and only the last bit is used for setting the bit
variable.

Hence the following:
	# in git.git:
	$ git status
	# working directory clean
	rm COPYING
	$ git status
	# deleted:    COPYING
	$ git checkout-index -a -n
	# deleted:    COPYING
	# which is expected as we're telling git to not restore or create
	# files, however:
	$ git checkout-index -a -n -n
	$ git status
	# working directory clean, COPYING is restored again!
	# That's the bug, we're fixing here.

By restraining the variable not_new to a value being definitely 0 or 1
by the macro OPT_BOOL the bug is fixed.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/checkout-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index aa922ed..69e167b 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -188,7 +188,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		OPT__FORCE(&force, N_("force overwrite of existing files")),
 		OPT__QUIET(&quiet,
 			N_("no warning for existing files and files not in index")),
-		OPT_BOOLEAN('n', "no-create", &not_new,
+		OPT_BOOL('n', "no-create", &not_new,
 			N_("don't checkout new files")),
 		{ OPTION_CALLBACK, 'u', "index", &newfd, NULL,
 			N_("update stat information in the index file"),
-- 
1.8.4.rc0.1.g8f6a3e5
