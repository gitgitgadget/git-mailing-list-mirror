From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] add likely/unlikely hints
Date: Thu, 28 Apr 2011 20:34:18 +0400
Message-ID: <20110428163418.GA6455@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 18:34:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFUAf-0003V5-DG
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 18:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760682Ab1D1QeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 12:34:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48862 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760449Ab1D1QeX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 12:34:23 -0400
Received: by fxm17 with SMTP id 17so1935666fxm.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=vGO6X3iuFYL7Tkyl7R0NCQcMrZuKUIvaHeycZ5GhJF4=;
        b=rz+DkGTO7FEUKQlEd4qC7bR+Av+dy0F96iE1qHTIY6oInHzifzPQGPpsNmWWRPK8de
         zG7i/34ononPjYqQ5oJVm4HrWRCfwazFRyLf1tqyIBFe9IUp7ksK5ksFRaAVp8DYluBH
         t5le0O8K5xH9jwxvcL08EmmE0yTNxrQYBal+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=Gtlf6EErgYTDN7jLqZxcKXQF6Uw88U5xkcqMNAPkl2xIXHhpuiWTTAzaXvnAkiYNgh
         k+LtUCTAETneaAcljY+gEUBa1XVmuPVTMWto4qi7exXihEGWrwAXjoHMi3bn5BjLfWGI
         GQYO989/jLyz4vBjKKKkWPobYj3B5cCYt7D+s=
Received: by 10.223.33.80 with SMTP id g16mr234074fad.125.1304008461563;
        Thu, 28 Apr 2011 09:34:21 -0700 (PDT)
Received: from localhost (ppp91-76-215-163.pppoe.mtu-net.ru [91.76.215.163])
        by mx.google.com with ESMTPS id j12sm638353fax.9.2011.04.28.09.34.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 09:34:20 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172374>

Usually modern CPUs work fine even when the most likely branch is not local,
thus these hints do not provide noticeable wins, but in a situation of some
loop that usually executed only once, the compiler may aggressively unroll
the loop making the code bigger and slower when the loop is executed only
once. So, for such rare situations, these hints may be helpful.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

 git-compat-util.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 40498b3..f690b29 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -60,6 +60,15 @@
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
 
+/* Hints for branch prediction */
+#if defined(__GNUC__) && (__GNUC__ >= 3)
+#define likely(x)	__builtin_expect(!!(x), 1)
+#define unlikely(x)	__builtin_expect(!!(x), 0)
+#else
+#define likely(x)	(!!(x))
+#define unlikely(x)	(!!(x))
+#endif
+
 #if defined(__sun__)
  /*
   * On Solaris, when _XOPEN_EXTENDED is set, its header file
-- 
1.7.5
