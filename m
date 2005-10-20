From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cg-fetch will now retrieve commits related to tags if missing.
Date: Wed, 19 Oct 2005 22:23:30 -0700
Message-ID: <7v3bmwu5gt.fsf@assigned-by-dhcp.cox.net>
References: <1129769745158-git-send-email-martin@catalyst.net.nz>
	<7voe5lvv1q.fsf@assigned-by-dhcp.cox.net>
	<46a038f90510192118s31c52fe7m73d88a9779653f4c@mail.gmail.com>
	<7virvsu79c.fsf@assigned-by-dhcp.cox.net>
	<46a038f90510192159h25aad025kf377e3e33b5d30d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 07:24:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESSuA-0005xB-MY
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 07:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbVJTFXd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 01:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbVJTFXd
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 01:23:33 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47778 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751750AbVJTFXd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 01:23:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051020052319.XYQP4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Oct 2005 01:23:19 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10350>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Ok -- I was using ^{commit} which _is_ lazy, but you are
> right, ^0 isn't lazy.

Ah, my mistake.  We would need something like this.

---

diff --git a/sha1_name.c b/sha1_name.c
index 75c688e..cc320d3 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -323,6 +323,8 @@ static int peel_onion(const char *name, 
 		return -1;
 	if (!type_string) {
 		o = deref_tag(o);
+		if (!o || (!o->parsed && !parse_object(o->sha1)))
+			return -1;
 		memcpy(sha1, o->sha1, 20);
 	}
 	else {
@@ -332,7 +334,7 @@ static int peel_onion(const char *name, 
 		 */
 
 		while (1) {
-			if (!o)
+			if (!o || (!o->parsed && !parse_object(o->sha1)))
 				return -1;
 			if (o->type == type_string) {
 				memcpy(sha1, o->sha1, 20);
