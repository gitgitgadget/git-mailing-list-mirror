From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] ident: check for useConfigOnly before auto-detection of name/email
Date: Fri, 01 Apr 2016 15:00:44 -0700
Message-ID: <xmqqr3epgfar.fsf@gitster.mtv.corp.google.com>
References: <1459366183-15451-1-git-send-email-redneb@gmx.com>
	<20160331144003.GE31116@sigill.intra.peff.net>
	<20160331150109.GA7235@zeno>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Marios Titas <redneb@gmx.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 00:00:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am77d-0005DC-3Z
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 00:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbcDAWAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 18:00:48 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753758AbcDAWAr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 18:00:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D5444F2FA;
	Fri,  1 Apr 2016 18:00:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ugYBJX/wVdqBhe0iq14twsN+08A=; b=yKLtl8
	MZhF/dTWx2+YK9ECPctARXqBYmddUEfbxB+V4cRKp57PQwkwXhyPRnROeRp0HnnT
	y9rK9NENX3trMMt0j9Kh2v7MaD0Xb3ieNoTtMpxxnv7RAFqliERQ5XSDerFwBoZQ
	zW6mHDKTaA7blA0VW/jJwyy1je1QFywmSs7PM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tniLM7Jrn6gVTFymdF1hOZLRtmwH6aHz
	ttJQxRq6U4jvLRG4WQ47RleIPu0daJiuFOaIEWMc95WRwf6GdCMK8wuUgk960wbo
	rG6qLZgiKTUEQ0XpyogyS60zPNKZCDo6SmQiKAs9Z3Wd8ElVUv5WIiPWD6/H0tCw
	YBLnIp4o0hY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 53EE94F2F9;
	Fri,  1 Apr 2016 18:00:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B53604F2E9;
	Fri,  1 Apr 2016 18:00:45 -0400 (EDT)
In-Reply-To: <20160331150109.GA7235@zeno> (Marios Titas's message of "Thu, 31
	Mar 2016 18:01:09 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2F80A0D4-F855-11E5-886C-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290582>

Marios Titas <redneb@gmx.com> writes:

> On Thu, Mar 31, 2016 at 10:40:03AM -0400, Jeff King wrote:
>>On Wed, Mar 30, 2016 at 10:29:42PM +0300, Marios Titas wrote:
>>
>>> If user.useConfigOnly is set, it does not make sense to try to
>>> auto-detect the name and/or the email. So it's better to do the
>>> useConfigOnly checks first.
>>
>>It might be nice to explain how it is better here. I'd guess it is
>>because we may fail during xgetpwuid(), giving a message that is much
>>less informative?
>
> Oops sorry, my bad, I should have included an example in the commit
> message. So with git 2.8.0, if you provide a name and set
> useConfigOnly to true in your ~/.gitconfig file, then if try to commit
> something in a new git repo, it will fail with the following message:
>
>    *** Please tell me who you are.
>     Run
>       git config --global user.email "you@example.com"
>      git config --global user.name "Your Name"
>     to set your account's default identity.
>    Omit --global to set the identity only in this repository.
>     fatal: unable to auto-detect email address (got 'XXX@YYY.(none)')
>
> (provided of course that auto-detection of email fails). This wrong,
> because auto-detection is disabled anyway.

OK, let's do this, then.

-- >8 --
From: Marios Titas <redneb@gmx.com>
Date: Wed, 30 Mar 2016 22:29:42 +0300
Subject: [PATCH] ident: check for useConfigOnly before auto-detection of
 name/email

If user.useConfigOnly is set, it does not make sense to try to
auto-detect the name and/or the email.  The auto-detection may
even result in a bogus name and trigger an error message.

Check if the use-config-only is set and die if no explicit name was
given, before attempting to auto-detect, to correct this.

Signed-off-by: Marios Titas <redneb@gmx.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ident.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ident.c b/ident.c
index 4bd8084..b2521ff 100644
--- a/ident.c
+++ b/ident.c
@@ -351,15 +351,15 @@ const char *fmt_ident(const char *name, const char *email,
 	if (want_name) {
 		int using_default = 0;
 		if (!name) {
+			if (strict && ident_use_config_only
+			    && !(ident_config_given & IDENT_NAME_GIVEN))
+				die("user.useConfigOnly set but no name given");
 			name = ident_default_name();
 			using_default = 1;
 			if (strict && default_name_is_bogus) {
 				fputs(env_hint, stderr);
 				die("unable to auto-detect name (got '%s')", name);
 			}
-			if (strict && ident_use_config_only
-			    && !(ident_config_given & IDENT_NAME_GIVEN))
-				die("user.useConfigOnly set but no name given");
 		}
 		if (!*name) {
 			struct passwd *pw;
@@ -374,14 +374,14 @@ const char *fmt_ident(const char *name, const char *email,
 	}
 
 	if (!email) {
+		if (strict && ident_use_config_only
+		    && !(ident_config_given & IDENT_MAIL_GIVEN))
+			die("user.useConfigOnly set but no mail given");
 		email = ident_default_email();
 		if (strict && default_email_is_bogus) {
 			fputs(env_hint, stderr);
 			die("unable to auto-detect email address (got '%s')", email);
 		}
-		if (strict && ident_use_config_only
-		    && !(ident_config_given & IDENT_MAIL_GIVEN))
-			die("user.useConfigOnly set but no mail given");
 	}
 
 	strbuf_reset(&ident);
-- 
2.8.0-246-g1783343
