From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] vcs-svn: suppress a -Wtype-limits warning
Date: Thu, 2 Feb 2012 05:06:01 -0600
Message-ID: <20120202110601.GL3823@burratino>
References: <4F28378F.6080108@ramsay1.demon.co.uk>
 <20120131192053.GC12443@burratino>
 <7vipjpzxav.fsf@alter.siamese.dyndns.org>
 <20120202104128.GG3823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	David Barr <davidbarr@google.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 12:06:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsuUh-0002bT-KD
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 12:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568Ab2BBLGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 06:06:19 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:39634 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755346Ab2BBLGS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 06:06:18 -0500
Received: by obcva7 with SMTP id va7so2629448obc.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 03:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+lxWeHooxQ8W5/iW+Bx1JaWKfSaUopnl5P1A3dQkxAU=;
        b=f3zcMpSebHdWmyV1d9Hr0c2yWteVyJgi/XRZ056P7e+mqwzKCsDyeuInzCB/dzYGyZ
         xfslkmAihkktp1OWGGzyM+R31myw26N6tuoZSlOeweR76MLT9jB5n5FEf1toP+lAgK0d
         k8sgaaY1AJzCdgjui57bjAyaJlXjsRHAeqPEE=
Received: by 10.50.197.169 with SMTP id iv9mr11547491igc.7.1328180778311;
        Thu, 02 Feb 2012 03:06:18 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id r18sm4370839ibh.4.2012.02.02.03.06.17
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 03:06:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120202104128.GG3823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189626>

On 32-bit architectures with 64-bit file offsets, gcc 4.3 and earlier
produce the following warning:

	    CC vcs-svn/sliding_window.o
	vcs-svn/sliding_window.c: In function `check_overflow':
	vcs-svn/sliding_window.c:36: warning: comparison is always false \
	    due to limited range of data type

The warning appears even when gcc is run without any warning flags
(this is gcc bug 12963).  In later versions the same warning can be
reproduced with -Wtype-limits, which is implied by -Wextra.

On 64-bit architectures it really is possible for a size_t not to be
representable as an off_t so the check this is warning about is not
actually redundant.  But even false positives are distracting.  Avoid
the warning by making the "len" argument to check_overflow a
uintmax_t; no functional change intended.

Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  I hope it was entertaining.

Thoughts of all kinds welcome, as usual.

Jonathan

 vcs-svn/sliding_window.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
index fafa4a63..2f4ae60f 100644
--- a/vcs-svn/sliding_window.c
+++ b/vcs-svn/sliding_window.c
@@ -31,15 +31,15 @@ static int read_to_fill_or_whine(struct line_buffer *file,
 	return 0;
 }
 
-static int check_overflow(off_t offset, size_t len)
+static int check_overflow(off_t offset, uintmax_t len)
 {
 	if (len > maximum_signed_value_of_type(off_t))
 		return error("unrepresentable length in delta: "
-				"%"PRIuMAX" > OFF_MAX", (uintmax_t) len);
+				"%"PRIuMAX" > OFF_MAX", len);
 	if (signed_add_overflows(offset, (off_t) len))
 		return error("unrepresentable offset in delta: "
 				"%"PRIuMAX" + %"PRIuMAX" > OFF_MAX",
-				(uintmax_t) offset, (uintmax_t) len);
+				(uintmax_t) offset, len);
 	return 0;
 }
 
-- 
1.7.9
