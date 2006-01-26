From: Junio C Hamano <junkio@cox.net>
Subject: Re: git describe fails without tags
Date: Thu, 26 Jan 2006 01:02:44 -0800
Message-ID: <7vr76vgy4r.fsf@assigned-by-dhcp.cox.net>
References: <20060125074725.GA2768@informatik.uni-freiburg.de>
	<7vek2wws61.fsf@assigned-by-dhcp.cox.net>
	<20060126084151.GB2941@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 10:02:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F231m-0004iQ-9S
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 10:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWAZJCr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 04:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWAZJCq
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 04:02:46 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:18595 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932136AbWAZJCp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 04:02:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060126085958.JCLX17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 Jan 2006 03:59:58 -0500
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15154>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:

> I see two things to fix in that patch:
>
>  1) define DEFAULT_ABBREV (e.g. by moving it to cache.h, where
>     find_unique_abbrev is defined.)

Sorry, the patch alone was not compilable since cleaning up the
definition of symbolic constants *_ABBREV comes before the patch
you quoted in the "pu" branch.

>  2) describe.c allows only abbrev >= 4.  (Allowing values less than 2
>     failes, because find_short_object_filename (and maybe others) assume
>     len to be at least 2.)  I think 4 is sensible.

Thanks.  "rev-parse --abbrev=2" would have segfaulted without
your fix.  I suspect substituting with MINIMUM instead of
DEFAULT in such a case would be more sensible, so...

-- >8 --
[PATCH] rev-parse --abbrev: do not try abbrev shorter than minimum.

We do not allow abbreviation shorter than 4 letters in other
parts of the system so do not attempt to generate such.

Noticed by Uwe Zeisberger.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 rev-parse.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

030d25d271adb2671f560b410d77585d8744acbf
diff --git a/rev-parse.c b/rev-parse.c
index 42969a6..8bf316e 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -206,8 +206,10 @@ int main(int argc, char **argv)
 				abbrev = DEFAULT_ABBREV;
 				if (arg[8] == '=')
 					abbrev = strtoul(arg + 9, NULL, 10);
-				if (abbrev < 0 || 40 <= abbrev)
-					abbrev = DEFAULT_ABBREV;
+				if (abbrev < MINIMUM_ABBREV)
+					abbrev = MINIMUM_ABBREV;
+				else if (40 <= abbrev)
+					abbrev = 40;
 				continue;
 			}
 			if (!strcmp(arg, "--sq")) {
-- 
1.1.4.g00a4
