From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Suggest use of "git add file1 file2" when there is nothing to commit.
Date: Fri, 05 Jan 2007 21:57:19 -0800
Message-ID: <7vodpcae9s.fsf@assigned-by-dhcp.cox.net>
References: <20061216025309.GA19955@spearce.org>
	<1168029891.11130.18.camel@ibook.zvpunry.de>
	<7virfldryw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 06 06:57:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H34Yb-0006W2-R8
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 06:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbXAFF5V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 00:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbXAFF5V
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 00:57:21 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:47923 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbXAFF5U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 00:57:20 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070106055720.YIOC20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Sat, 6 Jan 2007 00:57:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7hxa1W0131kojtg0000000; Sat, 06 Jan 2007 00:57:35 -0500
To: Michael Loeffler <zvpunry@zvpunry.de>
In-Reply-To: <7virfldryw.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 05 Jan 2007 14:33:11 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36075>

Junio C Hamano <junkio@cox.net> writes:

> Michael Loeffler <zvpunry@zvpunry.de> writes:
>
>> Am Freitag, den 15.12.2006, 21:53 -0500 schrieb Shawn O. Pearce:
>> ...
>>> +		printf("%s (%s)\n",
>>> +			s->amend ? "# No changes" : "nothing to commit",
>>> +			use_add_msg);
>>>  }
>> I don't like the new 'nothing to commit (use "git add ... message")'
>> message. I use git status very often to see if there is something to
>> commit, but now there is always this annoying "use git add ..." message.
>
> I tend to not like _ANY_ change at all, but I've learned to wait
> and see if I get used to it when I see something that annoys me
> initially, to see if the annoyance is because what it does is
> truly wrong or it is because what it does is merely different
> from what I am used to.
>
> So I've been trying it out myself as one of the guinea pigs on
> this one as well.
>
> So far, my judgement is that this is of the better kind; it is
> easy to get used to, and once you get used to it, it is easily
> ignorable.

How about doing this?

-- >8 --
git-status: squelch "use 'git add file...'" message when unneeded

Add a field in wt_status to record if there are any uncached
changes, and use it to decide when there is no point to add the
"use 'git add'" message.

---

diff --git a/wt-status.c b/wt-status.c
index db42738..1037c94 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -15,7 +15,7 @@ static char wt_status_colors[][COLOR_MAXLEN] = {
 	"\033[31m", /* WT_STATUS_CHANGED: red */
 	"\033[31m", /* WT_STATUS_UNTRACKED: red */
 };
-static const char* use_add_msg = "use \"git add file1 file2\" to include for commit";
+static const char* use_add_msg = "use \"git add file...\" to include for commit";
 
 static int parse_status_slot(const char *var, int offset)
 {
@@ -162,13 +162,17 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
                         struct diff_options *options,
                         void *data)
 {
+	struct wt_status *s = (struct wt_status *)data;
 	int i;
-	if (q->nr)
-		wt_status_print_header("Changed but not added", use_add_msg);
+
+	s->modified = q->nr;
+	if (!q->nr)
+		return;
+
+	wt_status_print_header("Changed but not added", use_add_msg);
 	for (i = 0; i < q->nr; i++)
 		wt_status_print_filepair(WT_STATUS_CHANGED, q->queue[i]);
-	if (q->nr)
-		wt_status_print_trailer();
+	wt_status_print_trailer();
 }
 
 void wt_status_print_initial(struct wt_status *s)
@@ -291,10 +295,14 @@ void wt_status_print(struct wt_status *s)
 
 	if (s->verbose && !s->is_initial)
 		wt_status_print_verbose(s);
-	if (!s->commitable)
-		printf("%s (%s)\n",
-			s->amend ? "# No changes" : "nothing to commit",
-			use_add_msg);
+	if (!s->commitable) {
+		const char *msg =
+			s->amend ? "# No changes" : "nothing to commit";
+		if (s->modified)
+			printf("%s (%s)\n", msg, use_add_msg);
+		else
+			printf("%s\n", msg);
+	}
 }
 
 int git_status_config(const char *k, const char *v)
diff --git a/wt-status.h b/wt-status.h
index 0a5a5b7..72df1b3 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -13,6 +13,7 @@ struct wt_status {
 	char *branch;
 	const char *reference;
 	int commitable;
+	int modified;
 	int verbose;
 	int amend;
 	int untracked;
