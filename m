From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Message from git reset: confusing?
Date: Thu, 06 Aug 2009 11:42:51 +0200
Message-ID: <vpqprb946sk.fsf@bauges.imag.fr>
References: <vpqab2e7064.fsf@bauges.imag.fr>
	<7v1vnqb2hc.fsf@alter.siamese.dyndns.org>
	<32541b130908051042x5308e8fte7b3ead6bf1f24ee@mail.gmail.com>
	<fabb9a1e0908051125n3e125209n88a9fd86d6fa7534@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 11:43:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYzVE-0003ZK-7l
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 11:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbZHFJnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Aug 2009 05:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbZHFJnH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 05:43:07 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41236 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754561AbZHFJnE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 05:43:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n769g2c1027527
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 11:42:03 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MYzUp-000435-Vv; Thu, 06 Aug 2009 11:42:52 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MYzUp-000701-Ue; Thu, 06 Aug 2009 11:42:51 +0200
In-Reply-To: <fabb9a1e0908051125n3e125209n88a9fd86d6fa7534@mail.gmail.com> (Sverre Rabbelier's message of "Wed\, 5 Aug 2009 11\:25\:07 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 06 Aug 2009 11:42:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n769g2c1027527
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1250156524.41194@fXPqD7Y74IN9Xy/z7kiWAw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125055>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Wed, Aug 5, 2009 at 10:42, Avery Pennarun<apenwarr@gmail.com> wrot=
e:
>> Yes. =A0I think the problem is that the current output looks more li=
ke
>> an error message than a status report.
>
> Definitely.

This is my biggest issue, indeed. Actually, several things bother me
(by decreasing annoyance):

1) It looks like an error message, and user can think git reset
failed.

2) It's inconsistant with the usual status display. I'd prefer an
output like "git diff --name-only" or "git status".

3) It's verbose. Junio's reply addresses this point. I'm not really
convinced that verbosity by default is a good thing, but I don't think
I can convince Junio either ;-), and I don't care that much.

So, let's address 1) and 2) only.

>> I would find it very pleasant if the output looked more like the
>> output of "git checkout" (no parameters) in the no-files-specified
>> case.
>
> Perhaps instead we could get away with simply adding a header like
> 'git status' does? And perhaps change the wording some.

Just this patch would already solve 1) above mostly. At first, I
wanted the message to say "reset successfull", but it's harder than it
seems, since the output is printf-ed as the work is done, so one knows
that reset is successful only after displaying the whole thing:

diff --git a/builtin-reset.c b/builtin-reset.c
index 5fa1789..6b16a00 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -108,6 +108,7 @@ static int update_index_refresh(int fd, struct lock=
_file *index_lock, int flags)
        if (read_cache() < 0)
                return error("Could not read index");
=20
+       printf("Unstaged changes after reset:\n");
        result =3D refresh_cache(flags) ? 1 : 0;
        if (write_cache(fd, active_cache, active_nr) ||
                        commit_locked_index(index_lock))

=46or 2), something along the lines of:

diff --git a/read-cache.c b/read-cache.c
index 4e3e272..3a99a2b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1075,10 +1075,13 @@ int refresh_index(struct index_state *istate, u=
nsigned int flags, const char **p
        int not_new =3D (flags & REFRESH_IGNORE_MISSING) !=3D 0;
        int ignore_submodules =3D (flags & REFRESH_IGNORE_SUBMODULES) !=
=3D 0;
        unsigned int options =3D really ? CE_MATCH_IGNORE_VALID : 0;
-       const char *needs_update_message;
+       const char *needs_update_fmt;
+       const char *needs_merge_fmt;
=20
-       needs_update_message =3D ((flags & REFRESH_SAY_CHANGED)
-                               ? "locally modified" : "needs update");
+       needs_update_fmt =3D ((flags & REFRESH_SAY_CHANGED)
+                               ? "M\t%s\n" : "%s: needs update\n");
+       needs_merge_fmt =3D ((flags & REFRESH_SAY_CHANGED)
+                               ? "U\t%s\n" : "%s: needs merge\n");
        for (i =3D 0; i < istate->cache_nr; i++) {
                struct cache_entry *ce, *new;
                int cache_errno =3D 0;
@@ -1094,7 +1097,7 @@ int refresh_index(struct index_state *istate, uns=
igned int flags, const char **p
                        i--;
                        if (allow_unmerged)
                                continue;
-                       printf("%s: needs merge\n", ce->name);
+                       printf(needs_merge_fmt, ce->name);
                        has_errors =3D 1;
                        continue;
                }
@@ -1117,7 +1120,7 @@ int refresh_index(struct index_state *istate, uns=
igned int flags, const char **p
                        }
                        if (quiet)
                                continue;
-                       printf("%s: %s\n", ce->name, needs_update_messa=
ge);
+                       printf(needs_update_fmt, ce->name);
                        has_errors =3D 1;
                        continue;
                }

would do. See d14e7407b3 ("needs update" considered harmful, Sun Jul
20 00:21:38 2008) for the previous improvement on the subject. The
problem with this second patch is that it says "M" where "diff
--name-status" would say "D" for example, which is a bit strange. If
the idea of the patch is accepted, REFRESH_SAY_CHANGED should also be
renamed to reflect its new nature, to stg like
REFRESH_PORCELAIN_OUTPUT.

Any opinion? Am I going in the right direction?

--=20
Matthieu
