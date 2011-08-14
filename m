From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/7] sequencer: Expose API to cherry-picking machinery
Date: Sun, 14 Aug 2011 10:22:04 -0500
Message-ID: <20110814152204.GJ18466@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-7-git-send-email-artagnon@gmail.com>
 <20110814131303.GF18466@elie.gateway.2wire.net>
 <CALkWK0=zqyvL8zo9wvBGUXyf3RWSZB7dY=WaC9TN6YXnThag0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 17:27:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QscbI-0006EA-T4
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 17:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab1HNPWK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 11:22:10 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61787 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab1HNPWI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 11:22:08 -0400
Received: by ywf7 with SMTP id 7so2810115ywf.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 08:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+2oymtvbYOepAeAzxgeBoC6acrbKiA40GjgDCEsjjqQ=;
        b=E9IS3YSrRp0L93VZk2f2jmjkw338tOFP5eA+ymeXMZaiAL/MqAIlGZczidf6Rt3pne
         b7g+/WbUswQTg6g/bNb3LYsgjXj7Ps20UeD0ms7n7YQ9bj/kRie0u6kbt+mF11RZsUXU
         EHwtjY/IT6Cbt0iUP4OZUHciH2KG1JOdV0W7Q=
Received: by 10.150.244.4 with SMTP id r4mr3918988ybh.435.1313335327830;
        Sun, 14 Aug 2011 08:22:07 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-108-227.dsl.chcgil.sbcglobal.net [68.255.108.227])
        by mx.google.com with ESMTPS id r2sm1190159ybh.10.2011.08.14.08.22.06
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 08:22:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=zqyvL8zo9wvBGUXyf3RWSZB7dY=WaC9TN6YXnThag0Q@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179330>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:

>> git_path() calls vsnprintf which clobbers errno, so depending on the
>> platform this can print messages like
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: Could not open '.git/CHERRY_PICK_H=
EAD' for writing: Success
[...]
> Ugh, yet another "bugfix patch" to queue near the beginning of the
> series.  Thanks for catching this.

It's not a bug you introduced, and ideally it would be a separate
patch on its own, against the js/cherry-pick-usability branch.

>> Ramkumar Ramachandra wrote:

>>> +static struct tree *empty_tree(void)
>>> [...]
>>
>> This tree is leaked (for example if you cherry-pick a sequence of
>> root commits).
>
> This is not something I introduced -- it can wait until later, no?

Yep, it's Christian's fault (for introducing multiple-cherry-pick).

Patch below.  The things I do... :)

[...]
> It is a simple code movement.  Is there something I can do to help?

Part of the review was about examples where it was not simple code
movement.  Maybe if there is another round the thing to do would be to
send a patch generated with -B -M to allow others to more easily check
it.

Thanks.

-- >8 --
Subject: revert: plug memory leak in "cherry-pick root commit" codepath

The empty tree passed as common ancestor to merge_trees() when
cherry-picking a parentless commit is allocated on the heap and never
freed.  Leaking such a small one-time allocation is not a very big
problem, but now that "git cherry-pick" can cherry-pick multiple
commits it can start to add up.

Avoid the leak by storing the fake tree exactly once in the BSS
section (i.e., use a static).  While at it, let's add a test to make
sure cherry-picking multiple parentless commits continues to work.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Patch is against cc/cherry-pick-series (86c7bb47).

 builtin/revert.c            |   10 +++++-----
 t/t3503-cherry-pick-root.sh |   27 ++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 853e9e40..c1b0fb3d 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -273,12 +273,12 @@ static void write_message(struct strbuf *msgbuf, =
const char *filename)
=20
 static struct tree *empty_tree(void)
 {
-	struct tree *tree =3D xcalloc(1, sizeof(struct tree));
+	static struct tree tree;
=20
-	tree->object.parsed =3D 1;
-	tree->object.type =3D OBJ_TREE;
-	pretend_sha1_file(NULL, 0, OBJ_TREE, tree->object.sha1);
-	return tree;
+	tree.object.parsed =3D 1;
+	tree.object.type =3D OBJ_TREE;
+	pretend_sha1_file(NULL, 0, OBJ_TREE, tree.object.sha1);
+	return &tree;
 }
=20
 static NORETURN void die_dirty_index(const char *me)
diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
index b0faa299..472e5b80 100755
--- a/t/t3503-cherry-pick-root.sh
+++ b/t/t3503-cherry-pick-root.sh
@@ -16,15 +16,40 @@ test_expect_success setup '
 	echo second > file2 &&
 	git add file2 &&
 	test_tick &&
-	git commit -m "second"
+	git commit -m "second" &&
+
+	git symbolic-ref HEAD refs/heads/third &&
+	rm .git/index file2 &&
+	echo third > file3 &&
+	git add file3 &&
+	test_tick &&
+	git commit -m "third"
=20
 '
=20
 test_expect_success 'cherry-pick a root commit' '
=20
+	git checkout second^0 &&
 	git cherry-pick master &&
 	test first =3D $(cat file1)
=20
 '
=20
+test_expect_success 'cherry-pick two root commits' '
+
+	echo first >expect.file1 &&
+	echo second >expect.file2 &&
+	echo third >expect.file3 &&
+
+	git checkout second^0 &&
+	git cherry-pick master third &&
+
+	test_cmp expect.file1 file1 &&
+	test_cmp expect.file2 file2 &&
+	test_cmp expect.file3 file3 &&
+	git rev-parse --verify HEAD^^ &&
+	test_must_fail git rev-parse --verify HEAD^^^
+
+'
+
 test_done
--=20
1.7.6
