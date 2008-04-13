From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH v3 1/4] config.c: Add git_config_bool_or_int to handle
 bool/int variable
Date: Sat, 12 Apr 2008 23:26:52 -0700
Message-ID: <7vmynye0cz.fsf@gitster.siamese.dyndns.org>
References: <1208012733-18211-1-git-send-email-pkufranky@gmail.com>
 <1208012733-18211-2-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 08:28:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkvgy-0008QF-K3
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 08:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbYDMG1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 02:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbYDMG1O
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 02:27:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbYDMG07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 02:26:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8E380303B;
	Sun, 13 Apr 2008 02:26:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9882E303A; Sun, 13 Apr 2008 02:26:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79393>

Ping Yin <pkufranky@gmail.com> writes:

> With git_config_bool_or_int, the caller can differentiate boolean true
> and integer 1 etc.
>
> Signed-off-by: Ping Yin <pkufranky@gmail.com>
> ---
>  config.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/config.c b/config.c
> index 0624494..e614456 100644
> --- a/config.c
> +++ b/config.c
> @@ -316,6 +316,21 @@ int git_config_bool(const char *name, const char *value)
>  	return git_config_int(name, value) != 0;
>  }
>  
> +int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
> +{
> +	*is_bool = 1;
> +	if (!value)
> +		return 1;
> +	if (!*value)
> +		return 0;
> +	if (!strcasecmp(value, "true") || !strcasecmp(value, "yes"))
> +		return 1;
> +	if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))
> +		return 0;
> +	*is_bool = 0;
> +	return git_config_int(name, value);
> +}
> +

I expected git_config_bool() to be implemented in terms of this new
function to avoid code duplication if we were actually going to do this.

You also need an external declaration in a header file for its users.

---
 cache.h  |    1 +
 config.c |   10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 2a1e7ec..50b28fa 100644
--- a/cache.h
+++ b/cache.h
@@ -692,6 +692,7 @@ extern int git_parse_long(const char *, long *);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
 extern unsigned long git_config_ulong(const char *, const char *);
+extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_set(const char *, const char *);
diff --git a/config.c b/config.c
index 0624494..5ea18ef 100644
--- a/config.c
+++ b/config.c
@@ -303,8 +303,9 @@ unsigned long git_config_ulong(const char *name, const char *value)
 	return ret;
 }
 
-int git_config_bool(const char *name, const char *value)
+int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
+	*is_bool = 1;
 	if (!value)
 		return 1;
 	if (!*value)
@@ -313,9 +314,16 @@ int git_config_bool(const char *name, const char *value)
 		return 1;
 	if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))
 		return 0;
+	*is_bool = 0;
 	return git_config_int(name, value) != 0;
 }
 
+int git_config_bool(const char *name, const char *value)
+{
+	int discard;
+	return git_config_bool_or_int(name, value, &discard);
+}
+
 int git_config_string(const char **dest, const char *var, const char *value)
 {
 	if (!value)
