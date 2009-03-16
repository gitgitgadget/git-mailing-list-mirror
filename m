From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Give error when no remote is configured
Date: Mon, 16 Mar 2009 00:12:36 -0700
Message-ID: <7vocw2x7ob.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903110139450.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bernie@codewiz.org, git@vger.kernel.org,
	Giovanni Bajo <rasky@develer.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 08:14:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lj71e-0007eJ-TY
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 08:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbZCPHMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 03:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbZCPHMq
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 03:12:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbZCPHMp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 03:12:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 24FE75456;
	Mon, 16 Mar 2009 03:12:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 328515454; Mon,
 16 Mar 2009 03:12:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D7B894EA-11F9-11DE-A3DA-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113311>

Daniel Barkalow <barkalow@iabervon.org> writes:

> When there's no explicitly-named remote, we use the remote specified
> for the current branch, which in turn defaults to "origin". But it
> this case should require the remote to actually be configured, and not
> fall back to the path "origin".

This is seriously broken.

> @@ -643,11 +656,22 @@ static int valid_remote_nick(const char *name)
>  struct remote *remote_get(const char *name)
>  {
>  	struct remote *ret;
> +	int name_given = 0;
>  
>  	read_config();
> -	if (!name)
> +	if (name)
> +		name_given = 1;
> +	else {
>  		name = default_remote_name;
> -	ret = make_remote(name, 0);
> +		name_given = explicit_default_remote_name;
> +	}
> +	if (name_given)
> +		ret = make_remote(name, 0);
> +	else {
> +		ret = get_remote_by_name(name);
> +		if (!ret)
> +			return NULL;
> +	}

When you do not have any config entry to name your remotes but have been
using .git/remotes/origin happily, you may have read config already at
this point, but when you call get_remote_by_name() you haven't read
anything from .git/remotes/* (nor .git/branches/* for that matter).  The
caller will get NULL in such a case.  This happens for both fetch and
push.

Because you did not have any test to protect whatever you wanted to "fix"
with your patch, I have no way knowing if I am breaking something else you
wanted to do with your patch, but the patch below at least fixes the
regression for me when running "git pull" in a repository I initialized
long time ago that does not use the .git/config file to specify where my
remote repositories are.

It applies on top of fa685bd (Give error when no remote is configured,
2009-03-11)

-- >8 --
Subject: Remove total confusion from git-fetch and git-push

The config file is not the only place remotes are defined, and without
consulting .git/remotes and .git/branches, you won't know if "origin" is
configured by the user.  Don't give up too early and insult the user with
a wisecrack "Where do you want to fetch from today?"

Insulting is ok, but I personally get really pissed off if a tool is both
confused and insulting.  At least be _correct_ and insulting.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c |   21 ++++-----------------
 1 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/remote.c b/remote.c
index 199830e..9f07dbc 100644
--- a/remote.c
+++ b/remote.c
@@ -105,16 +105,6 @@ static void add_url_alias(struct remote *remote, const char *url)
 	add_url(remote, alias_url(url));
 }
 
-static struct remote *get_remote_by_name(const char *name)
-{
-	int i;
-	for (i = 0; i < remotes_nr; i++) {
-		if (!strcmp(name, remotes[i]->name))
-			return remotes[i];
-	}
-	return NULL;
-}
-
 static struct remote *make_remote(const char *name, int len)
 {
 	struct remote *ret;
@@ -665,19 +655,16 @@ struct remote *remote_get(const char *name)
 		name = default_remote_name;
 		name_given = explicit_default_remote_name;
 	}
-	if (name_given)
-		ret = make_remote(name, 0);
-	else {
-		ret = get_remote_by_name(name);
-		if (!ret)
-			return NULL;
-	}
+
+	ret = make_remote(name, 0);
 	if (valid_remote_nick(name)) {
 		if (!ret->url)
 			read_remotes_file(ret);
 		if (!ret->url)
 			read_branches_file(ret);
 	}
+	if (!name_given && !ret->url)
+		return NULL;
 	if (!ret->url)
 		add_url_alias(ret, name);
 	if (!ret->url)
