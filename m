From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] repo-config: support --get-regexp and fix crash
Date: Tue, 02 May 2006 21:06:31 -0700
Message-ID: <7vlktjhhvc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0605021422150.7051@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 06:06:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb8dL-000847-0V
	for gcvg-git@gmane.org; Wed, 03 May 2006 06:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWECEGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 00:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWECEGf
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 00:06:35 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43986 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965058AbWECEGf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 00:06:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060503040634.BUDF27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 May 2006 00:06:34 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605021422150.7051@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 2 May 2006 14:22:48 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19454>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/repo-config.c b/repo-config.c
> index fa8aba7..722153c 100644
> --- a/repo-config.c
> +++ b/repo-config.c
> @@ -6,7 +6,10 @@ static const char git_config_set_usage[]

New flag missing from usage.

>  
>  static char* key = NULL;
>  static char* value = NULL;
> +static regex_t* key_regexp = NULL;
>  static regex_t* regexp = NULL;
> +static int show_keys = 0;
> +static int use_key_regexp = 0;
>  static int do_all = 0;
>  static int do_not_match = 0;
>  static int seen = 0;
> @@ -26,16 +29,18 @@ static int show_config(const char* key_,
>  	if (value_ == NULL)
>  		value_ = "";
>  
> -	if (!strcmp(key_, key) &&
> +	if ((use_key_regexp || !strcmp(key_, key)) &&
> +			(!use_key_regexp ||
> +			 !regexec(key_regexp, key_, 0, NULL, 0)) &&
>  			(regexp == NULL ||
>  			 (do_not_match ^
>  			  !regexec(regexp, value_, 0, NULL, 0)))) {

That's a convoluted logic.

 (1) Either we are using key-regexp, or otherwise the key has to
     exactly match; and

 (2) Either we are not using key-regexp, or key-regexp must
     match; and

 (3) Either we are not using regexp, or value must match (or
     unmatch) as we are told by do_no_match.

It all makes sense, but I wonder if this is the clearest way to
convey what is happening to people.  Not that I have a cleaner
alternative in mind...

> @@ -63,6 +70,14 @@ static int get_value(const char* key_, c
>  		key[i] = tolower(key_[i]);
>  	key[i] = 0;
>  
> +	if (use_key_regexp) {
> +		key_regexp = (regex_t*)malloc(sizeof(regex_t));
> +		if (regcomp(key_regexp, key, REG_EXTENDED)) {
> +			fprintf(stderr, "Invalid key pattern: %s\n", regex_);
> +			return -1;
> +		}
> +	}
> +

Not worrying about leaking on failure path is just fine, since
this is not a libified part.  Perhaps the free() in get_value()
are all like that -- get_value() is called once immediately
before exiting the program anyway ;-).

To my deliberately bogus request, I am getting (null); fprintf()
should use "key" instead of "regex_", perhaps?

	$ git-repo-config --get-regexp 'core['
        Invalid key pattern: (null)

> @@ -78,7 +93,8 @@ static int get_value(const char* key_, c
>  
>  	git_config(show_config);
>  	if (value) {
> -		printf("%s\n", value);
> +		if (!do_all)
> +			printf("%s\n", value);
>  		free(value);
>  	}
>  	free(key);

I wonder if it would make things cleaner if you do not keep the
global "value" around.  Instead, do all the printing in
show_config(), using a static global bool "seen" to control
do_all vs get-all request as you already do.  Then get_value()
does not even need to worry about freeing the value, does it?

Also I am not sure if "say OK if do_all was requested" at the
end of get_value().  If a do_all request did not find any match,
is it an OK condition?  I do not have strong feeling either way,
though.

A suggested patch on top of your version that is in "pu".

-- >8 --
diff --git a/repo-config.c b/repo-config.c
index 722153c..7e06d1a 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -2,10 +2,9 @@ #include "cache.h"
 #include <regex.h>
 
 static const char git_config_set_usage[] =
-"git-repo-config [ --bool | --int ] [--get | --get-all | --replace-all | --unset | --unset-all] name [value [value_regex]] | --list";
+"git-repo-config [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --unset | --unset-all] name [value [value_regex]] | --list";
 
 static char* key = NULL;
-static char* value = NULL;
 static regex_t* key_regexp = NULL;
 static regex_t* regexp = NULL;
 static int show_keys = 0;
@@ -26,6 +25,9 @@ static int show_all_config(const char *k
 
 static int show_config(const char* key_, const char* value_)
 {
+	char value[256];
+	const char *vptr = value;
+
 	if (value_ == NULL)
 		value_ = "";
 
@@ -35,28 +37,25 @@ static int show_config(const char* key_,
 			(regexp == NULL ||
 			 (do_not_match ^
 			  !regexec(regexp, value_, 0, NULL, 0)))) {
+		int dup_error = 0;
 		if (show_keys)
 			printf("%s ", key_);
-		if (seen > 0) {
-			if (!do_all)
-				fprintf(stderr, "More than one value: %s\n",
-						value);
-			free(value);
-		}
-
-		if (type == T_INT) {
-			value = malloc(256);
+		if (seen && !do_all)
+			dup_error = 1;
+		if (type == T_INT)
 			sprintf(value, "%d", git_config_int(key_, value_));
-		} else if (type == T_BOOL) {
-			value = malloc(256);
+		else if (type == T_BOOL)
 			sprintf(value, "%s", git_config_bool(key_, value_)
 					     ? "true" : "false");
-		} else {
-			value = strdup(value_);
-		}
+		else
+			vptr = value_;
 		seen++;
-		if (do_all)
-			printf("%s\n", value);
+		if (dup_error) {
+			error("More than one value for the key %s: %s",
+			      key_, vptr);
+		}
+		else
+			printf("%s\n", vptr);
 	}
 	return 0;
 }
@@ -73,7 +72,7 @@ static int get_value(const char* key_, c
 	if (use_key_regexp) {
 		key_regexp = (regex_t*)malloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
-			fprintf(stderr, "Invalid key pattern: %s\n", regex_);
+			fprintf(stderr, "Invalid key pattern: %s\n", key_);
 			return -1;
 		}
 	}
@@ -92,11 +91,6 @@ static int get_value(const char* key_, c
 	}
 
 	git_config(show_config);
-	if (value) {
-		if (!do_all)
-			printf("%s\n", value);
-		free(value);
-	}
 	free(key);
 	if (regexp) {
 		regfree(regexp);
@@ -104,9 +98,9 @@ static int get_value(const char* key_, c
 	}
 
 	if (do_all)
-		return 0;
+		return !seen;
 
-	return seen == 1 ? 0 : 1;
+	return (seen == 1) ? 0 : 1;
 }
 
 int main(int argc, const char **argv)
