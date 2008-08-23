From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-merge: fail properly when we are in the middle
 of a conflicted merge
Date: Sat, 23 Aug 2008 02:50:25 -0700
Message-ID: <7vljyo12n2.fsf@gitster.siamese.dyndns.org>
References: <1219479293-29111-1-git-send-email-vmiklos@frugalware.org>
 <1219479422-29148-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 11:51:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWpmV-0000Ev-EO
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 11:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbYHWJuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 05:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbYHWJuf
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 05:50:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbYHWJue (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 05:50:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B8350642E6;
	Sat, 23 Aug 2008 05:50:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7E221642DF; Sat, 23 Aug 2008 05:50:26 -0400 (EDT)
In-Reply-To: <1219479422-29148-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Sat, 23 Aug 2008 10:17:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ED535760-70F8-11DD-AA19-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93452>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Using unmerged_cache() without reading the cache first never will return
> anything. However, if we read the cache early then we have to discard it
> when we want to read it again from the disk.

I do not think the fix is correct with or without this one.  You are
writing a wrong index and recording a wrong tree object in the commit.

I have a two-liner fix for the issue I am testing right now.

diff --git c/t/t7605-merge-resolve.sh w/t/t7605-merge-resolve.sh
index ee21a10..a251dac 100755
--- c/t/t7605-merge-resolve.sh
+++ w/t/t7605-merge-resolve.sh
@@ -36,7 +36,9 @@ test_expect_success 'merge c1 to c2' '
 	git diff --exit-code &&
 	test -f c0.c &&
 	test -f c1.c &&
-	test -f c2.c
+	test -f c2.c &&
+	test 3 = $(git ls-tree -r HEAD | wc -l) &&
+	test 2 = $(git ls-files)
 '
 
 test_expect_success 'merge c2 to c3 (fails)' '
