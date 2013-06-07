From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] sequencer: trivial fix
Date: Fri,  7 Jun 2013 15:32:21 -0500
Message-ID: <1370637143-21336-2-git-send-email-felipe.contreras@gmail.com>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 22:34:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3Md-0006U7-Hi
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148Ab3FGUeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:34:19 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:46330 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603Ab3FGUeR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:34:17 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so7321775obb.36
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=eAbbO87Vbvb5YUTsoQf7LGzqlSnoKqoeGm5IRtIoTs4=;
        b=ZG4Tx+qem7QZQIu1ItLPDgGnVNocqwlRZjJ1IVYC0OtE2CRFrNjru5qjrr5CXd+e/D
         P001gLz7cU/ototNJXt1NyqmY7zDlCta9b5epIFajQrBWcOeGe6bOWKpQ3EisrqZVC3y
         1YQl35ZqUUVatxOamRNt8O/3dsIn3/tsZco1hw0ZVtulShMM7xXLgUuZhB1S0f4NryUE
         KPpHIP2q1lW5Pg7d3xeqxq3xiJgWW8hpF+pbBNjdbHFWiWOT8al4wVfKgXtK5jFWTKdz
         6zh2dvmY2pIm1yZ1MtrAP/hFUE/OtSSy66kPN+L5onIJ/7B7Sgs2IYuhgxszIeV5ds7W
         CeZw==
X-Received: by 10.182.74.194 with SMTP id w2mr275420obv.40.1370637256740;
        Fri, 07 Jun 2013 13:34:16 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ei16sm506610oeb.7.2013.06.07.13.34.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 13:34:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226700>

We should free objects before leaving.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ab6f8a7..7eeae2f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -626,12 +626,15 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		rerere(opts->allow_rerere_auto);
 	} else {
 		int allow = allow_empty(opts, commit);
-		if (allow < 0)
-			return allow;
+		if (allow < 0) {
+			res = allow;
+			goto leave;
+		}
 		if (!opts->no_commit)
 			res = run_git_commit(defmsg, opts, allow);
 	}
 
+leave:
 	free_message(&msg);
 	free(defmsg);
 
-- 
1.8.3.698.g079b096
