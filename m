From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] grep -O: Do not pass color sequences as filenames to
 pager
Date: Fri, 2 Jul 2010 21:55:06 -0500
Message-ID: <20100703025506.GB20980@burratino>
References: <1278064941-30689-1-git-send-email-ayiehere@gmail.com>
 <20100702192102.GA6585@burratino>
 <AANLkTilI0NZiDk3I850x28pr5I0sYRiPLW7HAST9sduU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Nazri Ramliy <ayiehere@gmail.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 04:55:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUstV-00060H-6v
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 04:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277Ab0GCCzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 22:55:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52844 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062Ab0GCCzh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 22:55:37 -0400
Received: by iwn7 with SMTP id 7so3858487iwn.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 19:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=A5Jz2TvsYfzaGNiXQ8PMxxRYIfD64HHv+1aWAk0TBdE=;
        b=KDbcRKCAIQkQuBIWJwdkKlzFdbVgW946lx2b83p18Gy7162YoRfoefIusjYUW3bGeu
         Vdkw/e2RXvD1vEPSn3fZBmYgXhZxxSmPSNZXut2zKQ9ukTzeyyYVdyBHDylh6Jo2CONU
         vtdHi1N7W+Oiq8O7PJyK+3iRQzQ4fKP5mCZzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=J+Q7CE6swPGloqAKAmnT8wTlXUqxH/M45PrjTi2iAM5MX8UHueb28k36zxTCuo4Rec
         stDqSQXbJNhfMoxVJpj0Fqq9n+zZ7x/+QZxUGHLOTTa1MDlqcZT7EOdFHo9fA3Xp3XcI
         utQ6m7dKXtfrzYmaETYYRs5bT5Jo5ONwEiDw0=
Received: by 10.231.33.205 with SMTP id i13mr1747236ibd.179.1278125735746;
        Fri, 02 Jul 2010 19:55:35 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm3619750ibb.14.2010.07.02.19.55.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 19:55:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTilI0NZiDk3I850x28pr5I0sYRiPLW7HAST9sduU@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150176>

From: Nazri Ramliy <ayiehere@gmail.com>

With a .gitconfig like this:

 [color]
	ui = auto
 [color "grep"]
	filename = magenta

if stdout is a terminal, the grep machinery will output the color
sequence \e[36m before each filename in its output.

In the case of "git grep -O foo", output is argv for the pager.
Disable color when calling the grep machinery in this case.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Nazri Ramliy wrote:

> You'll have to set "color.grep.filename" too in order to break the two
> test cases.

Thanks.

 builtin/grep.c       |    1 +
 t/t7811-grep-open.sh |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 232cd1c..597f76b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1001,6 +1001,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (show_in_pager == default_pager)
 		show_in_pager = git_pager(1);
 	if (show_in_pager) {
+		opt.color = 0;
 		opt.name_only = 1;
 		opt.null_following_name = 1;
 		opt.output_priv = &path_list;
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index c110441..568a6f2 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -125,6 +125,21 @@ test_expect_success 'modified file' '
 	test_cmp empty out
 '
 
+test_config() {
+	git config "$1" "$2" &&
+	test_when_finished "git config --unset $1"
+}
+
+test_expect_success 'copes with color settings' '
+	rm -f actual &&
+	echo grep.h >expect &&
+	test_config color.grep always &&
+	test_config color.grep.filename yellow &&
+	test_config color.grep.separator green &&
+	git grep -O'\''printf "%s\n" >actual'\'' GREP_AND &&
+	test_cmp expect actual
+'
+
 test_expect_success 'run from subdir' '
 	rm -f actual &&
 	echo grep.c >expect &&
-- 
1.7.1.1
