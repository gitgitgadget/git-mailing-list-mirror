From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] am: ignore leading whitespace before patch
Date: Mon, 8 Aug 2011 04:49:04 +0200
Message-ID: <20110808024904.GF19551@elie.gateway.2wire.net>
References: <1312323646-93427-1-git-send-email-davidbarr@google.com>
 <CALUzUxpn-vCWpTQyB7z9dsu8a+UBL9MPjEycOfTmyws5ndz5kA@mail.gmail.com>
 <CAFfmPPMY5FP8NbZ5Q15pW-NC_qs=i6FY7v6Pi8jkMAhkURFTmQ@mail.gmail.com>
 <7vvcub16e7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Simon Sasburg <simon.sasburg@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 04:50:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqFvL-0000J4-VG
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 04:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab1HHCtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 22:49:13 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38404 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965Ab1HHCtM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 22:49:12 -0400
Received: by gxk21 with SMTP id 21so450770gxk.19
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 19:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/unQPRQ/2GkgPaZAaJRiYlY6RSViSPRTdMHhtY2+eXc=;
        b=OGqtkPDn9Rsq03t3i/zirrmrm8Qmm+Loi7EhWp8LGDr10fTEJYP0769zmOJ6AqdZ3q
         JqnuiZr6y1FgR1NZdGdURZjifJhlg+MMRWGdh7xfW268t5ux4fcvEi0V61eUk+z/dKtH
         jcbAFbsQgYWOKifPYdrUQdNzatkfERxTwjNiI=
Received: by 10.91.146.19 with SMTP id y19mr4039925agn.0.1312771751750;
        Sun, 07 Aug 2011 19:49:11 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-49-224.dsl.chcgil.sbcglobal.net [69.209.49.224])
        by mx.google.com with ESMTPS id c5sm1014191anh.27.2011.08.07.19.49.10
        (version=SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 19:49:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvcub16e7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178935>

From: David Barr <davidbarr@google.com>

Some web-based email clients prepend whitespace to raw message
transcripts to workaround content-sniffing in some browsers.  Adjust
the patch format detection logic to ignore leading whitespace.

So now you can apply patches from GMail with "git am" in three steps:

 1. choose "show original"
 2. tell the browser to "save as" (for example by pressing Ctrl+S)
 3. run "git am" on the saved file

This fixes a regression introduced by v1.6.4-rc0~15^2~2 (git-am
foreign patch support: autodetect some patch formats, 2009-05-27).
GMail support was first introduced to "git am" by v1.5.4-rc0~274^2
(Make mailsplit and mailinfo strip whitespace from the start of the
input, 2007-11-01).

Signed-off-by: David Barr <davidbarr@google.com>
Acked-by: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> It no longer checks "the first few lines" but can read a lot more, so the
> comment that precedes this block is now invalid.
>
> Also we are rather old fashioned and we never say "until [ ... ]" anywhere
> in our shell scripts.

Good ideas, thanks.  While at it, let's initialize l1 to protect
against any stray value it might have inherited from the environment.

Looking forward to the promised test, :)
Jonathan

 git-am.sh |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 463c741d..c8422dbe 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -196,10 +196,15 @@ check_patch_format () {
 		return 0
 	fi
 
-	# otherwise, check the first few lines of the first patch to try
-	# to detect its format
+	# otherwise, check the first few non-blank lines of the first
+	# patch to try to detect its format
 	{
-		read l1
+		# Start from first line containing non-whitespace
+		l1=
+		while test -z "$l1"
+		do
+			read l1
+		done
 		read l2
 		read l3
 		case "$l1" in
-- 
1.7.6
