From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] builtin-rerere: fix conflict markers parsing
Date: Tue, 08 Jul 2008 00:52:55 -0700
Message-ID: <7vwsjwvmlk.fsf_-_@gitster.siamese.dyndns.org>
References: <1215434568-30456-1-git-send-email-dkr+ml.git@free.fr>
 <alpine.DEB.1.00.0807071400180.18205@racer>
 <7vy74d4mr8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Tue Jul 08 09:54:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG81a-0007iZ-8b
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 09:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbYGHHxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 03:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbYGHHxL
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 03:53:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbYGHHxK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 03:53:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 47D34294AF;
	Tue,  8 Jul 2008 03:53:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 43847294AE; Tue,  8 Jul 2008 03:53:03 -0400 (EDT)
In-Reply-To: <7vy74d4mr8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 07 Jul 2008 10:39:23 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E7882EA0-4CC2-11DD-8D70-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87729>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> So what about
>>
>> 	<<<<<<< This hunk contains =====
>> 	anythin
>> 	=======
>>
>> 	Hello
>> 	=======
>> 	somethin else
>> 	>>>>>>> problem!
>> ...
> I however think detecting that we have this ambiguous hunk is easy, and
> punting gracefully and not re-resolving in such a case is million times
> better than producing random results that the users need to be worried
> about.

I am wondering if a patch like this on top of your patch may make things
even safer.  The idea is the same as the earlier a1b32fd (git-rerere:
detect unparsable conflicts, 2008-06-22) to fail rerere unless the markers
are unambiguous.

Thanks to your isspace(buf[7]), it is slightly less likely that this
safety triggers on false positives.

Thoughts?

-- >8 --
rerere: punt and do not resolve if conflict markers are ambiguous

Especially because we are introducing rerere.autoupdate configuration
(which is off by default for safety) that automatically stages the
resolution made by rerere, it is necessary to make sure that we do not
autoresolve when there is any ambiguity.

 builtin-rerere.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index e618862..69c3a52 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -112,12 +112,17 @@ static int handle_file(const char *path,
 	strbuf_init(&one, 0);
 	strbuf_init(&two,  0);
 	while (fgets(buf, sizeof(buf), f)) {
-		if (hunk == 0 && !prefixcmp(buf, "<<<<<<< "))
+		if (!prefixcmp(buf, "<<<<<<< ")) {
+			if (hunk)
+				goto bad;
 			hunk = 1;
-		else if (hunk == 1 && !prefixcmp(buf, "=======") &&
-			 isspace(buf[7]))
+		} else if (!prefixcmp(buf, "=======") && isspace(buf[7])) {
+			if (hunk != 1)
+				goto bad;
 			hunk = 2;
-		else if (hunk == 2 && !prefixcmp(buf, ">>>>>>> ")) {
+		} else if (!prefixcmp(buf, ">>>>>>> ")) {
+			if (hunk != 2)
+				goto bad;
 			if (strbuf_cmp(&one, &two) > 0)
 				strbuf_swap(&one, &two);
 			hunk_no++;
@@ -143,6 +148,10 @@ static int handle_file(const char *path,
 			strbuf_addstr(&two, buf);
 		else if (out)
 			fputs(buf, out);
+		continue;
+	bad:
+		hunk = 99; /* force error exit */
+		break;
 	}
 	strbuf_release(&one);
 	strbuf_release(&two);
