From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] git svn: do not overescape URLs (fallback case)
Date: Sun, 14 Oct 2012 04:45:21 -0700
Message-ID: <20121014114521.GA21106@elie.Belkin>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-3-git-send-email-schwern@pobox.com>
 <20120728135018.GB9715@burratino>
 <50143700.80900@pobox.com>
 <20121014114234.GA18127@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Oct 14 13:45:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNMdc-000365-1w
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 13:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602Ab2JNLpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 07:45:33 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:64329 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab2JNLpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 07:45:33 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2101390dak.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 04:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Mq/Ib7wiuhjws05qWLBJbbkKw7qhCh5LyZrYpqSbCUQ=;
        b=SV/uLHhhoj0t5kQS7pZ48nk7rSVZVUENzw13bXXhuFhIckmKyzGselwiulF6IeXuvM
         k5mrYXnWVcsDZ/K7i1XQkYAnviLgj3VrUWQj6OCiBMDWPa/8ueMPA0+Y2H12DsAViKs0
         N0IRc/SDEqfDca+RBvVck5rRpr5GDkdj5QgK1Zfy6z2DHZkaKdeioz/k9OmnYPxhAZiY
         c4C/fXOneRzaNTOTH1fM3OSUjI+aD1rjpq8sNCvrfWd1YLBFb+00Zne2a3HtFa0YpQgn
         OIDDAkj/Awp9ORFNP5aUFqgmfMoAeJOCSwxfHiZUE43+7FX/3MaK6Lw63zR77dTJT6Zy
         3Msw==
Received: by 10.66.82.101 with SMTP id h5mr25175344pay.15.1350215132510;
        Sun, 14 Oct 2012 04:45:32 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id qd9sm7385920pbb.31.2012.10.14.04.45.31
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 04:45:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121014114234.GA18127@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207654>

Subversion's canonical URLs are intended to make URL comparison easy
and therefore have strict rules about what characters are special
enough to urlencode and what characters should be left alone.

When in the fallback codepath because unable to use libsvn's own
canonicalization function for some reason, escape special characters
in URIs according to the svn_uri__char_validity[] table in
subversion/libsvn_subr/path.c (r935829).  The libsvn versions that
trigger this code path are not likely to be strict enough to care, but
it's nicer to be consistent.

Noticed by using SVN 1.6.17 perl bindings, which do not provide
SVN::_Core::svn_uri_canonicalize (triggering the fallback code),
with libsvn 1.7.5, whose do_switch is fussy enough to care:

  Committing to file:///home/jrn/src/git/t/trash%20directory.\
  t9118-git-svn-funky-branch-names/svnrepo/pr%20ject/branches\
  /more%20fun%20plugin%21 ...
  svn: E235000: In file '[...]/subversion/libsvn_subr/dirent_uri.c' \
  line 2291: assertion failed (svn_uri_is_canonical(url, pool))
  error: git-svn died of signal 6
  not ok - 3 test dcommit to funky branch

After this change, the '!' in 'more%20fun%20plugin!' is not urlencoded
and t9118 passes again.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 perl/Git/SVN/Utils.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
index 8b8cf375..3d1a0933 100644
--- a/perl/Git/SVN/Utils.pm
+++ b/perl/Git/SVN/Utils.pm
@@ -155,7 +155,7 @@ sub _canonicalize_url_path {
 
 	my @parts;
 	foreach my $part (split m{/+}, $uri_path) {
-		$part =~ s/([^~\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
+		$part =~ s/([^!\$%&'()*+,.\/\w:=\@_`~-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
 		push @parts, $part;
 	}
 
-- 
1.8.0.rc2
