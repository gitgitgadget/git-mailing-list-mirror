From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [RFC/PATCH] Re: BUG? git log -Sfoo --max-count=N
Date: Mon, 07 Mar 2011 13:46:52 +0100
Message-ID: <vpqpqq3qern.fsf@bauges.imag.fr>
References: <87hbbgvske.fsf@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=D3scar?= Fuentes <ofv@wanadoo.es>
X-From: git-owner@vger.kernel.org Mon Mar 07 13:47:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwZqA-0008Qe-MB
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 13:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413Ab1CGMqz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2011 07:46:55 -0500
Received: from mx1.imag.fr ([129.88.30.5]:51445 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921Ab1CGMqz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 07:46:55 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p27Ckp3R023553
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Mar 2011 13:46:51 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PwZps-00070a-9s; Mon, 07 Mar 2011 13:46:52 +0100
In-Reply-To: <87hbbgvske.fsf@wanadoo.es> (=?iso-8859-1?Q?=22=D3scar?=
 Fuentes"'s message of "Sun,
	06 Mar 2011 22:37:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 07 Mar 2011 13:46:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p27Ckp3R023553
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1300106811.75562@JvQ74edkRochWO8i2ZDuMQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168590>

=D3scar Fuentes <ofv@wanadoo.es> writes:

> when [--max-count is] used with -S as in
>
> git log -Sfoo --max-count=3DN
>
> it acts as "inspect only the N first commits", i.e. if `foo' is not
> present on any of the first N commits no output is shown.

I'd call this a bug.

The following patch seems to fix it, but I'm not terribly happy with th=
e
way it works. Any better idea?

=46rom 3b962e004790c36c426efff64ad34043045e4aca Mon Sep 17 00:00:00 200=
1
=46rom: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Mon, 7 Mar 2011 13:41:05 +0100
Subject: [PATCH] log: fix --max-count when used together with -S or -G

--max-count is implemented by counting revisions in get_revision(), but
the -S and -G take effect later (after running diff), hence,
--max-count=3D10 -Sfoo meant "examine the 10 first revisions, and out o=
f
them, show only those changing the occurences of foo", not "show 10
revisions changing the occurences of foo".

In case the commit isn't actually shown, cancel the decrement of
max_count.
---
 builtin/log.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f5ed690..b83900b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -263,7 +263,12 @@ static int cmd_log_walk(struct rev_info *rev)
         * retain that state information if replacing rev->diffopt in t=
his loop
         */
        while ((commit =3D get_revision(rev)) !=3D NULL) {
-               log_tree_commit(rev, commit);
+               if (!log_tree_commit(rev, commit))
+                       /*
+                        * We decremented max_count in get_revision,
+                        * but we didn't actually show the commit.
+                        */
+                       rev->max_count++;
                if (!rev->reflog_info) {
                        /* we allow cycles in reflog ancestry */
                        free(commit->buffer);
--=20
1.7.4.1.176.g6b069.dirty

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
