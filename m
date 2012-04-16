From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #05; Thu, 12)
Date: Mon, 16 Apr 2012 08:26:41 +0200
Message-ID: <20120416082641.5d239ef6@mkiedrowicz.ivo.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 08:27:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJfOr-0005Y3-9K
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 08:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193Ab2DPG0w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 02:26:52 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62982 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab2DPG0v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 02:26:51 -0400
Received: by wgbdr13 with SMTP id dr13so4920357wgb.1
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 23:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=uDywZ/ahn7rSFBZ0nTuWdftr2fPo/FHpMkUzCR/IiiA=;
        b=Bj9GWiJTkkom4fTjy8e4quynyI/F2qmGX4t9jrx7mZSu57LjdA2duftcqlp9EOL13J
         PbM95fSPcX1fsaf0dcwR9u0UuFkP+oBmurePF5AF6KcZTua+htC15XxMmG3osPzNjvOl
         ShInvQRDVoIAhPJ4tXV5buxeKuQ4f4Zl8hGtbwdfPRyophs8c73J4vbbNGqGGjC0YB+M
         6QBoKlvWqbbBMUH9z8y5aCGGkAs8KlEK7z1gYmc37fdE3+3ycQL8PSicB6DUVOSXK9A0
         10Eyk5DrUrYEI8+Y9jxh4VpPURbkma2avjABRd1vrFoGBIWf7p+sw1vnIniCtQZx6cCV
         xZxg==
Received: by 10.180.81.135 with SMTP id a7mr15813070wiy.16.1334557610792;
        Sun, 15 Apr 2012 23:26:50 -0700 (PDT)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id u9sm17531474wix.0.2012.04.15.23.26.49
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 23:26:50 -0700 (PDT)
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195599>

Junio C Hamano <gitster@pobox.com> wrote:

> * lt/octopus-simplify (2012-04-12) 1 commit
>  - Make 'git merge' simplify parents earlier
>
> Octopus merge strategy did not reduce heads that are recorded in the
> final commit.  This was done off-list.

Heh, this seems to fix the issue I reported in [1], except... it
doesn't work for the testcase I posted :).  The problem is that this
commit makes Git 'fast-forward' to the first commit from remoteheads,
not from the reduced heads. See:


	$ git init /tmp/merge
	Initialized empty Git repository in /tmp/merge/.git/
	$ cd /tmp/merge
	$ echo a>>a && git add a && git commit -m first
	[master (root-commit) 7422615] first
	 1 file changed, 1 insertion(+)
	 create mode 100644 a
	$ echo a>>a && git add a && git commit -m second
	[master 0ba02e5] second
	 1 file changed, 1 insertion(+)
	$ echo a>>a && git add a && git commit -m third
	[master 9bd11ac] third
	 1 file changed, 1 insertion(+)
	$ git checkout master~2
	HEAD is now at 7422615... first
	# This is OK:
	$ git merge master master~1=20
	Updating 7422615..9bd11ac
	Fast-forward
	 a |    2 ++
	 1 file changed, 2 insertions(+)
	$ git checkout master~2
	Previous HEAD position was 9bd11ac... third
	HEAD is now at 7422615... first
	# This is not OK:
	$ git merge master~1 master=20
	Updating 7422615..0ba02e5
	Fast-forward
	 a |    1 +
	 1 file changed, 1 insertion(+)

Ths following patch fixes that.

[1] http://permalink.gmane.org/gmane.comp.version-control.git/190625


Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
(if this fix need a signed-off)
---

diff --git a/builtin/merge.c b/builtin/merge.c
index f5947b9..075c99b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1388,13 +1388,13 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
                if (verbosity >=3D 0)
                        printf(_("Updating %s..%s\n"),
                                hex,
-                               find_unique_abbrev(remoteheads->item->o=
bject.sha1,
+                               find_unique_abbrev(parents->item->objec=
t.sha1,
                                DEFAULT_ABBREV));
                strbuf_addstr(&msg, "Fast-forward");
                if (have_message)
                        strbuf_addstr(&msg,
                                " (no commit created; -m option ignored=
)");
-               commit =3D remoteheads->item;
+               commit =3D parents->item;
                if (!commit) {
                        ret =3D 1;
                        goto done;
