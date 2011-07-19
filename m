From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/18] config: Introduce functions to write non-standard
 file
Date: Tue, 19 Jul 2011 15:55:04 -0400
Message-ID: <20110719195504.GA3957@sigill.intra.peff.net>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
 <1311095876-3098-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 21:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjGNw-0004uE-8i
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 21:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382Ab1GSTzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 15:55:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49388
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043Ab1GSTzI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 15:55:08 -0400
Received: (qmail 1062 invoked by uid 107); 19 Jul 2011 19:55:35 -0000
Received: from m-0-33.docsis.hbci.com (HELO sigill.intra.peff.net) (64.213.220.33)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jul 2011 15:55:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jul 2011 15:55:04 -0400
Content-Disposition: inline
In-Reply-To: <1311095876-3098-3-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177495>

On Tue, Jul 19, 2011 at 10:47:40PM +0530, Ramkumar Ramachandra wrote:

> -int git_config_set_multivar(const char *key, const char *value,
> -	const char *value_regex, int multi_replace)
> +int git_config_set_multivar_in_file(const char *key, const char *value,
> +				const char *value_regex, int multi_replace,
> +				const char *filename)
>  {
>  	int fd = -1, in_fd;
>  	int ret;
>  	char *config_filename;
> +	const char *saved_config_filename;
>  	struct lock_file *lock = NULL;
>  
> +	saved_config_filename = config_exclusive_filename;
> +	config_exclusive_filename = filename;
> +
>  	if (config_exclusive_filename)
>  		config_filename = xstrdup(config_exclusive_filename);
>  	else
> @@ -1379,6 +1390,7 @@ out_free:
>  	if (lock)
>  		rollback_lock_file(lock);
>  	free(config_filename);
> +	config_exclusive_filename = saved_config_filename;
>  	return ret;
>  
>  write_err_out:

Is there a need for this "config_exclusive_filename" hackery at all?

I was thinking the result would look more like:

diff --git a/config.c b/config.c
index ee643eb..35be842 100644
--- a/config.c
+++ b/config.c
@@ -1193,19 +1193,14 @@ out_free_ret_1:
  * - the config file is removed and the lock file rename()d to it.
  *
  */
-int git_config_set_multivar(const char *key, const char *value,
+int git_config_set_multivar_in_file(const char *config_filename,
+	const char *key, const char *value,
 	const char *value_regex, int multi_replace)
 {
 	int fd = -1, in_fd;
 	int ret;
-	char *config_filename;
 	struct lock_file *lock = NULL;
 
-	if (config_exclusive_filename)
-		config_filename = xstrdup(config_exclusive_filename);
-	else
-		config_filename = git_pathdup("config");
-
 	/* parse-key returns negative; flip the sign to feed exit(3) */
 	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
 	if (ret)
@@ -1382,7 +1377,6 @@ int git_config_set_multivar(const char *key, const char *value,
 out_free:
 	if (lock)
 		rollback_lock_file(lock);
-	free(config_filename);
 	return ret;
 
 write_err_out:
@@ -1391,6 +1385,24 @@ write_err_out:
 
 }
 
+int git_config_set_multivar(const char *key, const char *value,
+			    const char *value_regex, int multi_replace)
+{
+	char *config_filename;
+	int r;
+
+	if (config_exclusive_filename)
+		config_filename = xstrdup(config_exclusive_filename);
+	else
+		config_filename = git_pathdup("config");
+
+	r = git_config_set_multivar_in_file(config_filename, key, value,
+					    value_regex, multi_replace);
+
+	free(config_filename);
+	return r;
+}
+
 static int section_name_match (const char *buf, const char *name)
 {
 	int i = 0, j = 0, dot = 0;

Which is a bit cleaner to read, IMHO.

BTW, I'm unclear why we bother duplicating the filename in the first
place. It seems like we could go even simpler with:

int git_config_set_multivar(const char *key, const char *value,
                            const char *value_regex, int multi_replace)
{
	char *config_filename;

	if (config_exclusive_filename)
		config_filename = config_exclusive_filename;
	else
		config_filename = git_path("config");

        return git_config_set_multivar_in_file(config_filename, key, value,
                                               value_regex, multi_replace);
}
