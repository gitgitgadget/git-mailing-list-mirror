From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config.c: fix a compiler warning
Date: Wed, 16 Apr 2014 11:29:20 -0400
Message-ID: <20140416152920.GA4691@sigill.intra.peff.net>
References: <20140416141353.GA9676@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 17:29:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaRmD-0002wv-SJ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 17:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161690AbaDPP3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 11:29:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:60879 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161560AbaDPP3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 11:29:25 -0400
Received: (qmail 23943 invoked by uid 102); 16 Apr 2014 15:29:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Apr 2014 10:29:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Apr 2014 11:29:20 -0400
Content-Disposition: inline
In-Reply-To: <20140416141353.GA9676@camelia.ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246337>

On Wed, Apr 16, 2014 at 04:13:53PM +0200, Stepan Kasal wrote:

> Date: Thu, 10 Apr 2014 16:37:15 +0200
> 
> This change fixes a gcc warning when building msysGit.

What warning? I'm assuming -Wuninitialized?

> diff --git a/config.c b/config.c
> index 314d8ee..0b7e4f8 100644
> --- a/config.c
> +++ b/config.c
> @@ -572,7 +572,7 @@ static void die_bad_number(const char *name, const char *value)
>  
>  int git_config_int(const char *name, const char *value)
>  {
> -	int ret;
> +	int ret = 0;
>  	if (!git_parse_int(value, &ret))
>  		die_bad_number(name, value);
>  	return ret;

Hmph. Generally gcc should assume that a variable is initialized after a
pointer to it is passed into a function. Unless it inlines that function
and can see that it isn't. But if we do inline git_parse_int, we see
that it "ret" is always initialized if it returns non-zero.

If it also inlines die_bad_number, it would see that we end in die(),
which is marked NORETURN. But if it does not, it will not realize that
we do not get to "return ret" in that case.

So perhaps a better solution is:

diff --git a/config.c b/config.c
index 6821cef..a30cb5c 100644
--- a/config.c
+++ b/config.c
@@ -557,6 +557,7 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 	return 1;
 }
 
+NORETURN
 static void die_bad_number(const char *name, const char *value)
 {
 	const char *reason = errno == ERANGE ?

Does that also silence the warning?

-Peff
