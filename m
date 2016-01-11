From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 0/2] Correctly handle transient files in shared
 repositories
Date: Mon, 11 Jan 2016 19:35:42 +0100 (CET)
Message-ID: <cover.1452537321.git.johannes.schindelin@gmx.de>
References: <cover.1452085713.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 19:36:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIhK4-0003Wh-Bn
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 19:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933097AbcAKSgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 13:36:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:50511 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932451AbcAKSgC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 13:36:02 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lgql4-1ZoG2D49Vm-00oDvL; Mon, 11 Jan 2016 19:35:44
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452085713.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:hB1uMoU/654yRcIb94uJ+ZnpqusrYm+5S8/2jg3C07Re4r7jpnl
 EfqwzPQrPBNsmuV4qKD35PGezVhxLbx2G+rqv6ryJN7Rdz4bCgr2uhwYZTlyCj3VV+bT9+r
 acXONVg3aVrHIJSL2xujttjvO05Zpe3vKgOjV1NpNGAXKorJyz0KRiMzSpTADpjd3qitsaz
 xEQSaBf7PEdGEomoA5aZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:14yJjg/6wrI=:izQh8/vjUeYjZd4BHhAzML
 e3o6bNCKE8LLNkT+Bb8e410xVmrBo+NrSdMD9HHchOTmh+4HbCjIfx4U/Ynhzur0KjE5Xd0jx
 60uN/R8ZKBezEJwYYiJ/HWuuuxUBKdEt/MLMCcy1hFk09gbRxJMffBB+ncXaNdwhssoCEkqPX
 8C8cdmaK+tocOnyhS2aLDThox95QvJK+pCKOlt6JYuQYqcY+2wxm6SAzYsOXz/W/6/t7OYF8e
 xIOXcnBOF8VE8V85NlMb09dCzh84DUh6edSeBuEWWV0dWfblpNe7virHUL10KXOOs2435g9Sa
 nNhSKdGfWOAe2kXPQHhEsusRzFnUzetHJ29X49peXjwCSoTI7dFivJFV55UEJ86dyVPGh2Kos
 ikF1Xd3x1c6gZVaSr5cd4kwPOWH9SHsAm0inCamxT+TXBeK+rgvBtWo0FX/smopZXoSKuGN4I
 u8WVLr7/MZSpJi5kMlfs03cefBmaA2sFx58x6f5FFWriuyHln59EyGUMQXl7T5w1yzu3iGIYQ
 7qMuQhUW7d+yVNx8jj133OY5F1OWXpBOIwpd/8fYOEEza1oz4+ZkNBcH4lHHEkB4PGJWy4KcJ
 8xjVBh6C8AS5X7dZCqKn6mVwWpxt3EdHyxgOEgeElXwejJ4mlw6MMbK3NL0S7YpASR+3ha5V0
 lzikwyj6STluvRmcqPRmB0MFsweu/IGoo4+9CCsYoy/Mm39HUMd3gGCZL3nNOZ/lkG9/lhX4f
 A4SphTIlnsJKOFDJb4sfruleTX/T0PWTvy9fmZo6QxAfgCpYiuZarTE2QpJH6KEGscyRWAdq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283695>

Transient files, e.g. commit messages, are writable only by the owner,
even in shared repositories, to avoid interference between competing
users working on the same files.

These files are typically not deleted after use. As a consequence, we
have to delete such files before writing when they are owned by someone
else than the current user.

The only change relative to v2 is that the second commit message
clarifies why apply, fsck and fast-import are left unchanged.

Reported-by: Yaroslav Halchenko <yoh@onerussian.com>


Johannes Schindelin (2):
  commit: allow editing the commit message even in shared repos
  Handle more file writes correctly in shared repos

 builtin/commit.c      |  2 +-
 builtin/fast-export.c |  2 +-
 builtin/fetch.c       |  2 +-
 git-compat-util.h     |  1 +
 wrapper.c             | 13 +++++++++++++
 5 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.6.3.windows.1.300.g1c25e49
