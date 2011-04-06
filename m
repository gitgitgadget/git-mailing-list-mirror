From: Arnaud Lacombe <lacombar@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.4.3
Date: Wed, 6 Apr 2011 14:40:29 -0400
Message-ID: <BANLkTimh+--iRNEpr2XOFf4jXoVhmHUnoA@mail.gmail.com>
References: <7v4o6fg29j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 20:40:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Xed-0001Fh-Pk
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 20:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756388Ab1DFSka convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 14:40:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39617 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756371Ab1DFSka convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 14:40:30 -0400
Received: by iyb14 with SMTP id 14so1690970iyb.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 11:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3q1k5P3OcsKQNEuy+KgFkQVzKzk7N6G++qi8nhn/iHs=;
        b=ceGiD0r36VgYLdR6k4ZDihDRkc8bMFxYXXO88w+XHiI3jz4MXpWEdPY5RdZRwKiW60
         zBf5yzyO4yvJLoYw0DwgGwKm5FNh23pbXd1YiyJbhQoRmhsgYD27xKgjldh2vLh9+4h0
         WlUTMvkaLA1grUR0r6WRTWNY6BQkX0bZvs7Sg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HkUKiYpwnGvL7d1ZgvvaMYhUChdvWh+RnCdSK85ehmC4agpXxZ+zhEfpLPdPrybSjo
         OOgZhctxiKdtag1pSpAfi4Bh7HbjpR1mlky2BkfdNQyUhU33UriaO1mnEa+uTZpAcA/s
         2paLpAh7TpSLszXxxlyJ6emf9FsCbejl58Lic=
Received: by 10.43.64.16 with SMTP id xg16mr1986436icb.72.1302115229347; Wed,
 06 Apr 2011 11:40:29 -0700 (PDT)
Received: by 10.42.180.71 with HTTP; Wed, 6 Apr 2011 11:40:29 -0700 (PDT)
In-Reply-To: <7v4o6fg29j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171000>

Hi Julio,,

On Sun, Apr 3, 2011 at 4:36 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Junio C Hamano (9):
> =A0 =A0 =A0apply: do not patch lines that were already patched
>
This commit introduces a regression when editing splithunks using "git
add -p". Reverting the patch fix the regression.

Considering the following checked-in code:

int
main(int argc, char **argv)
{
        int a;

        return 0;
}

modified the following way:

int
main(int argc, char **argv)
{
        int c;
        int a;
        int d;
        int e;
        int f;

        return 0;
}

if you 'git add -p' on the file, you'll get:

diff --git a/main.c b/main.c
index f9f4197..7fb483f 100644
--- a/main.c
+++ b/main.c
@@ -9,7 +9,11 @@
 int
 main(int argc, char **argv)
 {
+       int c;
        int a;
+       int d;
+       int e;
+       int f;

        return 0;
 }

Now, I only want the first part, so I reduce the context by typing
's', which lead to:

Split into 2 hunks.
@@ -9,4 +9,5 @@
 int
 main(int argc, char **argv)
 {
+       int c;
        int a;

If I edit this hunk and make _no_modification_, "git apply" fails with:

error: patch failed: main.c:12
error: main.c: patch does not apply
Your edited hunk does not apply. Edit again (saying "no" discards!) [y/=
n]?

This hunk does _apply_, as it could be staged and committed as-is if I
did not edit it.

This was just a way to reproduce the regression. If you change the
code in a way that would still apply, git-apply would still fails to
apply the hunk. Editing the whole original hunk (ie. not split) works
fine.

 - Arnaud
