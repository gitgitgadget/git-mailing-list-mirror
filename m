From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: fix "update [group...]"
Date: Mon, 03 Mar 2008 17:43:52 -0800
Message-ID: <7v4pbne013.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803040029440.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 04 02:44:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWMCy-0003CU-VM
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 02:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756520AbYCDBoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 20:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756363AbYCDBoD
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 20:44:03 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63760 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756272AbYCDBoB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 20:44:01 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7F27B3740;
	Mon,  3 Mar 2008 20:43:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 76582373D; Mon,  3 Mar 2008 20:43:55 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0803040029440.22527@racer.site> (Johannes
 Schindelin's message of "Tue, 4 Mar 2008 00:30:24 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76010>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The rewrite in C inadvertently broke updating with remote groups: when you
> pass parameters to "git remote update", it used to look up "remotes.<group>"
> for every parameter, and interpret the value as a list of remotes to update.
>
> Also, no parameter, or a single parameter "default" should update all
> remotes that have not been marked with "skipDefaultUpdate".

My reading of "sub update_remote {}" seems to indicate there still are
some differences.  What the scripted version did was:

   - Without extra parameter, update_remote() is run with "default";
   - With parameters, update_remote() is run for each of them;

  Then inside update_remote():

   - grab "remotes.$name" configuration; if exists, then it is split using
     "split(' ')", which is different from split(/ /).

     Compare:
          my @a = split(/ /, " A quick\t brown fox  ");
          my @b = split(' ', " A quick\t brown fox  ");
	  print "<" . join("><", @a), ">\n";
	  print "<" . join("><", @b), ">\n";
     The latter returns ('A', 'quick', 'brown', 'fox').

   - If no "remotes.$name" configuration exists, and if the name is
     "default", then grab all remotes that do not have
     remote.$foo.skipDefaultUpdate set to true.

   - Otherwise complain and die.

  Then fetch each of them.

> +static int get_one_remote_for_update(struct remote *remote, void *priv)
>  {
> +	struct path_list *list = priv;
>  	if (!remote->skip_default_update)
> +		path_list_append(xstrdup(remote->name), list);
> +	return 0;
> +}

This is called when no extra parameter is given or the name is default.
It behaves differently from the scripted version if remote.default
configuration exists, doesn't it?

I suspect this is a regression to a useful feature.  The user can specify
an explicit list of remotes to fetch from when he says "update default" or
just "update", without having to say skipdefaultupdate for all the usually
uninteresting remotes.

> +struct remote_group {
> +	const char *name;
> +	struct path_list *list;
> +} remote_group;
> +
> +static int get_remote_group(const char *key, const char *value)
> +{
> +	if (!prefixcmp(key, "remotes.") &&
> +			!strcmp(key + 8, remote_group.name)) {
> +		char *space = strchr(value, ' ');
> +		while (space) {
> +			path_list_append(xstrndup(value, space - value),
> +					remote_group.list);
> +			value = space + 1;
> +			space = strchr(value, ' ');
> +		}
> +		path_list_append(xstrdup(value), remote_group.list);
> +	}
> +

This does not mimick the magic "split(' ', $conf)" in the scripted
version.  We probably need a library function to parse whitespace
separated list of tokens, which may help other config parsers (color?  I
was too lazy to check).

>  static int update(int argc, const char **argv)
>  {
> +	int i, result = 0;
> +	struct path_list list = { NULL, 0, 0, 0 };
>  
> +	if (argc < 2 || (argc == 2 && !strcmp(argv[1], "default")))
> +		result = for_each_remote(get_one_remote_for_update, &list);
> +	else {
> +		remote_group.list = &list;
> +		for (i = 1; i < argc; i++) {
> +			remote_group.name = argv[i];
> +			result = git_config(get_remote_group);
> +		}
> +	}
> +	if (result)
> +		return result;
>  
> +	for (i = 0; i < list.nr; i++)
> +		result |= fetch_remote(list.items[i].path);
> +	list.strdup_paths = 1;
> +	path_list_clear(&list, 0);

This setting of strdup_paths after the fact and causing clear to free
things that were allocated while strdup_paths were set to 0 made me go
"Huh?", which means it needs explanation or code clarification.

> +
> +	return result;

The scripted one did not stop fetching upon error and this does not
regress it, but it reports error, which I think is a good change.
