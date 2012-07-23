From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 3/1] Makefile: BLK_SHA1 does not require fast htonl() and
 unaligned loads
Date: Mon, 23 Jul 2012 01:29:14 -0500
Message-ID: <20120723062914.GA14045@burratino>
References: <20120722233547.GA1978@burratino>
 <7v8vebp0cl.fsf@alter.siamese.dyndns.org>
 <20120723045148.GA13623@burratino>
 <7vobn7njtz.fsf@alter.siamese.dyndns.org>
 <20120723052605.GA13728@burratino>
 <7vboj7nidc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 08:29:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StC93-0007wM-Nh
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 08:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab2GWG3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 02:29:25 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49934 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061Ab2GWG3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 02:29:24 -0400
Received: by obbuo13 with SMTP id uo13so9044636obb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 23:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VSXvLYImcyO4gwuiqD6mZ2JG/XbgdI4/nr9quCt0FhE=;
        b=RTwfYOTjJb7eCLpxpR4bd/CSy64juMl4H0vXppEJWhTofevR8DUAEuxGmmJGU9SIA6
         AikQ5pR6nlP+h7+lnA+UGwQGbF7/1IsAYqj2iwF0BMVY1ozkegICoO7aD5g+oVIRkQcA
         14gqpFB3d/3+KaBq5jmb5lAzbKQH4VF54SnFYIpHayubRuluXemHTrh0JasyWjvkDtTB
         do9guj7+ngZZchcrZDaUIHaCvVEUqK8RwSZcy49w02Rf3j7Mq0Mk2k+KVq8YqIGgqi76
         J7Rlx3RtTYuM+LrBZLQ+Wke59L3MUKO9Fd8xUhR/DYz5JmwbMuOr775pVNgCrr8fwgtX
         sLwQ==
Received: by 10.50.100.129 with SMTP id ey1mr9484949igb.35.1343024963814;
        Sun, 22 Jul 2012 23:29:23 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id fe7sm7502438igc.14.2012.07.22.23.29.22
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 23:29:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vboj7nidc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201909>

block-sha1/ is fast on most known platforms.  Clarify the Makefile to
be less misleading about that.

Early versions of block-sha1/ explicitly relied on fast htonl() and
fast 32-bit loads with arbitrary alignment.  Now it uses those on some
arches but the default behavior is byte-at-a-time access for the sake
of arches like ARM, Alpha, and their kin and it is still pretty fast
on these arches (fast enough to supersede the mozilla SHA1
implementation and the hand-written ARM assembler implementation that
were bundled before).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> *1* In other words, the ntohl(*(uint *)(p)) is used only on selected
> little endian boxes, but that does not mean the generic code was
> big-endian only.  Little endian boxes that are not listed in #if
> block do use the generic byte-at-a-time macro.

Oh, that reminds me.  Here's a third patch.

 Makefile |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 134606b9..eadcc70a 100644
--- a/Makefile
+++ b/Makefile
@@ -84,9 +84,8 @@ all::
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
-# Define BLK_SHA1 environment variable if you want the C version
-# of the SHA1 that assumes you can do unaligned 32-bit loads and
-# have a fast htonl() function.
+# Define BLK_SHA1 environment variable to make use of the bundled
+# optimized C SHA1 routine.
 #
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
-- 
1.7.10.4
