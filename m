From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: git describe fails without tags
Date: Thu, 26 Jan 2006 09:41:52 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060126084151.GB2941@informatik.uni-freiburg.de>
References: <20060125074725.GA2768@informatik.uni-freiburg.de> <7vek2wws61.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 09:42:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F22ha-0000CA-RD
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 09:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWAZIly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 03:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWAZIly
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 03:41:54 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:7328 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751033AbWAZIlx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 03:41:53 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1F22hU-0006O7-A9; Thu, 26 Jan 2006 09:41:52 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k0Q8fqeF004645;
	Thu, 26 Jan 2006 09:41:52 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k0Q8fqh3004644;
	Thu, 26 Jan 2006 09:41:52 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vek2wws61.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15152>

Hello Junio,

Junio C Hamano wrote:
> diff --git a/rev-parse.c b/rev-parse.c
> index 0c951af..c1646e4 100644
> --- a/rev-parse.c
> +++ b/rev-parse.c
> @@ -20,6 +20,7 @@ static char *def = NULL;
>  #define REVERSED 1
>  static int show_type = NORMAL;
>  static int symbolic = 0;
> +static int abbrev = 0;
>  static int output_sq = 0;
>  
>  static int revs_count = 0;
> @@ -95,6 +96,8 @@ static void show_rev(int type, const uns
>  		putchar('^');
>  	if (symbolic && name)
>  		show(name);
> +	else if (abbrev)
> +		show(find_unique_abbrev(sha1, abbrev));
>  	else
>  		show(sha1_to_hex(sha1));
>  }
> @@ -195,6 +198,17 @@ int main(int argc, char **argv)
>  				verify = 1;
>  				continue;
>  			}
> +			if (!strcmp(arg, "--abbrev") ||
> +			    !strncmp(arg, "--abbrev=", 9)) {
> +				filter &= ~(DO_FLAGS|DO_NOREV);
> +				verify = 1;
> +				abbrev = DEFAULT_ABBREV;
> +				if (arg[8] == '=')
> +					abbrev = strtoul(arg + 9, NULL, 10);
> +				if (abbrev < 0 || 40 <= abbrev)
> +					abbrev = DEFAULT_ABBREV;
> +				continue;
> +			}
>  			if (!strcmp(arg, "--sq")) {
>  				output_sq = 1;
>  				continue;
I see two things to fix in that patch:

 1) define DEFAULT_ABBREV (e.g. by moving it to cache.h, where
    find_unique_abbrev is defined.)

 2) describe.c allows only abbrev >= 4.  (Allowing values less than 2
    failes, because find_short_object_filename (and maybe others) assume
    len to be at least 2.)  I think 4 is sensible.

This results in the following patch:

--8<--
[PATCH] rev-parse: --abbrev option.

The new option behaves just like --verify, but outputs an abbreviated object
name that is unique within the repository.

This patch is a modification of a suggestion by Junio C Hamano.

Signed-off-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>

---

 cache.h     |    2 ++
 describe.c  |    1 -
 rev-parse.c |   14 ++++++++++++++
 3 files changed, 16 insertions(+), 1 deletions(-)

0d43ec7461b38d6a1d1563fd7dc2ebf399eabe9e
diff --git a/cache.h b/cache.h
index b493b65..139c670 100644
--- a/cache.h
+++ b/cache.h
@@ -177,6 +177,8 @@ extern int check_repository_format(void)
 #define DATA_CHANGED    0x0020
 #define TYPE_CHANGED    0x0040
 
+#define DEFAULT_ABBREV 8 /* maybe too many */
+
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
 extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
diff --git a/describe.c b/describe.c
index 4866510..6518f06 100644
--- a/describe.c
+++ b/describe.c
@@ -11,7 +11,6 @@ static const char describe_usage[] =
 static int all = 0;	/* Default to annotated tags only */
 static int tags = 0;	/* But allow any tags if --tags is specified */
 
-#define DEFAULT_ABBREV 8 /* maybe too many */
 static int abbrev = DEFAULT_ABBREV;
 
 static int names = 0, allocs = 0;
diff --git a/rev-parse.c b/rev-parse.c
index 0c951af..58cff6f 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -20,6 +20,7 @@ static char *def = NULL;
 #define REVERSED 1
 static int show_type = NORMAL;
 static int symbolic = 0;
+static int abbrev = 0;
 static int output_sq = 0;
 
 static int revs_count = 0;
@@ -95,6 +96,8 @@ static void show_rev(int type, const uns
 		putchar('^');
 	if (symbolic && name)
 		show(name);
+	else if (abbrev)
+		show(find_unique_abbrev(sha1, abbrev));
 	else
 		show(sha1_to_hex(sha1));
 }
@@ -195,6 +198,17 @@ int main(int argc, char **argv)
 				verify = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--abbrev") ||
+					!strncmp(arg, "--abbrev=", 9)) {
+				filter &= ~(DO_FLAGS|DO_NOREV);
+				verify = 1;
+				abbrev = DEFAULT_ABBREV;
+				if (arg[8] == '=')
+					abbrev = strtoul(arg + 9, NULL, 10);
+				if (abbrev < 4 || 40 <= abbrev)
+					abbrev = DEFAULT_ABBREV;
+				continue;
+			}
 			if (!strcmp(arg, "--sq")) {
 				output_sq = 1;
 				continue;
-- 
1.1.4.g3e6c

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=72+PS+point+in+inch
