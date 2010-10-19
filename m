From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [WIP/PATCH 1/4] reset -p: accept "git reset -p <tree>"
Date: Tue, 19 Oct 2010 17:11:47 -0500
Message-ID: <20101019221147.GD32029@burratino>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
 <20101019175103.GA28847@kytes>
 <20101019182845.GE25139@burratino>
 <7vhbgiyoo9.fsf@alter.siamese.dyndns.org>
 <20101019221005.GC32029@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 00:15:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8KT0-0007Fq-Kx
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 00:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112Ab0JSWP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 18:15:28 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42826 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab0JSWP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 18:15:27 -0400
Received: by qwa26 with SMTP id 26so1670250qwa.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 15:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DQuPo1yL0/daGAVa88ABreisVtFEvxOnhhkgIbG72TA=;
        b=XPBE+gVKAIK8maP0iAjIz+H85+vRzjEMCJxQ7N4DiYvj3JH3psC/FsMrVwmz2QxC/+
         8naCiMg4fhTogeMB1Cjocmv+t/qBV56ZpswgKucRVUzj+yIjFg3Qp5COnzWs6hxMIerG
         uAX5RzDGcCs7NqGeLDnYQtAKuPiE7REV9Enxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xndY/ZwAdofrx4qAEEIWwvQSpRT8X8EjH0c4KoS55+3graaE4XDggIWkUjYMCyW3By
         GJLSB2lodilkqJdrlPMwPB2gLc+mKMsdCYOA7jqSgo8ghKavZkLEDe5CxjsO5H5aUXYT
         1Rs2/g/Tf8bAbZt61wHby3uAhMXlkR/aDSNiw=
Received: by 10.229.181.85 with SMTP id bx21mr4248062qcb.227.1287526526637;
        Tue, 19 Oct 2010 15:15:26 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id l14sm13786915qck.41.2010.10.19.15.15.24
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 15:15:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101019221005.GC32029@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159371>

When reset -p was implemented (v1.6.5-rc0~5^2~7, 2009-08-15), it
piggy-backed on an existing "git reset" check to verify that the
<rev> argument represents a valid commit.  By dropping that
check, we can use reset -p to apply changes from an arbitrary
tree; for example, from the linux-2.6 tree:

	git reset -p 2.6.11 -- Makefile

add--interactive already rejects invalid refs.

	$ git init >dev/null 2>&1; git reset -p HEAD; echo $?
	fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
	Use '--' to separate paths from revisions
	128

Unfortunate side-effect: reset -p will accept a blob for <rev>,
too.

	$ git reset -p HEAD:git.c; echo $?
	error: bad tree object HEAD:git.c
	No changes.
	0

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/reset.c        |   12 ++++++------
 t/t7105-reset-patch.sh |   12 ++++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 0037be4..a52e6f8 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -297,24 +297,24 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			/* Otherwise we treat this as a filename */
 			verify_filename(prefix, argv[i]);
 		}
 	}
 
+	if (patch_mode) {
+		if (reset_type != NONE)
+			die("--patch is incompatible with --{hard,mixed,soft}");
+		return interactive_reset(rev, argv + i, prefix);
+	}
+
 	if (get_sha1(rev, sha1))
 		die("Failed to resolve '%s' as a valid ref.", rev);
 
 	commit = lookup_commit_reference(sha1);
 	if (!commit)
 		die("Could not parse object '%s'.", rev);
 	hashcpy(sha1, commit->object.sha1);
 
-	if (patch_mode) {
-		if (reset_type != NONE)
-			die("--patch is incompatible with --{hard,mixed,soft}");
-		return interactive_reset(rev, argv + i, prefix);
-	}
-
 	/* git reset tree [--] paths... can be used to
 	 * load chosen paths from the tree into the index without
 	 * affecting the working tree nor HEAD. */
 	if (i < argc) {
 		if (reset_type == MIXED)
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 9891e2c..ba3ff42 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -46,10 +46,22 @@ test_expect_success PERL 'git reset -p dir' '
 	(echo y; echo n) | git reset -p dir &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
 '
 
+test_expect_success PERL 'git reset -p <tree> dir' '
+	set_state dir/foo work work &&
+	(echo y; echo n) | git reset -p HEAD^{tree} dir &&
+	verify_state dir/foo work head &&
+	verify_saved_state bar
+'
+
+test_expect_failure PERL 'git reset -p <blob>' '
+	set_state dir/foo work work &&
+	test_must_fail git reset -p HEAD:dir/foo
+'
+
 test_expect_success PERL 'git reset -p -- foo (inside dir)' '
 	set_state dir/foo work work
 	(echo y; echo n) | (cd dir && git reset -p -- foo) &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
-- 
1.7.2.3
