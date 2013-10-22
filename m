From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH] fixup! read-cache.c: fix memory leaks caused by removed cache,
 entries
Date: Tue, 22 Oct 2013 15:13:17 +0200
Message-ID: <526679ED.7060105@gmail.com>
References: <524A96FF.5090604@gmail.com> <524A9886.2030508@gmail.com> <8738nx2h70.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Oct 22 15:13:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYbm9-0003Gy-Dr
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 15:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152Ab3JVNNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 09:13:19 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:36908 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab3JVNNR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 09:13:17 -0400
Received: by mail-ee0-f44.google.com with SMTP id b47so4448703eek.31
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TNHCANUBIOBJQn3g3UbqhXkpxBQIibt9U2FlnRv5z4o=;
        b=htUvvpTBvBueLT8p1qNbqjiUuqVhTKZ65qCXF2SeGR4bVxQsooCH+EDdk3YFptFQFh
         J2OClasAA8gEUEmgsUAx45qIZgJn7L4LSZLDLqCocOYicirkhVcACruwIl+v+GGU/mPD
         4hT3qhBd18Vqkqyhk0G5kp0xAC1TuLIMDrO4zbtWKmSBajsnqbTByZsYY1vlRuIboMjz
         TBiRwvf0o7uRrHKBu6Cgwo53x/YvUr7qXuPcqHUO+voOGA99cbDEhEy4lfpFh4Klj7DD
         UrbOec4Svt2c5GzSyC9eONXj6bRTI7m7oG1KEnzAuNNQ/U3yktXCt5fUKLi4lh93yzCa
         4Xfw==
X-Received: by 10.14.122.132 with SMTP id t4mr29188682eeh.20.1382447596690;
        Tue, 22 Oct 2013 06:13:16 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id e47sm56725837eeo.8.2013.10.22.06.13.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Oct 2013 06:13:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <8738nx2h70.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236468>

...another instance where we access a free()d ce.

Signed-off-by: Karsten Blees <blees@dcon.de>
---

Am 19.10.2013 21:28, schrieb Thomas Rast:
> 
> Is this the version that is currently in pu?

No, its from a rebased-to-next version [1]. I didn't resend the patches because nothing actually changed (except diff contexts). Sorry for the inconvenience.

> In any case 36850edb currently breaks several valgrind tests.  You can
> valgrind only t6022.16 like so (that one test is sufficient to track it
> down and it's much faster that way):
> 
>   cd t  
>   ./t6022-merge-rename.sh --valgrind-only=16
> 

Thanks, here's the fix.

Karsten

[1] https://github.com/kblees/git/commits/kb/hashmap-v3-next


 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index fe90c3b..3f735f3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1898,7 +1898,7 @@ int read_index_unmerged(struct index_state *istate)
 		new_ce->ce_mode = ce->ce_mode;
 		if (add_index_entry(istate, new_ce, 0))
 			return error("%s: cannot drop to stage #0",
-				     ce->name);
+				     new_ce->name);
 		i = index_name_pos(istate, new_ce->name, len);
 	}
 	return unmerged;
-- 
1.8.4.msysgit.0.12.g88f5ed0.dirty
