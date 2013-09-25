From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: "git gc" leaving gc.pid files around
Date: Wed, 25 Sep 2013 20:29:50 +0200
Message-ID: <vpqzjr0rbz5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 25 20:30:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOtqh-0004R7-7g
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 20:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138Ab3IYSaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 14:30:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35884 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755133Ab3IYSaA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 14:30:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8PITmJU023988
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Sep 2013 20:29:48 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VOtqQ-0003OJ-HY; Wed, 25 Sep 2013 20:29:50 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 25 Sep 2013 20:29:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8PITmJU023988
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380738592.53453@yXsAj2E+N58EQJZ4+d0rWQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235362>

Hi,

Since 64a99eb47, "git gc" creates a lock file gc.pid while running. I
just noticed that the file is never deleted. The locking mechanism
works, but leaving these files around creates a minor annoyance.

For example, I run "git gc" in all my repos from time to time (in a cron
job). It normally does nothing in repos that have not changed, but now,
it updates the gc.pid file.

As a result, all the gc.pid files show up in unison (synchronization
tool between machines) for example.

Is there any reason not to do something like this:

--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -316,5 +316,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
                warning(_("There are too many unreachable loose objects; "
                        "run 'git prune' to remove them."));
 
+       unlink(git_path("gc.pid"));
        return 0;
 }

?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
