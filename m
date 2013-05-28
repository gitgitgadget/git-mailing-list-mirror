From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/5] sequencer: trivial fix
Date: Tue, 28 May 2013 07:54:28 -0500
Message-ID: <1369745671-22418-3-git-send-email-felipe.contreras@gmail.com>
References: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 14:56:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJS9-0001E5-72
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 14:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933936Ab3E1M4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 08:56:31 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:60819 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933922Ab3E1M4b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 08:56:31 -0400
Received: by mail-ob0-f170.google.com with SMTP id er7so9103327obc.29
        for <git@vger.kernel.org>; Tue, 28 May 2013 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wZ5WN3k3oVJeUQsJtx/Pddb52eArhVoDb53B/kET15Q=;
        b=Kfr2jGXNy4ZH2woIQyXomVQQjUGHTVccPA3pgzlkO8ooJ4xORz7Uy3qTR4o0oXUiF9
         XhuxbwfxhoGdhcvb5nax5HYA5yCFN99E9dRVbiBZOzlh5aUWPH4LSGUIGZSrjALQrvEh
         FFjQe3DhX8KQbehfrsY8N7dksdW4wafR3YWsFgiSw/3h3S8W1J8+JH2ZX3UuNxumSy5q
         wwhcvckbhEE5tJjndLYJPY8xufJ+wJaTbeT48kWkpBPba82xwm3EWjBuiBCKU/sQkYwc
         4Lt1CbQPW4LVq0JTvkOd2yq9zNR35orgfp15ydDNg2WOjjip3Ob3EICiodnIwDNd2LvK
         5NXw==
X-Received: by 10.60.41.66 with SMTP id d2mr20972090oel.12.1369745790607;
        Tue, 28 May 2013 05:56:30 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zn5sm34462827obc.10.2013.05.28.05.56.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 05:56:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225635>

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
1.8.3.rc3.312.g47657de
