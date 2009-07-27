From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [RFC] request-pull with diff body itself
Date: Mon, 27 Jul 2009 23:53:57 +0400
Message-ID: <20090727195357.GE17942@lenovo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 22:09:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVWVj-0002bY-Cm
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 22:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbZG0UJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 16:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754561AbZG0UJT
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 16:09:19 -0400
Received: from mail-fx0-f214.google.com ([209.85.220.214]:49804 "EHLO
	mail-fx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbZG0UJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 16:09:18 -0400
Received: by fxm10 with SMTP id 10so91380fxm.37
        for <git@vger.kernel.org>; Mon, 27 Jul 2009 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=WmrPgSLFtiXlTCiuxN9+iWX0LZMR3skZWCB3T8wZyOE=;
        b=j6M/fMP0xrlsJpGy1ZMMtDahf4AwipjZ+buq7wktNfM66mMxzUkdqIw0vn8bX5ZHe4
         gj7OvXQ7bc6uBdCuAblNVRt5wzIFUuGsjOHpiuRP/O0yG4Ida5xBLgaZQzCpRNwjtMBf
         FZ9TRCMmnZU5lRRyeGstZ6mEAwqRx6kiHhwYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=aVPK4N4hCp9uP4EJwSqP3ARTxsR+6T4uN16RO7if+o7jnWZwpQ9AkE++qd2WMhR8Z7
         h0uEU7Rp+u+58X3Fv2XCuG5XqXeKPFxaKgBrdXVjNGXwMF4Dhi9YemI6oFshUjU2+YN4
         B922c1Bc+O8K2x98asFgmyNiIAUYQ8JrHT5SE=
Received: by 10.102.228.10 with SMTP id a10mr3460797muh.131.1248725356869;
        Mon, 27 Jul 2009 13:09:16 -0700 (PDT)
Received: from gorcunov (host-93-145-66-217.spbmts.ru [217.66.145.93])
        by mx.google.com with ESMTPS id n7sm29491712mue.58.2009.07.27.13.09.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Jul 2009 13:09:16 -0700 (PDT)
Received: by gorcunov (Postfix, from userid 1000)
	id 7DC741C5A; Mon, 27 Jul 2009 23:53:57 +0400 (MSD)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124189>

Here is rfc in a sake of having ability to produce
diff body in small series of changes in request-pull.
we could use ">>" here and append diff by hands but
adding "-p" option seems more comfortable.

Dunno, just a thought.

Please CC me, I'm not subscribed.

	-- Cyrill
---
[RFC] request-pull -- produce long diff if needed

Allow git request-pull to append diff body into
pull request. It's really useful for small series
of commits.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---

This is just an RFC -- so if you don't like it feel
free to just drop. I found useful to have an ability
to pass additional "-p" option and have diff body in
request.

 git-request-pull.sh |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

Index: git.git/git-request-pull.sh
=====================================================================
--- git.git.orig/git-request-pull.sh
+++ git.git/git-request-pull.sh
@@ -4,7 +4,7 @@
 # This file is licensed under the GPL v2, or a later version
 # at the discretion of Linus Torvalds.
 
-USAGE='<start> <url> [<end>]'
+USAGE='[-p] <start> <url> [<end>]'
 LONG_USAGE='Summarizes the changes between two commits to the standard output,
 and includes the given URL in the generated summary.'
 SUBDIRECTORY_OK='Yes'
@@ -15,6 +15,16 @@ OPTIONS_SPEC=
 GIT_PAGER=
 export GIT_PAGER
 
+usediff="no"
+if [ $# -eq 4 ]; then
+	if [ $1 = "-p" ]; then
+		usediff="yes"
+		shift
+	else
+		usage
+	fi
+fi
+
 base=$1
 url=$2
 head=${3-HEAD}
@@ -55,4 +65,10 @@ echo
 
 git shortlog ^$baserev $headrev
 git diff -M --stat --summary $merge_base $headrev
+
+if [ "$usediff" = "yes" ]; then
+	echo "---"
+	git diff -M -p $merge_base $headrev
+fi
+
 exit $status
