From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv3 8/9] checkout-index: Fix negations of even numbers of -n
Date: Sat,  3 Aug 2013 13:51:25 +0200
Message-ID: <1375530686-2309-9-git-send-email-stefanbeller@googlemail.com>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Aug 03 13:51:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5aN5-0005cc-7m
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 13:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612Ab3HCLvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 07:51:25 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:58938 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab3HCLvX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 07:51:23 -0400
Received: by mail-ea0-f174.google.com with SMTP id z15so749935ead.19
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 04:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OJ/mJbzz5fVI1SZJVZNraC8gqDfAPKOAj4+Oh0MeUIc=;
        b=Ib6us17LuBtAP3WiNaDSsvJW7tli2sc4eeS6BO4igju2nIDEzNIVnl91dVeNCUwp4o
         DIxJaHKpW4spfiRAUho3z5jV+DR2GbIFwrQzrunfy8uuZoU1OIDfqID1n7qTaorRGm6D
         E1neevu8P3dwhD/5gMhCGVD5RJwO5rmELliypvIK4UtIJsqQL0LtnqtJabRwMvURsg8k
         1tO6VZGX0FcQy7D9gB+jBtLtAvYnY8/jDrYJkYJQU7hYcE2/oPJn92281YLKeeKrbvPA
         cmLIUuEbZvl6cnSOVP1TcDwee8DOomR1AD4eWohNYOI5psjlfLoIKSzkpXYiM5DrMHzt
         jtHA==
X-Received: by 10.14.176.8 with SMTP id a8mr9433132eem.12.1375530681228;
        Sat, 03 Aug 2013 04:51:21 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id l42sm18869902eeo.14.2013.08.03.04.51.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 04:51:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.16.g7fca822.dirty
In-Reply-To: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231586>

The --no-create was parsed with OPT_BOOLEAN, which has a counting up
logic implemented. Since b04ba2bb (parse-options: deprecate OPT_BOOLEAN,
2011-09-27) the OPT_BOOLEAN is deprecated and is only a define:
	/* Deprecated synonym */
	#define OPTION_BOOLEAN OPTION_COUNTUP

However the variable not_new, which can be counted up by giving
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
	$ git status
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
1.8.4.rc0.16.g7fca822.dirty
