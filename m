From: Tamer TAS <tamertas@outlook.com>
Subject: Re: [PATCH][GSOC2014] changed logical chain in branch.c to lookup
 tables
Date: Tue, 11 Mar 2014 04:33:24 -0700 (PDT)
Message-ID: <1394537604079-7605407.post@n2.nabble.com>
References: <BLU0-SMTP15131ED34F192C9871ACC0CD5740@phx.gbl> <CAPig+cS3H_8gZOuyro_Vt0ay3xphvsB92zFgwFfCdgKsXjU0Gg@mail.gmail.com> <1394488063227-7605372.post@n2.nabble.com> <CAPig+cTOZrQY1azPCmzdrfut0S_-8ZDoob3cEqT7Z1kDpj+PQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 12:33:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNKw5-0001Tk-MF
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 12:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbaCKLdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 07:33:25 -0400
Received: from sam.nabble.com ([216.139.236.26]:53141 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbaCKLdY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 07:33:24 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <tamertas@outlook.com>)
	id 1WNKw0-0006I5-2t
	for git@vger.kernel.org; Tue, 11 Mar 2014 04:33:24 -0700
In-Reply-To: <CAPig+cTOZrQY1azPCmzdrfut0S_-8ZDoob3cEqT7Z1kDpj+PQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243857>

Eric Sunshine wrote
> On Mon, Mar 10, 2014 at 5:47 PM, Tamer TAS &lt;

> tamertas@

> &gt; wrote:
> 
> Section 4.3 of the GNU gettext manual [1] explains the issues in more
> detail. I urge you to read it. The upshot is that translators fare
> best when handed full sentences.
> 
> Note also that your change effectively reverts d53a35032a67 [2], which
> did away with the sort of string composition used in your patch.

Eric thank you for your constructive feedbacks.
I read the section 4.3 of GNU gettext manual and also checked the commit you
mentioned.
It seems like that my previous changes were not internationalization
compatible.
In order for a table-driven change to be compatible, the sentences has to be
meaningful and not tokenized.
I made the following change to the branch.c in order for the function to be
both table-driven and
internationalization compatible. Let me know if there are any oversights on
my part.

Signed-off-by: TamerTas <tamertas@outlook.com>
---
 branch.c |   39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..4c04638 100644
--- a/branch.c
+++ b/branch.c
@@ -50,10 +50,25 @@ static int should_setup_rebase(const char *origin)
 void install_branch_config(int flag, const char *local, const char *origin,
const char *remote)
 {
 	const char *shortname = remote + 11;
+    const char *setup_messages[] = {
+		_("Branch %s set up to track remote branch %s from %s."),
+		_("Branch %s set up to track local branch %s."),
+		_("Branch %s set up to track remote ref %s."),
+		_("Branch %s set up to track local ref %s."),
+		_("Branch %s set up to track remote branch %s from %s by rebasing."),
+		_("Branch %s set up to track local branch %s by rebasing."),
+		_("Branch %s set up to track remote ref %s by rebasing."),
+		_("Branch %s set up to track local ref %s by rebasing.")
+	}; 
+
 	int remote_is_branch = starts_with(remote, "refs/heads/");
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
+    int msg_index = (!!origin           >> 0) +
+					(!!remote_is_branch >> 1) +
+					(!!rebasing         >> 2);
+   
 	if (remote_is_branch
 	    && !strcmp(local, shortname)
 	    && !origin) {
@@ -77,29 +92,7 @@ void install_branch_config(int flag, const char *local,
const char *origin, cons
 	strbuf_release(&key);
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		if (remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote branch %s from %s by rebasing.")
:
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
-		else
-			die("BUG: impossible combination of %d and %p",
-			    remote_is_branch, origin);
+		printf_ln(setup_messages[msg_index], local, remote);
 	}
 }
 
-- 
1.7.9.5



--
View this message in context: http://git.661346.n2.nabble.com/PATCH-GSOC2014-changed-logical-chain-in-branch-c-to-lookup-tables-tp7605343p7605407.html
Sent from the git mailing list archive at Nabble.com.
