From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] git config gets confused
Date: Sat, 12 May 2007 21:49:33 -0700
Message-ID: <7vtzuhtjj6.fsf@assigned-by-dhcp.cox.net>
References: <20070512235230.GE7184@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun May 13 06:49:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn61e-0008Ba-Hn
	for gcvg-git@gmane.org; Sun, 13 May 2007 06:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbXEMEtg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 00:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbXEMEtf
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 00:49:35 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60171 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbXEMEtf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 00:49:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070513044935.XHDV24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 13 May 2007 00:49:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id yUpZ1W00N1kojtg0000000; Sun, 13 May 2007 00:49:34 -0400
cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <20070512235230.GE7184@planck.djpig.de> (Frank Lichtenheld's
	message of "Sun, 13 May 2007 01:52:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47123>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> While working on test cases for git-cvsserver, especially the config
> file handling I noticed the following bug in git-config:
>
> $ git-config gitcvs.enabled true
> $ git-config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite
> $ git-config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite
>
> expected result:
>
> [gitcvs]
>         enabled = true
>         dbname = %Ggitcvs2.%a.%m.sqlite
> [gitcvs "ext"]
>         dbname = %Ggitcvs1.%a.%m.sqlite
>
> actual result:
>
> [gitcvs]
>         enabled = true
> [gitcvs "ext"]
>         dbname = %Ggitcvs1.%a.%m.sqlite
>         dbname = %Ggitcvs2.%a.%m.sqlite

Oh, boy.

Why am I not surprised by another bug in config writer?

Dscho, does this look good?

-- >8 --
git-config: do not forget "a.b.var" already ends "a.var" section.

Earlier code tried to be half-careful and knew the logic that
seeing "a.var" after seeing "a.b.var" is a sign of the previous
"a.b." section has ended, but forgot it has to handle the other
way.  Seeing "a.b.var" after seeing "a.var" is a sign that "a."
section has ended, so a new "a.var2" variable should be added
before the location "a.b.var" appears.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 config.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 70d1055..70e6e7e 100644
--- a/config.c
+++ b/config.c
@@ -451,6 +451,9 @@ static int matches(const char* key, const char* value)
 
 static int store_aux(const char* key, const char* value)
 {
+	const char *ep;
+	size_t section_len;
+
 	switch (store.state) {
 	case KEY_SEEN:
 		if (matches(key, value)) {
@@ -468,12 +471,27 @@ static int store_aux(const char* key, const char* value)
 		}
 		break;
 	case SECTION_SEEN:
-		if (strncmp(key, store.key, store.baselen+1)) {
+		/*
+		 * What we are looking for is in store.key (both
+		 * section and var), and its section part is baselen
+		 * long.  We found key (again, both section and var).
+		 * We would want to know if this key is in the same
+		 * section as what we are looking for.
+		 */
+		ep = strrchr(key, '.');
+		section_len = ep - key;
+
+		if ((section_len != store.baselen) ||
+		    memcmp(key, store.key, section_len+1)) {
 			store.state = SECTION_END_SEEN;
 			break;
-		} else
-			/* do not increment matches: this is no match */
-			store.offset[store.seen] = ftell(config_file);
+		}
+
+		/*
+		 * Do not increment matches: this is no match, but we
+		 * just made sure we are in the desired section.
+		 */
+		store.offset[store.seen] = ftell(config_file);
 		/* fallthru */
 	case SECTION_END_SEEN:
 	case START:
