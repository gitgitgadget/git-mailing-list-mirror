From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] Add tests for git check-ref-format
Date: Mon, 12 Oct 2009 00:27:04 -0500
Message-ID: <20091012052704.GB11106@progeny.tock>
References: <4AD0C93C.6050306@web.de>
 <7vws327wbp.fsf@alter.siamese.dyndns.org>
 <20091012052536.GA11106@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 07:20:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxDKq-0006Uy-3L
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 07:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbZJLFTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 01:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbZJLFTP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 01:19:15 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:63133 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbZJLFTO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 01:19:14 -0400
Received: by gxk4 with SMTP id 4so9738880gxk.8
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 22:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=o2Y5Yf578t/h2rZGa/Op1gh5ZVTTgejk1N/upgMuFik=;
        b=Qhkpg9QgJHnuXHxRRvP1XOky9TyavJi7hAbckiDZPrBlY3LNJJ/nX4617XiPu+5RqV
         Lxs/0jvPlfEKsjgHnmcxbZNLihbrScadnaHN2q4sUlQQtUrrX0NmK4vffWMi+cd6OQlN
         jV001a5+DGdzjP5onHcEurlsDITtrC1rDqGOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jMbJY8gccFqi8yQLKtZWMmctNdXyZhQuhnDJCEv27omlRpif/k7OHl51GYRz3fvY3D
         eVJ/TD6O18kSdMaj4rLEPYTYPayuTJuBPHeiMoJe/gYRLjAan7MDmSrDvDcXQ0HVgskd
         SwpXN6k7WAltQeCaxmU/Pc0tmATmfaUZZHpg0=
Received: by 10.150.22.2 with SMTP id 2mr9311681ybv.293.1255324717833;
        Sun, 11 Oct 2009 22:18:37 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm1119036gxk.14.2009.10.11.22.18.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 22:18:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091012052536.GA11106@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129981>

The "git check-ref-format" command is a basic command various
porcelains rely on.  Test its functionality to make sure it does
not unintentionally change.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t1402-check-ref-format.sh |   44 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 t/t1402-check-ref-format.sh

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
new file mode 100644
index 0000000..382bc6e
--- /dev/null
+++ b/t/t1402-check-ref-format.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='Test git check-ref-format'
+
+. ./test-lib.sh
+
+valid_ref() {
+	test_expect_success "ref name '$1' is valid" \
+		"git check-ref-format '$1'"
+}
+invalid_ref() {
+	test_expect_success "ref name '$1' is not valid" \
+		"test_must_fail git check-ref-format '$1'"
+}
+
+valid_ref 'heads/foo'
+invalid_ref 'foo'
+valid_ref 'foo/bar/baz'
+valid_ref 'refs///heads/foo'
+invalid_ref 'heads/foo/'
+invalid_ref './foo'
+invalid_ref '.refs/foo'
+invalid_ref 'heads/foo..bar'
+invalid_ref 'heads/foo?bar'
+valid_ref 'foo./bar'
+invalid_ref 'heads/foo.lock'
+valid_ref 'heads/foo@bar'
+invalid_ref 'heads/v@{ation'
+invalid_ref 'heads/foo\bar'
+
+test_expect_success "check-ref-format --branch @{-1}" '
+	T=$(git write-tree) &&
+	sha1=$(echo A | git commit-tree $T) &&
+	git update-ref refs/heads/master $sha1 &&
+	git update-ref refs/remotes/origin/master $sha1
+	git checkout master &&
+	git checkout origin/master &&
+	git checkout master &&
+	refname=$(git check-ref-format --branch @{-1}) &&
+	test "$refname" = "$sha1" &&
+	refname2=$(git check-ref-format --branch @{-2}) &&
+	test "$refname2" = master'
+
+test_done
-- 
1.6.5.rc1.199.g596ec
