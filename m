From: Conley Owens <cco3@android.com>
Subject: [PATCH] Fallback on getpwuid if envar HOME is unset
Date: Mon, 20 Aug 2012 18:28:57 -0700
Message-ID: <CAFFUb6WiXJ0n4NkhOQ=+mcfs+uaAo2_G6TOs7L=AuPwPVfxyMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 03:29:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3dHH-00051u-Co
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 03:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878Ab2HUB3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 21:29:01 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52749 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab2HUB26 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 21:28:58 -0400
Received: by qcro28 with SMTP id o28so4766883qcr.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 18:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :x-gm-message-state;
        bh=eQ4sfs5pzWCwAHdGks6Y5aIe7mcHvbE/vc1mNUjQ12Q=;
        b=QuAVrr/PLgiZ9q1uNS48+XPOsV21ZL+r4yvQtHIEodJR0c+OLsfLYpWaxJdJmSMQf/
         yy7VaJflSJE2++DCQnNplZh5VRemjPlFQrXQZs/mSxNA/H4GjjGFZ9dLviTI4hW1tJ3P
         E68cjWhxrrTAOTqCbPH0wQ8kdqWapQMz1mSdyoVMGfs0oKdJrjRAcgwmEZUO8T0R8FFQ
         FXQGZzvysLKvaBTrg9paoSty7XyYaIwo3DCpTcshmDe+jydqZHbGGb/RK/P3KCxdcUD6
         EK+E/egIXsxnDHxfCzJeQTfxZPD9f09Bpf7yaqpx8klFfxDfCMqmhdmWkHOk6tzgiZPX
         MErA==
Received: by 10.224.28.7 with SMTP id k7mr6418711qac.56.1345512537831; Mon, 20
 Aug 2012 18:28:57 -0700 (PDT)
Received: by 10.49.110.37 with HTTP; Mon, 20 Aug 2012 18:28:57 -0700 (PDT)
X-Gm-Message-State: ALoCoQnLpX6H/Gp9JJsf0w6pKtexOQ3eM4rwkdSDm8ZGqcCsTO3YGzq+O/naVNrXpI2VL/O4FBiU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203913>

>From f64ba3c908b33a2ea5a5ad1f0e5800af76b82ce9 Mon Sep 17 00:00:00 2001
From: Conley Owens <cco3@android.com>
Date: Mon, 20 Aug 2012 18:23:40 -0700
Subject: [PATCH] Fallback on getpwuid if envar HOME is unset

Signed-off-by: Conley Owens <cco3@android.com>
---
 path.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/path.c b/path.c
index 66acd24..60affab 100644
--- a/path.c
+++ b/path.c
@@ -144,6 +144,11 @@ void home_config_paths(char **global, char **xdg,
char *file)
        char *to_free = NULL;

        if (!home) {
+         struct passwd *pw = xgetpwuid_self();
+         home = pw->pw_dir;
+       }
+
+       if (!home) {
                if (global)
                        *global = NULL;
        } else {
-- 
1.7.11-rc3
