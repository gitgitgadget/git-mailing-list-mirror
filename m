From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 02/11] test-svn-fe: use parse-options
Date: Sun, 24 Jul 2011 15:04:43 +0200
Message-ID: <20110724130443.GB2934@elie.dc0b.debconf.org>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
 <1310559673-5026-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 15:06:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkyNt-00025U-H5
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 15:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab1GXNEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 09:04:51 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:46034 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab1GXNEt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 09:04:49 -0400
Received: by fxd18 with SMTP id 18so7575079fxd.11
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 06:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Qgd5kqooPrkgCeit1gs23VzwpcsZgrrHII3VJh7+/mw=;
        b=Xy3R3w3SKw1hgu3yZTsUULTP1VbQx2uWzOnAuXEgyi/iminj730BBN2kpzHS8a9Vv6
         wt2bXNtNa1aqqrP0nrveYXG9lMofQNq2cDt2T97fR8jV+pT8cuJoUMq7E7JpPCC0s1AE
         40ncgeRBOBL9q4X11UV0x67wTYwEqElQM96G0=
Received: by 10.223.144.136 with SMTP id z8mr2565166fau.31.1311512688521;
        Sun, 24 Jul 2011 06:04:48 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id d6sm3185527fak.34.2011.07.24.06.04.46
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 06:04:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310559673-5026-3-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177744>

Hi,

Sorry for the slow response.

Dmitry Ivankov wrote:

> There was custom options parsing. As more options arise it will
> be easier to add and document new options with parse-options api.

In particular this gives us a "test-svn-fe -h" command --- sounds
good.  Might make sense to combine this with the patch that
parsoptifies contrib/svn-fe/svn-fe.c.

> --- a/test-svn-fe.c
> +++ b/test-svn-fe.c
> @@ -3,28 +3,38 @@
>   */
>  
>  #include "git-compat-util.h"
> +#include "parse-options.h"
>  #include "vcs-svn/svndump.h"
>  #include "vcs-svn/svndiff.h"
>  #include "vcs-svn/sliding_window.h"
>  #include "vcs-svn/line_buffer.h"
>  
> -static const char test_svnfe_usage[] =
> -	"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";
> +static const char * const test_svnfe_usage[] = {
> +	"test-svn-fe (<dumpfile> | -d <preimage> <delta> <len>)",
> +	NULL
> +};

With this API, we're allowed to print multiple usage strings.  Might as
well take advantage of that for clarity:

 static const char * const test_svnfe_usage[] = {
	"test-svn-fe <dumpfile>",
	"test-svn-fe -d <preimage> <delta> <len>",
	NULL
 };

>  
> +static int d;
> +

The variable name is not so memorable.  Maybe something like
"apply_delta" would do.

> -static int apply_delta(int argc, char *argv[])
> +static struct option test_svnfe_options[] = {
> +	OPT_SET_INT('d', NULL, &d, "test apply_delta", 1),
> +	OPT_END()
> +};

Might make sense to take the opportunity to add a mnemonic long
option name while at it:

	OPT_SET_INT('d', "apply-delta", ...

[...]
> @@ -37,10 +47,16 @@ static int apply_delta(int argc, char *argv[])
>  	return 0;
>  }
>  
> -int main(int argc, char *argv[])
> +int main(int argc, const char *argv[])
>  {
> -	if (argc == 2) {
> -		if (svndump_init(argv[1]))
> +	argc = parse_options(argc, argv, NULL, test_svnfe_options,
> +						test_svnfe_usage, 0);
> +
> +	if (d)
> +		return apply_delta(argc, argv);
> +
> +	if (argc == 1) {

Probably easier to read with the simple and exceptional case first.

	if (apply_delta_instead)
		return apply_delta(argc, argv);
	if (argc != 1)
		usage_with_options(...);

	if (svndump_init(argv[0]))
		return 1;
	...

	
> +		if (svndump_init(argv[0]))
>  			return 1;
>  		svndump_read(NULL);
>  		svndump_deinit();
> @@ -48,7 +64,5 @@ int main(int argc, char *argv[])
>  		return 0;
>  	}
>  
> -	if (argc >= 2 && !strcmp(argv[1], "-d"))
> -		return apply_delta(argc, argv);
> -	usage(test_svnfe_usage);
> +	usage_with_options(test_svnfe_usage, test_svnfe_options);

Except for the minor nits noted above (in particular, hopefully this
can be squashed with the corresponding svn-fe patch),

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 test-svn-fe.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/test-svn-fe.c b/test-svn-fe.c
index 0aab2450..db56b6ba 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -3,21 +3,23 @@
  */
 
 #include "git-compat-util.h"
-#include "parse-options.h"
 #include "vcs-svn/svndump.h"
 #include "vcs-svn/svndiff.h"
 #include "vcs-svn/sliding_window.h"
 #include "vcs-svn/line_buffer.h"
+#include "parse-options.h"
 
 static const char * const test_svnfe_usage[] = {
-	"test-svn-fe (<dumpfile> | -d <preimage> <delta> <len>)",
+	"test-svn-fe <dumpfile>",
+	"test-svn-fe -d <preimage> <delta> <len>",
 	NULL
 };
 
-static int d;
+static int apply_delta_instead;
 
 static struct option test_svnfe_options[] = {
-	OPT_SET_INT('d', NULL, &d, "test apply_delta", 1),
+	OPT_SET_INT('d', "apply-delta",
+		&apply_delta_instead, "apply a subversion-format delta", 1),
 	OPT_END()
 };
 
@@ -52,17 +54,16 @@ int main(int argc, const char *argv[])
 	argc = parse_options(argc, argv, NULL, test_svnfe_options,
 						test_svnfe_usage, 0);
 
-	if (d)
+	if (apply_delta_instead)
 		return apply_delta(argc, argv);
 
-	if (argc == 1) {
-		if (svndump_init(argv[0]))
-			return 1;
-		svndump_read(NULL);
-		svndump_deinit();
-		svndump_reset();
-		return 0;
-	}
+	if (argc != 1)
+		usage_with_options(test_svnfe_usage, test_svnfe_options);
 
-	usage_with_options(test_svnfe_usage, test_svnfe_options);
+	if (svndump_init(argv[0]))
+		return 1;
+	svndump_read(NULL);
+	svndump_deinit();
+	svndump_reset();
+	return 0;
 }
-- 
1.7.6
