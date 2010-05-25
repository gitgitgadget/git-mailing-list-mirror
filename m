From: Dale Rowley <ddrowley@gmail.com>
Subject: [PATCH 1/1] run-command.c: ignore bad permissions on dirs in PATH
Date: Mon, 24 May 2010 20:55:06 -0600
Message-ID: <4BFB3C0A.2030505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 25 04:55:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGkIg-000261-6L
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 04:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756861Ab0EYCzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 22:55:20 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:48686 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755471Ab0EYCzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 22:55:19 -0400
Received: by pzk15 with SMTP id 15so2545371pzk.15
        for <git@vger.kernel.org>; Mon, 24 May 2010 19:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=MXPl3hlohYDfzkgdKxz8A5DU05/f4xNxXrc21CGOvik=;
        b=HoBrAhYtpPFzQX0h53ztF4FvnqyNDKM/Ekr3atCpPe4ikoThJj2ASCCwvPJs4F3bif
         OQllcZkHKSiXTxioVp/NSXchnq4wp1Nlf9UC1i9FB934K9Q+ate/gaJjLYbLclgP3OPj
         PVts0/EofvAqBSaUjlAIwU0eaQJXjQb8S+BcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=p/LMR8Xek6ooQIgTT2MIS1kz45Lg+gyE+libAjk5RWHs66geHx6TtdTxD0wRZhnqun
         /lehShUM/qpHV1PRcEWmYQxSymMPkpXUr4GF/kOtLfIDnHr4jNsg5gy9j6pLkkufkgBq
         Jt3FRlov8uQBGKWi0aM/qLr6QhZjagNIXrXdE=
Received: by 10.143.153.21 with SMTP id f21mr2142385wfo.91.1274756118194;
        Mon, 24 May 2010 19:55:18 -0700 (PDT)
Received: from [192.168.2.3] (97-118-8-44.hlrn.qwest.net [97.118.8.44])
        by mx.google.com with ESMTPS id w39sm1294591wfh.3.2010.05.24.19.55.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 19:55:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100411 Thunderbird/3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147657>

All of my git aliases stopped working one day. For example, when I ran 'git ci'
(where 'ci' is an alias for 'commit') it printed out this error:

fatal: cannot exec 'git-ci': Permission denied

This error was confusing (I didn't have a 'git-ci' executable anywhere, so why
was it complaining about permissions?) and it took me a while to figure out that
this was happening because I happened to have a random directory in my PATH that
had permissions set incorrectly. Git should probably ignore this, and here is
one way to fix it, although I'm not sure if it's the best way.



Signed-off-by: Dale Rowley <ddrowley@gmail.com>
---
 run-command.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index c7793f5..a98282b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -284,7 +284,7 @@ fail_pipe:
 		 * Do not check for cmd->silent_exec_failure; the parent
 		 * process will check it when it sees this exit code.
 		 */
-		if (errno == ENOENT)
+		if (errno == ENOENT || errno == EACCES)
 			exit(127);
 		else
 			die_errno("cannot exec '%s'", cmd->argv[0]);
-- 
1.7.1.226.g770c5.dirty
