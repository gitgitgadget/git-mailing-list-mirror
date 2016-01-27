From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.c: fix help.autocorrect after 57ea712 breaks it
Date: Tue, 26 Jan 2016 22:49:36 -0800
Message-ID: <xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 07:49:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOJvD-0000VC-Ce
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 07:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbcA0Gtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 01:49:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752075AbcA0Gti (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 01:49:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B3D0323E6;
	Wed, 27 Jan 2016 01:49:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zuTZFnR7jFWbuqozuHHAXlRNeSA=; b=CO/p9E
	8Z55NAvOhNL5dXMOrtJ6WJ8AE5vz6Pwhqx0CvTAw/n08536gLVGoxsm6HyG3waZT
	iKtBnPTSn2/e96ar95PwH0TQ5FkrqOEhQ6rGU9zw8zl5EdKguoGEL+9723lpdU1j
	jlh2/huh2zBClzvKGIRvzjQSjr2id9G+LA0X8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WPWd3PHForAfMZnaobqUWdiYwQaYSPe7
	nYRSffUzHkfQSiFAwoWbMS1RfMx0Digb/Z27Li/XFcijuHJ5S0LhV2W0eI/JLo09
	LpPZ6+d1rE0jYRsxeueEpqZKeVL2jlCjq8Ek5+eOTb0q2oLbR7AntibilyY38gMi
	jUskABOjHCo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 18FDC323E5;
	Wed, 27 Jan 2016 01:49:38 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 84F7F323E1;
	Wed, 27 Jan 2016 01:49:37 -0500 (EST)
In-Reply-To: <xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 26 Jan 2016 12:11:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 21DE1BDA-C4C2-11E5-A6C1-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284872>

Junio C Hamano <gitster@pobox.com> writes:

> I spoke too soon, I am afraid.
> ...
> I wonder if this would be better done as a multi-part series that
> goes like this:
> ...

So here is the first of the three-patch series to replace it.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 26 Jan 2016 11:46:53 -0800
Subject: [PATCH 1/3] git: remove an early return from save_env_before_alias()

When help.autocorrect is in effect, an attempt to auto-execute an
uniquely corrected result of a misspelled alias will result in an
irrelevant error message.  The codepath that causes this issue calls
save_env_before_alias() and restore_env() as a pair in handle_alias(),
and that happens twice.  A global variable orig_cwd is allocated and
holds the return value of getcwd() in save_env_before_alias(), which
is used in restore_env() to go back to that directory and freed.

However, save_env_before_alias() is not prepared to be called twice.
It returns early when it knows it has already been called, leaving
orig_cwd undefined, which is then checked in the second call to
restore_env(), and by that time, the memory that used to hold the
contents of orig_cwd is either freed or reused to hold something else,
and this is fed to chdir(), causing it to fail.

Fix this by making sure save_env() does do the saving when called.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/git.c b/git.c
index 98d4412..a57a4cb 100644
--- a/git.c
+++ b/git.c
@@ -30,8 +30,6 @@ static int saved_env_before_alias;
 static void save_env_before_alias(void)
 {
 	int i;
-	if (saved_env_before_alias)
-		return;
 	saved_env_before_alias = 1;
 	orig_cwd = xgetcwd();
 	for (i = 0; i < ARRAY_SIZE(env_names); i++) {
-- 
2.7.0-366-g065efda
