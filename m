From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] fast-import: plug leak of dirty trees in 'ls' command
Date: Thu, 8 Mar 2012 14:31:39 -0600
Message-ID: <20120308203139.GB8992@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
 <20120308202721.GA8992@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 21:31:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5k07-0001lg-8F
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 21:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab2CHUbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 15:31:47 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:47565 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752762Ab2CHUbq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 15:31:46 -0500
Received: by obbuo6 with SMTP id uo6so1115721obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 12:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VXXJoK/X6cwF1PWVzF2KYBb1B9T3Isr2Z57yqnLy+g8=;
        b=eIvdt64DOcESlgv+VY9DmibeD3aiKzpnhxBO4IxqXRTQh6KviLGPJZdz/YXhtMcYO0
         7Y1bdgLsS0BJsJSsCSIji7UvfqUoAGQOAmzZC/lnU9XVerz32H9YorVUFyr1Mw+BnW5T
         j1WphkZUlA4fdtfo4RJy8PEM4vmdpbd6Ky17I96sWaOMjSud2CAVpBMxOM7xs7tTNvq0
         pQQKGKsVYh1rJvtMBTP7gV1BrNEe6kpA3IfQHgzVGWDRI7M5HvCo3t/wHdedXO+Ahlo3
         2xezIvXZDgsB184TEM+a6ZX0+iBrjNELdgIky1tNG3uVOm8bBc3eYEsATBlidsINTivr
         mCBg==
Received: by 10.60.22.40 with SMTP id a8mr2942263oef.59.1331238705809;
        Thu, 08 Mar 2012 12:31:45 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id y7sm1456826oee.11.2012.03.08.12.31.44
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 12:31:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308202721.GA8992@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192644>

When the named directory has changed since it was last written to
pack, "tree_content_get" makes a deep copy of the list of tree entries
which we forgot to free.

This memory leak has been present since the "ls" command was
introduced in v1.7.5-rc0~3^2~33 (fast-import: add 'ls' command,
2010-12-02).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
After rediscovering this, I found [1] which mentions the same bug.

[1] http://thread.gmane.org/gmane.comp.version-control.git/178007/focus=178044

 fast-import.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fast-import.c b/fast-import.c
index c1486cab..1758da94 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3028,6 +3028,8 @@ static void parse_ls(struct branch *b)
 		store_tree(&leaf);
 
 	print_ls(leaf.versions[1].mode, leaf.versions[1].sha1, p);
+	if (leaf.tree)
+		release_tree_content_recursive(leaf.tree);
 	if (!b || root != &b->branch_tree)
 		release_tree_entry(root);
 }
-- 
1.7.9.2
