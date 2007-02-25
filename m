From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Update tests to use test-chmtime
Date: Sat, 24 Feb 2007 23:09:43 -0800
Message-ID: <7vzm72vhl4.fsf@assigned-by-dhcp.cox.net>
References: <11723651923476-git-send-email-normalperson@yhbt.net>
	<11723651934078-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 08:09:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLDVz-0004XF-0r
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 08:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933671AbXBYHJo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 02:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933672AbXBYHJo
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 02:09:44 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:63328 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933671AbXBYHJo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 02:09:44 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225070943.WNQB3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 02:09:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Tj9j1W0011kojtg0000000; Sun, 25 Feb 2007 02:09:43 -0500
In-Reply-To: <11723651934078-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Sat, 24 Feb 2007 16:59:52 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40540>

Eric Wong <normalperson@yhbt.net> writes:

> -case "$(date -d @11111111 +%s 2>/dev/null)" in
> -11111111)
> ...
> -	touch -m -t "$predate1" $rr/preimage
> -	touch -m -t "$predate2" $rr2/preimage
> ...
> -esac
> +now=$(date +%s)
> +almost_15_days_ago=$(($now+60-15*86400))
> +just_over_15_days_ago=$(($now-1-15*86400))
> +almost_60_days_ago=$(($now+60-60*86400))
> +just_over_60_days_ago=$(($now-1-60*86400))
> +
> +test-chmtime =$almost_60_days_ago $rr/preimage
> +test-chmtime =$almost_15_days_ago $rr2/preimage

Very nice.
I've been wanting to get rid of this part for quite a while.

However, is '+%s' output portable enough for this change to be
an improvement?

I would suggest changing "test-chmtime =-200 file" to set the
mtime of the file to 200 seconds in the past, relative to
present.

---
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index d5bb6ec..639d45f 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -112,11 +112,10 @@ rr2=.git/rr-cache/$sha2
 mkdir $rr2
 echo Hello > $rr2/preimage
 
-now=$(date +%s)
-almost_15_days_ago=$(($now+60-15*86400))
-just_over_15_days_ago=$(($now-1-15*86400))
-almost_60_days_ago=$(($now+60-60*86400))
-just_over_60_days_ago=$(($now-1-60*86400))
+almost_15_days_ago=$((60-15*86400))
+just_over_15_days_ago=$((-1-15*86400))
+almost_60_days_ago=$((60-60*86400))
+just_over_60_days_ago=$((-1-60*86400))
 
 test-chmtime =$almost_60_days_ago $rr/preimage
 test-chmtime =$almost_15_days_ago $rr2/preimage
diff --git a/test-chmtime.c b/test-chmtime.c
index 69b3ba9..2a1d00d 100644
--- a/test-chmtime.c
+++ b/test-chmtime.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include <utime.h>
 
-static const char usage_str[] = "(+|=|-)<seconds> <file_1> [<file_2>]";
+static const char usage_str[] = "(+|=|-)<seconds> <file_1>...";
 
 int main(int argc, const char *argv[])
 {
@@ -19,6 +19,10 @@ int main(int argc, const char *argv[])
 		fprintf(stderr, "Not a base-10 integer: %s\n", argv[1] + 1);
 		goto usage;
 	}
+	if (set_eq && set_time < 0) {
+		time_t now = time(NULL);
+		set_time += now;
+	}
 
 	for (i = 2; i < argc; i++) {
 		struct stat sb;
