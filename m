From: Alex Bennee <kernel-hacker@bennee.com>
Subject: [PATCH] Documentation: Another example for git-filter-branch
Date: Fri, 28 Mar 2008 18:07:55 +0000
Message-ID: <1206727676.9819.22.camel@malory>
References: <1206707716.9819.15.camel@malory>
	 <32541b130803280550u2ed23b5auc84bf935d5344e84@mail.gmail.com>
	 <b2cdc9f30803280852y4f160bb2tda1e688ddf7213e7@mail.gmail.com>
	 <b2cdc9f30803280903w4a6e3a6l9e33fd188af9995a@mail.gmail.com>
	 <47ED204E.3020602@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 19:08:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfIzh-00078c-30
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 19:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878AbYC1SHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 14:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbYC1SHS
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 14:07:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:5529 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108AbYC1SHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 14:07:16 -0400
Received: by ug-out-1314.google.com with SMTP id z38so810369ugc.16
        for <git@vger.kernel.org>; Fri, 28 Mar 2008 11:07:14 -0700 (PDT)
Received: by 10.78.138.14 with SMTP id l14mr10268203hud.63.1206727633269;
        Fri, 28 Mar 2008 11:07:13 -0700 (PDT)
Received: from ?192.168.250.3? ( [86.15.108.50])
        by mx.google.com with ESMTPS id u9sm8777712muf.4.2008.03.28.11.07.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Mar 2008 11:07:11 -0700 (PDT)
In-Reply-To: <47ED204E.3020602@viscovery.net>
X-Mailer: Evolution 2.12.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78430>


On Fri, 2008-03-28 at 17:43 +0100, Johannes Sixt wrote:
> Alex Bennee schrieb:
> > git-checkout dev-branch
> > git-filter-branch --tree-filter  'rm -rf big_dira big_dirb' HEAD
> 
> You really shouldn't do it this way, unless you do it on a ramdisk. Better
> use an --index-filter. This is modeled after the last example in the man
> page (and, of course, untested):

I missed the implications of the last example...

> git filter-branch --index-filter \
>         'git ls-files -s |
> 	 grep -v "	big_dira" |
> 	 grep -v "	big_dirb" |
>                 GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
>                         git update-index --index-info &&
>          mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
> 
> where the space before big_dir is actually a literal TAB!

Good example. Maybe we should add the following (because plenty of
examples is always a good thing IMHO)?

>From 341b480bad4ed9f99a54dc66ba20b0cead4594b5 Mon Sep 17 00:00:00 2001
From: Alex Bennee <Alex.Bennee@cambridgebroadband.com>
Date: Fri, 28 Mar 2008 18:00:20 +0000
Subject: [PATCH] Update git filter-branch examples for cleaning directories

I had to do this to a tree I imported from CVS which had a lot of cruft in it
which was taking ages. Luckily Johannes Sixt submitted this scriplet on the list
before I finished which makes things clearer.
---
 Documentation/git-filter-branch.txt |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 543a1cf..0e4b581 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -184,6 +184,27 @@ git filter-branch --index-filter 'git update-index --remove filename' HEAD
 
 Now, you will get the rewritten history saved in HEAD.
 
+If you need to remove whole directories it is tempting to use "rm -rf"
+in the --tree-filter form, however this will generate a lot of disk IO
+on big trees. Hence it's more preferable to use the index filter. For
+example:
+
+--------------------------------------------------------------------------
+git filter-branch --index-filter \
+       'git ls-files -s |
+        grep -v "      big_dira" |
+	grep -v "      big_dirb" |
+		GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
+                git update-index --index-info &&
+	mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
+--------------------------------------------------------------------------
+
+NB: The grep is matching literal TABs from the output of "git
+ls-files". Try <ctrl-v><tab> if your shell keeps giving you a directory
+listing every time you hit tab.
+
+
+
 To set a commit (which typically is at the tip of another
 history) to be the parent of the current initial commit, in
 order to paste the other history behind the current history:
-- 
1.5.5.rc0.6.gdeda.dirty





--
Alex, homepage: http://www.bennee.com/~alex/
We reject: kings, presidents, and voting. We believe in: rough consensus
and working code. -- Dave Clark
