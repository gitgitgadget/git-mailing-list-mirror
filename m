From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 4/4] credential-cache, send_request: close fd when done
Date: Thu, 31 Mar 2016 11:04:06 -0700
Message-ID: <1459447446-32260-5-git-send-email-sbeller@google.com>
References: <1459447446-32260-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: peff@peff.net, sunshine@sunshineco.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 31 20:04:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algxH-0001NJ-RU
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757977AbcCaSEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:04:24 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35465 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757415AbcCaSEU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:04:20 -0400
Received: by mail-pa0-f54.google.com with SMTP id td3so70935886pab.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yYLbgpr+F2wjCxN/oj57PcUx75cgn2OSJGzEOev3f9w=;
        b=L7WXVRo+/FIrFZ74hxYnHjKvPVvhf1/5E59izvJ5uJsq6ptw2kRXwY+m32jAQpJqgu
         xXtHnzDQZ6zboVaCdNnYS/USxVQHeM5Qtu89FWsrkSfpocZybYYPWlUFEuv2MZgzOwTU
         WwvE+Frkm5lPgCSeJUE0TnPUSvbEDW3cPw8HChOId0/o4PejIyXPe5Zq11m01EMAJ/Dg
         Q0w57FLJ8zR1g+4qqp2Akk00G3YmFVY18JJoKVOKE9KEuXcAHrdiTnJLGYI4lh07S4YR
         Ll148I4Pv1z/MIZqnfxfKsc5A6bBJNUsfXLK806Qr4wsWi5qWlT3B6GDTLfVKrYWHIxw
         Ms/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yYLbgpr+F2wjCxN/oj57PcUx75cgn2OSJGzEOev3f9w=;
        b=TZKdEdNn5fR2OHMIKLSdN/nrXed0pyp3S+AbmnEq27+pFuuFM9EdJw7PMvgmP8VajP
         T/57Sfu4kE1WqiMLab8BIOYduPlVNEMjbMn5hLkHgu2H9BPZMAGIPnh17X67yWfhJQzs
         gVupi9r2LjNV7ryGrQUz5StH+1u2W/cNxCXatbSa4Ac3abaZvUJ26ZGSgJ8Uh4ssk4Rr
         BWmXFzBGsTsGLa7JlTujxc8oawjpneekQi5vtaNIj6avui+oc3Cd8xxQNM7i6xN8iF6I
         htnF/rA0hGVTtHXoxyBJWLAL+upa3DVYKYW6WhdfQF85MlURiFqGWh1tUXyuVtyvdncm
         sgVg==
X-Gm-Message-State: AD7BkJJlusoSZzutLlrBu7nHrv7EtSfDCXKNzFYV0irWawT20rlD2Mxh5cxpnto5Uu+Kh+4k
X-Received: by 10.66.147.103 with SMTP id tj7mr23995343pab.72.1459447459714;
        Thu, 31 Mar 2016 11:04:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id p79sm14950693pfi.61.2016.03.31.11.04.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 11:04:18 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g4004fdc.dirty
In-Reply-To: <1459447446-32260-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290436>

No need to keep it open any further.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 credential-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/credential-cache.c b/credential-cache.c
index f4afdc6..86e21de 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -32,6 +32,7 @@ static int send_request(const char *socket, const struct strbuf *out)
 		write_or_die(1, in, r);
 		got_data = 1;
 	}
+	close(fd);
 	return got_data;
 }
 
-- 
2.5.0.264.g4004fdc.dirty
