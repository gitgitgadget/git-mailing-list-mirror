From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Move remote parsing into a library file out of builtin-push.
Date: Sat, 12 May 2007 12:27:53 -0700
Message-ID: <7vhcqhyh8m.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705121144130.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat May 12 21:28:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmxGB-0004Im-Fm
	for gcvg-git@gmane.org; Sat, 12 May 2007 21:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759848AbXELT2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 15:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759901AbXELT17
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 15:27:59 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42214 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759197AbXELT1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 15:27:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512192753.MDSI2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 15:27:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yKTt1W00D1kojtg0000000; Sat, 12 May 2007 15:27:53 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47080>

Daniel Barkalow <barkalow@iabervon.org> writes:

> +static int handle_config(const char *key, const char *value)
> +{
> +	const char *name;
> +	const char *subkey;
> +	struct remote *remote;
> +	if (!prefixcmp(key, "branch.") && current_branch &&
> +	    !strncmp(key + 7, current_branch, current_branch_len) &&
> +	    !strcmp(key + 7 + current_branch_len, ".remote")) {
> +		free(default_remote_name);
> +		default_remote_name = xstrdup(value);
> +	}
> +	if (prefixcmp(key,  "remote."))
> +		return 0;
> +	name = key + 7;
> +	subkey = strrchr(name, '.');
> +	if (!subkey)
> +		return error("Config with no key for remote %s", name);
> +	remote = make_remote(name, subkey - name);
> +	if (!strcmp(subkey, ".url")) {
> +		add_uri(remote, xstrdup(value));
> +	} else if (!strcmp(subkey, ".push")) {
> +		add_push_refspec(remote, xstrdup(value));
> +	} else if (!strcmp(subkey, ".receivepack")) {
> +		if (!remote->receivepack)
> +			remote->receivepack = xstrdup(value);
> +		else
> +			error("more than one receivepack given, using the first");
> +	}
> +	return 0;
> +}

You forgot to update this part?  With your comments on not
erroring out, which made sense to me, how about this?

diff --git a/remote.c b/remote.c
index dbcc74e..b032e81 100644
--- a/remote.c
+++ b/remote.c
@@ -150,7 +150,26 @@ static int handle_config(const char *key, const char *value)
 	subkey = strrchr(name, '.');
 	if (!subkey)
 		return error("Config with no key for remote %s", name);
+	if (*subkey == '/') {
+		warning("Config remote shorthand cannot begin with '/': %s", name);
+		return 0;
+	}
 	remote = make_remote(name, subkey - name);
+	if (!value) {
+		/* if we ever have a boolean variable, e.g. "remote.*.disabled"
+		 * [remote "frotz"]
+		 *      disabled
+		 * is a valid way to set it to true; we get NULL in value so
+		 * we need to handle it here.
+		 *
+		 * if (!strcmp(subkey, ".disabled")) {
+		 *      val = git_config_bool(key, value);
+		 *      return 0;
+		 * } else
+		 *
+		 */
+		return 0; /* ignore unknown booleans */
+	}
 	if (!strcmp(subkey, ".url")) {
 		add_uri(remote, xstrdup(value));
 	} else if (!strcmp(subkey, ".push")) {
