From: Junio C Hamano <gitster@pobox.com>
Subject: [Discuss] soften warning message after cloning "void"
Date: Wed, 18 Feb 2015 15:24:14 -0800
Message-ID: <xmqqh9ui2481.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 00:24:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YODyg-0003W6-QM
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 00:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbbBRXYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 18:24:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750770AbbBRXYR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 18:24:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 54DC53A378;
	Wed, 18 Feb 2015 18:24:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=I
	OuRgh2F8Mj+Ryj1SLwmI7oKBsk=; b=XuF2xYhubuUU1y3Kc9gI6fqbVfFjZWRAR
	xD2bLbuzB0wY5nFuB25YBGFbYmnH0BWcfM1Vuf8WRpbaj4/0aLRgqGvVdF2C7FMt
	3ns9hAoCmon53dJOCZjdiaSK0acWHmFwnHCfQkYSt4OoUNFa+oKrK+IuiTDZYvsD
	GEEn/EFzAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=fMF
	YlQvi1VqHXSQWeP3JRx8qj44FOjhA8DluCRc5F0t/p9Urj29HUlX0Jklog+yNJMZ
	Bt2m5+pQTZJnRGXKNhGtajYbxSPCjspt8VzFFQf+ilhxSOJSVeUpGfARfh32ve8i
	wCw5w6cdOORR29UsPY1ZM4aEbih9VFKbLSyYQY3k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C1263A377;
	Wed, 18 Feb 2015 18:24:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C21873A376;
	Wed, 18 Feb 2015 18:24:15 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 412F87AE-B7C5-11E4-8467-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264071>

If you did this:

    $ git init void &&
      git -C void commit --allow-empty -m initial &&
      git -C void symbolic-ref HEAD refs/heads/nosuch
    $ git clone --no-local void new

you would get

    warning: remote HEAD refers to nonexistent ref, unable to checkout.

While it is correct that we are unable to perform the normal
"checkout" of their primary branch that their HEAD points at,
it was reported that some users find this message unnecessarily
alarming.

Rephrase by saying what we decided to do, instead of only stating
what led us to that decision without telling what that decision is.
That is, "(because we cannot checkout), we left the HEAD pointing at
an unborn branch."

---
 builtin/clone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9572467..c7f1bf2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -625,8 +625,8 @@ static int checkout(void)
 
 	head = resolve_refdup("HEAD", RESOLVE_REF_READING, sha1, NULL);
 	if (!head) {
-		warning(_("remote HEAD refers to nonexistent ref, "
-			  "unable to checkout.\n"));
+		warning(_("remote HEAD refers to nonexistent ref; "
+			  "leaving the current branch unborn.\n"));
 		return 0;
 	}
 	if (!strcmp(head, "HEAD")) {
