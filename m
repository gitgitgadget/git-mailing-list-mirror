From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix archive format with -- on the command line
Date: Thu, 10 Dec 2009 15:27:51 -0800
Message-ID: <7vhbry8l54.fsf_-_@alter.siamese.dyndns.org>
References: <20091210212636.GA27722@Knoppix>
 <7v1vj2a3ik.fsf@alter.siamese.dyndns.org>
 <20091210222258.GQ4114@genesis.frugalware.org>
 <7vws0u8n99.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Dec 11 00:28:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIsQa-0006fM-Qu
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 00:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761619AbZLJX15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 18:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761561AbZLJX14
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 18:27:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023AbZLJX1z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 18:27:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD1201787;
	Thu, 10 Dec 2009 18:28:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dMyGY72MZHFeM0ZV+nlY6pKR57U=; b=JZOt24
	pEb4/6kiFNuPTBw53774/2/82zAoTfno3MTfXo98dOX3IjLos+ZjpM1BKOnW6vrI
	0rhLUPaJSQhHcaJBLOjpptBUyp2hp5UB/dkM4KbPxyI9t+ylVPtxOQWRQhDCnXF4
	lH6uhNSeZZr1arqwSdH//FJWj7CSsZWbe3exM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XF57C+ZY2tTNcH6j80sX901W5ah/gvy5
	xumzGNcJ+Euqt1CNkNVWDOTfDHWGVRurqERqUFg1TDST64XtPXzJCpDEVPHHHVE2
	BZOF7a4zz/yi2DyJy0XZibFWqY9BRZcEuljp3T0h+1F2nkoyQrMNDFlIGlhdT/Xc
	1eXPvcvWMSo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87D751784;
	Thu, 10 Dec 2009 18:27:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3ACAB177D; Thu, 10 Dec
 2009 18:27:53 -0500 (EST)
In-Reply-To: <7vws0u8n99.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 10 Dec 2009 14\:42\:10 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A6B75B06-E5E3-11DE-B7E3-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135049>

Giving --format from the command line, or using output file extention to
DWIM the output format, with a pathspec that is disambiguated with an
explicit double-dash on the command line, e.g.

    git archive -o file --format=zip HEAD -- path
    git archive -o file.zip HEAD -- path

didn't work correctly.

This was because the code reordered (when one was given) or added (when
the former was inferred) a --format argument at the end, effectively
making it to "archive HEAD -- path --format=zip", i.e. an extra pathspec
that is unlikely to match anything.

The command line argument list should always be "options, revs and then
paths", and we should set a good example by inserting the --format at the
beginning instead.

Reported-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So here is one with a proper commit log message. 

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
+		 * But argv[] may contain "--"; we should make it the
+		 * first option.
 		 */
-		argv[argc++] = fmt_opt;
-		argv[argc] = NULL;
+		memmove(argv + 2, argv + 1, sizeof(*argv) * argc);
+		argv[1] = fmt_opt;
+		argv[++argc] = NULL;
 	}
 
 	if (remote)
-- 
1.6.6.rc2
