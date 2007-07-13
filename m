From: Greg KH <greg@kroah.com>
Subject: [PATCH] make git-send-email.perl handle email addresses with no
	names when Email::Valid is present
Date: Thu, 12 Jul 2007 21:17:49 -0700
Message-ID: <20070713041749.GA28824@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 06:18:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Cbh-0003BI-Pn
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 06:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbXGMESO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 00:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbXGMESO
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 00:18:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47199 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbXGMESN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 00:18:13 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1I9Cbb-00019a-7V; Fri, 13 Jul 2007 05:18:11 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52358>

When using git-send-email.perl on a changeset that has:
	Cc: <stable@kernel.org>
in the body of the description, and the Email::Valid perl module is
installed on the system, the email address will be deemed "invalid" for
some reason (Email::Valid isn't smart enough to handle this?) and
complain and not send the address the email.

Anyway, this tiny patch fixes this problem for me.  Note, my perl-foo is
quite week, so this could probably be easily done in one line for those
with better reg-ex skills.


Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -410,6 +410,9 @@ sub extract_valid_address {
 	return $address if ($address =~ /^($local_part_regexp)$/);
 
 	if ($have_email_valid) {
+		if ($address =~ s/^<//) {
+			$address =~ s/>$//;
+		}
 		return scalar Email::Valid->address($address);
 	} else {
 		# less robust/correct than the monster regexp in Email::Valid,
