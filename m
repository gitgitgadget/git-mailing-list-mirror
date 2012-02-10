From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: A note on modern git plus ancient meld ("wrong number of
 arguments")
Date: Fri, 10 Feb 2012 02:23:49 -0600
Message-ID: <20120210082106.GA7871@burratino>
References: <20120209191742.GA20703@unpythonic.net>
 <CAJDDKr58LV9EDJZP+3S0YfyTOXFgJWD6nm=AiA19MkyBF-wb_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 09:24:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvlmI-0007M3-71
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 09:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140Ab2BJIYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 03:24:12 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34238 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab2BJIYL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 03:24:11 -0500
Received: by ghrr11 with SMTP id r11so1332862ghr.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 00:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yIs2gvBJD0osnsujpAmdSKP7zmooXFnbnYG2NMHxdkQ=;
        b=ItcNo4Wqdu4TKYsQQvi4qs6Appqyipf4ccJBIOBhtb2Kc2gi9V6VyAObrRToRmoyqB
         vTNYdlTI2Ld8mFwLBK+THyW+sEPQFQCxnHPjizNDTk+TzuG8ozYCvuSSmIgeIXlI4Sya
         vKOZwsFzhU7sPSDaQTzI53IPgDvwTV/8l0eZo=
Received: by 10.101.5.17 with SMTP id h17mr2272450ani.15.1328862250373;
        Fri, 10 Feb 2012 00:24:10 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wn7sm1762327igc.0.2012.02.10.00.24.09
        (version=SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 00:24:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJDDKr58LV9EDJZP+3S0YfyTOXFgJWD6nm=AiA19MkyBF-wb_g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190386>

David Aguilar wrote:
> On Thu, Feb 9, 2012 at 11:17 AM, Jeff Epler <jepler@unpythonic.net> wrote:

>> At $DAYJOB, I recently encountered a problem after upgrading from (don't
>> laugh) git 1.7.1 to 1.7.8.3: one developer stated that meld failed to
>> run, instead displaying the error 'Wrong number of arguments (Got 5)'.
>>
>> We determined that this user was running a very old version of meld
>> (1.1.1) from his home directory, as opposed to the also very old system
>> version of meld (1.1.5).
[...]
> We originally used the --output test so that we wouldn't have to check
> for a specific version.

My bad.  How about something like this patch (untested)?

-- >8 --
Subject: mergetools/meld: Use version number to detect '--output' support

In v1.7.7-rc0~3^2 (2011-08-19), git mergetool's "meld" support learned
to use the --output option when calling versions of meld (1.5.0 and
later) that support it.

Alas, it misdetects old versions (before 1.1.5, 2006-06-11) of meld as
supporting the option, so on systems with such meld, instead of
getting a nice merge helper, the operator gets a dialog box with the
text "Wrong number of arguments (Got 5)".  (Version 1.1.5 is when meld
switched to using optparse.  One consequence of that change was that
errors in usage are detected and signalled through the exit status
even when --help was passed.)

Just parse version numbers instead.  We can detect the version number
by running "meld --version" and postprocessing it.  As a
futureproofing measure, we are careful to handle all three --version
output formats encountered so far.  When confused, the mergetool falls
back to assuming the --output option is not usable.

 - [0.1, 0.8.5): "GNOME Meld 0.1".
 - [0.8.5, 0.9.4.1):
   "Meld 0.8.5
    Written by Stephen Kennedy <steve9000@users.sf.net>"
 - [0.9.4.1, 1.1.3): "GNOME Meld 0.9.4.1" again.
 - [1.1.3, 1.1.5): back to the two-line form.
 - [1.1.5, present): "$0 1.1.5".  ($0 is typically "meld".)

Reported-by: Jeff Epler <jepler@unpythonic.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 mergetools/meld |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/mergetools/meld b/mergetools/meld
index eaa115cc..3de29629 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -23,10 +23,15 @@ check_meld_for_output_version () {
 	meld_path="$(git config mergetool.meld.path)"
 	meld_path="${meld_path:-meld}"
 
-	if "$meld_path" --output /dev/null --help >/dev/null 2>&1
-	then
-		meld_has_output_option=true
-	else
-		meld_has_output_option=false
-	fi
+	# "GNOME Meld 0.8.4" -> "0.8.4"
+	meld_version=$("$meld_path" --version 2>/dev/null)
+	meld_version=${meld_version#GNOME }
+	meld_version=${meld_version#* }
+
+	case $meld_version in
+	[2-9].* | [1-9][0-9]* | 1.[5-9]* | 1.[1-9][0-9]*)	# >= 1.5.0
+		meld_has_output_option=true ;;
+	*)
+		meld_has_output_option=false ;;
+	esac
 }
-- 
1.7.9
