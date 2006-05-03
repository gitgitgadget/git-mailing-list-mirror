From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] repo-config: support --get-regexp and fix crash
Date: Wed, 3 May 2006 14:41:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605031438510.6340@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0605021422150.7051@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlktjhhvc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 14:41:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbGfG-0004WR-UH
	for gcvg-git@gmane.org; Wed, 03 May 2006 14:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbWECMlG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 08:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbWECMlG
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 08:41:06 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:61107 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965180AbWECMlE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 08:41:04 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 8480CC8E;
	Wed,  3 May 2006 14:41:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 782A9C83;
	Wed,  3 May 2006 14:41:03 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 5B827BBC;
	Wed,  3 May 2006 14:41:03 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlktjhhvc.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19479>

Hi,

thanks for your patch.

On Tue, 2 May 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > @@ -26,16 +29,18 @@ static int show_config(const char* key_,
> >  	if (value_ == NULL)
> >  		value_ = "";
> >  
> > -	if (!strcmp(key_, key) &&
> > +	if ((use_key_regexp || !strcmp(key_, key)) &&
> > +			(!use_key_regexp ||
> > +			 !regexec(key_regexp, key_, 0, NULL, 0)) &&
> >  			(regexp == NULL ||
> >  			 (do_not_match ^
> >  			  !regexec(regexp, value_, 0, NULL, 0)))) {
> 
> That's a convoluted logic.
> 
>  (1) Either we are using key-regexp, or otherwise the key has to
>      exactly match; and
> 
>  (2) Either we are not using key-regexp, or key-regexp must
>      match; and
> 
>  (3) Either we are not using regexp, or value must match (or
>      unmatch) as we are told by do_no_match.
> 
> It all makes sense, but I wonder if this is the clearest way to
> convey what is happening to people.  Not that I have a cleaner
> alternative in mind...

How about this (on top of your patch):

--- snip ---
[PATCH] repo-config: deconvolute logics

It was rightly noticed that the logic is quite convoluted. Fix that.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	The real change is very short, but a code block got reindented, 
	too.

 repo-config.c |   50 ++++++++++++++++++++++++++------------------------
 1 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/repo-config.c b/repo-config.c
index 7e06d1a..63eda1b 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -27,36 +27,38 @@ static int show_config(const char* key_,
 {
 	char value[256];
 	const char *vptr = value;
+	int dup_error = 0;
 
 	if (value_ == NULL)
 		value_ = "";
 
-	if ((use_key_regexp || !strcmp(key_, key)) &&
-			(!use_key_regexp ||
-			 !regexec(key_regexp, key_, 0, NULL, 0)) &&
-			(regexp == NULL ||
+	if (!use_key_regexp && strcmp(key_, key))
+		return 0;
+	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
+		return 0;
+	if (regexp != NULL &&
 			 (do_not_match ^
-			  !regexec(regexp, value_, 0, NULL, 0)))) {
-		int dup_error = 0;
-		if (show_keys)
-			printf("%s ", key_);
-		if (seen && !do_all)
-			dup_error = 1;
-		if (type == T_INT)
-			sprintf(value, "%d", git_config_int(key_, value_));
-		else if (type == T_BOOL)
-			sprintf(value, "%s", git_config_bool(key_, value_)
-					     ? "true" : "false");
-		else
-			vptr = value_;
-		seen++;
-		if (dup_error) {
-			error("More than one value for the key %s: %s",
-			      key_, vptr);
-		}
-		else
-			printf("%s\n", vptr);
+			  regexec(regexp, value_, 0, NULL, 0)))
+		return 0;
+
+	if (show_keys)
+		printf("%s ", key_);
+	if (seen && !do_all)
+		dup_error = 1;
+	if (type == T_INT)
+		sprintf(value, "%d", git_config_int(key_, value_));
+	else if (type == T_BOOL)
+		vptr = git_config_bool(key_, value_) ? "true" : "false";
+	else
+		vptr = value_;
+	seen++;
+	if (dup_error) {
+		error("More than one value for the key %s: %s",
+				key_, vptr);
 	}
+	else
+		printf("%s\n", vptr);
+
 	return 0;
 }
 
