From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stash --dwim safety
Date: Tue, 01 Sep 2009 21:11:37 -0700
Message-ID: <7vy6oyj892.fsf@alter.siamese.dyndns.org>
References: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
 <7v3a77dx5b.fsf@alter.siamese.dyndns.org> <vpqocpv2n93.fsf@bauges.imag.fr>
 <20090901065716.GA5575@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 06:11:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MihCP-0005Of-6e
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 06:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbZIBELq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 00:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbZIBELp
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 00:11:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbZIBELp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 00:11:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF5224079C;
	Wed,  2 Sep 2009 00:11:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bSTrrFwaw+qNJXFVnOqlb323dKk=; b=HqOQlB
	gNm2YBrGgaZEsyUS8vKIHtf+bunePeQai0gRK+hDilUOPFRah2SPrP+r2rgYrMDm
	FJvbJbg1DiqE8g+Q53wnEALKj7Q/EIwN4ltVGNklg+d7V8YJqZ9gJvc6lMtN9ecN
	Ut57lPK0GnAUKOcnquG26u3yInFYWvAOeF6X4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EolSMusUiqIUd1rZRw/Qi6PqgbPsP+Rw
	Dh0ul3r+DKewv0WSOpxqZ9NhSPuD528S/JkmFIHi8d5jiJz4lxcFr9iLI9Fz50j0
	++5vEJ+aRrv9w5xLO9iQs8NRVThwZDLTcVhytw+DyUY5HztkvpWecWKB6WfUWSAr
	mGwtzLUGMnk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B58554079B;
	Wed,  2 Sep 2009 00:11:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F0EDD40798; Wed,  2 Sep 2009
 00:11:38 -0400 (EDT)
In-Reply-To: <20090901065716.GA5575@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 1 Sep 2009 02\:57\:16 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B935FF5A-9776-11DE-AEA3-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127574>

From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Tue, 18 Aug 2009 23:38:40 +0200
Subject: [PATCH] stash: simplify defaulting to "save" and reject unknown options

With the earlier DWIM patches, certain combination of options defaulted
to the "save" command correctly while certain equally valid combination
did not.  For example, "git stash -k" were Ok but "git stash -q -k" did
not work.

This makes the logic of defaulting to "save" much simpler. If there is no
non-flag arguments, it is clear that there is no command word, and we
default to "save" subcommand.  This rule prevents "git stash -q apply"
from quietly creating a stash with "apply" as the message.

This also teaches "git stash save" to reject an unknown option.  This is
to keep a mistyped "git stash save --quite" from creating a stash with a
message "--quite", and this safety is more important with the new logic
to default to "save" with any option-looking argument without an explicit
comand word.

[jc: this is based on Matthieu's 3-patch series, and a follow-up
discussion, and he and Peff take all the credit; if I have introduced bugs
while reworking, they are mine.]

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Jeff King <peff@peff.net> writes:

 > On Tue, Sep 01, 2009 at 08:27:20AM +0200, Matthieu Moy wrote:
 >
 >> I was actually thinking of being a little more paranoid to prevent
 >> accidental "stash save": we could refuse to create a named stash when
 >> the "save" command is not given. The case I hadn't thought of was "git
 >> stash -q apply", which has 99% chances of being a typo for "git stash
 >> apply -q", and which would mean "create a stash named apply, quietly".
 >
 > I like that. I think it addresses Dscho's concern with mistakes causing
 > an unexpected stash, and it is actually more consistent with the current
 > rule (that named stashes need an explicit 'save'). IOW, it is actually a
 > bit confusing that "git stash foo" doesn't work, but "git stash -k foo"
 > does.

 Ok, then here comes the final proposal.

 Documentation/git-stash.txt |    9 +++++----
 git-stash.sh                |   27 +++++++++++++++++++++++----
 t/t3903-stash.sh            |   11 +++++++++++
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 1c4ed41..885bc97 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -14,7 +14,6 @@ SYNOPSIS
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet] [<message>]]
-'git stash' [-p|--patch|-k|--keep-index]
 'git stash' clear
 'git stash' create
 
@@ -46,9 +45,11 @@ OPTIONS
 save [--patch] [--[no-]keep-index] [-q|--quiet] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
-	--hard` to revert them.  This is the default action when no
-	subcommand is given. The <message> part is optional and gives
-	the description along with the stashed state.
+	--hard` to revert them.  The <message> part is optional and gives
+	the description along with the stashed state.  For quickly making
+	a snapshot, you can omit _both_ "save" and <message>, but giving
+	only <message> does not trigger this action to prevent misspelled
+	subcommand from making an unwanted stash.
 +
 If the `--keep-index` option is used, all changes already added to the
 index are left intact.
diff --git a/git-stash.sh b/git-stash.sh
index 9fd7289..f243376 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -8,7 +8,6 @@ USAGE="list [<options>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
    or: $dashless [save [-k|--keep-index] [-q|--quiet] [<message>]]
-   or: $dashless [-k|--keep-index]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -146,6 +145,14 @@ save_stash () {
 		-q|--quiet)
 			GIT_QUIET=t
 			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			echo "error: unknown option for 'stash save': $1"
+			usage
+			;;
 		*)
 			break
 			;;
@@ -355,6 +362,18 @@ apply_to_branch () {
 	drop_stash $stash
 }
 
+# The default command is "save" if nothing but options are given
+seen_non_option=
+for opt
+do
+	case "$opt" in
+	-*) ;;
+	*) seen_non_option=t; break ;;
+	esac
+done
+
+test -n "$seen_non_option" || set "save" "$@"
+
 # Main command set
 case "$1" in
 list)
@@ -406,9 +425,9 @@ branch)
 	apply_to_branch "$@"
 	;;
 *)
-	case $#,"$1","$2" in
-	0,,|1,-k,|1,--keep-index,|1,-p,|1,--patch,|2,-p,--no-keep-index|2,--patch,--no-keep-index)
-		save_stash "$@" &&
+	case $# in
+	0)
+		save_stash &&
 		say '(To restore them type "git stash apply")'
 		;;
 	*)
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index e16ad93..5514f74 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -208,4 +208,15 @@ test_expect_success 'stash -k' '
 	test bar,bar4 = $(cat file),$(cat file2)
 '
 
+test_expect_success 'stash --invalid-option' '
+	echo bar5 > file &&
+	echo bar6 > file2 &&
+	git add file2 &&
+	test_must_fail git stash --invalid-option &&
+	test_must_fail git stash save --invalid-option &&
+	test bar5,bar6 = $(cat file),$(cat file2) &&
+	git stash -- -message-starting-with-dash &&
+	test bar,bar2 = $(cat file),$(cat file2)
+'
+
 test_done
-- 
1.6.4.2.301.g12b4ad
