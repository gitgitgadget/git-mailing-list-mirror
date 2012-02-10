From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] mergetools/meld: Use --help output to detect --output support
Date: Fri, 10 Feb 2012 15:57:55 -0600
Message-ID: <20120210215755.GL19216@burratino>
References: <20120209191742.GA20703@unpythonic.net>
 <CAJDDKr58LV9EDJZP+3S0YfyTOXFgJWD6nm=AiA19MkyBF-wb_g@mail.gmail.com>
 <20120210082106.GA7871@burratino>
 <7vwr7unzs8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 22:58:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvyTt-0004a7-9m
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 22:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760232Ab2BJV6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 16:58:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44348 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab2BJV6G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 16:58:06 -0500
Received: by iacb35 with SMTP id b35so827172iac.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 13:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uDPv/ljDqw1aF13DGVOLKYXkyLnTLF3MaMEAircqY1k=;
        b=mEP+Xrq7UN9NhYPm90Gu7ydztp+7su9DQVO4kgyrsze1ewt8T+9aFM+VdIPcK+7QeY
         m2h5HYDfy7ZPcmCvFHiz/BJ/cRLOjAYXcu6e+I+Bng2T3ttsBw65GoIojcWjnEyz2Zks
         Xe0SuBrW0B1yeSInMSKB7BJXDAkiHKKU5ufy0=
Received: by 10.42.19.65 with SMTP id a1mr11631420icb.48.1328911084987;
        Fri, 10 Feb 2012 13:58:04 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f26sm13912011ibc.9.2012.02.10.13.58.03
        (version=SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 13:58:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vwr7unzs8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190466>

In v1.7.7-rc0~3^2 (2011-08-19), git mergetool's "meld" support learned
to use the --output option when calling versions of meld that are
detected to support it (1.5.0 and newer, hopefully).

Alas, it misdetects old versions (before 1.1.5, 2006-06-11) of meld as
supporting the option, so on systems with such meld, instead of
getting a nice merge helper, the operator gets a dialog box with the
text "Wrong number of arguments (Got 5)".  (Version 1.1.5 is when meld
switched to using optparse.  One consequence of that change was that
errors in usage are detected and signalled through the exit status
even when --help was passed.)

Luckily there is a simpler check that is more reliable: the usage
string printed by "meld --help" reliably reflects whether --output is
supported in a given version.  Use it.

Reported-by: Jeff Epler <jepler@unpythonic.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> When an older meld fails when given --output for real (not with the dry
> run current code tries with --help), can we sanely detect that particular
> failure?

Unfortunately it just pops up a GUI with a modal dialog box like this:
	 ___________________________________
	|                                   |
	| Wrong number of arguments (Got 5) |
	|                                   |
	|                     [Quit] [OK]   |
	|___________________________________|

If I choose "Quit", the exit status is 0.

But how about this?  "meld --help | grep -e --output" seems to detect
support for the option reliably.  With 2>&1 on the upstream of the
pipe, this even seems futureproof. ;-)

 mergetools/meld |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mergetools/meld b/mergetools/meld
index eaa115cc..cb672a55 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -23,7 +23,7 @@ check_meld_for_output_version () {
 	meld_path="$(git config mergetool.meld.path)"
 	meld_path="${meld_path:-meld}"
 
-	if "$meld_path" --output /dev/null --help >/dev/null 2>&1
+	if "$meld_path" --help 2>&1 | grep -e --output >/dev/null
 	then
 		meld_has_output_option=true
 	else
-- 
1.7.9
