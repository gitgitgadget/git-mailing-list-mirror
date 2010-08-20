From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] merge-recursive: Fix multiple file rename across D/F conflict
Date: Fri, 20 Aug 2010 06:47:37 -0600
Message-ID: <AANLkTin+keov7xDnXZVWzWVkQRqdfPEKBnpkzn27fUC+@mail.gmail.com>
References: <1282089199-17253-1-git-send-email-newren@gmail.com>
	<1282089199-17253-3-git-send-email-newren@gmail.com>
	<7v8w438q9k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 14:47:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmR0e-0004Ru-7i
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 14:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242Ab0HTMrk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 08:47:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47871 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab0HTMri convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 08:47:38 -0400
Received: by fxm13 with SMTP id 13so1748982fxm.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 05:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ks5Pyu86ossGWb7nVymaQwAQJLhLWvL5Kx5N+DC/15M=;
        b=dC1/pYUisuZJ8vtPmHUp530ma8gTXwHoakZy5KmYiZdJLkC/FGutQR9Ll0M6CISfo9
         14Tjo2Bj2J/mN5YOIsC7oh9Jb1ROOUhjpVISSJZ5qJz+UDuiRxddinrjrLllbVlHDGC8
         G/IGRvu6N8aaAh+EhuWOiLq1kdmm2M75cFzj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tkavgPZX8SYTRiIr7VZelbPy/3R3PWo3p4StVcxLybq40q3kAd6S+8K/Nx08DsG7dy
         JY0Wk6Vrv07bTAtiEI424iJWqL2sTnQzUYbGc6MSOUdNu8B6vFTmmoEKiv/ClbRNgIlX
         p8wSzUkrKIHAHCqWQNdZQPYEjqFqSTH8Nhv1Y=
Received: by 10.223.122.146 with SMTP id l18mr1042672far.82.1282308457086;
 Fri, 20 Aug 2010 05:47:37 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Fri, 20 Aug 2010 05:47:37 -0700 (PDT)
In-Reply-To: <7v8w438q9k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154025>

On Wed, Aug 18, 2010 at 5:17 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Elijah Newren <newren@gmail.com> writes:
>
>> I'm really embarrased about this one... =C2=A0:-/
>
> Let's embarrass you even more ;-)

Mission accomplished.  :-/

> After 5a2580d, the merge has become very noisy, and I don't see a goo=
d
> reason for that change.
>
> With a version of git built from 5a2580d^, for example, merging
> sp/fix-smart-http-deadlock-on-error into maint would give me this:
>
> ----------------
> $ git merge sp/fix-smart-http-deadlock-on-error
> Auto-merging remote-curl.c
> Merge made by recursive.
> =C2=A0remote-curl.c | =C2=A0 =C2=A05 +++--
> =C2=A01 files changed, 3 insertions(+), 2 deletions(-)
> ----------------
>
> With 5a2580d, it has become this:
>
> ----------------
> $ git merge sp/fix-smart-http-deadlock-on-error
> Adding builtin/add.c
> Auto-merging remote-curl.c
> Merge made by recursive.
> =C2=A0remote-curl.c | =C2=A0 =C2=A05 +++--
> =C2=A01 files changed, 3 insertions(+), 2 deletions(-)
> ----------------
>
> And with this patch on top, it will make it a disaster:
>
> ----------------
> $ git merge sp/fix-smart-http-deadlock-on-error
> Adding builtin/add.c
> ... similar 97 Adding lines omitted ...
> Adding gitweb/static/gitweb.js
> Auto-merging remote-curl.c
> Adding t/lib-t6000.sh
> Adding t/t7810-grep.sh
> Adding t/t9350-fast-export.sh
> Merge made by recursive.
> =C2=A0remote-curl.c | =C2=A0 =C2=A05 +++--
> =C2=A01 files changed, 3 insertions(+), 2 deletions(-)
> ----------------

Ick.

Interestingly, the new paths I added for additional output are not
being triggered here.  Rather, "normal" renames are being considered
unprocessed (I had a faulty assumption in the previous patch that a
clean merge would have cleared out the higher stage entries in
dst_entry as a side effect).  Because of this, normal renames are
needlessly re-processed in process_entry(), and trigger extra output
as a side-effect.  One could work around this by the following patch,
though it'd be better to just avoid the extra reprocessing.  I'll
submit a better patch in a minute.

diff --git a/merge-recursive.c b/merge-recursive.c
index 7ac0f57..5ec7f70 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -75,6 +75,7 @@ struct stage_data
                unsigned char sha[20];
        } stages[4];
        unsigned processed:1;
+       unsigned silent:1;
 };

 static int show(struct merge_options *o, int v)
@@ -1033,9 +1034,11 @@ static int process_renames(struct merge_options =
*o,
                                         * conflict) that need to be re=
solved.
                                         */
                                        for (i =3D 1; i <=3D 3; i++) {
                                                if
(!ren1->dst_entry->stages[i].mode)
                                                        continue;
                                                ren1->dst_entry->proces=
sed =3D 0;
+                                               ren1->dst_entry->silent=
 =3D 1;
                                                break;
                                        }
                                } else {
@@ -1188,7 +1198,8 @@ static int process_entry(struct merge_options *o,
                        remove_file(o, 0, path, !a_sha);
                        return 1; /* Assume clean till processed */
                } else {
-                       output(o, 2, "Adding %s", path);
+                       if (!entry->silent)
+                               output(o, 2, "Adding %s", path);
                        update_file(o, 1, sha, mode, path);
                }
        } else if (a_sha && b_sha) {
