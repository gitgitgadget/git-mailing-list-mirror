From: Junio C Hamano <gitster@pobox.com>
Subject: Re: mergetool feature request - select remote or local
Date: Wed, 14 May 2008 10:47:09 -0700
Message-ID: <7vzlqsok0y.fsf@gitster.siamese.dyndns.org>
References: <200805140721.13719.xenoterracide@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 19:48:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwL5c-0002s4-0Z
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 19:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbYENRra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 13:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753669AbYENRra
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 13:47:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbYENRr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 13:47:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 89DDC415D;
	Wed, 14 May 2008 13:47:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0FDCB4154; Wed, 14 May 2008 13:47:16 -0400 (EDT)
In-Reply-To: <200805140721.13719.xenoterracide@gmail.com> (Caleb Cushing's
 message of "Wed, 14 May 2008 07:21:00 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CF9B2726-21DD-11DD-9D6E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82120>

Caleb Cushing <xenoterracide@gmail.com> writes:

> sometimes when merge-ing fast forward doesn't work. but you know what the 
> resolution you want is.
>
> example (current behavior)
> Normal merge conflict for 'css/main.css':
>   {local}: modified
>   {remote}: modified
> Hit return to start merge resolution tool (vimdiff):
>
> but I don't want to. I know the remote updates are right. I could do a git 
> checkout remotebranch filename but when you have 20 files that need updating 
> this is annoying

I never understood why people are using git and not ftp when they say the
other side is always right, but I see this comes up every once in a while,
so it would probably be a good thing to support.

> my suggestion is this
> Normal merge conflict for 'css/main.css':
>   {local}: modified
>   {remote}: modified
> Use (l)local or (r)remote or (m)anual? 

The above "(l)local" and "(m)anual" look inconsistent, and the wording
should be more like "local, remote or merge".

> also in the event of having 20 files with this issue it would be nice to have 
> an option after first starting mergetool for remote all or local all.

This makes me wonder if you are better off not using mergetool in such a
situation.  Instead, perhaps

	$ git ls-files -u --no-stage | xargs git checkout MERGE_HEAD

might be a better option?  The attached is a completely untested
weather-baloon patch.

If this turns out to be a better approach, perhaps we would further want
to tweak things to make:

	$ git checkout --unmerged MERGE_HEAD [--] [<pathspec>...]

to work (if you want "local", you would use "HEAD" instead of
"MERGE_HEAD").

I would have done so here if "git checkout" were still a scripted version,
but now it is in C, it would take significantly more effort than it is
worth just to raise a weatherbaloon.

 builtin-ls-files.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index dc7eab8..36b2875 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -181,6 +181,8 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 {
 	int len = prefix_len;
 	int offset = prefix_offset;
+	static const char *last_tag_shown;
+	static struct cache_entry *last_ce_shown;
 
 	if (len >= ce_namelen(ce))
 		die("git-ls-files: internal error - cache entry not superset of prefix");
@@ -206,7 +208,18 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 	}
 
 	if (!show_stage) {
+		/*
+		 * Even when not showing stage information, we will call this
+		 * function for each stage.  Omit duplicate output.
+		 */
+		if ((!tag ||
+		     (last_tag_shown && !strcmp(last_tag_shown, tag))) &&
+		    (last_ce_shown &&
+		     !strcmp(last_ce_shown->name, ce->name)))
+			return;
 		fputs(tag, stdout);
+		last_tag_shown = tag;
+		last_ce_shown = ce;
 	} else {
 		printf("%s%06o %s %d\t",
 		       tag,
@@ -509,6 +522,15 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 			show_unmerged = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--no-stage")) {
+			/*
+			 * ... Not really.
+			 * Sometimes we would want a list of unmerged paths.
+			 */
+			show_stage = 0;
+			show_cached = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-x") && i+1 < argc) {
 			exc_given = 1;
 			add_exclude(argv[++i], "", 0, &dir.exclude_list[EXC_CMDL]);
