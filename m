From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 1/2] compat: add a mkstemps() compatibility function
Date: Thu, 28 May 2009 09:07:32 +0200
Message-ID: <4A1E3834.3020502@viscovery.net>
References: <1243491077-27738-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, markus.heidelberg@web.de,
	jnareb@gmail.com
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 09:07:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9ZiK-0008EZ-03
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 09:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbZE1HHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 03:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbZE1HHg
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 03:07:36 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:14742 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbZE1HHf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 03:07:35 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M9Zi9-00021K-4R; Thu, 28 May 2009 09:07:33 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D687A6B7; Thu, 28 May 2009 09:07:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1243491077-27738-1-git-send-email-davvid@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120159>

David Aguilar schrieb:
> +++ b/compat/mkstemps.c
> @@ -0,0 +1,78 @@
> +#include <string.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <inttypes.h>
> +#include <unistd.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
...
> +#ifndef O_BINARY
> +#define O_BINARY 0
> +#endif
...
> +		fd = open(pattern, O_BINARY|O_CREAT|O_EXCL|O_RDWR, 0600);

You should not include "random" system headers, nor has mkstemps any
business deciding whether files are opened in binary mode. We are not
using O_BINARY anywhere else (except in compat/mingw.c). With the patch
below squashed in (I hope it won't be wrapped) you can add:

Tested-by: Johannes Sixt <j6t@kdbg.org> (Windows)

to both your patches. And, yes, I like them :-)

-- Hannes

diff --git a/compat/mkstemps.c b/compat/mkstemps.c
index 10f9ed6..1cf7f3d 100644
--- a/compat/mkstemps.c
+++ b/compat/mkstemps.c
@@ -1,20 +1,9 @@
-#include <string.h>
-#include <errno.h>
-#include <stdio.h>
-#include <fcntl.h>
-#include <inttypes.h>
-#include <unistd.h>
-#include <sys/time.h>
-#include <sys/types.h>
+#include "../git-compat-util.h"

 #ifndef TMP_MAX
 #define TMP_MAX 16384
 #endif

-#ifndef O_BINARY
-#define O_BINARY 0
-#endif
-
 /* Adapted from libiberty's mkstemp.c. */
 int gitmkstemps(char *pattern, int suffix_len)
 {
@@ -57,7 +46,7 @@ int gitmkstemps(char *pattern, int suffix_len)
 		template[4] = letters[v % num_letters]; v/= num_letters;
 		template[5] = letters[v % num_letters]; v/= num_letters;

-		fd = open(pattern, O_BINARY|O_CREAT|O_EXCL|O_RDWR, 0600);
+		fd = open(pattern, O_CREAT|O_EXCL|O_RDWR, 0600);
 		if (fd > 0)
 			return fd;
 		/* Fatal error (EPERM, ENOSPC etc).
