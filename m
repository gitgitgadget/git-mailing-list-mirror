From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git svn: make minimize URL more reliable over http(s)
Date: Sat, 25 Jul 2009 13:57:05 -0700
Message-ID: <20090725205705.GA18321@dcvr.yhbt.net>
References: <7vd47r298e.fsf@alter.siamese.dyndns.org> <20090724093847.GA20338@dcvr.yhbt.net> <7vk51ykm42.fsf@alter.siamese.dyndns.org> <20090725103821.GA13534@dcvr.yhbt.net> <1248529164.4593.8.camel@kea> <20090725192230.GA11510@dcvr.yhbt.net> <1248553018.4593.15.camel@kea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mattias Nissler <mattias.nissler@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 22:57:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUoJ1-0001LV-R5
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 22:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbZGYU5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 16:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbZGYU5H
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 16:57:07 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39878 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192AbZGYU5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 16:57:07 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 4A9831F78F;
	Sat, 25 Jul 2009 20:57:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1248553018.4593.15.camel@kea>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124068>

In addition to path-based restrictions, Subversion servers over
http(s) may have access controls implemented via the LimitExcept
directive in Apache.  In some cases, LimitExcept may be
(arguably) misconfigured to not allow REPORT requests while
allowing OPTIONS and PROPFIND.

This caused problems with our existing minimize_url logic that
only issued OPTIONS and PROPFIND requests when connecting and
using SVN::Ra::get_latest_revnum.  We now call SVN::Ra::get_log
if get_latest_revnum succeeds, resulting in a REPORT request
being sent.  This will increase our chances of tripping access
controls before we start attempting to fetch history.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  Also pushed out to git://git.bogomips.org/git-svn

  Mattias Nissler <mattias.nissler@gmx.de> wrote:
  > On Sat, 2009-07-25 at 12:22 -0700, Eric Wong wrote:
  > > Mattias Nissler <mattias.nissler@gmx.de> wrote:
  > > > Maybe we should rather try to detect whether we have read access to the
  > > > repository root and adjust behaviour accordingly? Or at least print a
  > > > warning when cloning restricted multi-branch repos, since this just
  > > > fails silently (doesn't pick up any branches) when you have minimize_url
  > > > enabled.
  > > 
  > > We actually try that in Git::SVN::Ra::minimize_url:
   <snip>
  > > Maybe get_latest_revnum() isn't strong enough of a check for
  > > certain setups and get_log() needs to be used instead?
  > 
  > Well, I simply wasn't aware of this. I've just retried and it turns out
  > latest git.git works perfectly for me in both restricted and
  > non-restricted setups. Great work!

 git-svn.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index fd7232c..d075810 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4831,7 +4831,11 @@ sub minimize_url {
 	my $c = '';
 	do {
 		$url .= "/$c" if length $c;
-		eval { (ref $self)->new($url)->get_latest_revnum };
+		eval {
+			my $ra = (ref $self)->new($url);
+			my $latest = $ra->get_latest_revnum;
+			$ra->get_log("", $latest, 0, 1, 0, 1, sub {});
+		};
 	} while ($@ && ($c = shift @components));
 	$url;
 }
-- 
Eric Wong
