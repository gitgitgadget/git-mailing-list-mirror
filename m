From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Set TAR in t/Makefile and in t4116-apply-reverse.sh
Date: Fri, 25 Jul 2008 12:37:33 -0700
Message-ID: <7v8wvpsqki.fsf@gitster.siamese.dyndns.org>
References: <TE3N1FoSy-vEEv0qsAyvBwBMMq2RuJCWYw7DNLBC7mEh6PxM1LCsOw@cipher.nrlssc.navy.mil> <1217003860-10609-1-git-send-email-s-beyer@gmx.net> <7vvdytsu7n.fsf@gitster.siamese.dyndns.org> <20080725182416.GG27172@leksak.fem-net> <7vmyk5sska.fsf@gitster.siamese.dyndns.org> <20080725185818.GA13539@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:38:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMT7k-0002DT-N8
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbYGYThl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbYGYThl
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:37:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbYGYThk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:37:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D32D242B50;
	Fri, 25 Jul 2008 15:37:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D93BA42B49; Fri, 25 Jul 2008 15:37:34 -0400 (EDT)
In-Reply-To: <20080725185818.GA13539@leksak.fem-net> (Stephan Beyer's message
 of "Fri, 25 Jul 2008 20:58:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 23C6E14C-5A81-11DD-9EA3-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90095>

Stephan Beyer <s-beyer@gmx.net> writes:

> Junio C Hamano wrote:
>> Stephan Beyer <s-beyer@gmx.net> writes:
>> >> diff --git a/Makefile b/Makefile
>> >> index b003e3e..1d14209 100644
>> >> --- a/Makefile
>> >> +++ b/Makefile
>> >> @@ -1212,6 +1212,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
>> >>  
>> >>  GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
>> >>  	@echo SHELL_PATH=\''$(SHELL_PATH_SQ)'\' >$@
>> >> +	@echo TAR=\''$(subst ','\'',$(TAR))'\' >>$@
>> >>  
>> >>  ### Detect Tck/Tk interpreter path changes
>> >>  ifndef NO_TCLTK
>> >
>> > But then TAR has to be set in test-lib.sh also, to be able to
>> > invoke t5000 and t4116 directly, hasn't it?
>> 
>> Dosen't test-lib source GIT-BUILD-OPTIONS?
>
> It does.  Great, then.

Sorry, but not quite.  The above shell construct is toooootally bogus.

We need this patch on top.

-- >8 --
[PATCH] Makefile: fix shell quoting

Makefile records paths to a few programs in GIT-BUILD-OPTIONS file.  These
paths need to be quoted twice: once to protect specials from the shell
that runs the generated GIT-BUILD-OPTIONS file, and again to protect them
(and the first level of quoting itself) from the shell that runs the
"echo" inside the Makefile.

You can test this by trying:

    $ ln -s /bin/tar "$HOME/Tes' program/tar"
    $ make TAR="$HOME/Tes' program/tar" test

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile            |    7 +++++--
 t/t5000-tar-tree.sh |   10 +++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 1d14209..f13184b 100644
--- a/Makefile
+++ b/Makefile
@@ -1210,9 +1210,12 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
 		echo "$$FLAGS" >GIT-CFLAGS; \
             fi
 
+# We need to apply sq twice, once to protect from the shell
+# that runs GIT-BUILD-OPTIONS, and then again to protect it
+# and the first level quoting from the shell that runs "echo".
 GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
-	@echo SHELL_PATH=\''$(SHELL_PATH_SQ)'\' >$@
-	@echo TAR=\''$(subst ','\'',$(TAR))'\' >>$@
+	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
+	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
 
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 5eb119e..87902f8 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -67,7 +67,7 @@ test_expect_success \
 test_expect_success \
     'validate file modification time' \
     'mkdir extract &&
-     $TAR xf b.tar -C extract a/a &&
+     "$TAR" xf b.tar -C extract a/a &&
      perl -e '\''print((stat("extract/a/a"))[9], "\n")'\'' >b.mtime &&
      echo "1117231200" >expected.mtime &&
      diff expected.mtime b.mtime'
@@ -79,7 +79,7 @@ test_expect_success \
 
 test_expect_success \
     'extract tar archive' \
-    '(cd b && $TAR xf -) <b.tar'
+    '(cd b && "$TAR" xf -) <b.tar'
 
 test_expect_success \
     'validate filenames' \
@@ -96,7 +96,7 @@ test_expect_success \
 
 test_expect_success \
     'extract tar archive with prefix' \
-    '(cd c && $TAR xf -) <c.tar'
+    '(cd c && "$TAR" xf -) <c.tar'
 
 test_expect_success \
     'validate filenames with prefix' \
@@ -116,7 +116,7 @@ test_expect_success \
 
 test_expect_success \
     'extract substfiles' \
-    '(mkdir f && cd f && $TAR xf -) <f.tar'
+    '(mkdir f && cd f && "$TAR" xf -) <f.tar'
 
 test_expect_success \
      'validate substfile contents' \
@@ -128,7 +128,7 @@ test_expect_success \
 
 test_expect_success \
     'extract substfiles from archive with prefix' \
-    '(mkdir g && cd g && $TAR xf -) <g.tar'
+    '(mkdir g && cd g && "$TAR" xf -) <g.tar'
 
 test_expect_success \
      'validate substfile contents from archive with prefix' \
-- 
1.6.0.rc0.51.g51a9e
