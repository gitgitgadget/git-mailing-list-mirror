From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: Cygwin git and windows network shares
Date: Fri, 16 Jun 2006 16:24:30 +0200
Message-ID: <17554.48926.852000.679014@lapjr.intranet.kiel.bmiag.de>
References: <4492AAFA.20807@grin.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 16:24:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrFFf-0000Ou-5K
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 16:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWFPOYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 10:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWFPOYo
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 10:24:44 -0400
Received: from meriadoc.bmiag.de ([62.154.210.133]:2434 "EHLO
	meriadoc.bmiag.de") by vger.kernel.org with ESMTP id S1751418AbWFPOYn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 10:24:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 2FACA3AED9;
	Fri, 16 Jun 2006 16:24:40 +0200 (CEST)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14896-01; Fri, 16 Jun 2006 16:24:40 +0200 (CEST)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id DDEA63AED8;
	Fri, 16 Jun 2006 16:24:37 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id DC2C53BB4E;
	Fri, 16 Jun 2006 16:24:36 +0200 (CEST)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 03380-08; Fri, 16 Jun 2006 16:24:33 +0200 (CEST)
Received: from LAPJR (lapjr.intranet.kiel.bmiag.de [10.191.7.182])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 5869C3BB4D;
	Fri, 16 Jun 2006 16:24:31 +0200 (CEST)
To: Niklas Frykholm <niklas@grin.se>
In-Reply-To: <4492AAFA.20807@grin.se>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21942>

Niklas Frykholm writes:
 > I'm trying to use cygwin git (compiled from the 1.4.0 tarball) to create 
 > repository on a windows network share, but I get an error message.
 > 
 >     $ cd //computer/git/project
 >     $ git init-db
 >     defaulting to local storage area
 >     Could not rename the lock file?

cygwin's rename seems to be capable of overwriting an existing target
only on NTFS. The following hack is a workaround, but is probably not
safe.

diff --git a/lockfile.c b/lockfile.c
index 2346e0e..5e78211 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -48,6 +48,7 @@ int commit_lock_file(struct lock_file *l
 	strcpy(result_file, lk->filename);
 	i = strlen(result_file) - 5; /* .lock */
 	result_file[i] = 0;
+	unlink(result_file);
 	i = rename(lk->filename, result_file);
 	lk->filename[0] = 0;
 	return i;
