From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH] Makefile: don't hardcode HEAD in dist target
Date: Sat, 31 May 2014 22:25:10 +0200
Message-ID: <20140531202507.GA9101@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 22:25:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqpqE-0005ci-4l
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 22:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbaEaUZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2014 16:25:16 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35091 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbaEaUZP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2014 16:25:15 -0400
Received: by mail-wi0-f177.google.com with SMTP id f8so2731921wiw.10
        for <git@vger.kernel.org>; Sat, 31 May 2014 13:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=3v/lvCMWqHYYejufdooZ3FDXh+IGWKw/VmOBBoGxOuQ=;
        b=SzZ6Fpy1BV23KGBON9CSJrp71UgUEVDKuv1Blz2CJFw1CXL9MQ/7MQXjqZQEgYuM1o
         9i18USgB7wzXmVWW59x9s2l/mRij3ygxXpAwYnbN4IT/Zpg8SXDyg+66uv/KhAPaYGlF
         dhQY2YpCBkegy1HVP1fzPYxjldj4mucbf2V1b79alKJWhCdYF8KWxxY2tc6hzzq0Lkq4
         NE8LDPVJEn8NRTvGPz8AZve/i56IRNvJEq2tu0cuWqq5zDOta7bOqxtsRPkdvajrIiB0
         TnV4CgneDnKdL46AD+Cz2bjdsklVKrOrsIEI6pQR02ldT9M7fPLvkeAA4c6WoO/JIK2j
         C36A==
X-Gm-Message-State: ALoCoQl0X3whM0z9afc75fv+nPO9Mz3YnMFOcqcus4HZHB2pwD8Vu1xC8146GkkDt5078x0cCG2J
X-Received: by 10.180.228.100 with SMTP id sh4mr9149333wic.40.1401567913874;
        Sat, 31 May 2014 13:25:13 -0700 (PDT)
Received: from spirit (195-240-45-142.ip.telfort.nl. [195.240.45.142])
        by mx.google.com with ESMTPSA id d6sm17459738wiz.4.2014.05.31.13.25.12
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 31 May 2014 13:25:13 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250514>

Instead of calling git-archive HEAD^{tree}, use $(GIT_VERSION)^{tree}.
This makes sure the archive name and contents are consistent, if HEAD
has moved, but GIT-VERSION-FILE hasn't been regenerated yet.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
I have a somewhat odd setup in which I share a .git between multiple
checkouts for automated builds. To minimize locking time for parallel
builds with different options, there's only a lock around checkout and
running git describe $commit > version, the builds themselves run in
parallel.

This works just fine except during 'make dist', which is hardcoded to
package up HEAD, but that's not always the commit that is actually
checked out, another process may have checked out something else.

I realize this setup is somewhat strange, but the only change necessary
to make this work is this one-line patch, so I hope that's acceptable.

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a53f3a8..63d9bac 100644
--- a/Makefile
+++ b/Makefile
@@ -2433,7 +2433,7 @@ git.spec: git.spec.in GIT-VERSION-FILE
 GIT_TARNAME = git-$(GIT_VERSION)
 dist: git.spec git-archive$(X) configure
 	./git-archive --format=tar \
-		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
+		--prefix=$(GIT_TARNAME)/ $(GIT_VERSION)^{tree} > $(GIT_TARNAME).tar
 	@mkdir -p $(GIT_TARNAME)
 	@cp git.spec configure $(GIT_TARNAME)
 	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
-- 
2.0.0-538-ga6b2d95
