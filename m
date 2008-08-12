From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule foreach - Include output and clarify usage.
Date: Mon, 11 Aug 2008 21:45:52 -0400
Message-ID: <1218505552-3276-1-git-send-email-mlevedahl@gmail.com>
References: <7vhc9rwain.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com, pasky@suse.cz, johan@herland.net
X-From: git-owner@vger.kernel.org Tue Aug 12 03:47:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiyU-0007To-P0
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbYHLBp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbYHLBp7
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:45:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:23294 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbYHLBp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:45:58 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1655391wri.5
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 18:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/x9CaPZBj2rlUZ/8R++RIjqTr5c11nTFJbO9EbvXmD8=;
        b=trFXaxEXkKBoe9hgZBrMDW9/GZP+kA92dRdsSV1T0jIZjisnA99N5xJ6m4hGkgNEsL
         JmG0au0PZleVAXaWZWkB60L81ZWzS95J30Mf+TsOQa3NxdJmr8wJmaQLwXBmzh4agbXF
         RYwlRWJwakNI84OKqSKnjCJ9BlN8lXjAlzG90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=j8bHhlXf7zG0qkUgPC4IXnBQohTF3SYskYSD8hPVwS5foQtHgSsJAOAlRoXi7EkK2t
         wsA/LvypAtpIMMiLMJGCyuoxD+5EL3E1FCdUjzOZLDO2ObsH/usVEQ7z/Dqzloym2U2I
         MJmP0SD1Ga67wXZWu67IXFEDoqPtTiQN68BqU=
Received: by 10.90.90.4 with SMTP id n4mr4804005agb.108.1218505557646;
        Mon, 11 Aug 2008 18:45:57 -0700 (PDT)
Received: from localhost.localdomain ( [71.163.41.46])
        by mx.google.com with ESMTPS id 18sm1288820wry.18.2008.08.11.18.45.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Aug 2008 18:45:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.45.g1363
In-Reply-To: <7vhc9rwain.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92058>

Petr Baudis provided good feedback on the list, leading to this
patch to modify foreach.

This clarifies that the input to "foreach" is a single shell command,
though internally foreach evaluates "$@" so *may* work even if the
user fails to enclose the command in quotes. Also, this adds output
of each submodule entered unless --quiet is given, providing feedback
at the command line but still allowing a script to precisely control
the output given.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/git-submodule.txt |   12 +++++++-----
 git-submodule.sh                |    3 ++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 3470795..abbd5b7 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
-'git submodule' foreach <command-list>
+'git submodule' [--quiet] foreach <command>
 
 
 DESCRIPTION
@@ -125,14 +125,16 @@ summary::
 	index or working tree (switched by --cached) are shown.
 
 foreach::
-	Executes an arbitrary list of commands in each checked out submodule.
+	Evaluates an arbitrary shell command in each checked out submodule.
+	The command has access to the variables $path and $sha1:
 	$path is the name of the submodule directory relative to the
 	superproject, and $sha1 is the commit as recorded in the superproject.
 	Any submodules defined in the superproject but not checked out are
-	ignored by this command, and an empty command-list provides no output.
-	A non-zero return from the command-list in any submodule causes
+	ignored by this command. Unless given --quiet, foreach prints the name
+	of each submodule before evaluating the command.
+	A non-zero return from the command in any submodule causes
 	the processing to terminate. This can be overridden by adding '|| :'
-	to the end of the command list.
+	to the end of the command.
 +
 As an example, "git submodule foreach 'echo $path `git rev-parse HEAD`' will
 show the path and currently checked out commit for each submodule.
diff --git a/git-submodule.sh b/git-submodule.sh
index fc41e59..2d57d60 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -6,7 +6,7 @@
 
 USAGE="[--quiet] [--cached] \
 [add <repo> [-b branch] <path>]|[status|init|update [-i|--init]|summary [-n|--summary-limit <n>] [<commit>]] \
-[--] [<path>...]|[foreach <command-list>]"
+[--] [<path>...]|[foreach <command>]"
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -211,6 +211,7 @@ cmd_foreach()
 	do
 		if test -e "$path"/.git
 		then
+			say "Entering '$path'"
 			(cd "$path" && eval "$@") ||
 			die "Stopping at '$path'; script returned non-zero status."
 		fi
-- 
1.6.0.rc2.45.g1363
