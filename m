From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-help: add "help.format" config variable.
Date: Fri, 14 Dec 2007 21:20:29 -0800
Message-ID: <7vir30o7oi.fsf@gitster.siamese.dyndns.org>
References: <20071215055728.857b1924.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Dec 15 06:21:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3PSk-0005nb-AI
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 06:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbXLOFUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 00:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbXLOFUs
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 00:20:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbXLOFUr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 00:20:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2508286DD;
	Sat, 15 Dec 2007 00:20:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 74F9586DC;
	Sat, 15 Dec 2007 00:20:37 -0500 (EST)
In-Reply-To: <20071215055728.857b1924.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 15 Dec 2007 05:57:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68376>

Christian Couder <chriscool@tuxfamily.org> writes:

> Note that this patch also revert some recent changes in
> "git-browse-help" because they prevented to look for config
> variables in the global configuration file.

You are right, but I think git-sh-setup can further be simplified, as
NONGIT_OK users would just rely on the default behaviour of underlying
plumbing (most notably "git config").

I do not think your change to help.c is sufficient to work inside a
subdirectory.  Here is an attempt to fix it on top of yours.

---

 git-sh-setup.sh |    7 +------
 help.c          |    3 +++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index b366761..270d559 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -124,13 +124,8 @@ get_author_ident_from_commit () {
 
 # Make sure we are in a valid repository of a vintage we understand,
 # if we require to be in a git repository.
-if test -n "$NONGIT_OK"
+if test -z "$NONGIT_OK"
 then
-	if git rev-parse --git-dir >/dev/null 2>&1
-	then
-		: ${GIT_DIR=.git}
-	fi
-else
 	if [ -z "$SUBDIRECTORY_OK" ]
 	then
 		: ${GIT_DIR=.git}
diff --git a/help.c b/help.c
index af0a433..551b5b9 100644
--- a/help.c
+++ b/help.c
@@ -374,6 +374,9 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	}
 
 	else {
+		int nongit;
+
+		setup_git_directory_gently(&nongit);
 		git_config(git_help_config);
 		if (help_default_format)
 			parse_help_format(help_default_format);
