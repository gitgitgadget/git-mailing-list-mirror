From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Mon, 1 Sep 2008 16:12:22 +0530
Message-ID: <20080901104222.GA10026@toroid.org>
References: <48BBB59F.9080204@statsbiblioteket.dk> <vpqvdxggpw6.fsf@bauges.imag.fr> <20080901100435.GC6555@toroid.org> <48BBC20E.20808@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Petr Baudis <pasky@suse.cz>
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Mon Sep 01 12:43:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka6sl-0000sL-92
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 12:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbYIAKme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 06:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752529AbYIAKmd
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 06:42:33 -0400
Received: from fugue.toroid.org ([85.10.196.113]:52125 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbYIAKmd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 06:42:33 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 058F25580FE;
	Mon,  1 Sep 2008 12:42:31 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 1E8F2ADC36D; Mon,  1 Sep 2008 16:12:23 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <48BBC20E.20808@statsbiblioteket.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94570>

Perl 5.8.0 ships with File::Temp 0.13, which does not have the new()
interface introduced in 0.14, as pointed out by Tom G. Christensen.

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---

At 2008-09-01 12:21:02 +0200, tgc@statsbiblioteket.dk wrote:
>
> Wouldn't it be possible to accomplish the same as File::Temp->New with
> the old File::Temp?

OK, does this one work for you?

-- ams

 perl/Git.pm |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 102e6a4..f383ff8 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1021,10 +1021,13 @@ sub _temp_cache {
 			carp "Temp file '", $name,
 				"' was closed. Opening replacement.";
 		}
-		$$temp_fd = File::Temp->new(
-			TEMPLATE => 'Git_XXXXXX',
-			DIR => File::Spec->tmpdir
-			) or throw Error::Simple("couldn't open new temp file");
+		eval {
+			($$temp_fd) = File::Temp->tempfile(
+				'Git_XXXXXX',
+				DIR => File::Spec->tmpdir
+			);
+		};
+		throw Error::Simple("couldn't open new temp file") if $@;
 		$$temp_fd->autoflush;
 		binmode $$temp_fd;
 	}
-- 
1.6.0.1.161.g7f314
