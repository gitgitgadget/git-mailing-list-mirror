From: Junio C Hamano <junkio@cox.net>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Thu, 18 Jan 2007 22:47:47 -0800
Message-ID: <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 07:48:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7nXh-0005Wv-Vg
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 07:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbXASGrt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 01:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbXASGrt
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 01:47:49 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:58541 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964867AbXASGrs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 01:47:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119064747.MXXL18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Fri, 19 Jan 2007 01:47:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Cumt1W0081kojtg0000000; Fri, 19 Jan 2007 01:46:53 -0500
To: Yasushi SHOJI <yashi@atmark-techno.com>
In-Reply-To: <87r6trsu7n.wl@mail2.atmark-techno.com> (Yasushi SHOJI's message
	of "Fri, 19 Jan 2007 10:04:12 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37153>

Yasushi SHOJI <yashi@atmark-techno.com> writes:

> ls-files -o prints all files under .git if you are in the .git
> directory.  this is pretty dangerous since we now have git clean to
> delete files marked others.
>
> sure in UNIX env., you can easily shoot yourself in the foot. but it'd
> might be nice to help newbies.

It's amusing to see that people can find obscure ways to shoot
themselves in the foot.

Amusing problems deserve an equally amusing solution.

-- >8 --
[PATCH] Make sure .git/ is not readable by anybody.

Normal git operation continues to work after doing "chmod a-r .git".
This makes a newly created git repository unreadable (but searchable)
so that people cannot do "cd .git && git clean" to shoot themselves.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 8e7540b..4310a05 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -18,7 +18,10 @@
 
 static void safe_create_dir(const char *dir, int share)
 {
-	if (mkdir(dir, 0777) < 0) {
+	mode_t mode;
+
+	mode = share ? 0777 : 0333;
+	if (mkdir(dir, mode) < 0) {
 		if (errno != EEXIST) {
 			perror(dir);
 			exit(1);
