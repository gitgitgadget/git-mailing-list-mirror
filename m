From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v3 01/31] wrapper: implement xopen()
Date: Wed, 1 Jul 2015 17:53:49 +0800
Message-ID: <CACRoPnR4-N6i_budk+HHoYoBxPQJELp_-Rmsm=JZwfVQGNJgBQ@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-2-git-send-email-pyokagan@gmail.com>
	<ed4f6565ed610a337244e06cc15b41bb@www.dscho.org>
	<CAGZ79kYtF+rHozVQhNz8uguLZvArPiB2UdkPTFn=Vc+YCsA=UQ@mail.gmail.com>
	<40fbc9dd1a066ba137647ff384aa6395@www.dscho.org>
	<CACRoPnRqnFESb4tom1FLWxpumLz-BxfBksG=gMePqSzV44=_CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 01 11:54:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAEiP-0004OY-Qs
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 11:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbbGAJxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 05:53:53 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34499 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbbGAJxv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 05:53:51 -0400
Received: by lbnk3 with SMTP id k3so9510035lbn.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 02:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=b5LrunL0V4hOfh9S/7Pkk90ecxcmI8YaeM2MTzlyYCA=;
        b=m0kD4q1Qpji7OhNwKR2oiXk3umMvtyET9kVaHvFYyo8U9wlV35/Kk+eqY+EixmnyO9
         FfZYRvNtTmxHnnLgB+mln6bR1dgxJk+Zlqmf9TbH2l5nkjip1wdS6DE+qNpnXzVn36RM
         1s318AST/deOiMBk+1QKMBNARLbXAq1EDn8kP9Y8HcrKz10Kms1ekbMIw0uQ+xZQQuSW
         lIMXUX84a60PgMgdDZ1IDWgrv6zxnm+oifXrRhR0R0rSoCy692QAmDh+5ZJJV3YjFPlf
         SdJnHqBGU8ztyUXeZVWHAQeeb5SUVv/xtrlftj+28wz5oD5Lim+HaBrqEQ7WJrZKJWhv
         DFSg==
X-Received: by 10.112.126.101 with SMTP id mx5mr24737524lbb.35.1435744429710;
 Wed, 01 Jul 2015 02:53:49 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 1 Jul 2015 02:53:49 -0700 (PDT)
In-Reply-To: <CACRoPnRqnFESb4tom1FLWxpumLz-BxfBksG=gMePqSzV44=_CQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273147>

On Wed, Jul 1, 2015 at 5:41 PM, Paul Tan <pyokagan@gmail.com> wrote:
> Good point, I agree with this. I'll look into putting the error messages back.

This should work I think. It should take into account that O_RDONLY,
O_WRONLY, O_RDWR is defines as 0, 1, 2 on glibc, while the POSIX spec
also defines that O_RDONLY | O_WRONLY == O_RDWR.

diff --git a/wrapper.c b/wrapper.c
index c867ca9..e451463 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -214,7 +214,13 @@ int xopen(const char *path, int oflag, ...)
             return fd;
         if (errno == EINTR)
             continue;
-        die_errno(_("could not open '%s'"), path);
+
+        if ((oflag & O_RDWR) == O_RDWR)
+            die_errno(_("could not open '%s' for reading and writing"), path);
+        else if ((oflag & O_WRONLY) == O_WRONLY)
+            die_errno(_("could not open '%s' for writing"), path);
+        else
+            die_errno(_("could not open '%s' for reading"), path);
     }
 }

@@ -351,7 +357,13 @@ FILE *xfopen(const char *path, const char *mode)
             return fp;
         if (errno == EINTR)
             continue;
-        die_errno(_("could not open '%s'"), path);
+
+        if (*mode && mode[1] == '+')
+            die_errno(_("could not open '%s' for reading and writing"), path);
+        else if (*mode == 'w' || *mode == 'a')
+            die_errno(_("could not open '%s' for writing"), path);
+        else
+            die_errno(_("could not open '%s' for reading"), path);
     }
 }
