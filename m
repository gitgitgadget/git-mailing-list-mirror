From: Junio C Hamano <gitster@pobox.com>
Subject: Re* git submodule output on invalid command
Date: Fri, 05 Sep 2008 11:52:41 -0700
Message-ID: <7vy726v30m.fsf@gitster.siamese.dyndns.org>
References: <1220631370-19777-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Sep 05 20:54:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbgRV-0008FR-Jm
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 20:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbYIESwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 14:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbYIESwt
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 14:52:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbYIESws (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 14:52:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 08F36746F2;
	Fri,  5 Sep 2008 14:52:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 912AE746EF; Fri,  5 Sep 2008 14:52:43 -0400 (EDT)
In-Reply-To: <1220631370-19777-1-git-send-email-pdebie@ai.rug.nl> (Pieter de
 Bie's message of "Fri, 5 Sep 2008 18:16:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D4ACB034-7B7B-11DD-BFEB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95030>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> ..., something like 'git
> submodule satsus' is valid and should return nothing, because there are
> no submodules in the 'satsus' path. However, I still feel this should
> produce a warning.
>
> I'm sure there is a nicer way to alert the user than my patch below, which
> warns if the user did not supply any valid paths. Anyone else got a more
> satisfying approach?

"ls-files --error-unmatch" would warn you of mistyped nonexistent paths,
but "git submodule Makefile" would still catch the Makefile from the
toplevel superproject happily and will not complain without checking after
filtering by submodules.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 1c39b59..3aae746 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -59,7 +59,12 @@ resolve_relative_url ()
>  #
>  module_list()
>  {
> -       git ls-files --stage -- "$@" | grep '^160000 '
> +       git ls-files --stage -- "$@" | grep '^160000 ' ||
> +       if test -z "$@"; then

Shell nit; this must be "$*" not "$@", right?

> +               die "This repository contains no submodules"
> +       else
> +               die "Could not find any submodules in paths $@"

Because die() acts as if it is a fancier echo from output POV this does
not matter in practice, but as a principle, this should also be "$*"
instead.  Upon seeing "git submodule a b c", your intention is not to pass
three parameters "Could not find a", "b" and "c" to die() but is to pass a
single string that is the error message.

By the way, because this "limiting only to submodules" seem to appear very
often, we might want to give ls-files a native feature to do so, perhaps
something like this.  Then your warning/error could become:

	git ls-files --limit-type=submodule --error-unmatch

Although we would need to make the error message that comes from this
codepath tweakable by the caller.

 builtin-ls-files.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git c/builtin-ls-files.c w/builtin-ls-files.c
index e8d568e..69e3b5b 100644
--- c/builtin-ls-files.c
+++ w/builtin-ls-files.c
@@ -28,6 +28,10 @@ static const char **pathspec;
 static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
+static unsigned int limit_types;
+#define ENTRY_REGULAR   02
+#define ENTRY_SYMLINK   01
+#define ENTRY_SUBMODULE 04
 
 static const char *tag_cached = "";
 static const char *tag_unmerged = "";
@@ -37,6 +41,18 @@ static const char *tag_killed = "";
 static const char *tag_modified = "";
 
 
+static unsigned int entry_type_from_name(const char *name)
+{
+	if (!strcmp(name, "regular"))
+		return ENTRY_REGULAR;
+	else if (!strcmp(name, "symlink"))
+		return ENTRY_SYMLINK;
+	else if (!strcmp(name, "submodule"))
+		return ENTRY_SUBMODULE;
+	else
+		die("Unknown entry type: %s", name);
+}
+
 /*
  * Match a pathspec against a filename. The first "skiplen" characters
  * are the common prefix
@@ -205,6 +221,20 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 		tag = alttag;
 	}
 
+	if (limit_types) {
+		unsigned int entry_type;
+		if (S_ISLNK(ce->ce_mode))
+			entry_type = ENTRY_SYMLINK;
+		else if (S_ISREG(ce->ce_mode))
+			entry_type = ENTRY_REGULAR;
+		else if (S_ISGITLINK(ce->ce_mode))
+			entry_type = ENTRY_SUBMODULE;
+		else
+			die("Unknown type of entry %06o", ce->ce_mode);
+		if (!(limit_types & entry_type))
+			return;
+	}
+
 	if (!show_stage) {
 		fputs(tag, stdout);
 	} else {
@@ -551,6 +581,10 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 			with_tree = arg + 12;
 			continue;
 		}
+		if (!prefixcmp(arg, "--limit-type=")) {
+			limit_types |= entry_type_from_name(arg + 13);
+			continue;
+		}
 		if (!prefixcmp(arg, "--abbrev=")) {
 			abbrev = strtoul(arg+9, NULL, 10);
 			if (abbrev && abbrev < MINIMUM_ABBREV)
