From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow pickaxe and diff-filter options to be used by git log.
Date: Thu, 18 May 2006 22:41:43 -0700
Message-ID: <7vbqtuk1uw.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP04945C92FB14DA65AB1AC7AEA70@CEZ.ICE>
	<7vac9elm2p.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP096010F052E9BF78B5FD4AAEA70@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 07:42:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgxkF-0003St-1c
	for gcvg-git@gmane.org; Fri, 19 May 2006 07:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWESFlp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 01:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWESFlp
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 01:41:45 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:8680 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932230AbWESFlo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 01:41:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060519054143.JYZW15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 May 2006 01:41:43 -0400
To: Sean <seanlkml@sympatico.ca>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20323>

Sean <seanlkml@sympatico.ca> writes:

> +	if (rev->always_show_header) {
> +		if (rev->diffopt.pickaxe || rev->diffopt.filter) {

I understand and agree to the change up to this part, but I do
not necessarily agree with what follows:

> +			rev->always_show_header = 0;
> +			if (rev->diffopt.output_format == DIFF_FORMAT_RAW)
> +				rev->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;

To me, if the user explicitly says --diff-filter or -S, it seems
more natural to interpret that the user wanted _some_ sort of
diff.  Now, there are people who say raw format is anti-human,
which I consider is a valid view, but I think it is better than
NO_OUTPUT in that case.

I wonder if doing something like this instead makes more sense
perhaps?

-- >8 --

diff --git a/builtin-log.c b/builtin-log.c
index 69f2911..e68bfad 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -23,6 +23,35 @@ static int cmd_log_wc(int argc, const ch
 	if (argc > 1)
 		die("unrecognized argument: %s", argv[1]);
 
+	if (rev->always_show_header) {
+		/* Log command is primarily about the message for human
+		 * consumption, but if the user asks for any diff, it
+		 * is human unfriendly to give the raw diff.
+		 *
+		 * Show command is the same way, but there the default is
+		 * always give patch output, so this does not trigger.
+		 */
+		if (rev->diffopt.output_format == DIFF_FORMAT_RAW) {
+			if (rev->diffopt.pickaxe)
+				rev->diffopt.output_format = DIFF_FORMAT_PATCH;
+			else {
+				rev->diffopt.output_format = DIFF_FORMAT_DIFFSTAT;
+				rev->diffopt.summary = 1;
+			}
+		}
+
+		/* If the user is limiting the commits to the ones
+		 * that have particular classes of diff, we should not
+		 * show the log message for irrelevant ones.
+		 *
+		 * git show --diff-filter=R -M --all can be used to view
+		 * the branch tips that renames something.  I do not know
+		 * how useful that is, though.
+		 */
+		if (rev->diffopt.pickaxe || rev->diffopt.filter)
+			rev->always_show_header = 0;
+	}
+
 	prepare_revision_walk(rev);
 	setup_pager();
 	while ((commit = get_revision(rev)) != NULL) {
