From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: treat -crlf files as binary
Date: Sat, 30 Aug 2008 14:34:55 -0700
Message-ID: <7vljyefaps.fsf@gitster.siamese.dyndns.org>
References: <7vfxon4ikr.fsf@gitster.siamese.dyndns.org>
 <32541b130808291456k3de953a2yd1e93bc27ad14293@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, arman@twinsun.com
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 23:36:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZY7S-0003pJ-31
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 23:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759795AbYH3VfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 17:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755533AbYH3VfG
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 17:35:06 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759057AbYH3VfE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 17:35:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 66AE16DC21;
	Sat, 30 Aug 2008 17:35:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 281A86DC1F; Sat, 30 Aug 2008 17:34:56 -0400 (EDT)
In-Reply-To: <32541b130808291456k3de953a2yd1e93bc27ad14293@mail.gmail.com>
 (Avery Pennarun's message of "Fri, 29 Aug 2008 17:56:38 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 80575A38-76DB-11DD-8750-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94436>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> I think the bug is that "crlf=false" should not be considered the same
> as "binary=true", which seems to be a bug in the documentation, not
> the program.

Yeah, that's right.  How about doing something like this?

 Documentation/gitattributes.txt |   39 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 36 insertions(+), 3 deletions(-)

diff --git i/Documentation/gitattributes.txt w/Documentation/gitattributes.txt
index db16b0c..ec8a860 100644
--- i/Documentation/gitattributes.txt
+++ w/Documentation/gitattributes.txt
@@ -105,9 +105,8 @@ Set::
 
 Unset::
 
-	Unsetting the `crlf` attribute on a path is meant to
-	mark the path as a "binary" file.  The path never goes
-	through line endings conversion upon checkin/checkout.
+	Unsetting the `crlf` attribute on a path is tells git
+	not to attempt any end-of-line conversion  upon checkin/checkout.
 
 Unspecified::
 
@@ -482,6 +481,40 @@ in the file.  E.g. the string `$Format:%H$` will be replaced by the
 commit hash.
 
 
+USING ATTRIBUTE MACROS
+----------------------
+
+You do not want any end-of-line conversions applied to, nor textual diffs
+produced for any binary file you track.  You would need to specify e.g.
+
+------------
+*.jpg -crlf -diff
+------------
+
+but that is cumbersome.  Using attribute macros, you can specify groups of
+attributes set or unset at the same time.  The system knows a built-in
+attribute macro, `binary`:
+
+------------
+*.jpg binary
+------------
+
+which is equivalent to the above.  Note that the attribute macros can only
+be "Set" (see the above example).
+
+
+DEFINING ATTRIBUTE MACROS
+-------------------------
+
+Custom attribute macros can be defined only in the `.gitattributes` file
+at the toplevel (i.e. not in any subdirectory).  The built-in attribute
+macro "binary" is equivalent to:
+
+------------
+[attr]binary -diff -crlf
+------------
+
+
 EXAMPLE
 -------
 
