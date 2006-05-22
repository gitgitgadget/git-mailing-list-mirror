From: Junio C Hamano <junkio@cox.net>
Subject: Re: your mail
Date: Sun, 21 May 2006 17:16:44 -0700
Message-ID: <7vk68ehq1f.fsf@assigned-by-dhcp.cox.net>
References: <1148255528.61d5d241.0@fieldses.org>
	<20060521235514.GC23096@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 02:16:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhy6M-0002oj-8S
	for gcvg-git@gmane.org; Mon, 22 May 2006 02:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWEVAQq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 20:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWEVAQq
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 20:16:46 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:25495 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964963AbWEVAQp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 20:16:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060522001645.EWYG17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 May 2006 20:16:45 -0400
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060521235514.GC23096@fieldses.org> (J. Bruce Fields's message
	of "Sun, 21 May 2006 19:55:14 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20470>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Sun, May 21, 2006 at 07:53:18PM -0400, J. Bruce Fields wrote:
>> >From nobody Mon Sep 17 00:00:00 2001
>> From: J. Bruce Fields <bfields@citi.umich.edu>
>
> Oops, sorry, I screwed up sending those; let me know if you'd like them
> resent....

That's OK.  I just cooked up this one ;-).

-- >8 --
From 03946787890c12fbb6ecfbe0382cbf02ac209801 Mon Sep 17 00:00:00 2001
From: Junio C Hamano <junkio@cox.net>
Date: Sun, 21 May 2006 17:15:06 -0700
Subject: [PATCH] mailinfo: skip bogus UNIX From line inside body

Sometimes people just include the whole format-patch output in
the commit e-mail.  Detect it and skip the bogus ">From " line.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 mailinfo.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index b276519..a133e6d 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -237,10 +237,17 @@ static int eatspace(char *line)
 #define SEEN_FROM 01
 #define SEEN_DATE 02
 #define SEEN_SUBJECT 04
+#define SEEN_BOGUS_UNIX_FROM 010
 
 /* First lines of body can have From:, Date:, and Subject: */
 static int handle_inbody_header(int *seen, char *line)
 {
+	if (!memcmp(">From", line, 5) && isspace(line[5])) {
+		if (!(*seen & SEEN_BOGUS_UNIX_FROM)) {
+			*seen |= SEEN_BOGUS_UNIX_FROM;
+			return 1;
+		}
+	}
 	if (!memcmp("From:", line, 5) && isspace(line[5])) {
 		if (!(*seen & SEEN_FROM) && handle_from(line+6)) {
 			*seen |= SEEN_FROM;
-- 
1.3.3.g292f
