From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH v3] am: invoke perl's strftime in C locale
Date: Tue, 15 Jan 2013 23:05:17 +0400
Message-ID: <20130115190517.GB7963@altlinux.org>
References: <20130114205933.GA25947@altlinux.org> <20130115155953.GB21815@sigill.intra.peff.net> <CALWbr2w+q5=Z8__g+J_s2NtTMgziHrntFqsi8vCJyvfO2qi81A@mail.gmail.com> <20130115165058.GA29301@sigill.intra.peff.net> <20130115174015.GA7471@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Antoine Pelisse <apelisse@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 20:05:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvBpW-0006yN-0K
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 20:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757706Ab3AOTFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 14:05:23 -0500
Received: from vint.altlinux.org ([194.107.17.35]:46514 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757651Ab3AOTFS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 14:05:18 -0500
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 843FC3F80005;
	Tue, 15 Jan 2013 19:05:17 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 75829519000D; Tue, 15 Jan 2013 23:05:17 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <20130115174015.GA7471@altlinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213660>

This fixes "hg" patch format support for locales other than C and en_*.
Before the change, git-am was making "Date:" line from hg changeset
metadata according to the current locale, and this line was rejected
later with "invalid date format" diagnostics because localized date
strings are not supported.

Reported-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

 v3: alternative implementation using setlocale(LC_TIME, "C")

 git-am.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index c682d34..8677d8c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -334,7 +334,8 @@ split_patches () {
 			# Since we cannot guarantee that the commit message is in
 			# git-friendly format, we put no Subject: line and just consume
 			# all of the message as the body
-			perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
+			perl -M'POSIX qw(strftime :locale_h)' -ne '
+				BEGIN { setlocale(LC_TIME, "C"); $subject = 0 }
 				if ($subject) { print ; }
 				elsif (/^\# User /) { s/\# User/From:/ ; print ; }
 				elsif (/^\# Date /) {

-- 
ldv
