From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Oddity in git commit summary
Date: Sun, 16 Dec 2007 15:01:39 -0800
Message-ID: <7vhciii6r0.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712151507420.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 00:02:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J42V8-0002rV-Jz
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 00:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbXLPXCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 18:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755809AbXLPXCC
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 18:02:02 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbXLPXCA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 18:02:00 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B75E2198;
	Sun, 16 Dec 2007 18:01:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F7295FF2;
	Sun, 16 Dec 2007 18:01:47 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712151507420.5349@iabervon.org> (Daniel
	Barkalow's message of "Sat, 15 Dec 2007 15:29:18 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68500>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I just noticed that I got a strange summary from git commit -a --amend 
> with the current master. It said:
>
> Created commit f16cb29: Build in checkout
>  5 files changed, 482 insertions(+), 299 deletions(-)
>  create mode 100644 builtin-checkout.c
>  delete mode 100755 git-checkout.sh
>
> But git show --stat says:
>  7 files changed, 780 insertions(+), 306 deletions(-)
>
> And git show --stat -C says:
>  6 files changed, 482 insertions(+), 8 deletions(-)

Because "git status" has -B -M and your second one does not pass any, I
would not worry about the first two differences.  But 5 vs 6 seems
funny.

print_summary() is broken.

diff --git a/builtin-commit.c b/builtin-commit.c
index 518ebe0..8435702 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -663,6 +665,8 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	rev.commit_format = get_commit_format("format:%h: %s");
 	rev.always_show_header = 0;
 
+	diff_setup_done(&rev.diffopt);
+
 	printf("Created %scommit ", initial_commit ? "initial " : "");
 
 	if (!log_tree_commit(&rev, commit)) {
