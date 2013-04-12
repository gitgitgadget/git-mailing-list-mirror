From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] fixup! config: allow inaccessible configuration under $HOME
Date: Fri, 12 Apr 2013 13:34:42 -0700
Message-ID: <20130412203442.GT27070@google.com>
References: <20130412043501.GA12942@sigill.intra.peff.net>
 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
 <20130412112636.GC20178@odin.tremily.us>
 <20130412144855.GA17968@sigill.intra.peff.net>
 <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
 <20130412161600.GA20492@sigill.intra.peff.net>
 <20130412170505.GA2383@sigill.intra.peff.net>
 <20130412191433.GR27070@google.com>
 <20130412193755.GA5329@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 12 22:34:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQkgP-0001Ek-9n
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 22:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab3DLUes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 16:34:48 -0400
Received: from mail-da0-f45.google.com ([209.85.210.45]:62975 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229Ab3DLUes (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 16:34:48 -0400
Received: by mail-da0-f45.google.com with SMTP id v40so1284713dad.32
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=K+BOHRo13Oz6TnMic2W839cZfIRjjAlplaRXC1qMToU=;
        b=viDZHyiVni3B46G/JGNiC0pQmjV/IHi89s7+mc3mkpbBRfOZyyVhefOpRC1DJ6GGns
         HMCiMDYWXA5eKWSPEMg/6Tim/TlCZgcTux4u73RKUcUmeuaoQqA1dNs/50Vkwy9I/CsE
         loiMXXahUkUudT1SLe29Cca7bmxaiPT06xXlJjnOADGuMweImf0Ap2WZp64fY94B520h
         U1CxZcdc2AGOlLYEtNiwM3oO3mOb8aqxYgTbIBw4OZkb+WJ1dzyz4GXW9uVm9BF9tbyx
         de96h6RqLXZaQDfM990oNcsP/TAiTPBD7nIONZFKlMv6YghOfUVhzWjgdnBw+ZXEa7qN
         4zew==
X-Received: by 10.69.11.197 with SMTP id ek5mr4503245pbd.19.1365798887607;
        Fri, 12 Apr 2013 13:34:47 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id pb14sm9793398pbb.27.2013.04.12.13.34.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 13:34:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130412193755.GA5329@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221023>

A cleanup from Jeff King.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 wrapper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Jeff King wrote:

> I kind of wonder if we are doing anything with the check at this point.
> I suppose ENOMEM and EIO are the only interesting things left at this
> point. The resulting code would be much nicer if the patch were just:
>
>   -access_or_die(...);
>   +access(...);
>
> but I guess those conditions are still worth checking for, especially if
> we think an attacker could trigger ENOMEM intentionally. To be honest, I
> am not sure how possible that is, but it is not that hard to do so.

Yeah, I was tempted to go the plain access() route.  The case that
convinced me not to is that I wouldn't want to think about whether
there could have been a blip in $HOME producing EIO when wondering how
some malformed object had been accepted.  The ENOMEM case just seemed
simpler to explain.

I would also be surprised if it is easy to control kernel ENOMEM
carefully enough to exploit (a more likely DoS outcome is crashing
programs or a kernel assertion failure, which are more harmless in
their way).  I've given up on predicting what is too hard or easy
enough for security folks.  I couldn't think of an obviously easier
vulnerability that is already accepted to put my mind at ease.

[...]
> I know you are trying to be flexible with the flag,

I was mostly worried about damage to readability if we end up needing
to go further down this direction.  The opportunity to look at all
call sites was also nice.

[...]
>   static int access_error_is_ok(int err, int flag)
>   {
>           return err == ENOENT || errno == ENOTDIR ||
>                   (flag & ACCESS_EACCES_OK && err == EACCES);
>   }

Nice.  Here's a patch for squashing in.

diff --git a/wrapper.c b/wrapper.c
index e860ad1..29a866b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -408,11 +408,16 @@ void warn_on_inaccessible(const char *path)
 	warning(_("unable to access '%s': %s"), path, strerror(errno));
 }
 
+static int access_error_is_ok(int err, unsigned flag)
+{
+	return errno == ENOENT || errno == ENOTDIR ||
+		((flag & ACCESS_EACCES_OK) && errno == EACCES);
+}
+
 int access_or_warn(const char *path, int mode, unsigned flag)
 {
 	int ret = access(path, mode);
-	if (ret && errno != ENOENT && errno != ENOTDIR &&
-	    (!(flag & ACCESS_EACCES_OK) || errno != EACCES))
+	if (ret && !access_error_is_ok(errno, flag))
 		warn_on_inaccessible(path);
 	return ret;
 }
@@ -420,8 +425,7 @@ int access_or_warn(const char *path, int mode, unsigned flag)
 int access_or_die(const char *path, int mode, unsigned flag)
 {
 	int ret = access(path, mode);
-	if (ret && errno != ENOENT && errno != ENOTDIR &&
-	    (!(flag & ACCESS_EACCES_OK) || errno != EACCES))
+	if (ret && !access_error_is_ok(errno, flag))
 		die_errno(_("unable to access '%s'"), path);
 	return ret;
 }
-- 
1.8.2.1
