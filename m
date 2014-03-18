From: Aleksey Mokhovikov <moxobukob@gmail.com>
Subject: Re: [PATCH][GSOC] Selection of the verbose message is replaced with
 generated message in install_branch_config()
Date: Tue, 18 Mar 2014 21:33:29 +0700
Message-ID: <lg9l22$qto$1@ger.gmane.org>
References: <1395050104-19152-1-git-send-email-moxobukob@gmail.com> <loom.20140318T124348-742@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 15:26:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPuyn-00037X-1U
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 15:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbaCRO0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 10:26:43 -0400
Received: from plane.gmane.org ([80.91.229.3]:54872 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462AbaCRO0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 10:26:41 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WPuyS-0002h6-Qc
	for git@vger.kernel.org; Tue, 18 Mar 2014 15:26:36 +0100
Received: from l37-193-248-93.novotelecom.ru ([37.193.248.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 15:26:36 +0100
Received: from moxobukob by l37-193-248-93.novotelecom.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 15:26:36 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: l37-193-248-93.novotelecom.ru
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <loom.20140318T124348-742@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244357>


This patch replaces if chain with
2 dimensional array of format strings and arguments.


Signed-off-by: Aleksey Mokhovikov <moxobukob@gmail.com>
---
This patch is unrelated with previous one, but related to GSoC.
So I don't know if I should create new thread for this patch.

Compare with original construction
Pros:
1) Remove if chain.
2) Single table contains all messages with arguments in one construction.
3) Less code duplication.
Cons:
1) Harder to associate the case with message.
2) Harder for compiler to warn the programmer about not
   enough arguments for format string.
3) Harder to add non-string argument to messages.

If !!(x) is out of the coding guide, then message_id construction
can be rewritten in several other ways.
The guideline tells that !!(x) is not welcome and should not be
unless needed. But looks like this is normal place for it.

P.S.
Thanks to comments I got, so
I've read more GNU gettext manual to get info
about translation workflow. When I posted a first patch
I've passed the same message format strings to gettext /*_()*/
as in original, to save the context of the message. And they
will be translated if every possible string combination
will be marked separately for translation. Because of
xgettext can extract string from source automatically,
it ruins the idea to generate message from parts. Even if the
exaclty same message format string is passed to gettext.

 branch.c | 53 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..51a5faf 100644
--- a/branch.c
+++ b/branch.c
@@ -47,12 +47,32 @@ static int should_setup_rebase(const char *origin)
 	return 0;
 }

+	
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
 	const char *shortname = remote + 11;
 	int remote_is_branch = starts_with(remote, "refs/heads/");
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
+	int message_id = (!!remote_is_branch << 2) | (!!origin << 1) | (!!rebasing);
+	const char *message_table[][4] =
+		{{N_("Branch %s set up to track local ref %s."),
+		  local, remote},
+		 {N_("Branch %s set up to track local ref %s by rebasing."),
+		  local, remote},
+		 {N_("Branch %s set up to track remote ref %s."),
+		  local, remote},
+		 {N_("Branch %s set up to track remote ref %s by rebasing."),
+		  local, remote},
+		 {N_("Branch %s set up to track local branch %s."),
+		  local, shortname},
+		 {N_("Branch %s set up to track local branch %s by rebasing."),
+		  local, shortname},
+		 {N_("Branch %s set up to track remote branch %s from %s."),
+		  local, shortname, origin},
+		 {N_("Branch %s set up to track remote branch %s from %s by rebasing."),
+		  local, shortname, origin}};
+	const char **message = NULL;

 	if (remote_is_branch
 	    && !strcmp(local, shortname)
@@ -68,7 +88,7 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
 	git_config_set(key.buf, remote);
-
+	
 	if (rebasing) {
 		strbuf_reset(&key);
 		strbuf_addf(&key, "branch.%s.rebase", local);
@@ -77,29 +97,16 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	strbuf_release(&key);

 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		if (remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote branch %s from %s by rebasing.") :
-				  _("Branch %s set up to track remote branch %s from %s."),
-				  local, shortname, origin);
-		else if (remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local branch %s by rebasing.") :
-				  _("Branch %s set up to track local branch %s."),
-				  local, shortname);
-		else if (!remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote ref %s by rebasing.") :
-				  _("Branch %s set up to track remote ref %s."),
-				  local, remote);
-		else if (!remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local ref %s by rebasing.") :
-				  _("Branch %s set up to track local ref %s."),
-				  local, remote);
+		if ((0 <= message_id) && (message_id < ARRAY_SIZE(message_table)))
+			message = message_table[message_id];
 		else
-			die("BUG: impossible combination of %d and %p",
-			    remote_is_branch, origin);
+			die("BUG: id is out of range:id=%d (is_branch=%d, origin=%p, rebasing=%d)",
+			    message_id, remote_is_branch, origin, rebasing);
+
+		if (!message || !message[0])
+			die("BUG: message is NULL. Fix verbose message table.");
+
+		printf_ln(_(message[0]), message[1], message[2], message[3]);
 	}
 }

-- 
1.8.3.2
