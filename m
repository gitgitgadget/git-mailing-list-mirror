From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/17] remove_dir_recurse(): tighten condition for removing unreadable dir
Date: Mon,  6 Jan 2014 14:45:30 +0100
Message-ID: <1389015935-21936-13-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:46:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AW3-0006PI-MF
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbaAFNqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:46:45 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52323 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754601AbaAFNqa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:46:30 -0500
X-AuditID: 12074412-b7fc96d0000023d5-5c-52cab3b50b46
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 7B.09.09173.5B3BAC25; Mon,  6 Jan 2014 08:46:29 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfPD021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:28 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqLt186kggxV7tC26rnQzWTT0XmG2
	eHtzCaPF7RXzmS12T1vA5sDq8ff9ByaPnbPusntcvKTs8XjiCVaPz5vkAlijuG2SEkvKgjPT
	8/TtErgz5n6ey16wl63i467fTA2MDaxdjJwcEgImEne2fWaCsMUkLtxbz9bFyMUhJHCZUeLx
	lOmsEM4xJomWFb/ZQKrYBHQlFvU0g3WICKhJTGw7xAJSxCywmFGia9o3xi5GDg5hgViJrjOF
	ICaLgKrEq/smIOW8Aq4Sf/umMIGEJQQUJFZfFwIJcwKFp007DDZdSMBFYs2hRywTGHkXMDKs
	YpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI108vNLNFLTSndxAgJKKEdjOtPyh1iFOBgVOLh/fD4
	ZJAQa2JZcWXuIUZJDiYlUV7O1aeChPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwci0AyvGmJFZW
	pRblw6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAoSfAqAiNHSLAoNT21Ii0zpwQhzcTB
	CSK4QDbwAG24sglkQ3FBYm5xZjpE0SlGRSlxXkGQCQIgiYzSPLgBsNh/xSgO9I8wrw5IFQ8w
	bcB1vwIazAQ0ODQObHBJIkJKqoFx/Tmr39OcNqvyMO4XkpxRxH7sF7O+Usv1VJYDtxyiFRmn
	Be750D3Jb7HwuX1sO/ld1J8kiD/+rxIWlCwu+cO5+H/4z2mRSxXitnfr7G18X3TfKXmGMoP7
	2nNCr2TmGK0Oal67fPndyu0TVJ3b7n7UDJOzOOlktbIvSGfRwV9b+9bFzWNIM1FX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240001>

If opendir() fails on the top-level directory, it makes sense to try
to delete it anyway--but only if the failure was due to EACCES.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 dir.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 23b6de4..11e1520 100644
--- a/dir.c
+++ b/dir.c
@@ -1476,8 +1476,11 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	flag &= ~REMOVE_DIR_KEEP_TOPLEVEL;
 	dir = opendir(path->buf);
 	if (!dir) {
-		/* an empty dir could be removed even if it is unreadble */
-		if (!keep_toplevel)
+		if (errno == EACCES && !keep_toplevel)
+			/*
+			 * An empty dir could be removable even if it
+			 * is unreadable:
+			 */
 			return rmdir(path->buf);
 		else
 			return -1;
-- 
1.8.5.2
