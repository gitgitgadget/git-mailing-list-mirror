From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: BUG when trying to delete symbolic refs
Date: Tue, 16 Oct 2012 12:05:18 +0200
Message-ID: <507D315E.8040101@lsrfire.ath.cx>
References: <CALKQrgfnvV+1XHjeSytj+LxkAabZJK3hewxH7WT0nkX-ewOKUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@suse.cz>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 12:05:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO41n-0003mI-Dk
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 12:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754Ab2JPKFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 06:05:21 -0400
Received: from india601.server4you.de ([85.25.151.105]:44550 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab2JPKFU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 06:05:20 -0400
Received: from [192.168.2.105] (p4FFDBE50.dip.t-dialin.net [79.253.190.80])
	by india601.server4you.de (Postfix) with ESMTPSA id AE99B77;
	Tue, 16 Oct 2012 12:05:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121005 Thunderbird/16.0
In-Reply-To: <CALKQrgfnvV+1XHjeSytj+LxkAabZJK3hewxH7WT0nkX-ewOKUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207809>

Am 15.10.2012 10:50, schrieb Johan Herland:
> Basically, there is a "master" branch, and an "alias" symref to
> "master". When we naively try to delete the symref with "git branch -d
> alias", it ends up:
> 
>   - NOT deleting the "alias" symref
>   - DELETING the "master" loose ref
>   - NOT deleting the "master" packed ref
> 
> So, from the user perspective, "git branch -d alias" ends up resetting
> "master" (and "alias") back to the last time we happened to run "git
> gc". Needless to say, this is not quite what we had in mind...
> 
> AFAICS, there may be three possible "acceptable" outcomes when we run
> "git branch -d alias" in the above scenario:
> 
>   A. The symbolic ref is deleted. This is obviously what we expected...

Below is a patch to do that.

>   B. The command fails because "alias" is a symref. This would be
> understandable if we don't want to teach "branch -d" about symrefs.
> But then, the error message should ideally explain which command we
> should use to remove the symref.

Renaming of symrefs with branch -m is disallowed because it's more
complicated than it looks at first; this was discussed here:
http://thread.gmane.org/gmane.comp.version-control.git/98825/focus=99206

I can't imagine why deletion should be prohibited as well, though.

>   C. The "master" ref (BOTH loose and packed versions of it) is
> deleted. This would be less helpful for us, but Git would at least be
> internally consistent (in that the symref would be resolved, and the
> command would become "git branch -d master").

Are there use cases for this behaviour?

While I don't use symrefs, I'd somehow expect them to behave like
symbolic links on Unix do, where rm removes a link, not its target.

But I wonder why most delete_ref() calls in the code actually don't use
the flag REF_NODEREF, thus deleting symref targets instead of the
symrefs themselves.  I may be missing something important here.

---
 builtin/branch.c  |  2 +-
 t/t3200-branch.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ffd2684..31af114 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -221,7 +221,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (delete_ref(name, sha1, 0)) {
+		if (delete_ref(name, sha1, REF_NODEREF)) {
 			error(remote_branch
 			      ? _("Error deleting remote branch '%s'")
 			      : _("Error deleting branch '%s'"),
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 79c8d01..4b73406 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -262,6 +262,16 @@ test_expect_success 'config information was renamed, too' \
 	"test $(git config branch.s.dummy) = Hello &&
 	 test_must_fail git config branch.s/s/dummy"
 
+test_expect_success 'deleting a symref' '
+	git branch target &&
+	git symbolic-ref refs/heads/symlink refs/heads/target &&
+
+	git branch -d symlink &&
+
+	test_path_is_file .git/refs/heads/target &&
+	test_path_is_missing .git/refs/heads/symlink
+'
+
 test_expect_success 'renaming a symref is not allowed' \
 '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
-- 
1.7.12
