From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] revision: --ancestry-path
Date: Wed, 21 Apr 2010 10:46:22 +0200
Message-ID: <201004211046.22643.johan@herland.net>
References: <201004201649.31084.johan@herland.net>
 <4BCEADA3.7090504@viscovery.net> <7vochdcjz5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 10:46:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4VZq-0007i1-2r
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 10:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab0DUIq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 04:46:26 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59419 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106Ab0DUIqY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 04:46:24 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L170084FXPBTS60@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 21 Apr 2010 10:46:23 +0200 (MEST)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L1700GPPXPAOP00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 21 Apr 2010 10:46:23 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.4.21.83615
User-Agent: KMail/1.13.2 (Linux/2.6.33-ARCH; KDE/4.4.2; x86_64; ; )
In-reply-to: <7vochdcjz5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145418>

On Wednesday 21 April 2010, Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> > Am 4/21/2010 9:34, schrieb Johan Herland:
> >> I can confirm that this patch works with my original (more
> >> complicated) scenario. I've also played around with combinations of
> >> --ancestry-path, -- graph and --parents (and even --boundary), and
> >> AFAICS, the new option does not clobber the other options, and (IMHO)
> >> it all behaves correctly in the scenarios I've tested.
> > 
> > How about possible interactions with --reverse;
> > --date-order/--topo-order, --parents (important for gitk);
> > --simplify-by-decoration (useful for your problem that triggered
> > this); --full-history and --simplify-merges with path limiting?
> 
> These are all good points.
> 
> I am reasonably sure that parents (specifically, "rewrite_parents") is
> broken.  The new function should cull parents that do not appear on the
> ancestry path from merges (that is what "NEEDSWORK" is about).  It may or
> may not break gitk, though---these off-path parents are shown as parents
> of an on-path merge but will be marked as UNINTERESTING.

FWIW, I added the following patch to 'gitk', and then ran it against the 
t6019 test repo as follows:

	gitk --ancestry-path D..M

...and the resulting graph is exactly what I'd expect; showing the 
uninteresting parents (D, G and K) as "hollow" nodes.


diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1b0e09a..7749d2a 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -190,7 +190,7 @@ proc parseviewargs {n arglist} {
            "--author=*" - "--committer=*" - "--grep=*" - "-[iE]" -
            "--remove-empty" - "--first-parent" - "--cherry-pick" -
            "-S*" - "--pickaxe-all" - "--pickaxe-regex" -
-           "--simplify-by-decoration" {
+           "--simplify-by-decoration" - "--ancestry-path" {
                # These mean that we get a subset of the commits
                set filtered 1
                lappend glflags $arg


> I do not think reverse/date-order/topo-order would be affected by this
> change, as they only change the presentation order of what limit_list()
> returns;
> 
> Also simplify-merges and full-history should be Ok, as they control what
> is done in the current logic in limit_list(), which is an input to the
> new logic, meaning that the new logic will work on already simplified
> history.
> 
> This is not a new problem, but I strongly suspect that cherry-pick is
> broken the same way wrt "rewrite_parents".

I'm not very familiar with "rewrite_parents", nor do I know exactly how it 
should affect/interoperate with --ancestry-path in all cases, but running

	git rev-list D..M -- M.t

produces one commit (M), whereas

	git rev-list --ancestry-path D..M -- M.t

produces nothing, so I suspect there is something not quite right here.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
