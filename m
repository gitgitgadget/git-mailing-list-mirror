From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Thu, 2 Feb 2012 15:11:46 -0600
Message-ID: <20120202211146.GC19520@burratino>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120202201629.GA20200@burratino>
 <vpq62fp3r15.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 02 22:12:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt3x0-0002JR-BD
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 22:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757368Ab2BBVMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 16:12:09 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38742 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab2BBVMH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 16:12:07 -0500
Received: by ghrr11 with SMTP id r11so1406811ghr.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 13:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vAzCA/AtrO16eDJELPDuZxkz0mVXx0/GopNMSS03W/s=;
        b=mocb9j4Lp8QMjqtGyul2VYCArYk78xbm1ekgnDXmnGByvapRdSV3P0ESUxQlTLYx/T
         cgVFWmL07qh47Aex/qSUEfLPKMtET7ylNqHtKf9ePdN73zCyoPK/XAiAjOT6gMx6wTO6
         udGNRMQAHxaDWak5zwTlYhN1ezfPyYAzT+IhA=
Received: by 10.50.189.194 with SMTP id gk2mr14171444igc.0.1328217126180;
        Thu, 02 Feb 2012 13:12:06 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f8sm6933755ibl.6.2012.02.02.13.12.04
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 13:12:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <vpq62fp3r15.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189709>

Matthieu Moy wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> 	(
>> 		IFS==
>> 		while read key value
>> 		do
>> 			...
>> 		done
>> 	)
[...]
> I don't think so since the "..." contains
>
>     eval "$key=$value"

Oh, whoops.  Thanks for noticing.

Here's an updated patch, for amusement value.  No functional change
intended.  I don't think it's actually worth applying unless people
actively working on this file find the result easier to work with.

-- >8 --
Subject: t0300 (credentials): shell scripting style cleanups

As Ben noticed, the helper used by this test script assigns a
temporary value to IFS while calling the "read" builtin, which in
ancient shells causes the value to leak into the environment and
affect later code in the same script.  Explicitly save and restore IFS
to avoid rekindling old memories.

While at it, put the "do" associated to a "while" statement on its own
line to match the house style and define helper scripts in the test
data section above all test assertions so the "setup" test itself is
less cluttered and we can worry a little less about quoting issues.

Inspired-by: Ben Walton <bwalton@artsci.utoronto.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t0300-credentials.sh |   36 ++++++++++++++++++++----------------
 1 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index edf65478..780d5dcb 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -4,33 +4,37 @@ test_description='basic credential helper tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
 
-test_expect_success 'setup helper scripts' '
-	cat >dump <<-\EOF &&
+cat >dump <<-\EOF
 	whoami=`echo $0 | sed s/.*git-credential-//`
 	echo >&2 "$whoami: $*"
-	while IFS== read key value; do
+	save_IFS=$IFS
+	IFS==
+	while read key value
+	do
 		echo >&2 "$whoami: $key=$value"
 		eval "$key=$value"
 	done
-	EOF
+	IFS=$save_IFS
+EOF
 
-	cat >git-credential-useless <<-EOF &&
+cat >git-credential-useless <<-EOF
 	#!$SHELL_PATH
 	. ./dump
 	exit 0
-	EOF
+EOF
+
+cat >git-credential-verbatim <<-EOF
+	#!$SHELL_PATH
+	user=\$1; shift
+	pass=\$1; shift
+	. ./dump
+	test -z "\$user" || echo username=\$user
+	test -z "\$pass" || echo password=\$pass
+EOF
+
+test_expect_success setup '
 	chmod +x git-credential-useless &&
-
-	echo "#!$SHELL_PATH" >git-credential-verbatim &&
-	cat >>git-credential-verbatim <<-\EOF &&
-	user=$1; shift
-	pass=$1; shift
-	. ./dump
-	test -z "$user" || echo username=$user
-	test -z "$pass" || echo password=$pass
-	EOF
 	chmod +x git-credential-verbatim &&
-
 	PATH="$PWD:$PATH"
 '
 
-- 
1.7.9
