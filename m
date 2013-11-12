From: Jeff King <peff@peff.net>
Subject: Re: [[PATCH v2]] git-send-email: Added the ability to query the
 number of smtp password questions
Date: Tue, 12 Nov 2013 15:38:31 -0500
Message-ID: <20131112203831.GB23418@sigill.intra.peff.net>
References: <1383992508-2097-1-git-send-email-silvio@port1024.net>
 <1384084613-12260-1-git-send-email-silvio@port1024.net>
 <1384084613-12260-2-git-send-email-silvio@port1024.net>
 <xmqqwqkdh59o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: silvio@port1024.net, git@vger.kernel.org,
	Silvio F <silvio.fricke@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 21:38:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgKjT-0007Cq-09
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 21:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601Ab3KLUii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 15:38:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:37987 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756537Ab3KLUid (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 15:38:33 -0500
Received: (qmail 18752 invoked by uid 102); 12 Nov 2013 20:38:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Nov 2013 14:38:33 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Nov 2013 15:38:31 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwqkdh59o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237735>

On Tue, Nov 12, 2013 at 09:57:39AM -0800, Junio C Hamano wrote:

> > With this patch "git-send-mail" ask a configurable number of questions to
> > input the smtp password. Without this patch we have only one trial.
> 
> I wonder if Git::credential (or even the underlying lower level
> credential_fill() in the helper API) should give hints to the caller
> if calling it again may yield a different result.  An interactive
> prompt may allow the user to mistype the password and then a later
> call may return a correct one, but the .netrc helper will read from
> the file and will return a fixed result, so there is no use calling
> credential_fill() again.  And in the latter case, you do not want to
> loop $askpasswordcount times.

It would be pretty easy to add an "interactive=true" flag to the
credential response (patch below). Credential readers are supposed to
ignore elements that they don't understand. So storage helpers which are
told "we got a password interactively" can choose to use that
information if they want, but current implementations will fall back to
ignoring it. Similarly, users of "git credential fill" can use it, but
it won't hurt existing readers.

> I also have to wonder if this logic belongs to git-send-email.
> Specifically, I wonder if we can place the looping logic in
> Git::credential, so that other users of the library can take
> advantage of it?

A very early draft of the credential code added looping, but I cut it
out (I think before it even made it to the list). I don't recall the
exact reason, but it was probably a combination of:

  1. It's awkward to do at the credential layer in C, because you need
     input from the calling code on whether the credential worked or
     not. The perl Git::credential can take a callback, though, which
     means the credential code owns the outer loop, and it would be
     pretty easy to just loop on trying.

  2. We already have a retry mechanism; it is called "shell history". :)

The second one is only somewhat tongue in cheek. If we were an
interactive program, retrying would be essential. But fetch and push
tend to be very easy to simply re-run, as they perform only a single
action that either works or does not. So I have not really seen anyone
make a request for the feature.

I guess "send-email" does not (always) fall under the same category
because the user may have put work into a cover letter, or filling
interactive fields. So I have no objection to adding it there, but I do
agree we might as well put it in Git::credential.

---
Here's the "interactive" patch. It needs documentation and tests, and
it would probably make sense to simplify the text bool to "0|1", just to
make life easier for other reader implementations.

diff --git a/credential.c b/credential.c
index e54753c..fccb944 100644
--- a/credential.c
+++ b/credential.c
@@ -126,6 +126,7 @@ static char *credential_ask_one(const char *what, struct credential *c,
 
 	strbuf_release(&desc);
 	strbuf_release(&prompt);
+	c->interactive = 1;
 	return xstrdup(r);
 }
 
@@ -174,6 +175,8 @@ int credential_read(struct credential *c, FILE *fp)
 			c->path = xstrdup(value);
 		} else if (!strcmp(key, "url")) {
 			credential_from_url(c, value);
+		} else if (!strcmp(key, "interactive")) {
+			c->interactive = git_config_bool("interactive", value);
 		}
 		/*
 		 * Ignore other lines; we don't know what they mean, but
@@ -200,6 +203,8 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path);
 	credential_write_item(fp, "username", c->username);
 	credential_write_item(fp, "password", c->password);
+	if (c->interactive)
+		credential_write_item(fp, "interactive", "true");
 }
 
 static int run_credential_helper(struct credential *c,
diff --git a/credential.h b/credential.h
index 0c3e85e..c0e5cbc 100644
--- a/credential.h
+++ b/credential.h
@@ -7,6 +7,7 @@ struct credential {
 	struct string_list helpers;
 	unsigned approved:1,
 		 configured:1,
+		 interactive:1,
 		 use_http_path:1;
 
 	char *username;
