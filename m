From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 0/2 v3] Make git log --follow find copies among unmodified files.
Date: Thu, 22 Apr 2010 22:05:40 +0800
Message-ID: <1271945142-27015-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 22 16:06:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4x2V-0003I9-9R
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 16:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab0DVOFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 10:05:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56186 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772Ab0DVOFv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 10:05:51 -0400
Received: by pwj9 with SMTP id 9so5971057pwj.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Nc5JOZvJiWJ+ychgilz689kWgVSor8RisCYVgiud9Cw=;
        b=iNziHZTBPdBg1mOTQMDbj36KkQKgyj9Ql7Np/VXnQe1wxhJLJRzK1s2zd9xUc44USt
         yG6uw54oK8/SynT4Et9XtmPvl7Qmk70lp39hhBpkTEX/LX9oShGVGfe7/1eBAY55kLdQ
         7fWAFZDWGSnOlGcvFn/W4lmAIGMfRJlT/zJIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=UnePj/5w+c9l7acfEJgxrvy0DotfqiKrUz0EphzDCioIXkdBbHoS17ISnjGAAFd/Ro
         nr/WjVSs6a53aRZTD0NM7U4ytvkVm2PNw9Ft1wCO/jDPr3iurqeqKJKiF8elJglH0ASP
         URIpAQixq8VXZgID7Ts8qQ4DgEu3i9niaMhKE=
Received: by 10.114.54.28 with SMTP id c28mr3504545waa.169.1271945150627;
        Thu, 22 Apr 2010 07:05:50 -0700 (PDT)
Received: from localhost.localdomain ([222.35.130.216])
        by mx.google.com with ESMTPS id b17sm4487756wam.22.2010.04.22.07.05.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 07:05:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.273.gc2413.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145531>

I have tried to make --follow to support finding copies among unmodified files. And the first patch is to fix a bug introduced by '--follow' and 'git log' combination.
We use the code:

    else if (--p->one->rename_used > 0)
        p->status = DIFF_STATUS_COPIED;

to detect copies and renames. So, if diffcore_std run more than one time, p->one->rename_used will be reduced to a 'R' from 'C'. And this patch will fix this by allowing diffcore_std can only run once before a diff_flush, which seems rationale for our code.

Bo Yang (2):
  Make diffcore_std only can run once before a diff_flush.
  Make git log --follow find copies among unmodified files.

 Documentation/git-log.txt           |    2 +-
 diff.c                              |   21 ++++++++-----
 diffcore-break.c                    |    6 +--
 diffcore-pickaxe.c                  |    3 +-
 diffcore-rename.c                   |    3 +-
 diffcore.h                          |    6 ++++
 t/t4205-log-follow-harder-copies.sh |   56 +++++++++++++++++++++++++++++++++++
 tree-diff.c                         |    2 +-
 8 files changed, 81 insertions(+), 18 deletions(-)
 create mode 100755 t/t4205-log-follow-harder-copies.sh
