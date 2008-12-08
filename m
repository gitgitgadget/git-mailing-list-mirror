From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix bug in insert_file() subroutine
Date: Mon, 08 Dec 2008 14:13:21 +0100
Message-ID: <20081208130905.15803.83149.stgit@localhost.localdomain>
References: <7vfxl5c66h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Tatsuki Sugiura <sugi@nemui.org>,
	Gerrit Pape <pape@smarden.org>, Recai Oktas <roktas@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:15:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9fxm-0001uX-NT
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 14:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbYLHNOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 08:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbYLHNOd
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 08:14:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:63494 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYLHNOc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 08:14:32 -0500
Received: by ug-out-1314.google.com with SMTP id 39so597231ugf.37
        for <git@vger.kernel.org>; Mon, 08 Dec 2008 05:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=lGbMRI80Xt3pBQoWA6reUkm95JNcYQD6Sha1n3YSd3E=;
        b=hIAW11KoVtoRXhcV8Sny7uSqyLrm1PL7KoSkb6SiAxleQz2rSF1eB+vSpfNV7mDnln
         DcvW2LD97vFf/qLdDJhj3y3B51ZQMT4uJcgCKQKjU8UBsJFxxIFV+prCRzOEtjaAZPG9
         pAlb6P4NYpmj9RQedV+WrcGBCpDMZVa2miVLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=S4Z0KaGRwH2RXCIYpYDPo+osvge6vurIqcMO2j0wQ6RZDPgfH60TlZxaW8PW9ZPtb4
         y8932eIEKrtFxBLGpHp/s9FIiYx1G6Qcbvp75M9m+Nvlk/h19/DIQAwtM64H6+GsUgfY
         fGI6MIiV9np243KIVE8+R4rsaV/m3xHxSUmWk=
Received: by 10.210.29.11 with SMTP id c11mr3588943ebc.23.1228742070447;
        Mon, 08 Dec 2008 05:14:30 -0800 (PST)
Received: from localhost.localdomain (abvk203.neoplus.adsl.tpnet.pl [83.8.208.203])
        by mx.google.com with ESMTPS id 6sm5612899nfv.15.2008.12.08.05.14.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Dec 2008 05:14:29 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB8DDLSF015864;
	Mon, 8 Dec 2008 14:13:32 +0100
In-Reply-To: <7vfxl5c66h.fsf@gitster.siamese.dyndns.org>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102541>

In insert_file() subroutine (which is used to insert HTML fragments as
custom header, footer, hometext (for projects list view), and per
project README.html (for summary view)) we used:

     map(to_utf8, <$fd>);

This doesn't work, and other form has to be used:

     map { to_utf8($_) } <$fd>;

Now with test for t9600 added, for $GIT_DIR/README.html.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> With "close $fd" removed the patch is correct (and patches t9500*).
> 
> Yeah, it passes that test here, too.  Let's unleash it to 'master' and in
> an unlikely case where it still has bugs we know which commit to revert
> ;-).

I'm extremely sorry about that, but it still had bugs. I thought
I could use "map EXPR,LIST" form instead of "map BLOCK LIST" here,
i.e. "map(to_utf8, <$fd>)" instead of "map {to_utf8($_)} <$fd>;"
in original patch by Tatsuki Sugiura.

Just in case I have added check for this in t9500 gitweb test.

Once again, I'm very sorry for my buggy patches...

 gitweb/gitweb.perl                     |    2 +-
 t/t9500-gitweb-standalone-no-errors.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9517392..6eb370d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2764,7 +2764,7 @@ sub insert_file {
 	my $filename = shift;
 
 	open my $fd, '<', $filename;
-	print map(to_utf8, <$fd>);
+	print map { to_utf8($_) } <$fd>;
 	close $fd;
 }
 
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 64c4cce..43cd6ee 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -673,4 +673,14 @@ test_expect_success \
 	 gitweb_run "p=.git;a=tree"'
 test_debug 'cat gitweb.log'
 
+# ----------------------------------------------------------------------
+# non-ASCII in README.html
+
+test_expect_success \
+	'README.html with non-ASCII characters (utf-8)' \
+	'echo "<b>UTF-8 example:</b><br />" > .git/README.html &&
+	 cat "$TEST_DIRECTORY"/t3900/1-UTF-8.txt >> .git/README.html &&
+	 gitweb_run "p=.git;a=summary"'
+test_debug 'cat gitweb.log'
+
 test_done

-- 
Stacked GIT 0.14.3
git version 1.6.0.4
