From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix some sparse warnings
Date: Sun, 21 Jul 2013 10:39:37 -0700
Message-ID: <20130721173936.GA10647@elie.Belkin>
References: <51E84F4E.3050600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 21 19:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0xbp-0000Sp-I7
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 19:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab3GURjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 13:39:45 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:64559 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755646Ab3GURjp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 13:39:45 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so6203842pbc.35
        for <git@vger.kernel.org>; Sun, 21 Jul 2013 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qtaIUbb8dFcd/enlJCTeic9qFecUS6XnYoc5x67Tp1o=;
        b=bUyvYd0WgLgh80jgjJOmkxnmD8332LoIOkzEBri0vFpzPT3dXgLBSWIOLACIib50vO
         gDU8EnoQXTaqK584IXomUg2NodyHeJu5EAQQkTt4rwXCO+DwvOEKflNP6AmBE1qMgHSD
         Lzu0wVmDlFu2l0hN9yuwmbpMjXhf204KCSoWDct50zagjE7Ia28mhqCTd0gYS6037EfE
         9DJp+lxpubRdCk8PmRoAz5Z5SJBJbPUep5uD20i/4zI1QUwEr9Z0jiO6iA67YkwJD7qz
         Y2iImbYrm9agrSxC+Y+VpSTJIV0+XsF2PDLEDrGl96Fvfa942pPzNHPGDKbYTN8z96o2
         VrFA==
X-Received: by 10.68.76.34 with SMTP id h2mr26978265pbw.20.1374428384619;
        Sun, 21 Jul 2013 10:39:44 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id w8sm28766273pab.12.2013.07.21.10.39.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Jul 2013 10:39:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51E84F4E.3050600@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230938>

Hi,

Ramsay Jones wrote:

> Sparse issues some "Using plain integer as NULL pointer" warnings.
> Each warning relates to the use of an '{0}' initialiser expression
> in the declaration of an 'struct object_info'. The first field of
> this structure has pointer type. Thus, in order to suppress these
> warnings, we replace the initialiser expression with '{NULL}'.

I agree that this is worth solving but the fix feels like a move in
the wrong direction.  Before this patch, the initialization says
"= {0}", which basically means "memset it to 0".  Afterward, the
initializer depends on the order of fields in the struct.

How about something like the following?

diff --git i/cache.h w/cache.h
index f2915509..ba028b75 100644
--- i/cache.h
+++ w/cache.h
@@ -1124,6 +1124,7 @@ struct object_info {
 		} packed;
 	} u;
 };
+#define OBJECT_INFO_INIT { NULL, NULL, OI_CACHED, { { NULL, 0, 0 } } }
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *);
 
 /* Dumb servers support */
diff --git i/sha1_file.c w/sha1_file.c
index 6baed676..2d812b8d 100644
--- i/sha1_file.c
+++ w/sha1_file.c
@@ -2421,7 +2421,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 
 int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 {
-	struct object_info oi = {0};
+	struct object_info oi = OBJECT_INFO_INIT;
 
 	oi.sizep = sizep;
 	return sha1_object_info_extended(sha1, &oi);
diff --git i/streaming.c w/streaming.c
index cac282f0..b4c40ad9 100644
--- i/streaming.c
+++ w/streaming.c
@@ -135,7 +135,7 @@ struct git_istream *open_istream(const unsigned char *sha1,
 				 struct stream_filter *filter)
 {
 	struct git_istream *st;
-	struct object_info oi = {0};
+	struct object_info oi = OBJECT_INFO_INIT;
 	const unsigned char *real = lookup_replace_object(sha1);
 	enum input_source src = istream_source(real, type, &oi);
 
