From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: [PATCH] Git.pm: do not break inheritance
Date: Sat, 18 Oct 2008 20:25:12 +0200
Message-ID: <2980b5cead38d5ae3510e4ed9adc847c80be1075.1224360106.git.christian@jaeger.mine.nu>
Cc: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 22:23:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrIKG-0002Pd-IY
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 22:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbYJRUV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 16:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbYJRUVZ
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 16:21:25 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:49138 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751124AbYJRUVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 16:21:25 -0400
Received: (qmail 25111 invoked by uid 1000); 18 Oct 2008 20:21:21 -0000
MBOX-Line: From 2980b5cead38d5ae3510e4ed9adc847c80be1075 Mon Sep 17 00:00:00 2001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98568>

Make it possible to write subclasses of Git.pm

Signed-off-by: Christian Jaeger <christian@jaeger.mine.nu>
---

 I don't really know what the reason for the _maybe_self behaviour
 was; I'm hoping this fix doesn't break anything, I haven't run any
 tests with it except with my own code; the fix works on the
 assumptions that if an object does indeed have Git.pm in it's
 ancestry, _maybe_self should work just as if the object is a 'Git'
 object without inheritance.

 I'm currently using the following hack to make my scripts be able to
 inherit from a non-patched Git.pm: I inherit instead from a wrapper
 around Git.pm which inherits from and patches the latter at runtime
 using this code:

 if (do {
     my @res= Git::_maybe_self ( (bless {}, __PACKAGE__) );
     not $res[0]
 }) {
     #warn "patching Git.pm";#
     no warnings;
     *Git::_maybe_self= sub {
	 UNIVERSAL::isa($_[0], 'Git') ? @_ : (undef, @_);
     }
 }

 While this currently works, a proper fix would of course be
 preferable (like: when in the future will the above hack break?..).


 perl/Git.pm |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 6aab712..ba94453 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1203,8 +1203,7 @@ either version 2, or (at your option) any later version.
 # the method was called upon an instance and (undef, @args) if
 # it was called directly.
 sub _maybe_self {
-	# This breaks inheritance. Oh well.
-	ref $_[0] eq 'Git' ? @_ : (undef, @_);
+	UNIVERSAL::isa($_[0], 'Git') ? @_ : (undef, @_);
 }
 
 # Check if the command id is something reasonable.
-- 
1.6.0.2
