From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test-lib.sh: use printf instead of echo
Date: Tue, 18 Mar 2014 15:18:44 -0700
Message-ID: <20140318221844.GA828@google.com>
References: <20140314235735.GA6959@ibr.ch>
 <20140315001855.GK15625@google.com>
 <xmqq61nceidp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe Storbeck <uwe@ibr.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 23:19:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ2Lg-0007bR-Ej
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 23:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933070AbaCRWSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 18:18:52 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:54233 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933314AbaCRWSv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 18:18:51 -0400
Received: by mail-pa0-f42.google.com with SMTP id fb1so8027592pad.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0h4r7k8yW6tjwLO+E08fXE3BPSIVODsM1RVngwJgv0Q=;
        b=xlK3dG7kUsi5nLwGR3R5FljgC7GxVAv/py5mgf1l/M3MfJNzDQcwv/sZmb/7cglu64
         LHk0/qFoN70jfFKp5yaJxBnwNRFgwKzZ1SaxsQx6TAeqr45xG5QiTbYkIR2I6htqLbYs
         oWNlBew80zJEfxyRPLtIXk2BDsRFtmauejTlwlXmd7LL5MVyoa86rgoRImaVMZZtGqkJ
         XIkwEhjqk1CLTJFAOmKJ+f3sBEPXtVocx4n18RIHMtWahgmkPyblRoeXGlodJjU5CXYr
         TpZdx8yJUqbBl/VnHXR8wgPQB2uP9gjkO6ZjMnWg2j2GsYBo47Pj8OYn7UAT9DHTPHCH
         7ZXw==
X-Received: by 10.68.194.202 with SMTP id hy10mr35632373pbc.94.1395181130693;
        Tue, 18 Mar 2014 15:18:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vo1sm93520911pab.32.2014.03.18.15.18.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Mar 2014 15:18:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq61nceidp.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244388>

Junio C Hamano wrote:
>> Uwe Storbeck wrote:

>>> +	printf '%s\n' "$@" | sed -e 's/^/#	/'
>
> This is wrong, isn't it?  Why do we want one line per item here?

Yes, Hannes caught the same, too.  Sorry for the sloppiness.

We currently use "echo" all over the place (e.g., 'echo "$path"' in
git-sh-setup), and every time we fix it there is a chance of making
mistakes.  I wonder if it would make sense to add a helper to make the
echo calls easier to replace:

-- >8 --
Subject: git-sh-setup: introduce sane_echo helper

Using 'echo' with arguments that might contain backslashes or "-e" or
"-n" can produce confusing results that vary from platform to platform
(e.g., dash always interprets \ escape sequences and echoes "-e"
verbatim, whereas bash does not interpret \ escapes unless "-e" is
passed as an argument to echo and suppresses the "-e" from its
output).

Instead, we should use printf, which is more predictable:

	printf '%s\n' "$foo"; # Just prints $foo, on all platforms.

Blindly replacing echo with "printf '%s\n'" would not be good enough
because that printf prints each argument on its own line.  Provide a
sane_echo helper that prints its arguments, space-delimited, on a
single line, to make this easier to remember, and tweak 'say'
and 'die_with_status' to illustrate how it is used.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-sh-setup.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git i/git-sh-setup.sh w/git-sh-setup.sh
index 256c89a..f35b5b9 100644
--- i/git-sh-setup.sh
+++ w/git-sh-setup.sh
@@ -43,6 +43,10 @@ git_broken_path_fix () {
 
 # @@BROKEN_PATH_FIX@@
 
+sane_echo () {
+	printf '%s\n' "$*"
+}
+
 die () {
 	die_with_status 1 "$@"
 }
@@ -50,7 +54,7 @@ die () {
 die_with_status () {
 	status=$1
 	shift
-	printf >&2 '%s\n' "$*"
+	sane_echo >&2 "$*"
 	exit "$status"
 }
 
@@ -59,7 +63,7 @@ GIT_QUIET=
 say () {
 	if test -z "$GIT_QUIET"
 	then
-		printf '%s\n' "$*"
+		sane_echo "$*"
 	fi
 }
 
