From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] git-svn: keep leading slash when canonicalizing paths
 (fallback case)
Date: Fri, 5 Oct 2012 00:04:31 -0700
Message-ID: <20121005070430.GA23572@elie.Belkin>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-7-git-send-email-schwern@pobox.com>
 <20120728135502.GC9715@burratino>
 <5014387C.50903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 09:04:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK1xs-0004cT-Sy
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab2JEHEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 03:04:43 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37286 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2JEHEm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 03:04:42 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1371084pad.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pW33wIr+h5zHWWmCuJQpqPaIFgOEmkuV0dvSJfZogLg=;
        b=RFa7RAgpMiFcuA1TspCsILzbpy4V4Cd4rTI5CXMfGUuZW1QbbiQBQs1v/9CHlQdGfv
         YK6ZhJXTvkyh8Jlcu93McW44FsYwCpRJZRDsaaszVO7rNt7YOOeQ40hpa2//k0itsjUW
         HgxEOEbpAMxmJflkQlju06uK57kB/2TEuEr78O8RuqRCrGdhs3BvnbLrH1H8y1UEqMdK
         8/p/o6zEcdxVNFaca6J+Y+rv3jFZwA1/jBDQLXPfptfmPGYWIMfrmb287U2no9cVhear
         6OVV/g0wERgfgZbnBvSdwsw2SKJ5DAqn5NnFCqv5B7ouwbfyUZQmav+WjYfZwWs6mXtG
         s8HA==
Received: by 10.66.81.231 with SMTP id d7mr19215234pay.50.1349420681796;
        Fri, 05 Oct 2012 00:04:41 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id e9sm5559439pay.34.2012.10.05.00.04.40
        (version=SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 00:04:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5014387C.50903@pobox.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207079>

Subversion's svn_dirent_canonicalize() and svn_path_canonicalize()
APIs keep a leading slash in the return value if one was present on
the argument, which can be useful since it allows relative and
absolute paths to be distinguished.

When git-svn's canonicalize_path() learned to use these functions if
available, its semantics changed in the corresponding way.  Some new
callers rely on the leading slash --- for example, if the slash is
stripped out then _canonicalize_url_ourselves() will transform
"proto://host/path/to/resource" to "proto://hostpath/to/resource".

Unfortunately the fallback _canonicalize_path_ourselves(), used when
the appropriate SVN APIs are not usable, still follows the old
semantics, so if that code path is exercised then it breaks.  Fix it
to follow the new convention.

Noticed by forcing the fallback on and running tests.  Without this
patch, t9101.4 fails:

 Bad URL passed to RA layer: Unable to open an ra_local session to \
 URL: Local URL 'file://homejrnsrcgit-scratch/t/trash%20directory.\
 t9101-git-svn-props/svnrepo' contains unsupported hostname at \
 /home/jrn/src/git-scratch/perl/blib/lib/Git/SVN.pm line 148

With it, the git-svn tests pass again.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi Eric,

Michael G Schwern wrote:
> On 2012.7.28 6:55 AM, Jonathan Nieder wrote:

>> When would this "else" case trip?
>
> When svn_path_canonicalize() does not exist in the SVN API, presumably because
> their SVN is too old.

I accidentally tested this "else" branch by making the other cases
false.  t9101.4 failed as described above, or in other words,
canonicalize_url_ourselves() stripped out a few too many slashes.  For
reference:

| sub _canonicalize_url_ourselves {
|         my ($url) = @_;
|         if ($url =~ m#^([^:]+)://([^/]*)(.*)$#) {
|                 my ($scheme, $domain, $uri) = ($1, $2, _canonicalize_url_path(canonicalize_path($3)));
|                 $url = "$scheme://$domain$uri";
|         }
|         $url;
| }

When $url is http://host/path/to/resource,

	$1 = "http", $2 = "host", $3 = "/path/to/resource"
	canonicalize_path($3) = "path/to/resource" <--- (??)
	_canonicalize_url_path(ditto) = "path/to/resource"
	$url = "http://hostpath/to/resource"

How about this patch?

 perl/Git/SVN/Utils.pm |    1 -
 1 file changed, 1 deletion(-)

diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
index 4bb4dde8..8b8cf375 100644
--- a/perl/Git/SVN/Utils.pm
+++ b/perl/Git/SVN/Utils.pm
@@ -122,7 +122,6 @@ sub _canonicalize_path_ourselves {
 	$path = _collapse_dotdot($path);
 	$path =~ s#/$##g;
 	$path =~ s#^\./## if $dot_slash_added;
-	$path =~ s#^/##;
 	$path =~ s#^\.$##;
 	return $path;
 }
-- 
1.7.10.4
