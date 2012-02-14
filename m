From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] test: mailmap can change author name without changing email
Date: Tue, 14 Feb 2012 23:35:33 +0200
Message-ID: <CAMP44s3di25SbMa1T1=0_s6f-rKnniwEcA+o5HWT7xedcghSeg@mail.gmail.com>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
	<20120214203431.GB13210@burratino>
	<20120214203519.GC13210@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:35:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQ2G-0001JI-DB
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 22:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761243Ab2BNVfg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 16:35:36 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56507 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755490Ab2BNVfe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 16:35:34 -0500
Received: by lagu2 with SMTP id u2so423920lag.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 13:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LSjcPG62Pd4N7nX9RcMem3U+WUp4fBD2mBUViX+oDf8=;
        b=riR1Kn57tRV5O9HaRjtyIYagVIYxl1bVbAegcf8jP8Dx8+bCtzV9pZF8WsBIvzBsqW
         3O8Z4asc6Fs4F+nyFXnpA3RYa5nxhc+o+DAKsxJpBGnB47QQsLnZQoee45fwmoO1ASXF
         X2NMfqXwxIftFe/jQhzt+8fNkpYwETlSXK25M=
Received: by 10.152.128.230 with SMTP id nr6mr13707085lab.27.1329255333294;
 Tue, 14 Feb 2012 13:35:33 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Tue, 14 Feb 2012 13:35:33 -0800 (PST)
In-Reply-To: <20120214203519.GC13210@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190762>

On Tue, Feb 14, 2012 at 10:35 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>

> test: mailmap can change author name without changing email

That doesn't say anything to me, which is weird if I supposedly wrote
this patch. What is the *purpose* of this?

At least 'add simple name translation test' is clear about the
purpose, albeit not clear enough as Junio pointed out.

> (2) 'email@example.com'
> becomes the canonical author email for commits with author name 'A U
> Thor'.

That's not true. I initially thought that was the case, and I think it
might be useful to have that, but it's not the case now, and your
patch doesn't test this.

> We already have tests for the effect (1) in the committer name, but
> not in the author name, so the tests do not cover the shortlog and
> blame codepaths as they should. =C2=A0Fix that.

In order to test that you would need additional changes, something
along the lines of:

--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -157,8 +157,9 @@ A U Thor <author@example.com> (1):
 CTO <cto@company.xx> (1):
       seventh

-Committed <committer@example.com> (1):
+Committed <committer@example.com> (2):
       eighth
+      nine

 Other Author <other@author.xx> (2):
       third
@@ -204,6 +205,11 @@ test_expect_success 'Shortlog output (complex mapp=
ing)' '
        test_tick &&
        git commit --author "C O Mitter <committer@example.com>" -m eig=
hth &&

+       echo nine >>one &&
+       git add one &&
+       test_tick &&
+       git commit --author "Committed <bad@example.com>" -m nine &&
+
        mkdir -p internal_mailmap &&
        echo "Committed <committer@example.com>" > internal_mailmap/.ma=
ilmap &&
        echo "<cto@company.xx>
<cto@coompany.xx>" >> internal_mailmap/.mailmap &&
@@ -220,6 +226,9 @@ test_expect_success 'Shortlog output (complex mappi=
ng)' '

 # git log with --pretty format which uses the name and email mailmap
placemarkers
 cat >expect <<\EOF
+Author Committed <committer@example.com> maps to Committed
<committer@example.com>
+Committer C O Mitter <committer@example.com> maps to Committed
<committer@example.com>
+
 Author C O Mitter <committer@example.com> maps to Committed
<committer@example.com>
 Committer C O Mitter <committer@example.com> maps to Committed
<committer@example.com>

@@ -260,6 +269,7 @@ OBJID (Santa Claus  DATE 5) five
 OBJID (Santa Claus  DATE 6) six
 OBJID (CTO          DATE 7) seven
 OBJID (Committed    DATE 8) eight
+OBJID (Committed    DATE 9) nine
 EOF
 test_expect_success 'Blame output (complex mapping)' '
        git blame one >actual &&

But that of course fails.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

I most definitely did not sign this off, and I didn't add any of these
lines, nor wrote anything about this commit message.

It might be possible to simplify my patch "t: mailmap: add simple name
translation test" using the already existing "Committed
<committer@example.com>" mapping, but that most likely is going to
remove only one line, and would make the code less clear about what
that translation is trying to test.

Cheers.

--=20
=46elipe Contreras
