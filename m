From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [BUG] format-patch does not wrap From-field after author name
Date: Thu, 14 Apr 2011 19:01:41 +0200
Message-ID: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 19:02:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAPvl-0005aQ-UB
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 19:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758165Ab1DNRCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 13:02:03 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63016 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab1DNRCB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 13:02:01 -0400
Received: by pzk9 with SMTP id 9so561152pzk.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:from:date:message-id
         :subject:to:content-type;
        bh=nRMnlenNHYL8VcN8zV1WelrRreXu3ltSui4w/MXS8OI=;
        b=TLBLBGZuiDCtorASW6uLwag6Q9eXBPNG6kdXxD7l6EeZIYfE1M51aDDqa+BhWYhqb8
         FZTbrP4kYgGqjW5rAoI/v98MqmAI+VatZIl3pn1J93q4ZuqU8wzQuQl8gnV1MnVBjqU9
         UuI8TBa6DIXg22R8uP3z2r51H7o6+boVzLdhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:from:date:message-id:subject:to:content-type;
        b=C0Ttn2cO6tLegz9YtgpSEP87RyN9I2t80VImt5SwDRUZ4wL7lV5YpbJVwo31E3mG9r
         lsSQz4zf0TNYgFs3tir3u9107QCxfEJia4O5eHBcmX/fiwbYTwAN/1A6W1alnyzDBZHj
         fx1HGyiqFaSj/d2VR3elro6Kpw49B5qctvWrQ=
Received: by 10.68.37.72 with SMTP id w8mr600184pbj.263.1302800521089; Thu, 14
 Apr 2011 10:02:01 -0700 (PDT)
Received: by 10.68.56.105 with HTTP; Thu, 14 Apr 2011 10:01:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171524>

With certain combinations of author name and email lengths, git
format-patch does not correctly wrap the From line to be below 78
characters, violating rfc2047.

This happens because pp_user_info in pretty.c use add_rfc2047 (which
wraps) for the name, but strbuf_add (which does not wrap) for the
email part.

Here's a test that illustrate the problem:

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 9c66367..a4b8b59 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -793,4 +793,19 @@ test_expect_success 'format-patch wraps extremely
long headers (rfc2047)' '
 	test_cmp expect subject
 '

+M8="foo_bar_"
+M64=$M8$M8$M8$M8$M8$M8$M8$M8
+cat >expect <<'EOF'
+From: foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar
+ <foobar@foo.bar>
+EOF
+test_expect_success 'format-patch wraps non-quotable headers' '
+	rm -rf patches/ &&
+	echo content >>file &&
+	git add file &&
+	git commit -mfoo --author "$M64 <foobar@foo.bar>" &&
+	git format-patch --stdout -1 >patch &&
+	sed -n "/^From: /p; /^ /p; /^$/q" <patch >from &&
+	test_cmp expect from
+'
 test_done
