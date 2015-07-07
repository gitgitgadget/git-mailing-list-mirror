From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5] pull: allow dirty tree when rebase.autostash enabled
Date: Tue, 7 Jul 2015 11:59:56 +0800
Message-ID: <20150707035956.GA6105@yoshi.chippynet.com>
References: <1434538880-15608-1-git-send-email-me@ikke.info>
 <1436046158-19426-1-git-send-email-me@ikke.info>
 <xmqqd205yq98.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Daudt <me@ikke.info>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 06:00:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCK3F-0001ai-Cd
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 06:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbbGGEAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 00:00:05 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36767 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbbGGEAD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 00:00:03 -0400
Received: by pacgz10 with SMTP id gz10so32145774pac.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 21:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Zh4+R8cJtcFmiHF4BpL4zFgOCBK8frOmAk0jYHNOV4Q=;
        b=OEMJzqqrlF+tMnyoXlQ1rMf1fubr9pkLwEx7Gvv5e/fh2xegxqKo6LPs1amWfuBrc5
         23CyeoycE8KJdLU12GlFfC4LMLlq1CkPiKcgKlwCenn6/meGiM41VsyNAcspOBEka1iu
         ZD4j1irgqu7kzNGS4ZwyHmGyr+IvhMETBe8cD1dPwee7vWJzJsjKAdEt2Lj4KUGZ0/Ty
         h4PdWbHsyH+Epu28VaT0c3zgdoUoTYQYwf1CNL8swi1VnRWOcVTTT9ZKkFYf2lMEBqvl
         qfE3RqZiURtjwNlIvy9Bv05VHwpY0Ar8jRQoXNbPilUvjDmTkAbYLD/0WfsIn18eKiag
         EPWg==
X-Received: by 10.66.131.110 with SMTP id ol14mr4525933pab.0.1436241602566;
        Mon, 06 Jul 2015 21:00:02 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.132.138])
        by mx.google.com with ESMTPSA id y2sm20027961pdi.80.2015.07.06.20.59.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 21:00:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqd205yq98.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273475>

On Mon, Jul 06, 2015 at 01:39:47PM -0700, Junio C Hamano wrote:
> Kevin Daudt <me@ikke.info> writes:
> 
> > rebase learned to stash changes when it encounters a dirty work tree, but
> > git pull --rebase does not.
> >
> > Only verify if the working tree is dirty when rebase.autostash is not
> > enabled.
> >
> > Signed-off-by: Kevin Daudt <me@ikke.info>
> > Helped-by: Paul Tan <pyokagan@gmail.com>
> > ---
> 
> I applied it, tried to run today's integration cycle, and then ended
> up ejecting it from my tree for now, as this seemed to break 5520
> when merged to 'pu' X-<.
> 
> Well, that is partly expected, as Paul's builtin/pull.c does not
> know about it (yet).

Yeah, sorry about that.

Here's a modified patch for the C code.

Regards,
Paul

--- >8 ---
From: Kevin Daudt <me@ikke.info>
Date: Sat, 4 Jul 2015 23:42:38 +0200

rebase learned to stash changes when it encounters a dirty work tree,
but git pull --rebase does not.

Only verify if the working tree is dirty when rebase.autostash is not
enabled.

Signed-off-by: Kevin Daudt <me@ikke.info>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c  |  6 +++++-
 t/t5520-pull.sh | 11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 722a83c..b7bc1ff 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -823,10 +823,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		hashclr(orig_head);
 
 	if (opt_rebase) {
+		int autostash = 0;
+
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		die_on_unclean_work_tree(prefix);
+		git_config_get_bool("rebase.autostash", &autostash);
+		if (!autostash)
+			die_on_unclean_work_tree(prefix);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index f4a7193..a0013ee 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -245,6 +245,17 @@ test_expect_success '--rebase fails with multiple branches' '
 	test modified = "$(git show HEAD:file)"
 '
 
+test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
+	test_config rebase.autostash true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	git pull --rebase . copy &&
+	test_cmp_rev HEAD^ copy &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "modified again"
+'
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
-- 
2.5.0.rc1.21.gbd65f2d.dirty
