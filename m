From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/2] git-svn: apply "svn.pathnameencoding" before URL
 encoding
Date: Mon, 15 Feb 2016 00:33:31 +0000
Message-ID: <20160215003331.GA19436@dcvr.yhbt.net>
References: <56B8B1EA.5020901@f2.dion.ne.jp>
 <56B8B25E.9000001@f2.dion.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, alex.crezoff@gmail.com
To: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
X-From: git-owner@vger.kernel.org Mon Feb 15 01:33:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aV76j-0004ke-A6
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 01:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630AbcBOAdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 19:33:33 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53711 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754814AbcBOAdb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 19:33:31 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85F4420276;
	Mon, 15 Feb 2016 00:33:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <56B8B25E.9000001@f2.dion.ne.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286165>

Kazutoshi Satoda <k_satoda@f2.dion.ne.jp> wrote:
> The conversion from "svn.pathnameencoding" to UTF-8 should be applied
> first, and then URL encoding should be applied on the resulting UTF-8
> path. The reversed order of these transforms (used before this fix)
> makes non-UTF-8 URL which causes error from Subversion such as
> "Filesystem has no item: '...' path not found" when sending a rename (or
> a copy) from non-ASCII path.
> 
> Signed-off-by: Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>

Thanks, running full SVN tests now.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

> --- a/perl/Git/SVN/Editor.pm
> +++ b/perl/Git/SVN/Editor.pm
> @@ -144,11 +144,12 @@ sub repo_path {
>  
>  sub url_path {
>  	my ($self, $path) = @_;
> +	$path = $self->repo_path($path);
>  	if ($self->{url} =~ m#^https?://#) {
>  		# characters are taken from subversion/libsvn_subr/path.c
>  		$path =~ s#([^~a-zA-Z0-9_./!$&'()*+,-])#sprintf("%%%02X",ord($1))#eg;
>  	}
> -	$self->{url} . '/' . $self->repo_path($path);
> +	$self->{url} . '/' . $path;
>  }

This is trickier to test, as it requires an https?:// URL.
It always succeeds with the default file:// URL.

diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 82222fd..9828f05 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -93,6 +93,18 @@ test_expect_success 'svn.pathnameencoding=cp932 new file on dcommit' '
 	git svn dcommit
 '
 
+test_expect_success 'svn.pathnameencoding=cp932 rename on dcommit' '
+	inf=$(printf "\201\207") &&
+	git config svn.pathnameencoding cp932 &&
+	echo inf >"$inf" &&
+	git add "$inf" &&
+	git commit -m "inf" &&
+	git svn dcommit &&
+	git mv "$inf" inf &&
+	git commit -m "inf rename" &&
+	git svn dcommit
+'
+
 stop_httpd
 
 test_done
-- 
EW
