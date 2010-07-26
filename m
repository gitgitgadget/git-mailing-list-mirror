From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] config --get --path: check for unset $HOME
Date: Mon, 26 Jul 2010 10:06:51 -0500
Message-ID: <20100726150651.GA4021@burratino>
References: <20100723003456.2976.899.reportbug@dr-wily.mit.edu>
 <20100723012322.GA27113@burratino>
 <20100725085939.GA5281@radis.liafa.jussieu.fr>
 <20100726005111.GA29755@burratino>
 <20100726140756.GH12476@radis.liafa.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Julien Cristau <jcristau@debian.org>
X-From: git-owner@vger.kernel.org Mon Jul 26 17:08:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdPHl-0007lo-Uh
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 17:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab0GZPIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 11:08:04 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38707 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab0GZPIB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 11:08:01 -0400
Received: by qwh6 with SMTP id 6so138391qwh.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=H7W7L5bFs8gh8sfWyY3m3jaOSpEpf1tByNloCsK8hVY=;
        b=bSTNyFmsixfOJcAzvl5s4Fj4jE9xJ9ZKnMJ/+frFmH+u4LHFwmOzO5gSyfXwi23eNQ
         MKtNxLPtAQ80ODrfN6fhT1N1EhgPskHL8AAQr6oxL+6S7ExMVxWu4/ItgYkuVUzSwjZI
         fWSBc+KBDQEwhM8QQP93ywTCSdyT0ho+4wmiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=t+tgGmBqko8FatsOAwH3RITm+JbdiOdcYPtpfdVmCOvo3r3oTpLEBBb7EoSo1Tj6w0
         +SWSW/y6cKC/YorNvqso8vQ/48RY1ogpCevjwRGiUs0J0gv0xBoEqlx8vQnJtcZXPNkh
         leB+ABYI/JgcXyagl1X+C3/hsyBQdx8kUEiTw=
Received: by 10.224.60.19 with SMTP id n19mr6135322qah.248.1280156880456;
        Mon, 26 Jul 2010 08:08:00 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h34sm4206092qcm.2.2010.07.26.08.07.58
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 08:07:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100726140756.GH12476@radis.liafa.jussieu.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151843>

If $HOME is unset (as in some automated build situations),
currently

	git config --path path.home "~"
	git config --path --get path.home

segfaults.  Error out with

	Failed to expand user dir in: '~/'

instead.

Reported-by: Julien Cristau <jcristau@debian.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Julien Cristau wrote:

> * expecting success: 
>         git config --get --path path.home > result &&
>         git config --get --path path.normal >> result &&
>         git config --get --path path.trailingtilde >> result &&
>         test_cmp expect result
> 
> Segmentation fault

Good catch.  

 path.c                 |    2 ++
 t/t1300-repo-config.sh |   24 +++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/path.c b/path.c
index b4c8d91..6b23023 100644
--- a/path.c
+++ b/path.c
@@ -316,6 +316,8 @@ char *expand_user_path(const char *path)
 		size_t username_len = first_slash - username;
 		if (username_len == 0) {
 			const char *home = getenv("HOME");
+			if (!home)
+				goto return_null;
 			strbuf_add(&user_path, home, strlen(home));
 		} else {
 			struct passwd *pw = getpw_str(username, username_len);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index f11f98c..7ddab5f 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -707,19 +707,41 @@ test_expect_success 'set --path' '
 	git config --path path.trailingtilde "foo~" &&
 	test_cmp expect .git/config'
 
+if test "${HOME+set}"
+then
+	test_set_prereq HOMEVAR
+fi
+
 cat >expect <<EOF
 $HOME/
 /dev/null
 foo~
 EOF
 
-test_expect_success 'get --path' '
+test_expect_success HOMEVAR 'get --path' '
 	git config --get --path path.home > result &&
 	git config --get --path path.normal >> result &&
 	git config --get --path path.trailingtilde >> result &&
 	test_cmp expect result
 '
 
+cat >expect <<\EOF
+/dev/null
+foo~
+EOF
+
+test_expect_success 'get --path copes with unset $HOME' '
+	(
+		unset HOME;
+		test_must_fail git config --get --path path.home \
+			>result 2>msg &&
+		git config --get --path path.normal >>result &&
+		git config --get --path path.trailingtilde >>result
+	) &&
+	grep "[Ff]ailed to expand.*~/" msg &&
+	test_cmp expect result
+'
+
 rm .git/config
 
 git config quote.leading " test"
-- 
1.7.1
