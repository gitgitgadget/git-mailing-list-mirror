From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-remote: add verbose mode to git remote update
Date: Mon, 17 Nov 2008 08:46:00 -0800
Message-ID: <7vljviwbav.fsf@gitster.siamese.dyndns.org>
References: <1226920551-28303-1-git-send-email-crquan@gmail.com>
 <1226920551-28303-2-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: crquan@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 17 17:48:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L27HB-0004yr-QE
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 17:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbYKQQrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 11:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752402AbYKQQrW
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 11:47:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbYKQQrV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 11:47:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C3E3A7F236;
	Mon, 17 Nov 2008 11:47:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E03BB7F200; Mon,
 17 Nov 2008 11:46:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 66D7E418-B4C7-11DD-B74C-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101232>

crquan@gmail.com writes:

> From: Cheng Renquan <crquan@gmail.com>
>
> Pass the verbose mode parameter to the underlying fetch command.
> 
>   $ ./git remote -v update
>   Updating origin
>   From git://git.kernel.org/pub/scm/git/git
>    = [up to date]      html       -> origin/html
> ...
> -	"git remote update [group]",
> +	"git remote update [-v | --verbose] [group]",
>  	NULL
>  };
 
Hmm, ok.  I do not think "git remote update -v" would work, though.

> @@ -40,9 +40,13 @@ static int opt_parse_track(const struct option *opt, const char *arg, int not)
>  	return 0;
>  }
>  
> -static int fetch_remote(const char *name)
> +static int fetch_remote(const char *name, const char *url)
>  {
> -	const char *argv[] = { "fetch", name, NULL };
> +	const char *argv[] = { "fetch", name, NULL, NULL };
> +	if (verbose) {
> +		argv[1] = "-v";
> +		argv[2] = name;
> +	}
>  	printf("Updating %s\n", name);
>  	if (run_command_v_opt(argv, RUN_GIT_CMD))
>  		return error("Could not fetch %s", name);

I do not think this new parameter "url" is used anywhere in this function;
please drop the change in the function signature.  That would make your
change to "add()", "get_one_remote_for_update()", and "update()" all
unnecessary.

> @@ -769,8 +773,12 @@ static int prune(int argc, const char **argv)
>  static int get_one_remote_for_update(struct remote *remote, void *priv)
>  {
>  	struct string_list *list = priv;
> +
>  	if (!remote->skip_default_update)
> -		string_list_append(xstrdup(remote->name), list);
> +		string_list_append(remote->name, list)->util =
> +			remote->url_nr > 0
> +			? (void *)remote->url[remote->url_nr-1] : NULL;
> +
>  	return 0;
>  }
>  

I notice that you dropped xstrdup() without explanation.  While I think it
is a valid leak fix, that should be done as a separate commit (shown
below).

By the way, you fixed mismatch between the documentation and usage string
in an earlier patch, but you broke it yourself ;-).  Please fix it up.

Thanks.

-- >8 --
Subject: builtin-remote.c: plug a small memory leak in get_one_remote_for_updates()

We know that the string pointed at by remote->name won't change.  It can
be borrowed as the key in the string_list without copying.  Other parts of
existing code such as get_one_entry() already rely on this fact.

Noticed by Cheng Renquan.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index d032f25..14774e3 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -770,7 +770,7 @@ static int get_one_remote_for_update(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
 	if (!remote->skip_default_update)
-		string_list_append(xstrdup(remote->name), list);
+		string_list_append(remote->name, list);
 	return 0;
 }
 
-- 
1.6.0.4.772.g2ebfe
