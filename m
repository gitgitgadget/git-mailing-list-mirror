From: Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH] gitweb: Convert string to internal form before chopping in
	chop_str
Date: Wed, 21 May 2008 13:44:43 +0200
Message-ID: <20080521114443.GA1576@0x63.nu>
References: <g0vdse$rj6$1@ger.gmane.org> <m3lk244o16.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 14:07:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyn6a-0001MJ-Iu
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 14:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761504AbYEUMGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 08:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761625AbYEUMGt
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 08:06:49 -0400
Received: from 0x63.nu ([193.26.17.18]:34107 "EHLO gagarin.0x63.nu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756462AbYEUMGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 08:06:48 -0400
X-Greylist: delayed 1320 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 May 2008 08:06:48 EDT
Received: from andersg by gagarin.0x63.nu with local (Exim 3.36 #1 (Debian))
	id 1JymkN-0004vT-00; Wed, 21 May 2008 13:44:43 +0200
Content-Disposition: inline
In-Reply-To: <m3lk244o16.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82541>

Fix chop_str not to cut in middle of utf8 multibyte chars. Without
this fix at least author name in short log may cut in middle of a
multibyte char. When the result comes to esc_html to_utf8 is called
again, which doesn't find valid utf8 and decodes using
$fallback_encoding making it even worse.

This also have the nice side effect that it actually tries to show the
first 10 _characters_, not the number of characters that happened to fit
into 10 bytes.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---

Description updated as per your suggesion, and hopefully without the
embarrassing whitespace corruption.

gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2facf2d..8308e22 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -866,6 +866,10 @@ sub chop_str {
 	my $add_len = shift || 10;
 	my $where = shift || 'right'; # 'left' | 'center' | 'right'
 
+	# Make sure perl knows it is utf8 encoded so we don't
+	# cut in the middle of a utf8 multibyte char.
+	$str = to_utf8($str);
+
 	# allow only $len chars, but don't cut a word if it would fit in $add_len
 	# if it doesn't fit, cut it if it's still longer than the dots we would add
 	# remove chopped character entities entirely
-- 
1.5.5.1
