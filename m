From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Mon, 19 Nov 2012 23:58:38 +0100
Message-ID: <20121119225838.GA23412@shrek.podlesie.net>
References: <20121119095747.GA13552@arwen.pp.htv.fi>
 <20121119151845.GA29678@shrek.podlesie.net>
 <7vk3thxuj2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Balbi <balbi@ti.com>, git@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 23:59:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaaIr-0004Ci-30
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 23:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab2KSW6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 17:58:41 -0500
Received: from [93.179.225.50] ([93.179.225.50]:54114 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752834Ab2KSW6l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 17:58:41 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id A4941810; Mon, 19 Nov 2012 23:58:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vk3thxuj2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210062>

On Mon, Nov 19, 2012 at 11:27:45AM -0800, Junio C Hamano wrote:
> Given that the problematic line
> 
> 	Stable Kernel Maintainance Track <stable@vger.kernel.org> # vX.Y
> 
> is not even a valid e-mail address, doesn't this new logic belong to
> sanitize_address() conceptually?

Yes, it's much better to do it in the sanitize_address().

Felipe, may you check it?

Krzysiek
-- >8 --
Subject: [PATCH] git-send-email: remove garbage after email address

In some cases it's very useful to add some additional information
after email in Cc-list, for instance:

"Cc: Stable kernel <stable@vger.kernel.org> #v3.4 v3.5 v3.6"

Currently the git refuses to add such invalid email to Cc-list,
when the Email::Valid perl module is available or just uses whole line
as the email address.

Now in sanitize_address() everything after the email address is
removed, so the resulting line is correct email address and Email::Valid
validates it correctly.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
 git-send-email.perl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5a7c29d..9840d0a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -924,6 +924,10 @@ sub quote_subject {
 # use the simplest quoting being able to handle the recipient
 sub sanitize_address {
 	my ($recipient) = @_;
+
+	# remove garbage after email address
+	$recipient =~ s/(.*>).*$/$1/;
+
 	my ($recipient_name, $recipient_addr) = ($recipient =~ /^(.*?)\s*(<.*)/);
 
 	if (not $recipient_name) {
-- 
1.8.0.283.gc57d856
