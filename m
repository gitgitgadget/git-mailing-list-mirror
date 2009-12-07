From: Junio C Hamano <gitster@pobox.com>
Subject: Re: clang static analyzer
Date: Sun, 06 Dec 2009 16:18:00 -0800
Message-ID: <7vtyw3d4cn.fsf@alter.siamese.dyndns.org>
References: <33ABC714-2BCC-4910-BCAE-D331AAF2A724@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 01:21:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHRLa-000081-3q
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 01:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758674AbZLGASI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 19:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758660AbZLGASF
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 19:18:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758639AbZLGASB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 19:18:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 35479A4534;
	Sun,  6 Dec 2009 19:18:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1IN+2AYIt/tdZO4UnoBCDB29VG0=; b=mdNcfI
	9ALCD6VgRPaGDKOC7c4+9PmFRxVGfo0AvxGlFihyCBo34oBioSD0wohKqBM4Mole
	tQ3u/3/idaETjEngopDCU8C4yto2Nb1iODf2xZMEqYyWRON9pMohJ0Jv5rTwQYxZ
	6t9y4t+CbQ7O7VxSYeREnbyf6FBdDs3xJiyuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h6bZzpxzsD9oSUoaLyG5EuAmfQ3Uh5Id
	nevEPRKFMgwFmEpbObv/wAOb3am2s4vvojuv54tIdsbudpq9zchUpqGXfhhEbBG4
	gZKG2EraVXzFB+461Qj4h7e2RWaz/OhXWDXO1yjCcBcfNyVYfS4DMO30CwFdcmsN
	hsnyIXlWgpw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15821A4533;
	Sun,  6 Dec 2009 19:18:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 05D27A4532; Sun,  6 Dec 2009
 19:18:01 -0500 (EST)
In-Reply-To: <33ABC714-2BCC-4910-BCAE-D331AAF2A724@dbservice.com> (Tomas
 Carnecky's message of "Sun\, 6 Dec 2009 07\:11\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FD198EB8-E2C5-11DE-AF51-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134697>

Tomas Carnecky <tom@dbservice.com> writes:

> pretty.c:get_header() - if 'line' doesn't contain a newline character,
> line is set to NULL on first iteration and then passed to strchr() in
> the second itration.

Thanks.

In practice, we will always have a newline, as we are reading from a valid
commit object in this codepath.


 pretty.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 8f5bd1a..7eb5384 100644
--- a/pretty.c
+++ b/pretty.c
@@ -245,11 +245,11 @@ static char *get_header(const struct commit *commit, const char *key)
 	int key_len = strlen(key);
 	const char *line = commit->buffer;
 
-	for (;;) {
+	while (line) {
 		const char *eol = strchr(line, '\n'), *next;
 
 		if (line == eol)
-			return NULL;
+			break;
 		if (!eol) {
 			eol = line + strlen(line);
 			next = NULL;
@@ -262,6 +262,7 @@ static char *get_header(const struct commit *commit, const char *key)
 		}
 		line = next;
 	}
+	return NULL;
 }
 
 static char *replace_encoding_header(char *buf, const char *encoding)
