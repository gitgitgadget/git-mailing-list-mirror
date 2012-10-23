From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/2] git svn: canonicalize_url(): use
 svn_path_canonicalize when available
Date: Tue, 23 Oct 2012 22:58:12 +0000
Message-ID: <20121023225812.GA21716@dcvr.yhbt.net>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-3-git-send-email-schwern@pobox.com>
 <20120728135018.GB9715@burratino>
 <50143700.80900@pobox.com>
 <20121014114234.GA18127@elie.Belkin>
 <20121014114857.GB21106@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:58:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQnQX-0006jZ-87
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 00:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933725Ab2JWW6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 18:58:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53180 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933464Ab2JWW6M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 18:58:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592821F42D;
	Tue, 23 Oct 2012 22:58:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20121014114857.GB21106@elie.Belkin>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208271>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Until Subversion 1.7 (more precisely r873487), the standard way to
> canonicalize a URI was to call svn_path_canonicalize().  Use it.
> 
> This saves "git svn" from having to rely on our imperfect
> reimplementation of the same.  If the function doesn't exist or
> returns undef, though, it can use the fallback code, which we keep to
> be conservative.  Since svn_path_canonicalize() was added before
> Subversion 1.1, hopefully that doesn't happen often.

Hi Jonathan, this fails for me using http (but not file:// or svn://).
1/2 of this RFC looks fine, though.

subversion 1.6.12dfsg-6, apache2-mpm-prefork 2.2.16-6+squeeze8
(Debian squeeze)

$ SVN_HTTPD_PORT=12345 sh t9118-git-svn-funky-branch-names.sh -v
Initialized empty Git repository in /home/ew/git-core/t/trash directory.t9118-git-svn-funky-branch-names/.git/
expecting success: 
	mkdir project project/trunk project/branches project/tags &&
	echo foo > project/trunk/foo &&
	svn_cmd import -m "$test_description" project "$svnrepo/pr ject" &&
	rm -rf project &&
	svn_cmd cp -m "fun" "$svnrepo/pr ject/trunk" \
	                "$svnrepo/pr ject/branches/fun plugin" &&
	svn_cmd cp -m "more fun!" "$svnrepo/pr ject/branches/fun plugin" \
	                      "$svnrepo/pr ject/branches/more fun plugin!" &&
	svn_cmd cp -m "scary" "$svnrepo/pr ject/branches/fun plugin" \
	              "$svnrepo/pr ject/branches/$scary_uri" &&
	svn_cmd cp -m "leading dot" "$svnrepo/pr ject/trunk" \
			"$svnrepo/pr ject/branches/.leading_dot" &&
	svn_cmd cp -m "trailing dot" "$svnrepo/pr ject/trunk" \
			"$svnrepo/pr ject/branches/trailing_dot." &&
	svn_cmd cp -m "trailing .lock" "$svnrepo/pr ject/trunk" \
			"$svnrepo/pr ject/branches/trailing_dotlock.lock" &&
	svn_cmd cp -m "reflog" "$svnrepo/pr ject/trunk" \
			"$svnrepo/pr ject/branches/not-a@{0}reflog@" &&
	start_httpd
	
Adding         project/trunk
Adding         project/trunk/foo
Adding         project/branches
Adding         project/tags

Committed revision 1.

Committed revision 2.

Committed revision 3.

Committed revision 4.

Committed revision 5.

Committed revision 6.

Committed revision 7.

Committed revision 8.
ok 1 - setup svnrepo

expecting success: 
	git svn clone -s "$svnrepo/pr ject" project &&
	(
		cd project &&
		git rev-parse "refs/remotes/fun%20plugin" &&
		git rev-parse "refs/remotes/more%20fun%20plugin!" &&
		git rev-parse "refs/remotes/$scary_ref" &&
		git rev-parse "refs/remotes/%2Eleading_dot" &&
		git rev-parse "refs/remotes/trailing_dot%2E" &&
		git rev-parse "refs/remotes/trailing_dotlock%2Elock" &&
		git rev-parse "refs/remotes/$non_reflog"
	)
	
Initialized empty Git repository in /home/ew/git-core/t/trash directory.t9118-git-svn-funky-branch-names/project/.git/
Bad URL passed to RA layer: URL 'http://127.0.0.1:12345/pr ject' is malformed or the scheme or host or path is missing at /home/ew/git-core/perl/blib/lib/Git/SVN.pm line 310

not ok - 2 test clone with funky branch names
#	
#		git svn clone -s "$svnrepo/pr ject" project &&
#		(
#			cd project &&
#			git rev-parse "refs/remotes/fun%20plugin" &&
#			git rev-parse "refs/remotes/more%20fun%20plugin!" &&
#			git rev-parse "refs/remotes/$scary_ref" &&
#			git rev-parse "refs/remotes/%2Eleading_dot" &&
#			git rev-parse "refs/remotes/trailing_dot%2E" &&
#			git rev-parse "refs/remotes/trailing_dotlock%2Elock" &&
#			git rev-parse "refs/remotes/$non_reflog"
#		)
#		

expecting success: 
	(
		cd project &&
		git reset --hard 'refs/remotes/more%20fun%20plugin!' &&
		echo hello >> foo &&
		git commit -m 'hello' -- foo &&
		git svn dcommit
	)
	
fatal: ambiguous argument 'refs/remotes/more%20fun%20plugin!': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
not ok - 3 test dcommit to funky branch
#	
#		(
#			cd project &&
#			git reset --hard 'refs/remotes/more%20fun%20plugin!' &&
#			echo hello >> foo &&
#			git commit -m 'hello' -- foo &&
#			git svn dcommit
#		)
#		

expecting success: 
	(
		cd project &&
		git reset --hard "refs/remotes/$scary_ref" &&
		echo urls are scary >> foo &&
		git commit -m "eep" -- foo &&
		git svn dcommit
	)
	
fatal: ambiguous argument 'refs/remotes/Abo-Uebernahme%20(Bug%20#994)': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
not ok - 4 test dcommit to scary branch
#	
#		(
#			cd project &&
#			git reset --hard "refs/remotes/$scary_ref" &&
#			echo urls are scary >> foo &&
#			git commit -m "eep" -- foo &&
#			git svn dcommit
#		)
#		

expecting success: 
	(
		cd project &&
		git reset --hard "refs/remotes/trailing_dotlock%2Elock" &&
		echo who names branches like this anyway? >> foo &&
		git commit -m "bar" -- foo &&
		git svn dcommit
	)
	
fatal: ambiguous argument 'refs/remotes/trailing_dotlock%2Elock': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
not ok - 5 test dcommit to trailing_dotlock branch
#	
#		(
#			cd project &&
#			git reset --hard "refs/remotes/trailing_dotlock%2Elock" &&
#			echo who names branches like this anyway? >> foo &&
#			git commit -m "bar" -- foo &&
#			git svn dcommit
#		)
#		

# failed 4 among 5 test(s)
1..5
