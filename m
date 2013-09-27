From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: tighten "local paths with colons" check a bit
Date: Fri, 27 Sep 2013 14:56:03 -0400
Message-ID: <20130927185603.GA2917@sigill.intra.peff.net>
References: <1380289693-593-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Morten Stenshorne <mstensho@opera.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 20:56:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPdD3-00017a-FH
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 20:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341Ab3I0S4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 14:56:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:58112 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754140Ab3I0S4I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 14:56:08 -0400
Received: (qmail 30132 invoked by uid 102); 27 Sep 2013 18:56:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Sep 2013 13:56:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Sep 2013 14:56:03 -0400
Content-Disposition: inline
In-Reply-To: <1380289693-593-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235473>

On Fri, Sep 27, 2013 at 08:48:13PM +0700, Nguyen Thai Ngoc Duy wrote:

> ---
>  I wanted to add a test then realized there were no ssh tests in the
>  test suite. So laziness won :p

There is one in t5602, but it's not very reusable. How about squashing
in the patch below, which does a basic ssh-works test, and confirms your
fix?

---
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0629149..a3e3d48 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -280,9 +280,53 @@ test_expect_success NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar' '
 	test_cmp fetch.expected fetch.actual
 '
 
+test_expect_success 'setup ssh wrapper' '
+	write_script "$TRASH_DIRECTORY/ssh-wrapper" <<-\EOF &&
+	echo >>"$TRASH_DIRECTORY/ssh-output" "ssh: $*" &&
+	# throw away all but the last argument, which should be the
+	# command
+	while test $# -gt 1; do shift; done
+	eval "$1"
+	EOF
+
+	GIT_SSH="$TRASH_DIRECTORY/ssh-wrapper" &&
+	export GIT_SSH &&
+	export TRASH_DIRECTORY
+'
+
+clear_ssh () {
+	>"$TRASH_DIRECTORY/ssh-output"
+}
+
+expect_ssh () {
+	{
+		case "$1" in
+		none)
+			;;
+		*)
+			echo "ssh: $1 git-upload-pack '$2'"
+		esac
+	} >"$TRASH_DIRECTORY/ssh-expect" &&
+	(cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
+}
+
+test_expect_success 'cloning myhost:src uses ssh' '
+	clear_ssh &&
+	git clone myhost:src ssh-clone &&
+	expect_ssh myhost src
+'
+
 test_expect_success NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar' '
+	clear_ssh &&
 	cp -R src "foo:bar" &&
-	git clone "./foo:bar" foobar
+	git clone "./foo:bar" foobar &&
+	expect_ssh none
+'
+
+test_expect_success 'bracketed hostnames are still ssh' '
+	clear_ssh &&
+	git clone "[myhost:123]:src" ssh-bracket-clone &&
+	expect_ssh myhost:123 src
 '
 
 test_done
