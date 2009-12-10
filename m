From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git archive formats and dashdash
Date: Thu, 10 Dec 2009 14:05:39 -0800
Message-ID: <7v1vj2a3ik.fsf@alter.siamese.dyndns.org>
References: <20091210212636.GA27722@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Dec 10 23:05:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIr90-0005wT-99
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 23:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761868AbZLJWFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 17:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761866AbZLJWFm
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 17:05:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761856AbZLJWFl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 17:05:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD43CA5D99;
	Thu, 10 Dec 2009 17:05:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s8aR9hfMyq0ILf4QjUOWDNK/avA=; b=O+ghOb
	4zmD6LnbP4AxnP8ei9ApUvYKF8xpdLtHijkFi4O1TjYkIvB7w3jSQU9c29X5evtg
	/e8+6dWkxXJ6ihrO+NdaipSbK4LyhEOVuBZUbj/X4mKqqRR1UiWgVpUqXKJwXBbG
	Za2sVqNAuw/3Tv3FUmYWrQKQurwLJiPghRmRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EDnYRsYgpWiyJp2cvWMEcc1347OCxBUi
	DqZ8dVVk8thCm2d1Njui+C6VtnyZIgOHQ1U0SpYZBG6IlTr/CysbiH4z2g2nlW1U
	y07cytFC8AuYHHHbdOf6BfYApJbtcBCPCr02Qnv4sF77nHhDHANZr7Q7hPFgtrF6
	cW8XI+hw0Sg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BDD67A5D98;
	Thu, 10 Dec 2009 17:05:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 994BCA5D97; Thu, 10 Dec 2009
 17:05:41 -0500 (EST)
In-Reply-To: <20091210212636.GA27722@Knoppix> (Ilari Liusvaara's message of
 "Thu\, 10 Dec 2009 23\:26\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 29F4A2AA-E5D8-11DE-B88C-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135042>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> --format option of git archive stops working if -- is used:

Good catch.  Is this a regression between 1.6.5 and the current code?

 builtin-archive.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 12351e9..8ef5ab3 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -106,13 +106,17 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	if (format) {
 		sprintf(fmt_opt, "--format=%s", format);
 		/*
-		 * This is safe because either --format and/or --output must
-		 * have been given on the original command line if we get to
-		 * this point, and parse_options() must have eaten at least
-		 * one argument, i.e. we have enough room to append to argv[].
+		 * We have enough room in argv[] to muck it in place,
+		 * because either --format and/or --output must have
+		 * been given on the original command line if we get
+		 * to this point, and parse_options() must have eaten
+		 * it, i.e. we can add back one element to the array.
+		 * But argv[] may contain "--" so we should make this
+		 * the first option.
 		 */
-		argv[argc++] = fmt_opt;
-		argv[argc] = NULL;
+		memmove(argv + 2, argv + 1, sizeof(*argv) * argc);
+		argv[1] = fmt_opt;
+		argv[++argc] = NULL;
 	}
 
 	if (remote)
