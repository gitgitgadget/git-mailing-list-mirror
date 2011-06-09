From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] gitweb: do misparse nonnumeric content tag files that
 contain a digit
Date: Thu, 9 Jun 2011 02:08:57 -0500
Message-ID: <20110609070857.GA735@elie>
References: <20110301190229.11297.17767.reportbug@cassiopeia.kleinek>
 <201103030142.17258.jnareb@gmail.com>
 <20110303081904.GM22310@pengutronix.de>
 <201103071900.16126.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, "J.H." <warthog9@kernel.org>,
	git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 09:09:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUZMh-0006dP-1K
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 09:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817Ab1FIHJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 03:09:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50467 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153Ab1FIHJH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 03:09:07 -0400
Received: by iwn34 with SMTP id 34so1073027iwn.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 00:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YoPZuq5958Ycz1KceJQClaSIhpn5zY8l1EfjJqaDYJQ=;
        b=HacuD3aEVCqta98EWUTV37Z+JQfajUArq3I998d+3IDdhwrQs225DmhlQT2oW3xlvf
         pOeb90U6z4MImwePmdW3Lznw436nenefdeGpJmmJE6gy1pDqjUTHLvQUZh34Iro5ane5
         rvePcv46Lwt0DduG3CgCMrKaaYSEFqryggiN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nEe9msy8U2Tymr2LLWNGnlFTPR1J41+z9qOtTTSvcG52afinTJz8oheYUXsb9qi/Fi
         cmzbEDR2QD4w50uGzhlAl62696YOpl5iSPLp16Nxp7gsRTrBabdYosHsr6xdlSQR+2qq
         T+znqIxp+jeopXF+UhXXMFgEiZzVsFTgkdjZc=
Received: by 10.42.157.138 with SMTP id d10mr528388icx.490.1307603346180;
        Thu, 09 Jun 2011 00:09:06 -0700 (PDT)
Received: from elie (adsl-69-209-61-87.dsl.chcgil.sbcglobal.net [69.209.61.87])
        by mx.google.com with ESMTPS id d6sm662405ibj.23.2011.06.09.00.09.04
        (version=SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 00:09:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201103071900.16126.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175496>

v1.7.6-rc0~27^2~4 (gitweb: Change the way "content tags" ('ctags') are
handled, 2011-04-29) tried to make gitweb's tag cloud feature more
intuitive for webmasters by checking whether the ctags/<label> under
a project's .git dir contains a number (representing the strength of
association to <label>) before treating it as one.

So after that change, after putting '$feature{'ctags'}{'default'} =
[1];' in your $GITWEB_CONFIG, you could do

	echo Linux >.git/ctags/linux

and gitweb would treat that as a request to tag the current repository
with the Linux tag, instead of the previous behavior of writing an
error page embedded in the projects list that triggers error messages
from Chromium and Firefox about malformed XML.

Unfortunately the pattern (\d+) used to match numbers is too loose,
and the "XML declaration allowed only at the start of the document"
error can still be experienced if you write "Linux-2.6" in place of
"Linux" in the example above.  Fix it by tightening the pattern to
^\d+$.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Jakub Narebski wrote:
>> On Thu, Mar 03, 2011 at 01:42:15AM +0100, Jakub Narebski wrote:

>>> 1. Hardening parsing of ctags files, so that gitweb does not crash on
>>>    malformed entries, but e.g. just ignores them.
>
> Done.

Sorry for a (long-) delayed response.  Based on testing rc0 today, it
works well; thanks!  Patch to fix a small detail noticed while trying
'-1' follows.

 gitweb/gitweb.perl                     |    2 +-
 t/t9500-gitweb-standalone-no-errors.sh |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ebf2d1c..1b83a8d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2644,7 +2644,7 @@ sub git_get_project_ctags {
 			close $ct;
 
 			(my $ctag = $tagfile) =~ s#.*/##;
-			if ($val =~ /\d+/) {
+			if ($val =~ /^\d+$/) {
 				$ctags->{$ctag} = $val;
 			} else {
 				$ctags->{$ctag} = 1;
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index f5648a6..5329715 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -644,6 +644,14 @@ test_expect_success \
 	'ctags: search projects by non existent tag' \
 	'gitweb_run "by_tag=non-existent"'
 
+test_expect_success \
+	'ctags: malformed tag weights' \
+	'mkdir -p .git/ctags &&
+	 echo "not-a-number" > .git/ctags/nan &&
+	 echo "not-a-number-2" > .git/ctags/nan2 &&
+	 echo "0.1" >.git/ctags/floating-point &&
+	 gitweb_run'
+
 # ----------------------------------------------------------------------
 # categories
 
-- 
1.7.6.rc0
