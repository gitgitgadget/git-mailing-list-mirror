From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/12] t6038 (merge.renormalize): try checkout -m and
 cherry-pick
Date: Thu, 5 Aug 2010 06:11:12 -0500
Message-ID: <20100805111112.GD13779@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:12:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgyNS-00082i-9w
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759007Ab0HELMj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 07:12:39 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:32932 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758946Ab0HELMh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:12:37 -0400
Received: by gwb20 with SMTP id 20so2409829gwb.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ALvYu7raakmec0fcv/rwOkOm3slPbXkNr056aul1bQo=;
        b=fBzIEEAwRPVfiHSurVAlisrEOFgiLk5pfCwMnBSwKGzgIH/PLL9pTgFm0qBazCpgUk
         xPlmdwdcOo5Ky8XG4giob6PwG5o8lHQ6F9icWhD3UYTiGVzs0Zl6jPTaLirhYSI0ula3
         zaqYKVDAmCgQf3OXCG1ptOE+t9CpvkilK02Vw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=gJxybmgPSZhM8g4kJreR4W3j7KpX0aaRCbxTYupg37p4QPPgCskA5gjwDtMLtZ/C2D
         0RwE22NUcnZ28O6SPm/2ZDTSeSIHBpbnnnhAQLGh0do0vv7iu8ZDt1N6O+96M5Anx5wY
         LpXrmKeA7Z1Syitso9yqJG8DeuXVMIeY2uoIU=
Received: by 10.150.14.21 with SMTP id 21mr12419382ybn.65.1281006756564;
        Thu, 05 Aug 2010 04:12:36 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u42sm76367yba.0.2010.08.05.04.12.35
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:12:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100805110822.GB13779@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152634>

checkout -m and cherry-pick have not been wired up to respect
merge.renormalize, but a na=EFve user would not know that.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This series does not change these to expect success, but they
are part of the same thought process.

 t/t6038-merge-text-auto.sh |   41 ++++++++++++++++++++++++++++++++++++=
+++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index e21b5d2..a7ea4b6 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -85,6 +85,47 @@ test_expect_success 'Merge addition of text=3Dauto' =
'
 	test_cmp expected file
 '
=20
+test_expect_failure 'checkout -m after setting text=3Dauto' '
+	cat <<-\EOF >expected &&
+	first line
+	same line
+	EOF
+
+	git rm -fr . &&
+	rm -f .gitattributes &&
+	git reset --hard initial &&
+	git checkout a -- . &&
+	git checkout -m b &&
+	test_cmp expected file
+'
+
+test_expect_failure 'checkout -m addition of text=3Dauto' '
+	cat <<-\EOF >expected &&
+	first line
+	same line
+	EOF
+
+	git rm -fr . &&
+	rm -f .gitattributes file &&
+	git reset --hard initial &&
+	git checkout b -- . &&
+	git checkout -m a &&
+	test_cmp expected file
+'
+
+test_expect_failure 'cherry-pick patch from after text=3Dauto was adde=
d' '
+	append_cr <<-\EOF >expected &&
+	first line
+	same line
+	EOF
+
+	git rm -fr . &&
+	git reset --hard b &&
+	test_must_fail git cherry-pick a >err 2>&1 &&
+	grep "[Nn]othing added" err &&
+	test_cmp expected file
+'
+
 test_expect_success 'Test delete/normalize conflict' '
 	git checkout -f side &&
 	git rm -fr . &&
--=20
1.7.2.1.544.ga752d.dirty
