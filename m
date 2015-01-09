From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH] receive-pack.c: only accept push-cert if push_cert_nonce was advertised
Date: Fri,  9 Jan 2015 12:47:17 -0800
Message-ID: <1420836437-11068-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 09 21:47:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9gSy-0001sT-K8
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 21:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbbAIUr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 15:47:28 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:49729 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbbAIUr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 15:47:27 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar1so17146377iec.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2015 12:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NrWkaRjECXydB8FMvYsm8d6TUI6GFwlCkLfabR4kHRM=;
        b=lAXEX3QYC4F1dJd0+rwXuRNBEPlKxK786bko31XHgavy3EnBFEUqVouPPipeRXuXqa
         hIwGj3AT7U5M9EeVRwFgLAQSKoA+67K4K+XMmBkkhpVgQ3xTwgLwm8jpVOPIb1kAKcAl
         A3zTcfDlFuPQWJFIoxO5gy5f751utiySn9lY+Y4NrInYe0pYhVRC+5CijHc/FEvaWBDQ
         oWWvs6/xb5PSzOpvqFfc0Zirkn598zUPxVC6clZiiqq8ry603vQX+X1e77q5vDSiz0hy
         e+RDjGLnXHGFwXFAMYFcuSyevWyiwQNaW8BmRsJM+WWkVizSP5lTeWdCUuIErx06C5+T
         kaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NrWkaRjECXydB8FMvYsm8d6TUI6GFwlCkLfabR4kHRM=;
        b=ke7SOxvii4bjUMbhDP801IAtyLpbCY1iY5cAu0CvOQkp3Yv07FPNBC5YI2BgX+URfp
         6VGxdPxFv3fbYQainDERM0SLLDizv4GAAwBLQ+gcGWh1hstCnjrhfgdNszDfMmF1HqAx
         WEmJ52fraK2Sri3gwZP9x3SuNlLc0I+t1QcFjiOWx/GpA3VU3tbkCB3xC7r/KkUOW2qD
         lx3Y59ooktifrKo/111pq9+t0+Syi/J5QBRYIcbH+YhaYveMoZArJ5DEOOvMBsAY8Tq8
         velpgLIMz0GPMfLVov9tvY/niSK52pgUEgb35aunKB74+odg1xCKacvQYYdlAcwANla+
         g0og==
X-Gm-Message-State: ALoCoQkgnyJFFxo4zErVV+5K0WYfY+EGcC0i7eNxzBcR1A91Nwafo/Gpo/Je5gnbjqqbd3x43Dzx
X-Received: by 10.107.164.75 with SMTP id n72mr17213869ioe.17.1420836447066;
        Fri, 09 Jan 2015 12:47:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:60c6:3f0a:318f:e7c0])
        by mx.google.com with ESMTPSA id o185sm4308962ioe.40.2015.01.09.12.47.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Jan 2015 12:47:26 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262244>

If the server did not advertise the capability to have signed pushes
it should not accept signed pushes as stated in
Documentation/technical/protocol-capabilities.txt:

    Client will then send a space separated list of capabilities it wants
    to be in effect. The client MUST NOT ask for capabilities the server
    did not say it supports.

    Server MUST diagnose and abort if capabilities it does not understand
    was sent.  Server MUST NOT ignore capabilities that client requested
    and server advertised.  As a consequence of these rules, server MUST
    NOT advertise capabilities it does not understand.

After rereading the second paragraph I think they should also be reworded to

    Server MUST diagnose and abort if capabilities it did not advertise
    was sent.


Suppose there would be hypothetical flaw in the capability of signed
pushes (or any capability for the current reasoning) which may harm
the server. This would require a bugfix release if it was severe and
would put us on time pressure to get it done.

A change like the one proposed would allow us to tell the community to
simply configure the server to not advertise the feature and if not
advertised the flaw could not be abused.

I am not saying there is a problem now, but I am rather saying patches
similar to this one would buy us time in case of problems arising.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    As I discovered the idea while composing the
    atomic push series and the changes line of this
    patch is closeby, this applies on top of
    origin/sb/atomic-push (v12 as sent on Jan. 7th)
    
    This patch is RFC, thinking about security best practice.
    It's not enough to document the intended behavior in
    Documentation/technical/protocol-capabilities.txt, but
    rather enforce it in the code as well.
    
    Any thoughts on that welcome!
    
    Thanks,
    Stefan

 builtin/receive-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4c069c5..628d13a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1276,7 +1276,8 @@ static struct command *read_head_info(struct sha1_array *shallow)
 				use_atomic = 1;
 		}
 
-		if (!strcmp(line, "push-cert")) {
+		if (push_cert_nonce &&
+		    !strcmp(line, "push-cert")) {
 			int true_flush = 0;
 			char certbuf[1024];
 
-- 
2.2.1.62.g3f15098
