From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (Apr 2012, #05; Thu, 12)
Date: Mon, 16 Apr 2012 07:57:59 -0700
Message-ID: <CA+55aFwkf2bOLmUCU+_pSg0OzGyfQ1x-Cy_CiczpJN3zsThNWg@mail.gmail.com>
References: <20120416082641.5d239ef6@mkiedrowicz.ivo.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 16:58:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJnNp-0003Uq-PI
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 16:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824Ab2DPO6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 10:58:21 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:55568 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511Ab2DPO6U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 10:58:20 -0400
Received: by wejx9 with SMTP id x9so3401746wej.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 07:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1G+5HL8emjifAGVxd3S3Ko3SDB4g7Q5H68yaW0D0EaU=;
        b=LsSmD+JofmLxdqM0KKQPYsdZmuSPXGw/xqxYNPMcSfDUcrYKl8V41t8Ca60eutc3RX
         h1zrDtuvhc2z9hKFbxX2/eG4mt+YWw6+PZSE+Cc5xTyE1odF1cFv2qpFvoltYIhqp1o1
         mOisZoSB+Fe7XVAKM9kNWIp3Wq154Z6F8pejfh6ujexFR+5Qg6/F9yDSflng0gU72edL
         cBcDzyrO5ww1W83Ej8jJ5iCOCD2d+LAC46ZVExOI3P/pz1PXdwW8foheH7HM8iLtt9Yl
         vLT+GX87NvEAWrjx3thLTuwNX8twN0mL2tP6E25cVg62wPH4dSW6FJLiMb3gdZdspKB0
         wSdg==
Received: by 10.180.80.9 with SMTP id n9mr19588141wix.4.1334588299519; Mon, 16
 Apr 2012 07:58:19 -0700 (PDT)
Received: by 10.216.221.167 with HTTP; Mon, 16 Apr 2012 07:57:59 -0700 (PDT)
In-Reply-To: <20120416082641.5d239ef6@mkiedrowicz.ivo.pl>
X-Google-Sender-Auth: sOywrVRaI8rS1j1lkeNgaibwevE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195641>

On Sun, Apr 15, 2012 at 11:26 PM, Michal Kiedrowicz
<michal.kiedrowicz@gmail.com> wrote:
>
> Heh, this seems to fix the issue I reported in [1], except... it
> doesn't work for the testcase I posted :). =A0The problem is that thi=
s
> commit makes Git 'fast-forward' to the first commit from remoteheads,
> not from the reduced heads.

Ack, good catch.

Thinking some more about this thing, I think we have a similar issue
with the "Already up-to-date." thing.

It too had the "only one remote-head" test, which is wrong - what if
you try to do a octopus merge with *two* commits that are different,
and are both in the past? It will fail the "Already up-to-date" test,
and then do a "fast-forward" to the first remote parent, if I read the
code right..

So I think the "Already up-to-date" case should also be fixed, and in
fact it becomes much more natural now that we have finalized the
parents: we just check whether the one remaining parent is the same as
HEAD.

So  Ack on Michal's patch, but I think we also should do the appended
equivalent thing for the fast-forward test on top of it (it's
white-space damaged, sorry).

Trivially tested with

    git merge HEAD^ HEAD^^

which did the wrong thing before, and now works.

                       Linus

---
 builtin/merge.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 016a4dbee3b5..28fb5c9d6ada 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1370,8 +1370,7 @@ int cmd_merge(int argc, const char **argv, const
char *prefix)

        if (!common)
                ; /* No common ancestors found. We need a real merge. *=
/
-       else if (!remoteheads->next && !common->next &&
-                       common->item =3D=3D remoteheads->item) {
+       else if (!parents->next && parents->item =3D=3D head_commit) {
                /*
                 * If head can reach all the merge then we are up to da=
te.
                 * but first the most common case of merging one remote=
=2E
