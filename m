From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 1/4] contrib/subtree: Store subtree sources in .gitsubtree and
 use for push/pull
Date: Tue, 12 Feb 2013 23:21:34 +0000
Message-ID: <CALeLG_kuXdF_F4ScRLPLm5h5cV_9p=EZYrWdjoWBrO99WFyi2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "David A. Greene" <greened@obbligato.org>,
	Michael Schubert <mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 00:22:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5PAl-0000TT-C8
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 00:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758853Ab3BLXVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 18:21:36 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:53213 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836Ab3BLXVf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 18:21:35 -0500
Received: by mail-ob0-f173.google.com with SMTP id dn14so675849obc.18
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 15:21:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=zU/ILtqlvHZ8rvdfROfi9RmK5Fokv3CNaBpA6XhTi1k=;
        b=ocP6lcNfEhfbKRuExG5oVHyjxTlDMc1LJQHc2j151Rl6+xATERFdhR27rCOd8LRhVP
         dkbdWVJOeLVvYDbflObU77Y2ODNi4q6ATmDu8b4/o+kb0+ciDfMAGeEPaN13Vqnx+rxB
         sw0tYk6yUgStctspfU/MJ4zfzysyofTXtdNh7Bvqj5Ou+QpW8+Pe+ziBC9dfxUMWr9Ng
         7wfO1N3C8S/RX/noXCjShjhqB6dyhXDXXefW5e0RwrCvtgsgGbsC+zYi2LHqdyc3SXNF
         3EwMcVg6bdW3dKwlwjV9EgCj1b4WhkIHMvXLI/ZaLdCsSrOEnhmwo0+KvY6qb4NKuYu3
         X25A==
X-Received: by 10.60.169.147 with SMTP id ae19mr15315777oec.27.1360711294581;
 Tue, 12 Feb 2013 15:21:34 -0800 (PST)
Received: by 10.76.143.67 with HTTP; Tue, 12 Feb 2013 15:21:34 -0800 (PST)
X-Originating-IP: [2.102.85.14]
X-Gm-Message-State: ALoCoQl7PIU0ge+uPVL0+zU7cnMpxhHgGAZZRjXaEH+0GPCS/uipf8YHs1m/6YwmC4wUeFJVWon3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216223>

Having to remember what subtree came from what source is a waste of
developer memory and doesn't transfer easily to other developers.

git subtree push/pull operations would typically be to/from the same
source that the original subtree was cloned from with git subtree add.


The <repository> and <refspec>, or <commit>, used in the git subtree add
operation are stored in .gitsubtree. One line each delimited by a space:
<prefix> <repository> <refspec> or <prefix> . <commit>.

Subsequent git subtree push/pull operations now default to the values
stored in .gitsubtree, unless overridden from the command line.

The .gitsubtree file should be tracked as part of the repo as it
describes where parts of the tree came from and can be used to update
to/from that source.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 920c664..02aae30 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -488,6 +488,23 @@ ensure_clean()
  fi
 }

+subtree_memorize()
+{
+ if [ $# -eq 1 ] ; then
+ echo "$dir . $@" >> .gitsubtree
+ elif [ $# -eq 2 ]; then
+ echo "$dir $@" >> .gitsubtree
+ else
+ # don't know how to handle this
+ echo "Not memorizing subtree: $dir $@"
+ fi
+}
+
+subtree_remember()
+{
+ grep "^$dir " .gitsubtree || die "Subtree $dir isn't in .gitsubtree"
+}
+
 cmd_add()
 {
  if [ -e "$dir" ]; then
@@ -496,6 +513,7 @@ cmd_add()

  ensure_clean

+ subtree_memorize "$@"
  if [ $# -eq 1 ]; then
  "cmd_add_commit" "$@"
  elif [ $# -eq 2 ]; then
@@ -688,7 +706,17 @@ cmd_merge()
 cmd_pull()
 {
  ensure_clean
- git fetch "$@" || exit $?
+ if [ $# -eq 0 ]; then
+ memory=($(subtree_remember))
+ echo "Pulling into '$dir' from '${memory[1]}' '${memory[2]}'"
+ repository=${memory[1]}
+ refspec=${memory[2]}
+ echo "git fetch using: " $repository $refspec
+ git fetch "$repository" "$refspec" || exit $?
+ else
+ echo "git fetch using: $@"
+ git fetch "$@" || exit $?
+ fi
  revs=FETCH_HEAD
  set -- $revs
  cmd_merge "$@"
@@ -696,12 +724,16 @@ cmd_pull()

 cmd_push()
 {
- if [ $# -ne 2 ]; then
-    die "You must provide <repository> <refspec>"
+ repository=$1
+ refspec=$2
+ if [ $# -eq 0 ]; then
+ memo=($(subtree_remember))
+ repository=${memo[1]}
+ refspec=${memo[2]}
+ elif [ $# -ne 2 ]; then
+ die "You must provide <repository> <refspec> or a <prefix> listed in
.gitsubtree"
  fi
  if [ -e "$dir" ]; then
-    repository=$1
-    refspec=$2
     echo "git push using: " $repository $refspec
     git push $repository $(git subtree split
--prefix=$prefix):refs/heads/$refspec
  else
--
1.8.1.3.566.gaa39828


--
Paul [W] Campbell
