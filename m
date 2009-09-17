From: Alexey Borzenkov <snaury@gmail.com>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW and 
	MSVC
Date: Thu, 17 Sep 2009 17:02:25 +0400
Message-ID: <e2480c70909170602l6afc9842v7be2b91fde9ad498@mail.gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
	 <4AB10F01.9010703@viscovery.net>
	 <e2480c70909161300o3db4b416k8f33ccce2f987c55@mail.gmail.com>
	 <4AB1E118.70504@viscovery.net> <4AB1E4C5.80102@gmail.com>
	 <4AB1E6E4.1040100@viscovery.net> <4AB1EB02.2090308@gmail.com>
	 <4AB1EF0E.5010600@viscovery.net>
	 <e2480c70909170139x9580bb4pcc1ad8e1b93aef17@mail.gmail.com>
	 <4AB1FB79.5070903@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com,
	Marius Storm-Olsen <marius.storm-olsen@nokia.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 15:02:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoGd8-0002Y0-CH
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 15:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756953AbZIQNCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 09:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757313AbZIQNCX
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 09:02:23 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:53778 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067AbZIQNCW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 09:02:22 -0400
Received: by fxm17 with SMTP id 17so1479fxm.37
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Q7i9cQEdjcg0FL5AldDPbCxObwVHN09jk5yRMe1eS3Y=;
        b=usituJPENHdE9cKjii8jlNWkhDpCIrwN48HyhPW4EGO7GrcsFIDY65ZT3UbV6yQ2hm
         1Yje/ZjSP+DI/eBWhnTxWKNaCC4bvd8WBNNdMYkX7ypHh2LCho4L+NoCcodinA/fICJ/
         86zoMLta/RU6yZ8l/2YRpGgxPl04kk5JsMsdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SQxRgGeNPtGRx63Fn3iz1ZxF5MHKTgnfAkF3s951UQ5VxjcJ5094aswIGWTt2cn26a
         6Yj2qZt/ECKSbn+/Mw4vumflLfbPrHLY6g6kd1kHeX2AsZok1wTuUkcVdXPOVsQb+JIU
         qWD1Fs2dmTiIyh5aXKKCAVfwZmfwmgsMgQOFo=
Received: by 10.223.21.15 with SMTP id h15mr29354fab.15.1253192545397; Thu, 17 
	Sep 2009 06:02:25 -0700 (PDT)
In-Reply-To: <4AB1FB79.5070903@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128750>

This is slightly more than a repost, forgot to reply to all, then
found more info.

On Thu, Sep 17, 2009 at 1:03 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> First thing to do is to understand what is going on: There are other
> architectures that do not have nsec and that do *not* have the problem;
> why do we have a problem on Windows? If you cannot answer this question,
> an nsec solution would still just be "it happens to work", and not "it
> works by design".

Ah, yes, I didn't realize that nsec checking isn't even enabled by
default. So implementing it wouldn't help. As for st_ino it doesn't
matter in this case, as it wouldn't change anyway.

It's interesting that putting git diff or git status before calling
git stash shows that the changes are actually there (and then they can
be picked up). It seems that something manages to spend enough time so
that cache_entry's mtime and index.timestamp start to differ. For
example, here I modified check-racy to show more info for this
particular case:

diff --git a/Makefile b/Makefile
index e0f9a63..00f425c 100644
--- a/Makefile
+++ b/Makefile
@@ -364,6 +364,7 @@ PROGRAMS += git-unpack-file$X
 PROGRAMS += git-update-server-info$X
 PROGRAMS += git-upload-pack$X
 PROGRAMS += git-var$X
+PROGRAMS += git-check-racy$X

 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin-$C.o but is linked in as part of some other command.
diff --git a/check-racy.c b/check-racy.c
index 00d92a1..72b2878 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -16,6 +16,12 @@ int main(int ac, char **av)
                       continue;
               }

+               if (!strcmp(ce->name, "file")) {
+                       printf("for file: index.timestamp.sec: %d\n",
the_index.timestamp.sec);
+                       printf("for file:    ce->ce_mtime.sec: %d\n",
ce->ce_mtime.sec);
+                       printf("for file:         st.st_mtime: %d\n",
(int)st.st_mtime);
+               }
+
               if (ce_match_stat(ce, &st, 0))
                       dirty++;
               else if (ce_match_stat(ce, &st, CE_MATCH_RACY_IS_DIRTY))
diff --git a/git-stash.sh b/git-stash.sh
index 03e589f..6eb73fe 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -74,8 +74,14 @@ create_stash () {
               cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP-index" &&
               GIT_INDEX_FILE="$TMP-index" &&
               export GIT_INDEX_FILE &&
+               echo ">>> before git read-tree:" >&2 &&
+               git check-racy >&2 &&
               git read-tree -m $i_tree &&
+               echo ">>> before git add:" >&2 &&
+               git check-racy >&2 &&
               git add -u &&
+               echo ">>> before git write-tree" >&2 &&
+               git check-racy >&2 &&
               git write-tree &&
               rm -f "$TMP-index"
       ) ) ||

Now where I run it and it doesn't fail:

HEAD is now at dfc6a3a other-file
>>> before git read-tree:
for file: index.timestamp.sec: 1253191568
for file:    ce->ce_mtime.sec: 1253191568
for file:         st.st_mtime: 1253191568
dirty 1, clean 1, racy 0
>>> before git add:
for file: index.timestamp.sec: 1253191570
for file:    ce->ce_mtime.sec: 1253191568
for file:         st.st_mtime: 1253191568
dirty 1, clean 1, racy 0
>>> before git write-tree
for file: index.timestamp.sec: 1253191571
for file:    ce->ce_mtime.sec: 1253191568
for file:         st.st_mtime: 1253191568
dirty 0, clean 2, racy 0
Saved working directory and index state WIP on master: dfc6a3a other-file
HEAD is now at dfc6a3a other-file
(To restore them type "git stash apply")
>>> before git read-tree:
for file: index.timestamp.sec: 1253191572
for file:    ce->ce_mtime.sec: 1253191571
for file:         st.st_mtime: 1253191572
dirty 1, clean 1, racy 0
>>> before git add:
for file: index.timestamp.sec: 1253191574
for file:    ce->ce_mtime.sec: 1253191571
for file:         st.st_mtime: 1253191572
dirty 1, clean 1, racy 0
>>> before git write-tree
for file: index.timestamp.sec: 1253191574
for file:    ce->ce_mtime.sec: 1253191572
for file:         st.st_mtime: 1253191572
dirty 0, clean 2, racy 0
Saved working directory and index state WIP on master: dfc6a3a other-file

But, when this test fails, the results are:

HEAD is now at dfc6a3a other-file
>>> before git read-tree:
for file: index.timestamp.sec: 1253191677
for file:    ce->ce_mtime.sec: 1253191676
for file:         st.st_mtime: 1253191676
dirty 0, clean 2, racy 0
>>> before git add:
for file: index.timestamp.sec: 1253191679
for file:    ce->ce_mtime.sec: 1253191676
for file:         st.st_mtime: 1253191676
dirty 0, clean 2, racy 0
>>> before git write-tree
for file: index.timestamp.sec: 1253191679
for file:    ce->ce_mtime.sec: 1253191676
for file:         st.st_mtime: 1253191676
dirty 0, clean 2, racy 0
Saved working directory and index state WIP on master: dfc6a3a other-file
HEAD is now at dfc6a3a other-file
(To restore them type "git stash apply")
>>> before git read-tree:
for file: index.timestamp.sec: 1253191681
for file:    ce->ce_mtime.sec: 1253191680
for file:         st.st_mtime: 1253191680
dirty 0, clean 2, racy 0
>>> before git add:
for file: index.timestamp.sec: 1253191683
for file:    ce->ce_mtime.sec: 1253191680
for file:         st.st_mtime: 1253191680
dirty 0, clean 2, racy 0
>>> before git write-tree
for file: index.timestamp.sec: 1253191683
for file:    ce->ce_mtime.sec: 1253191680
for file:         st.st_mtime: 1253191680
dirty 0, clean 2, racy 0
Saved working directory and index state WIP on master: dfc6a3a other-file

As you can see, even for "8" (first git stash in that test) it failed:
it seemed as if working tree is clean, index was not updated, changes
were not stashed. But it just so happens that it didn't matter.

Also, as you can see, in both cases index timestamp is slightly bigger
than cache_entry's timestamp. That's why git doesn't see file as racy.
Now I'm wondering WHAT manages to modify index timestamp. :-/

Update:

Ah, I just added more git check-racy calls and found one extremely
interesting case:

HEAD is now at dfc6a3a other-file
>>> start of create_stash:
for file: index.timestamp.sec: 1253192315
for file:    ce->ce_mtime.sec: 1253192315
for file:         st.st_mtime: 1253192315
dirty 1, clean 1, racy 0
>>> after update-index -q --refresh:
for file: index.timestamp.sec: 1253192315
for file:    ce->ce_mtime.sec: 1253192315
for file:         st.st_mtime: 1253192315
dirty 1, clean 1, racy 0
>>> after checking for changes:
for file: index.timestamp.sec: 1253192315
for file:    ce->ce_mtime.sec: 1253192315
for file:         st.st_mtime: 1253192315
dirty 1, clean 1, racy 0
>>> after finding i_tree and i_commit:
for file: index.timestamp.sec: 1253192315
for file:    ce->ce_mtime.sec: 1253192315
for file:         st.st_mtime: 1253192315
dirty 1, clean 1, racy 0
>>> before git read-tree:
for file: index.timestamp.sec: 1253192316
for file:    ce->ce_mtime.sec: 1253192315
for file:         st.st_mtime: 1253192315
dirty 0, clean 2, racy 0
>>> before git add:
for file: index.timestamp.sec: 1253192318
for file:    ce->ce_mtime.sec: 1253192315
for file:         st.st_mtime: 1253192315
dirty 0, clean 2, racy 0
>>> before git write-tree
for file: index.timestamp.sec: 1253192318
for file:    ce->ce_mtime.sec: 1253192315
for file:         st.st_mtime: 1253192315
dirty 0, clean 2, racy 0
Saved working directory and index state WIP on master: dfc6a3a other-file

"after finding i_tree and i_commit" is immediately before calculating
w_tree. As you can see, "before git read-tree" is off by a second. I
think it's just a bug in msys, cp -p doesn't preserve mtime exactly.
:-/
