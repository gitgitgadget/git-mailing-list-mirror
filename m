From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] clone: support atomic operation with --separate-git-dir
Date: Sat, 05 Jan 2013 21:17:04 +0100
Message-ID: <50E88A40.9010904@web.de>
References: <50E74145.4020701@gmail.com> <7vzk0osjli.fsf@alter.siamese.dyndns.org> <50E83224.2070701@web.de> <50E83DAE.1080500@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 21:17:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TraBP-0001yR-Iz
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 21:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867Ab3AEURN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 15:17:13 -0500
Received: from mout.web.de ([212.227.17.11]:64747 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755843Ab3AEURL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 15:17:11 -0500
Received: from [192.168.178.41] ([91.3.188.151]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LudLU-1Srx7E2PVA-0100eO; Sat, 05 Jan 2013 21:17:08
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50E83DAE.1080500@web.de>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:9fw0cKjh6oBkcpV3WDujgk1Bk8kWOCugNT1ssrYxK2Z
 igN4ninkV+8bcY1P4epdhWiuJ4EKidlMUXOi407jycZGauC3iy
 y3q3zLjEisojxvPb8yEHuCuWrVCoUNld585pjhVUOP7ICJfws1
 HQPv5Hr3xSCx62IfVakBrOEKLOXBpq6HsPMHbDg5HqJNVpWzDj
 U++5SuLaugJg0Km5an49w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212711>

Since b57fb80a7d (init, clone: support --separate-git-dir for .git file)
git clone supports the --separate-git-dir option to create the git dir
outside the work tree. But when that option is used, the git dir won't be
deleted in case the clone fails like it would be without this option. This
makes clone lose its atomicity as in case of a failure a partly set up git
dir is left behind. A real world example where this leads to problems is
when "git submodule update" fails to clone a submodule and later calls to
"git submodule update" stumble over the partially set up git dir and try
to revive the submodule from there, which then fails with a not very user
friendly error message.

Fix that by updating the junk_git_dir variable (used to remember if and
what git dir should be removed in case of failure) to the new value given
with the --seperate-git-dir option. Also add a test for this to t5600 (and
while at it fix the former last test to not cd into a directory to test
for its existence but use "test -d" instead).

Reported-by: Manlio Perillo <manlio.perillo@gmail.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Am 05.01.2013 15:50, schrieb Jens Lehmann:
> Am 05.01.2013 15:01, schrieb Jens Lehmann:
>> The reason seems to be that clone leaves a partial initialized .git
>> directory in case of connection problems. The next time submodule
>> update runs it tries to revive the submodule from .git/modules/<name>
>> but fails as there are no objects in it.
>>
>> This looks like a bug in clone to me, as it takes precautions to clean
>> up if something goes wrong but doesn't do that in this case. But while
>> glancing over the code I didn't find out what goes wrong here.
> 
> I dug a bit deeper here and found the reason: In remove_junk() of
> builtin/clone.c the junk_git_dir points to the gitfile in the
> submodules work tree, not the .git/modules/<name> directory where
> clone was told to put the git directory. Will see if I can come up
> with a patch soonish ...

And this fixes it for me. Manlio, it'd be great if you could test
this patch (but please not only remove .git/modules/<name> but also
the submodule work tree before doing that).


 builtin/clone.c               |  4 +++-
 t/t5600-clone-fail-cleanup.sh | 12 +++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index ec2f75b..8d23a62 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -771,8 +771,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die(_("could not create leading directories of '%s'"), git_dir);

 	set_git_dir_init(git_dir, real_git_dir, 0);
-	if (real_git_dir)
+	if (real_git_dir) {
 		git_dir = real_git_dir;
+		junk_git_dir = real_git_dir;
+	}

 	if (0 <= option_verbosity) {
 		if (option_bare)
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index ee06d28..4435693 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -37,6 +37,16 @@ test_expect_success \

 test_expect_success \
     'successful clone must leave the directory' \
-    'cd bar'
+    'test -d bar'
+
+test_expect_success 'failed clone --separate-git-dir should not leave any directories' '
+	mkdir foo/.git/objects.bak/ &&
+	mv foo/.git/objects/* foo/.git/objects.bak/ &&
+	test_must_fail git clone --separate-git-dir gitdir foo worktree &&
+	test_must_fail test -e gitdir &&
+	test_must_fail test -e worktree &&
+	mv foo/.git/objects.bak/* foo/.git/objects/ &&
+	rmdir foo/.git/objects.bak
+'

 test_done
-- 
1.8.1.81.gb1e9864
