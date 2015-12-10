From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-clone fails when current user is not in /etc/passwd
Date: Thu, 10 Dec 2015 10:43:17 -0800
Message-ID: <xmqqoadyi1q2.fsf@gitster.mtv.corp.google.com>
References: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
	<CACsJy8AQFSvcxKqSdWfvGArV60RA96WcvvofpfJ4EuG+q_=t0Q@mail.gmail.com>
	<CACsJy8Dc3Lsqa2zccoqH7UkDitqDbOTX3EXsUCcN9OHY=LfaKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Taylor Braun-Jones <taylor@braun-jones.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 19:43:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a76Bj-0004tY-Pl
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 19:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbbLJSn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 13:43:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752180AbbLJSnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 13:43:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF8CC3240B;
	Thu, 10 Dec 2015 13:43:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/CUwqxI0gyi+z+6p++e97d9g99s=; b=lUBk/n
	nEAYPYEyQcQ7Llp4pbYjRUCktYtibyXg3TwcXbAEgHiaj+lqfOl6Jf6fWln8zAe5
	w4XAN+M6nV1QyYpxK3I3H741d5oht1c0CRlVogygeve0wSUP3RIpuzIiGajlrzII
	4NHMypO3lw4pd1/JKDVf+H3YFGJZUq5nNe3Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oT/MKof4gf4u2sPvHgyvXLn6zkZ1WE6G
	N0QXWtHk+8AnYUMAwSPw93vA1lF0bR0mYbAaSnphoYUVYNQZEk0191r37uziAMZX
	b0oTNWhEqpVmIHYqhQaIHP9GLIsOpHRC5ZCZpw4oHk2JrH90f/hqVmw4NGA6zbIr
	KjC8zVtQiDs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE4463240A;
	Thu, 10 Dec 2015 13:43:18 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4751332409;
	Thu, 10 Dec 2015 13:43:18 -0500 (EST)
In-Reply-To: <CACsJy8Dc3Lsqa2zccoqH7UkDitqDbOTX3EXsUCcN9OHY=LfaKw@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 9 Dec 2015 19:24:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E131BFAC-9F6D-11E5-B925-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282222>

Duy Nguyen <pclouds@gmail.com> writes:

> Well.. reflog needs it. So either you disable reflog at clone time or
> define name/email via config file. I don't see anything wrong with
> this behavior.

Hmm, I am not quite sure about that.

In the codepath that computes ident_default_email(), which is one
half of what the "reflog" code you cite wants to do, copy_email()
calls copy_email() which in turn calls add_domainname().  If your
getpwuid() gave you some username, but your gethostname() gave you a
NULL, we do not barf but add "(none)" as and then issue a warning.

Perhaps we can do the same by returning a structure with members set
to a set of fake values.  Because we already have checks in places
that really matter to the recorded history (read: not reflog) in the
form of *_ident_sufficiently_given() functions, potential damage due
to having phoney names returned from here would not be too bad.

Totally untested...

 ident.c   | 13 ++++++++++---
 wrapper.c |  4 ----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/ident.c b/ident.c
index 4e7f99d..2ccae2c 100644
--- a/ident.c
+++ b/ident.c
@@ -31,7 +31,7 @@ static void copy_gecos(const struct passwd *w, struct strbuf *name)
 	 * with commas.  Also & stands for capitalized form of the login name.
 	 */
 
-	for (src = get_gecos(w); *src && *src != ','; src++) {
+	for (src = w ? get_gecos(w) : "&"; *src && *src != ','; src++) {
 		int ch = *src;
 		if (ch != '&')
 			strbuf_addch(name, ch);
@@ -117,7 +117,7 @@ static void copy_email(const struct passwd *pw, struct strbuf *email)
 	 * Make up a fake email address
 	 * (name + '@' + hostname [+ '.' + domainname])
 	 */
-	strbuf_addstr(email, pw->pw_name);
+	strbuf_addstr(email, pw ? pw->pw_name : "unknown");
 	strbuf_addch(email, '@');
 
 	if (!add_mailname_host(email))
@@ -332,8 +332,15 @@ const char *fmt_ident(const char *name, const char *email,
 				fputs(env_hint, stderr);
 			die("empty ident name (for <%s>) not allowed", email);
 		}
+		errno = 0;
 		pw = xgetpwuid_self();
-		name = pw->pw_name;
+		if (!pw) {
+			warning(_("unable to look up current user: %s"),
+				errno ? strerror(errno) : _("no such user"));
+			name = "unknown";
+		} else {
+			name = pw->pw_name;
+		}
 	}
 
 	if (strict && email == git_default_email.buf &&
diff --git a/wrapper.c b/wrapper.c
index 6fcaa4d..16ab45f 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -605,11 +605,7 @@ struct passwd *xgetpwuid_self(void)
 {
 	struct passwd *pw;
 
-	errno = 0;
 	pw = getpwuid(getuid());
-	if (!pw)
-		die(_("unable to look up current user in the passwd file: %s"),
-		    errno ? strerror(errno) : _("no such user"));
 	return pw;
 }
 
