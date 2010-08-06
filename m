From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] Allow "check-ref-format --branch" from subdirectory
Date: Thu, 5 Aug 2010 22:39:22 -0500
Message-ID: <20100806033922.GS22369@burratino>
References: <20100626192203.GA19973@burratino>
 <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
 <7v630hyf5r.fsf@alter.siamese.dyndns.org>
 <20100806023529.GB22369@burratino>
 <20100806033411.GQ22369@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 05:40:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhDnd-00056n-HL
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 05:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935346Ab0HFDkp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 23:40:45 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36790 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933683Ab0HFDko (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 23:40:44 -0400
Received: by gyg10 with SMTP id 10so2716755gyg.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 20:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sIAHqG0ocb54yHPYnd+tLubcWdSi+aZCZVrKlYgjhI4=;
        b=uN73JJD5nXaUxBCdGPxGtOWjJJ0d4jV3OQ+PtXQsnZBD4I6Qe4MPi2/rnKVb0H7R9n
         47rxwDvqlYU9nCXWgOlXCijicOGxTtyIy77wH7ABT7QMeYOeEENqg0o/vyTtZ+VGBkSc
         yD9/iKLD0lRjNdqUKc/Zjk4v+tfQRgZtbjDZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=JjzjvI63uIWHjIfgxX75r9RtJUJfeFoQw6iONBHQsPJW9QYmvDCJJbbApxCG8khFD+
         89QmcshsiFXHmPSW3IrH1+uBbBBJ7UngnK9Vpj6vDIP7J+G+j1O2b9j4YxAR8Y4EnZNo
         r0V3dkB3csUrikKWFrTnUqQw5FllZpPgXoPQ4=
Received: by 10.100.105.15 with SMTP id d15mr12985985anc.212.1281066043149;
        Thu, 05 Aug 2010 20:40:43 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id t30sm1330381ann.7.2010.08.05.20.40.42
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 20:40:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806033411.GQ22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152761>

check-ref-format --branch requires access to the repository
to resolve refs like @{-1}.

Noticed by Duy.

Cc: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The original used the RUN_SETUP_GENTLY flag to run setup
unconditionally.  That might still be a good idea, but I am
more comfortable running setup just for this subcommand
for now so commands like "git check-ref-format refs/foo" are not
affected.

 builtin/check-ref-format.c  |    2 ++
 t/t1402-check-ref-format.sh |   17 +++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 8707ee9..ae3f281 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -36,7 +36,9 @@ static void collapse_slashes(char *dst, const char *s=
rc)
 static int check_ref_format_branch(const char *arg)
 {
 	struct strbuf sb =3D STRBUF_INIT;
+	int nongit;
=20
+	setup_git_directory_gently(&nongit);
 	if (strbuf_check_branch_ref(&sb, arg))
 		die("'%s' is not a valid branch name", arg);
 	printf("%s\n", sb.buf + 11);
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index eb45afb..782e75d 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -41,6 +41,23 @@ test_expect_success "check-ref-format --branch @{-1}=
" '
 	refname2=3D$(git check-ref-format --branch @{-2}) &&
 	test "$refname2" =3D master'
=20
+test_expect_success 'check-ref-format --branch from subdir' '
+	mkdir subdir &&
+
+	T=3D$(git write-tree) &&
+	sha1=3D$(echo A | git commit-tree $T) &&
+	git update-ref refs/heads/master $sha1 &&
+	git update-ref refs/remotes/origin/master $sha1
+	git checkout master &&
+	git checkout origin/master &&
+	git checkout master &&
+	refname=3D$(
+		cd subdir &&
+		git check-ref-format --branch @{-1}
+	) &&
+	test "$refname" =3D "$sha1"
+'
+
 valid_ref_normalized() {
 	test_expect_success "ref name '$1' simplifies to '$2'" "
 		refname=3D\$(git check-ref-format --print '$1') &&
--=20
1.7.2.1.544.ga752d.dirty
