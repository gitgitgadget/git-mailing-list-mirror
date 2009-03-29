From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: fix ls-tree usage with dash-prefixed paths
Date: Sun, 29 Mar 2009 13:33:02 -0700
Message-ID: <7v8wmoqdc1.fsf@gitster.siamese.dyndns.org>
References: <22719363.post@talk.nabble.com>
 <20090326130213.GC3114@atjola.homenet>
 <83dfc36c0903260735q3231ce96h5949d1123858995f@mail.gmail.com>
 <83dfc36c0903270418q59a81290xcb8043b8c037be18@mail.gmail.com>
 <20090329060858.GB15773@dcvr.yhbt.net> <20090329061045.GA29721@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anton Gyllenberg <anton@iki.fi>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Mar 29 22:34:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo1iO-0001HZ-C7
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 22:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbZC2UdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 16:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753803AbZC2UdL
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 16:33:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36279 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbZC2UdL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 16:33:11 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B422A49D;
	Sun, 29 Mar 2009 16:33:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4530BA49A; Sun,
 29 Mar 2009 16:33:03 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D032A768-1CA0-11DE-93D3-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115036>

Eric Wong <normalperson@yhbt.net> writes:

> To find the blob object name given a tree and pathname, we were
> incorrectly calling "git ls-tree" with a "--" argument followed
> by the pathname of the file we wanted to get.
>
>   git ls-tree <TREE> -- --dashed/path/name.c
>
> Unlike many command-line interfaces, the "--" alone does not
> symbolize the end of non-option arguments on the command-line.
>
> ls-tree interprets the "--" as a prefix to match against, thus
> the entire contents of the --dashed/* hierarchy would be
> returned because the "--" matches "--dashed" and every path
> under it.

The above makes only half a sense to me.  In an empty directory:

    $ git init
    Initialized empty Git repository in /tmp/empty/.git
    $ mkdir -p ./--dashed/path
    $ >./--dashed/path/name
    $ git add .
    $ git ls-files
    --dashed/path/name
    $ git commit -a -m initial
    [master (root-commit) cd44284] initial
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 --dashed/path/name
    $ git ls-tree HEAD^{tree} --
    $ git ls-tree HEAD^{tree} -- --dashed/path/name
    100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	--dashed/path/name
    $ mkdir ./--
    $ >./--/eman
    $ git add .
    $ git commit -m second
    [master 80f8ef9] second
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 --/eman
    $ git ls-tree HEAD^{tree} -- --dashed/path
    100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	--/eman
    040000 tree 23e59e0c91294c39ac7c5a2e39efb01d878de9a0	--dashed/path
    $ exit

Perhaps the problem repository had a pathname that is exactly -- (in
addition to --dashed/), and ls-tree emitted everything under --/
hierarchy?  In other words, your fix to git-svn may be correct and I am
reading your problem description above incorrectly?

As the command always takes exactly one tree, it could be argued that it
is not a bug that it does not honour the usual -- convention, even though
I am tempted to think it is of a very dark shade of gray.  It is certainly
something that we would have done differently if we were implementing the
command today.

"Fixing" ls-tree would be trivial to ignore the first "--" if it precedes
other pathspecs (see below), but the command is a plumbing, and such a
change will break existing scripts that have relied on the existing
behaviour since 2005, so I do not think it is worth the risk of causing
such silent breakages to them.  Besides, with such a "fix", fixing of user
scripts will become much more cumbersome, as they need to detect the
version of git and drive ls-tree differently.


 builtin-ls-tree.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 22008df..08c4307 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -186,6 +186,12 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	if (get_sha1(argv[1], sha1))
 		die("Not a valid object name %s", argv[1]);
 
+	if (3 < argc && !strcmp(argv[2], "--")) {
+		/* ls-tree <tree> -- pathspec */
+		argc--;
+		argv++;
+		warning("ignoring -- in 'ls-tree <tree> -- <pathspec>'");
+	}
 	pathspec = get_pathspec(prefix, argv + 2);
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
