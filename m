From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: git checkout creates strange '(null)'-branch
Date: Tue, 8 May 2012 13:24:15 +0200
Message-ID: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 13:25:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRiXO-00063t-8S
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 13:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685Ab2EHLY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 07:24:57 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45131 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab2EHLY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 07:24:56 -0400
Received: by pbbrp8 with SMTP id rp8so7920417pbb.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 04:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:from:date:message-id:subject:to:content-type;
        bh=zCJG0HxLqXM+/2sVHh/ljypHegFgu7BHOrQaJPknD70=;
        b=Es3cqrvvu1YJ4JLQtbg6NIO1+quXPvu+PraRx9z8ub55t5bgvqafVphQgyIl47VejF
         h3ppu4iedv51ehoP6L6f/Peqge+WPG7sBn7OCAgdV1f9Vqk2NpqQzDSSmd93jB+L8dn0
         S4To6RJngeT0PU7ayKM5DRmEuD/6pQKX78f/7Xokb+H098JxRCebSKuFWMpJ9f7zxtn3
         4Pz+Od0lnxkrnAP5OvIilQIhPf8Zwv3pH/neX9jBpVNfsY0TsjD5n7HpS+Y2HNZm9tVb
         U/zHWdCBgs/d9KzX3HhT/Tw/OSv1+ZN6cQ4aKeejz9JUMDus2aRmOfeCxNTy9SVlDXqo
         ECQg==
Received: by 10.68.244.40 with SMTP id xd8mr39302038pbc.132.1336476295913;
 Tue, 08 May 2012 04:24:55 -0700 (PDT)
Received: by 10.68.73.65 with HTTP; Tue, 8 May 2012 04:24:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197352>

I'm not very familiar with submodules, but I gave them a go today, and
quite quickly bumped into something I consider a bit... odd behavior:
When I add an empty submodule and commit to it, a strangely named
"(null)"-branch gets created.

Here's a test that illustrate the issue:

---8<---
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 81827e6..ce47b0a 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -520,4 +520,16 @@ test_expect_success 'moving the superproject does
not break submodules' '
 	)
 '

+test_expect_failure 'committing to empty submodule does not create
(null) branch' '
+	test_create_repo empty-repo &&
+	git submodule add ./empty-repo empty-submodule &&
+	(
+		cd empty-submodule &&
+		echo "foo" > bar.txt &&
+		git add bar.txt &&
+		git commit -m. &&
+		git show-ref | !grep "(null)"
+	)
+'
+
 test_done
---8<---

Now, it could very well be that the best move here would be "don't do
that". But in that case, I think we should error out instead of
creating a cryptic branch.

So, I decided to dig a bit and see if I could figure out where this
strange branch-name came from. So I inserted a few calls to
test_pause, and noticed that:
1) empty-repo/.git/HEAD contains "ref: refs/heads/master"
2) .git/modules/empty-submodule/HEAD contains "ref: refs/heads/(null)"

Digging further, it turns out that this magical "(null)"-branch
creation can be reproduced without the use of "git submodule":
$ git init empty
$ cd empty
$ cat .git/HEAD
ref: refs/heads/master
$ git checkout
$ cat .git/HEAD
ref: refs/heads/(null)

The offending code seems to be switch_unborn_to_new_branch, when
opts->new_branch is NULL. This is relatively new code, introduced in
January this year by commit abe1998 ("git checkout -b: allow switching
out of an unborn branch") .

Before this commit, the checkout would error out with "fatal: You are
on a branch yet to be born". Perhaps abe1998 was too optimistic about
allowing this, and something like this would be in order?

---8<---
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 23fc56d..35924d4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1091,7 +1091,7 @@ int cmd_checkout(int argc, const char **argv,
const char *prefix)
 	if (opts.writeout_stage)
 		die(_("--ours/--theirs is incompatible with switching branches."));

-	if (!new.commit) {
+	if (!new.commit && opts.new_branch) {
 		unsigned char rev[20];
 		int flag;
---8<---

Now, doing this doesn't make my test above pass, but it makes the "git
submodule add" call fail when the submodule is empty, which is much
better than what we do now IMO.
