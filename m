From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] check_repository_format_version(): run git_default_config() again
Date: Mon, 06 Aug 2007 16:08:11 -0700
Message-ID: <7vy7go9s84.fsf@assigned-by-dhcp.cox.net>
References: <2BA49414-54E0-4353-B237-7799B675FAE8@silverinsanity.com>
	<Pine.LNX.4.64.0708061831070.14781@racer.site>
	<7vbqdkcxy3.fsf@assigned-by-dhcp.cox.net>
	<7vsl6wbe9e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 07 01:08:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIBgQ-0003JR-B9
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 01:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763827AbXHFXIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 19:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763701AbXHFXIO
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 19:08:14 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:46562 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763567AbXHFXIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 19:08:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070806230813.MWUR2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 6 Aug 2007 19:08:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Yn8B1X00M1kojtg0000000; Mon, 06 Aug 2007 19:08:12 -0400
In-Reply-To: <7vsl6wbe9e.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 06 Aug 2007 13:26:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55185>

Junio C Hamano <gitster@pobox.com> writes:

> I see git_config(git_default_config) is called ... big thanks
> for sorting this mess out.
>
> I however have a mild suspicion that this has to be done much
> earlier.
> ...
> We could work this around by having the "we need config -- where
> is it" logic in setup_pager(), but if we later have new options
> like -p that affects the way how git wrapper itself behaves
> based on the configuration, we would need the same "early config
> read" logic to support it.

Ok, how about this as an interim solution?

This is a minimum change in the sense that it restores the old
behaviour of not even reading config in setup_git_directory(),
but have the core.pager honored when we know it matters.

---

 pager.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/pager.c b/pager.c
index 3bfed02..8bac9d9 100644
--- a/pager.c
+++ b/pager.c
@@ -31,8 +31,11 @@ void setup_pager(void)
 
 	if (!isatty(1))
 		return;
-	if (!pager)
+	if (!pager) {
+		if (!pager_program)
+			git_config(git_default_config);
 		pager = pager_program;
+	}
 	if (!pager)
 		pager = getenv("PAGER");
 	if (!pager)
