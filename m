From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] builtin-blame: Reencode commit messages according
	to git-log rules.
Date: Wed, 22 Oct 2008 15:22:53 -0400
Message-ID: <20081022192253.GC31568@coredump.intra.peff.net>
References: <1224622557-6669-1-git-send-email-angavrilov@gmail.com> <20081022082016.GA18473@sigill.intra.peff.net> <7vd4hsv46z.fsf@gitster.siamese.dyndns.org> <20081022191415.GA31568@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 21:24:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsjJm-0003Tt-N3
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 21:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640AbYJVTXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 15:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756319AbYJVTXB
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 15:23:01 -0400
Received: from peff.net ([208.65.91.99]:4200 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758988AbYJVTW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 15:22:56 -0400
Received: (qmail 3249 invoked by uid 111); 22 Oct 2008 19:22:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 15:22:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 15:22:53 -0400
Content-Disposition: inline
In-Reply-To: <20081022191415.GA31568@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98894>

On Wed, Oct 22, 2008 at 03:14:16PM -0400, Jeff King wrote:

> > git-submodule.sh uses grep "-e" to look for two patterns and I suspect
> > older Solaris would have the same issue.
> 
> Yes, that code will break on Solaris. Most of my portability fixes have
> been in direct response to tests, so I guess we are not testing
> git-submodule very well.

And here's a patch. Though I believe this is the last "grep -e", I
wonder if it wouldn't have been wiser to simply force people on such
platforms to use GNU grep (I already have to use GNU tools to build, and
bash to run the scripts).

-- >8 --
submodule: fix some non-portable grep invocations

Not all greps support "-e", but in this case we can easily
convert it to a single extended regex.

Signed-off-by: Jeff King <peff@peff.net>
---
Passes the test scripts, but I'm not sure they are exercising this code,
anyway, since it passed on Solaris. Please double-check my conversion.

 git-submodule.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 65178ae..b63e5c3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -424,7 +424,7 @@ cmd_summary() {
 	cd_to_toplevel
 	# Get modified modules cared by user
 	modules=$(git diff-index $cached --raw $head -- "$@" |
-		grep -e '^:160000' -e '^:[0-7]* 160000' |
+		egrep '^:([0-7]* )?160000' |
 		while read mod_src mod_dst sha1_src sha1_dst status name
 		do
 			# Always show modules deleted or type-changed (blob<->module)
@@ -438,7 +438,7 @@ cmd_summary() {
 	test -z "$modules" && return
 
 	git diff-index $cached --raw $head -- $modules |
-	grep -e '^:160000' -e '^:[0-7]* 160000' |
+	egrep '^:([0-7]* )?160000' |
 	cut -c2- |
 	while read mod_src mod_dst sha1_src sha1_dst status name
 	do
-- 
1.6.0.2.825.g6d19d
