From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH - maint review] update-index: work with c-quoted name
Date: Wed, 11 Jan 2006 16:04:52 -0800
Message-ID: <7vbqyil3a3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 12 01:05:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewpxd-00021K-Dg
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 01:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWALAE4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 19:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWALAE4
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 19:04:56 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:63669 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751223AbWALAEy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 19:04:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112000344.ROR6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 19:03:44 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14527>

update-index --stdin did not work with c-style quoted names even though
update-index --index-info did.  This fixes the inconsistency.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * For 1.0.10 and 1.1.2

 update-index.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

a94d9948da539fdafc26c74afb335b2fe9f8f21d
diff --git a/update-index.c b/update-index.c
index be87b99..a84a04f 100644
--- a/update-index.c
+++ b/update-index.c
@@ -534,10 +534,17 @@ int main(int argc, const char **argv)
 		struct strbuf buf;
 		strbuf_init(&buf);
 		while (1) {
+			char *path_name;
 			read_line(&buf, stdin, line_termination);
 			if (buf.eof)
 				break;
-			update_one(buf.buf, prefix, prefix_length);
+			if (line_termination && buf.buf[0] == '"')
+				path_name = unquote_c_style(buf.buf, NULL);
+			else
+				path_name = buf.buf;
+			update_one(path_name, prefix, prefix_length);
+			if (path_name != buf.buf)
+				free(path_name);
 		}
 	}
 	if (active_cache_changed) {
-- 
1.1.1-g8ecb
