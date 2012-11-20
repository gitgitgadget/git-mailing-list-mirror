From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Tue, 20 Nov 2012 22:21:26 +0100
Message-ID: <20121120212126.GA12656@shrek.podlesie.net>
References: <20121119151845.GA29678@shrek.podlesie.net>
 <7vk3thxuj2.fsf@alter.siamese.dyndns.org>
 <20121119225838.GA23412@shrek.podlesie.net>
 <CAMP44s0f0zYa1FVf9RhNuwYJbkQ7zPwgJ6=ty3c5knjo5a2TNw@mail.gmail.com>
 <7vlidxuowf.fsf@alter.siamese.dyndns.org>
 <20121120073100.GB7206@shrek.podlesie.net>
 <20121120075628.GA7159@shrek.podlesie.net>
 <CAMP44s38gTB_3Ao1rFZgMo2EAuiNb+h88-qRFcQPRMJNxo3CAQ@mail.gmail.com>
 <20121120115942.GA6132@shrek.podlesie.net>
 <m2lidw11yb.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Balbi <balbi@ti.com>, git@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 22:21:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TavGJ-0005EQ-M4
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 22:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250Ab2KTVV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 16:21:29 -0500
Received: from [93.179.225.50] ([93.179.225.50]:54257 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753160Ab2KTVV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 16:21:28 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 7173262B; Tue, 20 Nov 2012 22:21:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m2lidw11yb.fsf@igel.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210114>

On Tue, Nov 20, 2012 at 08:58:20PM +0100, Andreas Schwab wrote:
> How about "s/(.*?<[^>]*>).*$/$1/"?  That will still fail on "<foo@bar>"
> <foo@bar>, but you'll need a full rfc822 parser to handle the general
> case anyway.

That will fail also on "<something>" <foo@bar>.


I think it's good compromise between complexity and correctness.

Felipe, may you check, it again? This time the change is trivial.

Andreas, may I add you in Thanks-to?

Thanks,

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

To avoid unnecessary complexity this code assumes that in phrase before
email address '<something>' never exists.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
 git-send-email.perl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5a7c29d..157eabc 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -924,6 +924,10 @@ sub quote_subject {
 # use the simplest quoting being able to handle the recipient
 sub sanitize_address {
 	my ($recipient) = @_;
+
+	# remove garbage after email address
+	$recipient =~ s/(.*?<[^>]*>).*$/$1/;
+
 	my ($recipient_name, $recipient_addr) = ($recipient =~ /^(.*?)\s*(<.*)/);
 
 	if (not $recipient_name) {
-- 
1.8.0.283.gc57d856
