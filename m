From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-daemon problem
Date: Tue, 11 Jul 2006 16:32:34 -0700
Message-ID: <7v3bd73egd.fsf@assigned-by-dhcp.cox.net>
References: <E1G0QeX-0003hG-0I@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 01:32:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Ric-0007yJ-Bl
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 01:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWGKXch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 19:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWGKXch
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 19:32:37 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:2814 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751350AbWGKXcg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 19:32:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060711233235.QMNG22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Jul 2006 19:32:35 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G0QeX-0003hG-0I@moooo.ath.cx> (Matthias Lederhofer's message
	of "Wed, 12 Jul 2006 00:24:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23748>

Matthias Lederhofer <matled@gmx.net> writes:

> A few weeks ago upgrading from 1.3.x to 1.4.1 I had a problem with
> git-daemon.  I started git-daemon on a terminal but did not redirect
> stdin/stdout/stderr to /dev/null (actually using daemon(8) on freebsd
> without -f but just disowning the process and closing the terminal
> works fine too, nothing freebsd/daemon(8) specific).

This is because the server side closes fd #2 in such a setup,
and we still wrote using safe_write() into it.  Thanks for
spotting.

Would this replacement patch help?

diff --git a/upload-pack.c b/upload-pack.c
index b18eb9b..44038d3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -51,6 +51,13 @@ static ssize_t send_client_data(int fd, 
 		if (fd == 3)
 			/* emergency quit */
 			fd = 2;
+		if (fd == 2) {
+			/* people sometomes close fd 2 on the server
+			 * side -- making safe_write() to barf.
+			 */
+			write(2, data, sz);
+			return sz;
+		}
 		return safe_write(fd, data, sz);
 	}
 	p = data;
