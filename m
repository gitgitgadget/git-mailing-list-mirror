From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 04/11] svn-fe: add usage and unpositional arguments
 versions
Date: Sun, 24 Jul 2011 15:25:51 +0200
Message-ID: <20110724132551.GD2934@elie.dc0b.debconf.org>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
 <1310559673-5026-5-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 15:29:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkykF-0008LT-Fg
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 15:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665Ab1GXN0C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 09:26:02 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:56091 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab1GXN0A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 09:26:00 -0400
Received: by fxd18 with SMTP id 18so7594159fxd.11
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 06:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=enVfk7GIbDdQgAh/dpEVbW1CtN2k7LFKz1xBkIv2yC8=;
        b=I7m8TiOORH6F0cvfNWnNheSuL172PtnmG0ZVLBYilUjSXJTEU2HKQFz1NkE0K193r4
         OtbCCvkAZUA4FsLoxLsKtJKs0igmSe9P7KBI1YoIktz5PorIrijCBL12+Y8RmpG9Ejp0
         oud1wsy8YRIMdEruk7zjr2Bb3HSv4LxodKeB8=
Received: by 10.223.61.211 with SMTP id u19mr5095256fah.146.1311513959360;
        Sun, 24 Jul 2011 06:25:59 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id n18sm2174591fam.7.2011.07.24.06.25.54
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 06:25:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310559673-5026-5-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177746>

Dmitry Ivankov wrote:

> $ svn-fe --git-svn-id-url=url
> does the same thing as
> $ svn-fe url
> i.e., url is used to generate git-svn-id: lines, if url is set.

Reasonable.  Let's see...

> --- a/contrib/svn-fe/Makefile
> +++ b/contrib/svn-fe/Makefile
> @@ -41,7 +41,7 @@ svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
>  		$(ALL_LDFLAGS) $(LIBS)
>  
>  svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
> -	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
> +	$(QUIET_CC)$(CC) -I../../vcs-svn -I../.. -o $*.o -c $(ALL_CFLAGS) $<

I'd prefer to see the -I flags as part of ALL_CFLAGS, though that's
somewhat orthogonal to this patch.

[...]
> --- a/contrib/svn-fe/svn-fe.c
> +++ b/contrib/svn-fe/svn-fe.c
> @@ -3,14 +3,38 @@
[...]
> +static struct option svn_fe_options[] = {
> +	OPT_STRING(0, "git-svn-id-url", &url, "url",
> +		"append git-svn metadata line to commit messages"),

Hmm.  How about this?

	"add git-svn-id line to log messages, imitating git-svn"

[...]
> +	argc = parse_options(argc, argv, NULL, svn_fe_options,
> +						svn_fe_usage, 0);
> +	if (argc == 1) {
> +		if (url)
> +			usage_msg_opt("git-svn-id-url is set twice: as a "
> +					"--parameter and as a [parameter]",
> +					svn_fe_usage, svn_fe_options);
> +		url = argv[0];
> +	} else if (argc)
> +		usage_with_options(svn_fe_usage, svn_fe_options);

IMHO would be more readable with the simplest and exceptional case
first:

	if (argc > 1)
		usage_with_options(...);

This way, a person reading can be comforted with the knowledge that
argc <= 1 from then on.

	if (argc == 1) {
		if (url)
			...
	}

To sum up, the patch looks good, and the only improvements I can think
of are tiny nits. :)

With whatever changes mentioned above seem suitable,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
---
 contrib/svn-fe/Makefile |    4 ++--
 contrib/svn-fe/svn-fe.c |    8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 14b07b5b..62a5c628 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -6,7 +6,7 @@ MV = mv
 
 CFLAGS = -g -O2 -Wall
 LDFLAGS =
-ALL_CFLAGS = $(CFLAGS)
+ALL_CFLAGS = -I../.. -I../../vcs-svn $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 EXTLIBS = -lssl -lcrypto -lpcre -lz -lpthread
 
@@ -39,7 +39,7 @@ svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
 		$(ALL_LDFLAGS) $(LIBS)
 
 svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
-	$(QUIET_CC)$(CC) -I../../vcs-svn -I../.. -o $*.o -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<
 
 svn-fe.html: svn-fe.txt
 	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 7e829b91..a95e72f4 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -16,7 +16,7 @@ static const char *url;
 
 static struct option svn_fe_options[] = {
 	OPT_STRING(0, "git-svn-id-url", &url, "url",
-		"append git-svn metadata line to commit messages"),
+		"add git-svn-id line to log messages, imitating git-svn"),
 	OPT_END()
 };
 
@@ -24,14 +24,16 @@ int main(int argc, const char **argv)
 {
 	argc = parse_options(argc, argv, NULL, svn_fe_options,
 						svn_fe_usage, 0);
+	if (argc > 1)
+		usage_with_options(svn_fe_usage, svn_fe_options);
+
 	if (argc == 1) {
 		if (url)
 			usage_msg_opt("git-svn-id-url is set twice: as a "
 					"--parameter and as a [parameter]",
 					svn_fe_usage, svn_fe_options);
 		url = argv[0];
-	} else if (argc)
-		usage_with_options(svn_fe_usage, svn_fe_options);
+	}
 	if (svndump_init(NULL))
 		return 1;
 	svndump_read(url);
-- 
1.7.6
