From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH 0/3] Fix support for FreeBSD's /bin/sh
Date: Fri, 11 Apr 2014 01:28:16 -0700
Message-ID: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 10:28:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYWp7-00038M-Ge
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 10:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbaDKI22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 04:28:28 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:32927 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbaDKI20 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 04:28:26 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so5097920pbb.25
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 01:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Er9I5TRqoryHk4p6NfbbK0AgOBAuPsEM67QDG+kMRJI=;
        b=aidQTabvCI5DKPo61yQq070CdlPtcFiC2+FGo/GQrRtnhkAP5dZqkvYBSTiHRhAg/y
         Sbp96lRrKtekmLe38pvO0w7JfCgN0i+VsFt11NB0W02lISVnZLcD1dub2MFi7GX9WU4U
         1pLzRp4qQoFxem/VkUGdKT0lIWyiV+pmyveGR1PKvaGon8SYnG8hVGTWitkB8IvY4knT
         oFdyg+Lv2Gn8/sSKR0Rat0b4x397Uh2+6rScs8IloC9z8AcXaWSxgzJ1ZoTBAkJZqTn3
         3TuE65VXKh4yh7Qdwy4efrOOgHIknY9qijArCpGWkP555R+6sAbHvHjLiqUae2BsTXZs
         9CfA==
X-Received: by 10.66.241.66 with SMTP id wg2mr25674813pac.132.1397204905715;
        Fri, 11 Apr 2014 01:28:25 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ky8sm14002027pbc.64.2014.04.11.01.28.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 01:28:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246069>

This patch series words around the FreeBSD /bin/sh problems that cause rebase
to fail on FreeBSD as well as test t5560-http-backend-noserver.

The rebase issue was first introduced in Git v1.8.4 which started using the
"return" statement to return from a "dot" command script where the "dot"
command itself was located inside a function.  This behaves badly when using
FreeBSD's /bin/sh.  An attempt was made to fix this in Git v1.8.4.1, but it
only addressed part of the problem.

Patch 1/3 fixes the problem by eliminating such use of "return", patch 2/3
then reverts the earlier workaround since it is no longer needed and did
not fully solve the problem.

The t5560 issue was first introduced in Git v1.7.0 which started using a
backslash escapes in ${...} expansions.  The FreeBSD /bin/sh does not
properly support such escapes, but there is a simple change that works
everywhere (using [?] instead of \?).

There are more details in the individual patches.

This patch series is based on maint since these are bug fixes and that's
what SubmittingPatches says to do...

Kyle J. McKay (3):
  rebase: avoid non-function use of "return" on FreeBSD
  Revert "rebase: fix run_specific_rebase's use of "return" on FreeBSD"
  test: fix t5560 on FreeBSD

 git-rebase--am.sh                | 131 +++++++--------
 git-rebase--interactive.sh       | 341 ++++++++++++++++++++-------------------
 git-rebase--merge.sh             |  87 +++++-----
 git-rebase.sh                    |  11 +-
 t/t5560-http-backend-noserver.sh |   4 +-
 5 files changed, 287 insertions(+), 287 deletions(-)

The above stat may seem like a lot, but when using diff -w --stat you get this:

 git-rebase--am.sh                |  3 +++
 git-rebase--interactive.sh       |  3 +++
 git-rebase--merge.sh             |  3 +++
 git-rebase.sh                    | 11 +----------
 t/t5560-http-backend-noserver.sh |  4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

which more accurately reflects what was actually touched.
