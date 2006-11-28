X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git-branch howto rename a branch
Date: Tue, 28 Nov 2006 00:49:11 -0800
Message-ID: <7vzmac3qig.fsf@assigned-by-dhcp.cox.net>
References: <1164679287192-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 08:49:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32496>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoyeS-0002XA-UE for gcvg-git@gmane.org; Tue, 28 Nov
 2006 09:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935698AbWK1ItN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 03:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935699AbWK1ItN
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 03:49:13 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:35712 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S935698AbWK1ItM
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 03:49:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128084912.GAOJ20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Tue, 28
 Nov 2006 03:49:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id s8pL1V00N1kojtg0000000; Tue, 28 Nov 2006
 03:49:21 -0500
To: Lars Hjemli <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org

Lars Hjemli <hjemli@gmail.com> writes:

> This adds a '--rename' option to git branch. If specified, branch
> creation becomes branch renaming.
>
> With a single branchname, the current branch is renamed and .git/HEAD is
> updated.
>
> With two branchnames, the second name is renamed to the first.

Thanks.

"--rename newname oldname" feels funny, as already mentioned a
few times on the list.  rename(2) is "rename(old, new)" and
mv(1) is "mv old new".

> This seems to do the right thing for both refs and reflogs, but 'make test' 
> probably should be expanded with some evil test-cases to confirm my manual
> testing.

Certainly.  Let's keep discipline to have tests and docs for new
features.
 
+static void rename_branch(const char *oldname, const char *newname, int force)
+{
+	char oldref[PATH_MAX], newref[PATH_MAX];
+	unsigned char sha1[20];
+
+	snprintf(oldref, sizeof oldref, "refs/heads/%s", oldname);
+	if (check_ref_format(oldref))
+		die("Invalid branch name: %s", oldref);

Although "sizeof type" is valid C, we tend to prefer
"sizeof(type)".  If you use snprintf(), it would make sense to
check its return value.

+	if (resolve_ref(newref, sha1, 1, NULL) && !force)
+		die("A branch named '%s' already exists.\n", newname);

No trailing '\n' is necessary for die().

+	if (!rename_ref(oldref, newref) && !strcmp(oldname, head))
+		create_symref("HEAD", newref);
+}

Can create_symref() fail?

+int rename_ref(const char *oldref, const char *newref)
+{
+	unsigned char sha1[20], orig_sha1[20];
+	int flag = 0, logmoved = 0;
+	struct ref_lock *lock;
+	char msg[PATH_MAX*2 + 100];
+	struct stat stat;
+	int log = !lstat(git_path("logs/%s", oldref), &stat);

This is not wrong per-se, but it made me stop and wonder if we
want to error out when we find out "logs/oldref" is a symlink; I
do not think we care about it that much, but in that case we may
want to say stat() here instead...  Just a minor detail.

+	lock = lock_ref_sha1_basic("tmp-renamed-ref", NULL, NULL);
+	if (!lock)
+		return error("unable to lock tmp-renamed-ref");
+	lock->force_write = 1;
+	if (write_ref_sha1(lock, orig_sha1, msg))
+		return error("unable to save current sha1 in tmp-renamed-ref");
+	if (log && rename(git_path("logs/%s", oldref), git_path("tmp-renamed-log")))
+		return error("unable to move logfile logs/%s to tmp-renamed-log: %s",
+			oldref, strerror(errno));

I am confused with this code.  tmp-renamed-ref is not even a
ref, you lock $GIT_DIR/tmp-renamed-ref and call write-ref_sha1()
with an uninitialized msg[] buffer to write into a logfile. What
is the name of that logfile?  $GIT_DIR/log/tmp-renamed-ref???
