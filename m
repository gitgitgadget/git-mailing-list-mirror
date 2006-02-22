From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Prevent git-upload-pack segfault if object cannot be found
Date: Wed, 22 Feb 2006 10:50:05 -0800
Message-ID: <7vy803mdnm.fsf@assigned-by-dhcp.cox.net>
References: <20060222181758.GH3355@andrew-vasquezs-powerbook-g4-15.local>
	<87bqwzs07h.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Vasquez <andrew.vasquez@qlogic.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 19:50:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBz44-0008BV-IX
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 19:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWBVSuL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 13:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422655AbWBVSuK
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 13:50:10 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:20873 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1422654AbWBVSuI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 13:50:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222184730.ZMHK17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 13:47:30 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87bqwzs07h.wl%cworth@cworth.org> (Carl Worth's message of "Wed,
	22 Feb 2006 10:44:02 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16608>

I have this in mind...

---
diff --git a/sha1_file.c b/sha1_file.c
index f08b1d6..dae77fc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -552,7 +552,8 @@ static void prepare_packed_git_one(char 
 	len = strlen(path);
 	dir = opendir(path);
 	if (!dir) {
-		fprintf(stderr, "unable to open object pack directory: %s: %s\n", path, strerror(errno));
+		if (errno != ENOENT)
+			fprintf(stderr, "unable to open object pack directory: %s: %s\n", path, strerror(errno));
 		return;
 	}
 	path[len++] = '/';
