From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] merge: let custom strategies intervene in trivial
 merges
Date: Sun, 15 Aug 2010 20:11:06 -0500
Message-ID: <20100816011106.GB22573@burratino>
References: <20100816010652.GA22546@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 16 03:12:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkoFw-0005b5-B5
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 03:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab0HPBMq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 21:12:46 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64957 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab0HPBMp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 21:12:45 -0400
Received: by gwj17 with SMTP id 17so742179gwj.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 18:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zQbzAQU+yZW8z5S9eguBa8z5YHsRutUXyf4TKqlcObc=;
        b=rMkf88XslRiKkxa3HTlYt1uoBiTqy5Vj/2vMiAwFX1Os/jScC56z75elzrXEjk7u0i
         aU0DvRh9iDVKDaIwIB5POvUf1JcbREvSweruAwh5h470HHE0GpwUc8fIwAFRw4pTPwC4
         TJIsZELEd1ub/XmvoKoviMCQ0YL8ayphjXvfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Ghx1HI/rdx1FQQi+UMRCVUs23dEP0nqb8bx19wwjb/Qhbks6vvSZsdRNWAgaG1otZJ
         Q5WXIuchs9CHdzD4Cxd8vZ4lzyGsX6mjpkBYu+TwKmQ3V5kLuJ+VILdNEL4D9sWWBO+h
         BV0gf9kd4BXlH0JBbSKx9/ZoQkx/uO+6YUuOk=
Received: by 10.100.127.5 with SMTP id z5mr3225777anc.47.1281921164753;
        Sun, 15 Aug 2010 18:12:44 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id a12sm9244570and.36.2010.08.15.18.12.43
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 15 Aug 2010 18:12:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100816010652.GA22546@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153640>

As v1.6.1-rc1~294^2 (2008-08-23) explains, custom merge strategies
do not even kick in when the merge is truly trivial.  But they
should, since otherwise a custom =E2=80=9C--strategy=3Dtheirs=E2=80=9D =
is not useful.

Perhaps custom strategies should not allow fast-forward either.  This
patch does not make that change, since it is less important (because
it is always possible to explicitly use --no-ff).

Reported-by: Yaroslav Halchenko <debian@onerussian.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/merge.c         |    1 +
 t/t7606-merge-custom.sh |   36 +++++++++++++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 37ce4f5..e48e90b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -131,6 +131,7 @@ static struct strategy *get_strategy(const char *na=
me)
=20
 	ret =3D xcalloc(1, sizeof(struct strategy));
 	ret->name =3D xstrdup(name);
+	ret->attr =3D NO_TRIVIAL;
 	return ret;
 }
=20
diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
index 82045cd..13c2193 100755
--- a/t/t7606-merge-custom.sh
+++ b/t/t7606-merge-custom.sh
@@ -4,11 +4,13 @@ test_description=3D"git merge
=20
 Testing a custom strategy.
=20
-*   (HEAD, master) Merge commit 'c2'
+*   (HEAD, master) Merge commit 'c3'
 |\
-| * (tag: c2) c2
+| * (tag: c3) c3
 * | (tag: c1) c1
 |/
+| * tag: c2) c2
+|/
 * (tag: c0) c0
 "
=20
@@ -31,7 +33,9 @@ test_expect_success 'setup' '
 	git reset --keep c0 &&
 	echo c1c1 >c1.c &&
 	git add c1.c &&
-	test_commit c2 c2.c
+	test_commit c2 c2.c &&
+	git reset --keep c0 &&
+	test_commit c3 c3.c
 '
=20
 test_expect_success 'merge c2 with a custom strategy' '
@@ -60,4 +64,30 @@ test_expect_success 'merge c2 with a custom strategy=
' '
 	test -f c2.c
 '
=20
+test_expect_success 'trivial merge with custom strategy' '
+	git reset --hard c1 &&
+
+	git rev-parse c1 >head.old &&
+	git rev-parse c3 >second-parent.expected &&
+	git rev-parse c3^{tree} >tree.expected &&
+	git merge -s theirs c3 &&
+
+	git rev-parse HEAD >head &&
+	git rev-parse HEAD^1 >first-parent &&
+	git rev-parse HEAD^2 >second-parent &&
+	git rev-parse HEAD^{tree} >tree &&
+	git update-index --refresh &&
+	git diff --exit-code &&
+	git diff --exit-code c3 HEAD &&
+	git diff --exit-code c3 &&
+
+	! test_cmp head.old head &&
+	test_cmp head.old first-parent &&
+	test_cmp second-parent.expected second-parent &&
+	test_cmp tree.expected tree &&
+	test -f c0.c &&
+	! test -e c1.c &&
+	test -f c3.c
+'
+
 test_done
--=20
1.7.2.1.544.ga752d.dirty
