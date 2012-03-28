From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] add -p: skip conflicted paths
Date: Wed, 28 Mar 2012 22:20:17 +0200
Message-ID: <1332966017-6100-1-git-send-email-kusmabite@gmail.com>
References: <7viphov839.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, matthieu.moy@grenoble-inp.fr,
	hellmuth@ira.uka.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 22:20:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzM6-0007OB-7e
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758590Ab2C1UUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 16:20:25 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52136 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758510Ab2C1UUY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 16:20:24 -0400
Received: by bkcik5 with SMTP id ik5so1333188bkc.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gw5M6Z55VYZWUWKcn5KrZunsEyvYWxcqZESm22xXTqA=;
        b=I9EB7e9VU0kUe25WEETfMlDUrxf9rmCt1ExzNcWEPXVfckGcJ8HDELd/ulZViSML/z
         6gQKPW+56gWJmSTj+Tvimyxm4SxcU5nkAtRV2N0k5XEb1sRwFoi7Gz4NuD8gXYAyiHkk
         jMCfXigRJrttdtl9PUWO0QO3niXiWIJ+yP76fgYCmEs9qnCtUFTf4IHNynkTD4dtruFB
         c/5G7X4wBVG4OYPK2ePDMdJ1js+IVxECOd2oRQaduc7loz8lJLZXRFQiSCbcA8tLndrF
         wHfwi4x0dbE4v8OF7GEPMGttunDeTTs39iN+7vJ2N3IPRZw+sI2PT55M+9qfmWw3H7xj
         ECnQ==
Received: by 10.205.125.148 with SMTP id gs20mr4827122bkc.47.1332966023393;
        Wed, 28 Mar 2012 13:20:23 -0700 (PDT)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id u5sm9036962bka.5.2012.03.28.13.20.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 13:20:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <7viphov839.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194186>

When performing "git add -p" on a file in a conflicted state, we
currently spew the diff and terminate the process.

This is not very helpful to the user. Change the behaviour to
skipping the file, while outputting a warning.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

On Wed, Mar 28, 2012 at 9:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Perhaps teach list_modified(), which currently takes 'file-only' and
> 'index-only', to also take an option to omit (and warn if it is
> appropriate) unmerged paths?

Good idea. This way, the path doesn't even get listed when using
git add -i, and no warning is spewed on "git add -p" without specifying
the path. It seems like the right thing to do.

Again, I'm no Perl-guru, so apologies if the code isn't idiomatic.

 git-add--interactive.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8f0839d..4913203 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -270,7 +270,7 @@ sub get_empty_tree {
 # FILE_ADDDEL:	is it add/delete between index and file?
 
 sub list_modified {
-	my ($only) = @_;
+	my ($only, $omit_unmerged) = @_;
 	my (%data, @return);
 	my ($add, $del, $adddel, $file);
 	my @tracked = ();
@@ -359,6 +359,10 @@ sub list_modified {
 				next if ($it->{FILE} eq 'nothing');
 			}
 		}
+		if ($omit_unmerged && run_cmd_pipe(qw(git ls-files -u --), $_)) {
+			print colored $error_color, "Warning: $_ is in conflicted state, skipping.\n" if @ARGV;
+			next;
+		}
 		push @return, +{
 			VALUE => $_,
 			%$it,
@@ -1189,7 +1193,7 @@ sub apply_patch_for_checkout_commit {
 }
 
 sub patch_update_cmd {
-	my @all_mods = list_modified($patch_mode_flavour{FILTER});
+	my @all_mods = list_modified($patch_mode_flavour{FILTER}, 1);
 	my @mods = grep { !($_->{BINARY}) } @all_mods;
 	my @them;
 
-- 
1.7.9
