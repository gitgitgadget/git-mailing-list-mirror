From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: t9010 broken in pu [Re: What's cooking in git.git (Dec 2010,
 #01; Sat, 4)]
Date: Wed, 8 Dec 2010 05:28:36 -0600
Message-ID: <20101208112836.GA5285@burratino>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org>
 <201012081223.47642.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 08 12:28:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQICd-0001bc-LO
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 12:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066Ab0LHL2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 06:28:51 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57975 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab0LHL2u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 06:28:50 -0500
Received: by yxt3 with SMTP id 3so574036yxt.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 03:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TZNZp53XmgoNjQVSBihINYjPTREWdnfgToisjXISA5Y=;
        b=mK48x6Y8nCFQSn/PnIpHHf9odShTgutNqZBIaLsPd5vkiMM9qoDlSJo2fqaBdU3jWG
         fgKi01WVKahHQkWtanMpLVUZeN6EnjhlJ2laWuS1LEWV3PI+/5SZdv+YOQ6VXPWtx3zK
         ilwGvk/BiLuHvSEBK6POm3eLpUmHb3Am/XcVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WlDGJXFrovZ92+uapKywQHYVDL2zxT7xHxEakGDbtU1+KIAxS8DeIuFbLLsrza/46D
         OKu/TkB2STJhDnr6Pa4ZL2vlBZdcbCRSMyHeq6L97e0Xi7c1YW/11KC3Dma3ese7jBWY
         zKhZuJ4PwLj5hfk3JdCs1LIabrjQfoXIJ+uiw=
Received: by 10.150.135.11 with SMTP id i11mr3919584ybd.230.1291807729956;
        Wed, 08 Dec 2010 03:28:49 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id y73sm326278yhc.36.2010.12.08.03.28.48
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 03:28:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201012081223.47642.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163191>

Thomas Rast wrote:

> If I'm reading the test report right, the merge conflict in
> t/t9010-svn-fe.sh broke tests.  It bisects to 5ea8b68 (Merge branch
> 'jn/svn-fe' into pu, 2010-12-07), failing with
[...]
> A quick reading of the merge suggests that you concatenated with an
> earlier test that goes
> 
>   test_dump () {
[...]
> hence creating simple-svn, too.  So a rename or rm -rf should suffice.

Thanks for the analysis.  Even better would be to remove the redundant
definition and invocation of test_dump, like this (imitating b3e5bce,
vcs-svn: Error out for v3 dumps, 2010-11-17):
---
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 6e3b6ad..d207aeb 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -14,31 +14,6 @@ svn_cmd () {
 	svn "$subcommand" --config-dir "$svnconf" "$@"
 }
 
-test_dump () {
-	label=$1
-	dump=$2
-	test_expect_success "$dump" '
-		svnadmin create "$label-svn" &&
-		svnadmin load "$label-svn" < "$TEST_DIRECTORY/$dump" &&
-		svn_cmd export "file://$PWD/$label-svn" "$label-svnco" &&
-		git init "$label-git" &&
-		test-svn-fe "$TEST_DIRECTORY/$dump" >"$label.fe" &&
-		(
-			cd "$label-git" &&
-			git fast-import < ../"$label.fe"
-		) &&
-		(
-			cd "$label-svnco" &&
-			git init &&
-			git add . &&
-			git fetch "../$label-git" master &&
-			git diff --exit-code FETCH_HEAD
-		)
-	'
-}
-
-test_dump simple t9135/svn.dump
-
 reinit_git () {
 	rm -fr .git &&
 	git init
