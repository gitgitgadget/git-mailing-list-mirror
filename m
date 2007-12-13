From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Thu, 13 Dec 2007 00:45:35 -0800
Message-ID: <7vhcin3rv4.fsf@gitster.siamese.dyndns.org>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
	<31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>
	<e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com>
	<402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com>
	<31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com>
	<20071212041002.GN14735@spearce.org>
	<31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>
	<20071212052329.GR14735@spearce.org>
	<31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com>
	<Pine.LNX.4.64.0712121814260.27959@racer.site>
	<31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com>
	<Pine.LNX.4.64.0712121931050.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Sewall <jasonsewall@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 13 09:46:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ji3-0008NK-Eh
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 09:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbXLMIp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 03:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbXLMIp7
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 03:45:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40253 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbXLMIp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 03:45:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D9FB37DC2;
	Thu, 13 Dec 2007 03:45:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B81007DBF;
	Thu, 13 Dec 2007 03:45:37 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712121931050.27959@racer.site> (Johannes
	Schindelin's message of "Wed, 12 Dec 2007 19:37:45 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68131>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> For this to work, apply has to be called with --unidiff-zero, since
> the new hunks can start or stop with a "-" or "+" line.

You do not have to do "unidiff zero".  Suppose you have this hunk you
need to split.

diff --git a/read-cache.c b/read-cache.c
index 7db5588..4d12073 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -12,8 +12,8 @@
 /* Index extensions.
  *
  * The first letter should be 'A'..'Z' for extensions that are not
- * necessary for a correct operation (i.e. optimization data).
- * When new extensions are added that _needs_ to be understood in
+ * necessary for a correct operation (that is, optimization data).
+ * When new extensions are added that needs to be understood in
  * order to correctly interpret the index file, pick character that
  * is outside the range, to cause the reader to abort.
  */

Think about taking the s/i.e./that is,/ substitution without taking the
other s/_needs_/needs/ substitution.  You do not split the hunk between
two '-' lines, but effectively make it into this hunk instead:

diff --git a/read-cache.c b/read-cache.c
index 7db5588..4d12073 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -12,8 +12,8 @@
 /* Index extensions.
  *
  * The first letter should be 'A'..'Z' for extensions that are not
- * necessary for a correct operation (i.e. optimization data).
+ * necessary for a correct operation (that is, optimization data).
  * When new extensions are added that _needs_ to be understood in
  * order to correctly interpret the index file, pick character that
  * is outside the range, to cause the reader to abort.
  */

That is, , if you want to do finer grained hunk splitting than what "git
add -p" lets you do, you do _not_ let user specify "I want to split the
hunk into two, before this point and after this point".  Instead, let
the user pick zero or more '-' line and zero or more '+' line, and
adjust the context around it.  An unpicked '-' line becomes the common
context, and an unpicked '+' line disappears.  After that, you recount
the diff.  That way, you do not have to do any "unidiff zero" cop-out.

At the same time, you can stash away what was _not_ picked, creating two
variants to be applied on top of the result of applying (or not
applying) the picked patch, if you want to allow "undo".

(variant one: applies after the above is applied)
@@ -12,8 +12,8 @@
 /* Index extensions.
  *
  * The first letter should be 'A'..'Z' for extensions that are not
  * necessary for a correct operation (that is, optimization data).
- * When new extensions are added that _needs_ to be understood in
+ * When new extensions are added that needs to be understood in
  * order to correctly interpret the index file, pick character that
  * is outside the range, to cause the reader to abort.
  */

(variant two: applies if the above is not applied)
@@ -12,8 +12,8 @@
 /* Index extensions.
  *
  * The first letter should be 'A'..'Z' for extensions that are not
  * necessary for a correct operation (i.e. optimization data).
- * When new extensions are added that _needs_ to be understood in
+ * When new extensions are added that needs to be understood in
  * order to correctly interpret the index file, pick character that
  * is outside the range, to cause the reader to abort.
  */
