From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff returns fatal error with core.safecrlf is set to true.
Date: Fri, 21 Jun 2013 14:57:24 -0700
Message-ID: <7vip17ktyz.fsf@alter.siamese.dyndns.org>
References: <6a3d8a2b19a859d8c969ee434e1d6a89@meuh.org>
	<7vobazo4ds.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 23:57:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq9Kl-0000gJ-JR
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 23:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946191Ab3FUV52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 17:57:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946161Ab3FUV51 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 17:57:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 412292A280;
	Fri, 21 Jun 2013 21:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sGI9iQx3qw4huI8UhsF395v6M00=; b=b7Thzv
	queefVGz7S1be8R1tXJIHpPgM4LK0VQ+ySqbV4g4EX2XhsnVicTgolEygY6Evxoz
	o9hwmLn75C+LOERfZPcQ/yb/a5GtmuKg2PoneLpS4dSmxI+GfFSNfVj2C8aAuXhL
	h2sBZvZoZHeW56I1wX/digrOD1oFoDMaJ/n7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lXU5n1BhGlJOa+ScbsM1WNwcJw8ZGgHh
	6B/8/6m6CD6Td1l7rgeCEGe9Z62XvjOu2c6HChrxoW8Z4fK45VxUY3Y34+zUHha2
	ftbALakA/mBntPVbIpUhUEXCEO/5ZclVKx15ChNhLxnR9fTs7RpNYrxufcGv11AP
	9rdFNGXC6/U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34F8B2A27F;
	Fri, 21 Jun 2013 21:57:26 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 992082A27E;
	Fri, 21 Jun 2013 21:57:25 +0000 (UTC)
In-Reply-To: <7vobazo4ds.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 21 Jun 2013 08:44:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8EF0CE9E-DABD-11E2-9739-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228659>

Junio C Hamano <gitster@pobox.com> writes:

> The helper may want to learn a way to be told to demote that error
> to a warning.

Perhaps something like this?

 diff.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index f0b3e7c..9b4f3ac 100644
--- a/diff.c
+++ b/diff.c
@@ -2677,6 +2677,10 @@ static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
 int diff_populate_filespec(struct diff_filespec *s, int size_only)
 {
 	int err = 0;
+	enum safe_crlf crlf_warn = (safe_crlf != SAFE_CRLF_FAIL
+				    ? safe_crlf
+				    : SAFE_CRLF_WARN);
+
 	if (!DIFF_FILE_VALID(s))
 		die("internal error: asking to populate invalid file.");
 	if (S_ISDIR(s->mode))
@@ -2732,7 +2736,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(s->path, s->data, s->size, &buf, safe_crlf)) {
+		if (convert_to_git(s->path, s->data, s->size, &buf, crlf_warn)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
