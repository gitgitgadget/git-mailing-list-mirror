From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Add Git::config_path()
Date: Fri, 07 Oct 2011 13:32:39 -0700 (PDT)
Message-ID: <m3vcs01r32.fsf@localhost.localdomain>
References: <vpqty7wk9km.fsf@bauges.imag.fr>
	<1317379945-9355-1-git-send-email-cowose@gmail.com>
	<1317379945-9355-2-git-send-email-cowose@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@gmail.com>
To: Cord Seele <cowose@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 22:38:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCHC3-0000Zg-HX
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 22:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759586Ab1JGUit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 16:38:49 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59333 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759537Ab1JGUin (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 16:38:43 -0400
Received: by wyg34 with SMTP id 34so4267025wyg.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 13:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ByWcb2159VlX+WvLdBreNbjnvInmRgNYICGgcP1mBHk=;
        b=k17LNZEzzMpznCIBz+h8j9AM9yRoXxbpBqzKbRXX+0TfdWqZb8p/acK//LsxKYHxki
         FBvdxGqEIVxN9XnMIsJyU3zjvUVAnu2GGglUbhMe70eR4BgntmbxEFxclitFA+qCWfPE
         VIXeOfm4PluyFYn4m1PrTBmK4B/q8KYxkx43Q=
Received: by 10.223.5.3 with SMTP id 3mr12972463fat.4.1318019561159;
        Fri, 07 Oct 2011 13:32:41 -0700 (PDT)
Received: from localhost.localdomain (abwl248.neoplus.adsl.tpnet.pl. [83.8.235.248])
        by mx.google.com with ESMTPS id l8sm14454843fai.16.2011.10.07.13.32.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 13:32:39 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p97KVx8c000791;
	Fri, 7 Oct 2011 22:32:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p97KVTtu000754;
	Fri, 7 Oct 2011 22:31:29 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1317379945-9355-2-git-send-email-cowose@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183108>

Cord Seele <cowose@googlemail.com> writes:

> Use --path option when calling 'git config' thus allow for pathname
> expansion, e.g. a tilde.
> 
> Signed-off-by: Cord Seele <cowose@gmail.com>
> ---
>  perl/Git.pm |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)

I think the following minimal test should be squashed in:

---
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 3787186..7558f0c 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -43,7 +43,9 @@ test_expect_success \
      git config --add test.booltrue true &&
      git config --add test.boolfalse no &&
      git config --add test.boolother other &&
-     git config --add test.int 2k
+     git config --add test.int 2k &&
+     git config --add test.path "~/foo" &&
+     git config --add test.pathexpanded "$HOME/foo"
      '
 
 # The external test will outputs its own plan
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 13ba96e..ce9340c 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -33,6 +33,8 @@ is($r->config_int("test.int"), 2048, "config_int: integer");
 is($r->config_int("test.nonexistent"), undef, "config_int: nonexistent");
 ok($r->config_bool("test.booltrue"), "config_bool: true");
 ok(!$r->config_bool("test.boolfalse"), "config_bool: false");
+is($r->config_path("test.path"), $r->config("test.pathexpanded"),
+   "config_path: ~/foo expansion");
 our $ansi_green = "\x1b[32m";
 is($r->get_color("color.test.slot1", "red"), $ansi_green, "get_color");
 # Cannot test $r->get_colorbool("color.foo")) because we do not
