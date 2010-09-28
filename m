From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH v3 1/3] tests: Prepare --textconv tests for correctly-failing conversion program
Date: Tue, 28 Sep 2010 16:41:48 +0400
Message-ID: <20100928124148.GA29882@landau.phys.spbu.ru>
References: <cover.1285351816.git.kirr@landau.phys.spbu.ru> <66d4603c7e21561557f612690d6196e7ae0b38f9.1285351816.git.kirr@landau.phys.spbu.ru> <7vsk0vyriw.fsf@alter.siamese.dyndns.org> <20100928120722.GA29525@landau.phys.spbu.ru> <20100928122031.GC29525@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 14:41:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ZVL-0001CD-5Y
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 14:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862Ab0I1Mlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 08:41:50 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:43587 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab0I1Mlt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 08:41:49 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 4A3C3FF718; Tue, 28 Sep 2010 16:41:48 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <20100928122031.GC29525@landau.phys.spbu.ru>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157417>

On Tue, Sep 28, 2010 at 04:20:31PM +0400, Kirill Smelkov wrote:
> On Tue, Sep 28, 2010 at 04:07:22PM +0400, Kirill Smelkov wrote:
> > diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
> > index 68fee12..6aaa10b 100755
> > --- a/t/t4042-diff-textconv-caching.sh
> > +++ b/t/t4042-diff-textconv-caching.sh
> > @@ -5,8 +5,8 @@ test_description='test textconv caching'
> >  
> >  cat >helper <<'EOF'
> >  #!/bin/sh
> > -grep -q '^bin: ' "$@" || { echo "E: $@ is not \"binary\" file" 1>&2; exit 1; }
> > -sed 's/^bin: /converted: /' "$@" >helper.out
> > +grep -q '^bin: ' "$1" || { echo "E: $1 is not \"binary\" file" 1>&2; exit 1; }
> > +sed 's/^bin: /converted: /' "$1" >helper.out
> >  cat helper.out
> >  EOF
> >  chmod +x helper
> 
> Please ignore this - changing so breaks textconv cache tests in this
> file.

Ok, here is what also is needed here

---- 8< ----

    NOTE: in t4042, I had to correct args hack, and just roll second
    textconv helper for cache-invalidates-on-textconv-change test.

    ...

diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
index 6aaa10b..c362261 100755
--- a/t/t4042-diff-textconv-caching.sh
+++ b/t/t4042-diff-textconv-caching.sh
@@ -9,7 +9,12 @@ grep -q '^bin: ' "$1" || { echo "E: $1 is not \"binary\" file" 1>&2; exit 1; }
 sed 's/^bin: /converted: /' "$1" >helper.out
 cat helper.out
 EOF
-chmod +x helper
+cat >helper2 <<'EOF'
+#!/bin/sh
+echo "converted: other"
+./helper "$1"
+EOF
+chmod +x helper helper2
 
 test_expect_success 'setup' '
 	echo "bin: foo content 1" >foo.bin &&
@@ -77,8 +82,7 @@ index 255496b..ad450ff 100644
 +converted: foo content 2
 EOF
 test_expect_success 'changing textconv invalidates cache' '
-	echo "bin: other" >other &&
-	git config diff.magic.textconv "./helper other" &&
+	git config diff.magic.textconv ./helper2 &&
 	git diff HEAD^ HEAD >actual &&
 	test_cmp expect actual
 '
