From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin-tag.c: allow arguments in $EDITOR
Date: Thu, 20 Dec 2007 14:14:38 -0800
Message-ID: <7vhcidovxt.fsf@gitster.siamese.dyndns.org>
References: <20071219232326.GA4135@bit.office.eurotux.com>
	<20071220095706.GA9685@bit.office.eurotux.com>
	<Pine.LNX.4.64.0712201255510.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luciano Rocha <luciano@eurotux.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 20 23:15:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5TfZ-0001hv-C9
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 23:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764556AbXLTWOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 17:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757977AbXLTWOr
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 17:14:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756358AbXLTWOq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 17:14:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EE422D4D;
	Thu, 20 Dec 2007 17:14:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 97B212D47;
	Thu, 20 Dec 2007 17:14:40 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712201255510.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 20 Dec 2007 12:58:59 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69020>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Anything wrong with that patch?
>
> http://article.gmane.org/gmane.comp.version-control.git/68444

I think Steven stopped after you poked holes in that patch.

The way scripted commands spawned editor is:

	eval "${GIT_EDITOR:=vi}" '"$@"'

which meant that $IFS characters in $GIT_EDITOR separated words
and $environment_variables were substituted.

IOW, this is possible:

	GIT_EDITOR='emacs -l $HOME/my-customization.el'

I think something like this patch is probably more appropriate.
It avoids potential bugs in splitting arguments by hand and lets the
shell deal with the issue.

---
 builtin-tag.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 274901a..fae2487 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -47,7 +47,19 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
 		editor = "vi";
 
 	if (strcmp(editor, ":")) {
-		const char *args[] = { editor, path, NULL };
+		size_t len = strlen(editor);
+		int i = 0;
+		const char *args[6];
+
+		if (strcspn(editor, "$ \t'") != len) {
+			/* there are specials */
+			args[i++] = "sh";
+			args[i++] = "-c";
+			args[i++] = "$0 \"$@\"";
+		}
+		args[i++] = editor;
+		args[i++] = path;
+		args[i] = NULL;
 
 		if (run_command_v_opt_cd_env(args, 0, NULL, env))
 			die("There was a problem with the editor %s.", editor);

	
