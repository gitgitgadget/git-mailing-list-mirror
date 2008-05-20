From: Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH] gitweb: Fix chop_str not to cut in middle of utf8 multibyte
 chars.
Date: Tue, 20 May 2008 22:55:41 +0200
Message-ID: <g0vdse$rj6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 23:01:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyYxA-0000Ks-KA
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 23:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758437AbYETVAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 17:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759627AbYETVAJ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 17:00:09 -0400
Received: from main.gmane.org ([80.91.229.2]:37255 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756397AbYETVAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 17:00:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JyYwE-00010s-Qo
	for git@vger.kernel.org; Tue, 20 May 2008 21:00:02 +0000
Received: from 81-233-4-40-no34.tbcn.telia.com ([81.233.4.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 May 2008 21:00:02 +0000
Received: from anders by 81-233-4-40-no34.tbcn.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 May 2008 21:00:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81-233-4-40-no34.tbcn.telia.com
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82503>


Without this fix at least author name in short log may cut in middle of a
multibyte char. When the result comes to esc_html to_utf8 is called again,
which doesn't find valid utf8 and decodes using $fallback_encoding making
it even worse.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
  gitweb/gitweb.perl |    4 ++++
  1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2facf2d..8308e22 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -866,6 +866,10 @@ sub chop_str {
         my $add_len = shift || 10;
         my $where = shift || 'right'; # 'left' | 'center' | 'right'

+       # Make sure perl knows it is utf8 encoded so we don't
+       # cut in the middle of a utf8 multibyte char.
+       $str = to_utf8($str);
+
         # allow only $len chars, but don't cut a word if it would fit in $add_len
         # if it doesn't fit, cut it if it's still longer than the dots we would add
         # remove chopped character entities entirely
