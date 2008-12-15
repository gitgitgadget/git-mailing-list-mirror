From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fatal output from git-show really wants a terminal
Date: Mon, 15 Dec 2008 00:23:54 -0800
Message-ID: <7vwse1yhgl.fsf@gitster.siamese.dyndns.org>
References: <ghop5d$qud$1@ger.gmane.org>
 <200812111051.20322.bss03@volumehost.net>
 <20081211215554.GA11565@sigill.intra.peff.net>
 <200812111645.10067.bss03@volumehost.net>
 <7vr64eb9ha.fsf@gitster.siamese.dyndns.org>
 <7v3agpzwet.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
X-From: git-owner@vger.kernel.org Mon Dec 15 09:25:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC8lY-0004Nz-Q1
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 09:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYLOIYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 03:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbYLOIYF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 03:24:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbYLOIYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 03:24:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 465E7873D1;
	Mon, 15 Dec 2008 03:24:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CBD4D873C2; Mon,
 15 Dec 2008 03:23:56 -0500 (EST)
In-Reply-To: <7v3agpzwet.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 15 Dec 2008 00:15:38 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BB482F60-CA81-11DD-A49E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103139>

Junio C Hamano <gitster@pobox.com> writes:

>> Isn't the issue about 61b8050 (sending errors to stdout under $PAGER,
>> 2008-02-16)?  With that commit, we changed things so that when we send the
>> standard output to the $PAGER, we dup stderr to the $PAGER as well,
>> because otherwise any output to stderr will be wiped out by whatever the
>> pager does and the user will not notice the breakage.  E.g.
>>
>> 	$ git log
>>
>> will just show reams of output, and you won't see any errors and warnings
>> even if there were any encountered during the process.
>>
>> Unfortunately we did it unconditionally.

By the by, I noticed that the example shown in the commit message of
61b8050 has been broken since 4f3dcc2 (Fix 'git show' on signed tag of
signed tag of commit, 2008-07-01).

Here is a fix.

 builtin-log.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git c/builtin-log.c w/builtin-log.c
index 840daf9..99d1137 100644
--- c/builtin-log.c
+++ w/builtin-log.c
@@ -340,7 +340,13 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					t->tag,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
 			ret = show_object(o->sha1, 1, &rev);
-			objects[i].item = parse_object(t->tagged->sha1);
+			if (ret)
+				break;
+			o = parse_object(t->tagged->sha1);
+			if (!o)
+				ret = error("Could not read object %s",
+					    sha1_to_hex(t->tagged->sha1));
+			objects[i].item = o;
 			i--;
 			break;
 		}
