From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: false base href sent when integrated via reverse proxy and path_info is active
Date: Sun, 28 Nov 2010 23:05:35 +0100
Message-ID: <201011282305.39975.jnareb@gmail.com>
References: <20101128081048.13668.67286.reportbug@sb74.startrek> <4CF2BBEE.2050808@nachtgeist.net> <20101128211054.GA20203@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Daniel Reichelt <debian@nachtgeist.net>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 23:06:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMpNq-00038a-9V
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 23:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab0K1WF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 17:05:58 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34213 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab0K1WF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 17:05:58 -0500
Received: by bwz15 with SMTP id 15so3363392bwz.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 14:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lQUio9HLWmNSmgF+jTQjAf0FNDcbg7JRDcFYGV24c3o=;
        b=xd8r/iEt2ov7iXFMLluReoevYm3kyzU3fJ6q0kAXTY/xi7yeb336x9F9gIkwivCqAb
         gbDJTz8KystW1zlT7skExL0lBi/vM7VqcHo/7KXSkjJZBKjuYtdXIVBd20+nYm1oA9Rm
         opn+sQk5sYoEPakWJAdayxAcLgYXzv5YGWDkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Y1oNUWjYeqvnVbm6S34mfVkmG8yU993L/9pHl0O0pFsV+g+8PU13eDCUvUdyVF8eC4
         V/EDT6P7X8fLv+Lz3wy3nYD1ajmgCMy/q1GqmGODxaAXXNlbgIwILydew2YT04J/XCCU
         APeh1SLPkBmVcvWhE9U3g6Q+RfXATPI1uW0vQ=
Received: by 10.204.73.75 with SMTP id p11mr4171444bkj.46.1290981956289;
        Sun, 28 Nov 2010 14:05:56 -0800 (PST)
Received: from [192.168.1.13] (abwq157.neoplus.adsl.tpnet.pl [83.8.240.157])
        by mx.google.com with ESMTPS id 11sm1672251bkj.12.2010.11.28.14.05.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 14:05:54 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101128211054.GA20203@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162364>

On Sun, 28 Nov 2010, Jonathan Nieder wrote:
> Daniel Reichelt wrote:
> 
> > However, I just tried that and it failed. $base_url gets ignored in
> > gitweb.conf and even setting $my_url and $my_uri in gitweb.conf seems to
> > have no effect at all.
> 
> Aha.  The bug fixed by v1.7.3-rc0~85^2 (gitweb: allow configurations
> that change with each request, 2010-07-30) strikes again.
> 
> Daniel, could you try again with version 1:1.7.2.3-2.1 (from Debian sid)?
> 
> Jakub, we should probably tweak evaluate_uri to do something special if
> $base_url is already set, or advertise that $base_url needs to be set
> in per_request_config when that feature is enabled.

Jonathan, something like this, perhaps?

-- >8 ---- >8 --
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Preserve $base_url if it was set

If $base_url was defined, then do not redefine it in evaluate_uri().
This matters only in the case when $base_url was set in gitweb config
file, and $per_request_config is false or is coderef; without this
change $base_url would get overwritten on subsequent requests from the
value set in config.

If you need $base_url that can change with request, but the default
value set by gitweb doesn't work for you, and you want most of gitweb
config file to be evaluated only once, you need to use $per_request_config
coderef to set it.

Possible-issue-reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On top of (gitweb: selectable configurations that change with each
request, 2010-11-28).

 gitweb/gitweb.perl |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1d94718..5efee0d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -36,10 +36,9 @@ sub evaluate_uri {
 	our $my_url = $cgi->url();
 	our $my_uri = $cgi->url(-absolute => 1);
 
-	# Base URL for relative URLs in gitweb ($logo, $favicon, ...),
-	# needed and used only for URLs with nonempty PATH_INFO
-	our $base_url = $my_url;
-
+	# $base_url contains base URL for relative URLs in gitweb ($logo, $favicon, ...);
+	# it is needed and it is used only for URLs with nonempty PATH_INFO
+	#
 	# When the script is used as DirectoryIndex, the URL does not contain the name
 	# of the script file itself, and $cgi->url() fails to strip PATH_INFO, so we
 	# have to do it ourselves. We make $path_info global because it's also used
@@ -57,7 +56,11 @@ sub evaluate_uri {
 		if ($my_url =~ s,\Q$path_info\E$,, &&
 		    $my_uri =~ s,\Q$path_info\E$,, &&
 		    defined $ENV{'SCRIPT_NAME'}) {
-			$base_url = $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};
+			# preserve existing $base_url
+			$base_url ||= $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};
+		} else {
+			# in case e.g. $ENV{'SCRIPT_NAME'} is not defined
+			$base_url ||= $my_url;
 		}
 	}
 
-- 
1.7.3
