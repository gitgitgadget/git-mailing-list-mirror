From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: [PATCH] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Mon, 8 Sep 2008 13:35:48 +0530
Message-ID: <20080908080548.GA3206@toroid.org>
References: <48BBB59F.9080204@statsbiblioteket.dk> <vpqvdxggpw6.fsf@bauges.imag.fr> <20080901100435.GC6555@toroid.org> <48BBC20E.20808@statsbiblioteket.dk> <20080901104222.GA10026@toroid.org> <48BBCBEA.8000301@statsbiblioteket.dk> <7vskscplsz.fsf@gitster.siamese.dyndns.org> <20080907092624.GA8470@toroid.org> <48C40670.6090106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Petr Baudis <pasky@suse.cz>
To: Marcus Griep <neoeinstein@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 10:07:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcbm6-0006Ya-7z
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 10:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbYIHIFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 04:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbYIHIFx
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 04:05:53 -0400
Received: from fugue.toroid.org ([85.10.196.113]:46389 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbYIHIFw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 04:05:52 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 811C0558577;
	Mon,  8 Sep 2008 10:05:49 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 3E5B0388402; Mon,  8 Sep 2008 13:35:48 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <48C40670.6090106@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95227>

At 2008-09-07 12:50:56 -0400, neoeinstein@gmail.com wrote:
>
> As I was the one who brought File::Temp->new over from git-svn, I can
> take a look at reducing the dependency to ->tempfile.  If you don't
> patch in first, I'll get one in as well.

Please do.

Here's my latest patch, in case you find it useful as a starting point.
I do not have more time or inclination to work on this at the moment.
The problem with this patch is that the caller (git-svn in this case)
assumes that a File::Temp object will be returned, and depends on the
OO interface (e.g. by calling $tmp_fh->filename).

Unfortunately, I do not think the problem is limited to filename(). I
blessed $$temp_fd into a stub package that provided a fake filename()
method, but t9100-git-svn-basic.sh failed a little further on, and I
did not investigate further. Anyway, I don't think emulating the
File::Temp OO interface is a good solution at all.

(Tom: I'm sorry I ran out of energy before I could put together a
complete fix for you.)

-- ams

From: Abhijit Menon-Sen <ams@toroid.org>
Date: Mon, 8 Sep 2008 12:26:59 +0530
Subject: [PATCH] Git.pm: Use File::Temp->tempfile instead of ->new

Perl 5.8.0 ships with File::Temp 0.13, which does not have the new()
interface introduced in 0.14, as pointed out by Tom G. Christensen.

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---
 perl/Git.pm |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 102e6a4..b0498ca 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -991,7 +991,7 @@ the same string.
 sub temp_release {
 	my ($self, $temp_fd, $trunc) = _maybe_self(@_);
 
-	if (ref($temp_fd) ne 'File::Temp') {
+	if (exists $TEMP_FILES{$temp_fd}) {
 		$temp_fd = $TEMP_FILES{$temp_fd};
 	}
 	unless ($TEMP_LOCKS{$temp_fd}) {
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
1.6.0.1.196.g01914
