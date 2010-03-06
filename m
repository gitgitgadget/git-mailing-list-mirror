From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] gitk: Stop clobbering "Remember This View" setting
Date: Sat, 6 Mar 2010 16:58:42 -0600
Message-ID: <20100306225842.GC7064@progeny.tock>
References: <20100306224605.GA7064@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steve Cotton <steve0001@s.cotton.clara.co.uk>,
	Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Mar 06 23:58:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No2xF-0007v7-6L
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 23:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab0CFW6g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 17:58:36 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47519 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab0CFW6f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 17:58:35 -0500
Received: by gwb15 with SMTP id 15so2401009gwb.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 14:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=u2isFE+S4d4mWrvkShvu4SfM2Ow5sjGU/S9gChycr48=;
        b=jpmSai51MGeWglOzvZd/vAT6Kf+VcQK+VwA38Fx+kIlLrbmk7AtPaHAjQCk0+CbXqz
         ZFUYF4uFkgll1QbsZLSFpTLav45e/0wjA7/ni4rO4MANtkpQmwReif/DAX6xa3TpfB4W
         Cz+2hlNoe40XA0r7aCk0damCDAUr4+eyxjq2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=AR/PNexauAGEKjQjcdbgj+q5kk7knq3Bo/t99QfffTqvrqTw4ZXI8UUEEkH8zbumUT
         J1bCoAEkjm5igk+DggE9k8iGTgS38e97VA0xQOp2qgEhwFZ5zvHOP4YJY7skAoopa/x4
         b9jGEGXjJcF8zRVSvelHBfIoJ8sqzFovJcqv8=
Received: by 10.101.167.21 with SMTP id u21mr5803299ano.118.1267916314550;
        Sat, 06 Mar 2010 14:58:34 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2839265iwn.10.2010.03.06.14.58.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 14:58:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100306224605.GA7064@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141626>

In the View =E2=86=92 Edit View... dialog, the "Remember this view" opt=
ion
always starts out unset.  Using the dialog to change an existing view
and ignoring the parts of the dialog that aren=E2=80=99t relevant resul=
ts in
both the old and new versions of the view being lost.

The cause: right after newviewopts($curview,perm) is set to an
appropriate value, decode_view_opts is clobbering it with the default
value.  If that call is moved a little earlier, the "Remember this
view" option gets properly set to its previous value, fixing the
problem.

Reported-by: Steve Cotton <steve0001@s.cotton.clara.co.uk>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 gitk |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 7f498b5..c3ef275 100755
--- a/gitk
+++ b/gitk
@@ -3805,10 +3805,10 @@ proc newview {ishighlight} {
 	raise $top
 	return
     }
+    decode_view_opts $nextviewnum $revtreeargs
     set newviewname($nextviewnum) "[mc "View"] $nextviewnum"
     set newviewopts($nextviewnum,perm) 0
     set newviewopts($nextviewnum,cmd)  $viewargscmd($curview)
-    decode_view_opts $nextviewnum $revtreeargs
     vieweditor $top $nextviewnum [mc "Gitk view definition"]
 }
=20
@@ -3962,10 +3962,10 @@ proc editview {} {
 	raise $top
 	return
     }
+    decode_view_opts $curview $viewargs($curview)
     set newviewname($curview)      $viewname($curview)
     set newviewopts($curview,perm) $viewperm($curview)
     set newviewopts($curview,cmd)  $viewargscmd($curview)
-    decode_view_opts $curview $viewargs($curview)
     vieweditor $top $curview "[mc "Gitk: edit view"] $viewname($curvie=
w)"
 }
=20
--=20
1.7.0
