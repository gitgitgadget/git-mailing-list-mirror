From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] This patch is to allow 12 different OS's to compile and
 run git.
Date: Fri, 06 Jun 2008 16:08:15 -0700
Message-ID: <7vmylyrwkg.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com>
 <87bq2ez72u.fsf@jeremyms.com>
 <Pine.LNX.4.64.0806061359080.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Harning <harningt@gmail.com>,
	Jeremy Maitin-Shepard <jbms@cmu.edu>,
	Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 01:09:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4l3u-0006V3-4V
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305AbYFFXIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbYFFXIl
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:08:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932976AbYFFXI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 19:08:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D38813759;
	Fri,  6 Jun 2008 19:08:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D09073758; Fri,  6 Jun 2008 19:08:18 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 77BCAC44-341D-11DD-8E45-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84131>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> diff --git a/progress.c b/progress.c
> index d19f80c..295c4e3 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -241,7 +241,8 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
>  	*p_progress = NULL;
>  	if (progress->last_value != -1) {
>  		/* Force the last update */
> -		char buf[strlen(msg) + 5];
> +		/* char buf[strlen(msg) + 5]; */
> +		char *buf = alloca (strlen(msg) + 5 );
>  		struct throughput *tp = progress->throughput;
>  		if (tp) {
>  			unsigned int rate = !tp->avg_misecs ? 0 :

I do not know the situation over there these days, but I have a distant
but bitter memory of having to deal with AIX X-<.  It insisted that
inclusion of <alloca.h> to be the very first thing in the source before
anything else.  I would want to keep alloca() out of the codebase without
very good reason.  Not that I care much about portability to AIX, but not
having to worry about alloca() unless necessary is a good thing.

I do not think progress_msg() is a good reason to even worrying about a
dynamically sized array.  The function is designed to spit out a single
line of message (so the incoming msg is expected to be shorter than 80
chars or so).  If you "git grep stop_progress_msg", you will see that
there are only two callers of this function, one in progress.c itself that
says "done", and the other one in index-pack.c that gives a string
formatted into 48-byte buffer.

So we can be lazy and say:

	char buf[128];
        ...
        snprintf(buf, sizeof(buf), ", %s.\n", msg)

and be done with it.

If you really wanted to be safe and anal, you could do something like
this, which would be just as efficient and much more straightforward:

 progress.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/progress.c b/progress.c
index d19f80c..55a8687 100644
--- a/progress.c
+++ b/progress.c
@@ -241,16 +241,21 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 	*p_progress = NULL;
 	if (progress->last_value != -1) {
 		/* Force the last update */
-		char buf[strlen(msg) + 5];
+		char buf[128], *bufp;
+		size_t len = strlen(msg) + 5;
 		struct throughput *tp = progress->throughput;
+
+		bufp = (len < sizeof(buf)) ? buf : xmalloc(len + 1);
 		if (tp) {
 			unsigned int rate = !tp->avg_misecs ? 0 :
 					tp->avg_bytes / tp->avg_misecs;
 			throughput_string(tp, tp->curr_total, rate);
 		}
 		progress_update = 1;
-		sprintf(buf, ", %s.\n", msg);
-		display(progress, progress->last_value, buf);
+		sprintf(bufp, ", %s.\n", msg);
+		display(progress, progress->last_value, bufp);
+		if (buf != bufp)
+			free(bufp);
 	}
 	clear_progress_signal();
 	free(progress->throughput);
