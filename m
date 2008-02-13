From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] diff --relative: output paths as relative to the
 current subdirectory
Date: Wed, 13 Feb 2008 00:33:56 -0800
Message-ID: <7v3arxs1aj.fsf@gitster.siamese.dyndns.org>
References: <7vzlu524n9.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802121531170.2920@woody.linux-foundation.org>
 <7vfxvx211k.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802121550570.2920@woody.linux-foundation.org>
 <alpine.LFD.1.00.0802121604310.2920@woody.linux-foundation.org>
 <7vhcgdzm8u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 09:34:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPD4n-0000k3-E3
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 09:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549AbYBMIeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 03:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756700AbYBMIeK
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 03:34:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35081 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644AbYBMIeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 03:34:09 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 21DD13500;
	Wed, 13 Feb 2008 03:34:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 1B5F134FF; Wed, 13 Feb 2008 03:34:03 -0500 (EST)
In-Reply-To: <7vhcgdzm8u.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 12 Feb 2008 17:19:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73756>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> So I simply don't think that we should assume a working directory for any 
>> basic git operation, unless that operation fundamentally needs one because 
>> it's only defined for a system with working directories (which is fairly 
>> rare, but obviously happens: "git reset --hard", "git pull/merge", "git 
>> checkout" etc).
>
> Yeah, but that begs for a larger design-level question.
>
> Instead of treating "diff --relative=drivers/ a..b", as a
> special case, shouldn't we have a more general "I may be in a
> bare repository, but please pretend that my prefix were this
> path" option?
>
>     $ git --prefix=drivers/ diff --relative a..b -- scsi
>     $ git --prefix=drivers/scsi log a..b .
>
> Of course, if you are truly in a bare repository and if you did
> an operation that wants a work tree, you would get mostly
> useless results, e.g.
>
>     $ git --prefix=fs/ diff v2.6.24 -- ext3
>
> will give you tons of whole-file removals.
>
> I suspect that a lot of existing code assumes a non NULL prefix
> automatically means we have work tree, which needs to be fixed,
> if we go this route, though.

This does not address the above issue, but simply adds the
special purpose --relative=<path>.

The earlier one had the option described only in "git-diff"
manual page, simply because I originally planned to do this only
for "git-diff" Porcelain and nothing else.  But it should have
been described as a general diff option.  This moves the
description where it belongs to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/diff-options.txt |    8 ++++++++
 Documentation/git-diff.txt     |    5 -----
 diff.c                         |    4 ++++
 revision.c                     |    2 +-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 8d35cbd..8dc5b00 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -170,6 +170,14 @@ endif::git-format-patch[]
 	Swap two inputs; that is, show differences from index or
 	on-disk file to tree contents.
 
+--relative[=<path>]::
+	When run from a subdirectory of the project, it can be
+	told to exclude changes outside the directory and show
+	pathnames relative to it with this option.  When you are
+	not in a subdirectory (e.g. in a bare repository), you
+	can name which subdirectory to make the output relative
+	to by giving a <path> as an argument.
+
 --text::
 	Treat all files as text.
 
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 012bbdc..57c2862 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -78,11 +78,6 @@ OPTIONS
 :git-diff: 1
 include::diff-options.txt[]
 
---relative::
-	When run from a subdirectory of the project, it can be
-	told to exclude changes outside the directory and show
-	pathnames relative to it with this option.
-
 <path>...::
 	The <paths> parameters, when given, are used to limit
 	the diff to the named paths (you can give directory
diff --git a/diff.c b/diff.c
index db4bd55..2b89b16 100644
--- a/diff.c
+++ b/diff.c
@@ -2302,6 +2302,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->detect_rename = 0;
 	else if (!strcmp(arg, "--relative"))
 		DIFF_OPT_SET(options, RELATIVE_NAME);
+	else if (!prefixcmp(arg, "--relative=")) {
+		DIFF_OPT_SET(options, RELATIVE_NAME);
+		options->prefix = arg + 11;
+	}
 
 	/* xdiff options */
 	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
diff --git a/revision.c b/revision.c
index 6d9188b..4d6f57b 100644
--- a/revision.c
+++ b/revision.c
@@ -720,7 +720,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->commit_format = CMIT_FMT_DEFAULT;
 
 	diff_setup(&revs->diffopt);
-	if (prefix) {
+	if (prefix && !revs->diffopt.prefix) {
 		revs->diffopt.prefix = prefix;
 		revs->diffopt.prefix_length = strlen(prefix);
 	}
