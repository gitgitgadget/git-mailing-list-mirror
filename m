From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: deny policy to prevent pushes to unwanted remotes.
Date: Mon, 30 May 2016 15:19:52 +0200
Message-ID: <vpq37ozd6o7.fsf@anie.imag.fr>
References: <20160530104501.4402-1-antoine.queru@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, larsxschneider@gmail.com,
	rsbecker@nexbridge.com, aaron@schrab.com, gitster@pobox.com,
	peff@peff.net
To: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 15:20:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7N7S-0003I4-51
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 15:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbcE3NUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 09:20:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37485 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754813AbcE3NU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 09:20:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4UDJp3G013314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 30 May 2016 15:19:51 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4UDJq7k004279;
	Mon, 30 May 2016 15:19:52 +0200
In-Reply-To: <20160530104501.4402-1-antoine.queru@ensimag.grenoble-inp.fr>
	(Antoine Queru's message of "Mon, 30 May 2016 12:45:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 30 May 2016 15:19:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4UDJp3G013314
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465219194.85234@74346PtU3VD1F7BtQK4D3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295893>

Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr> writes:

> Currently, a user wanting to prevent accidental pushes to the wrong remote
> has to create a pre-push hook.
> The feature offers a configuration to allow users to prevent accidental pushes
> to the wrong remote. The user may define a list of whitelisted remotes, a list
> of blacklisted remotes and a default policy ("allow" or "deny"). A push
> is denied if the remote is explicitely blacklisted or if it isn't
> whitelisted and the default policy is "deny".

Not really serious, but the text above is weirdly wrapped, probably by
hand. I'm sure your text editor can do better and quicker ;-).

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 53f00db..1478ce3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2517,6 +2517,23 @@ remote.pushDefault::
>  	`branch.<name>.remote` for all branches, and is overridden by
>  	`branch.<name>.pushRemote` for specific branches.
>  
> +remote.pushBlacklisted::
> +	The list of remotes the user is forbidden to push to.
> +	See linkgit:git-push[1]

I'd have spelled that "pushBlacklist" (no 'ed'). I think variable names
usually do not use verbs. But I'm fine with your version too.

> +For example, if we set up the configuration variables like this:
> +	git config --add remote.pushBlacklisted repository.com
> +	git config --add remote.pushWhitelisted repository.com/Special_Folder
> +Any push of this form will be accepted:
> +	git push repository.com/Special_Folder/foo
> +While those ones for example will be denied:
> +	git push repository.com/Normal_Folder/bar

Please, look at the rendered output of your documentation, and notice
it's broken. We'd typically use the asciidoc syntax for inline code here
(between -----).

> +An error will be raised if the url is blacklisted and whitelisted at the same.

"at the same time"?

But as-is, this sentence conflicts with the previous "the more the url
in the config prefixes the asked url the more priority it has."
statement.

The documentation doesn't talk about the URL-normalization the code is
doing. I think a reasonable behavior would be:

pushBlacklisted = example.com/ => deny all accesses to example.com
pushBlacklisted = http://example.com/ => deny HTTP accesses to
                                         example.com

The second is a valid use-case IMHO, some people may want to forbid some
protocols. Actually, one may even want to whilelist only one protocol
and write stg like this to force HTTPS on host example.com:

  pushBlacklisted = example.com
  pushWhitelisted = https://example.com

BTW, these use-cases could motivate some per-blacklist deny message
like

[remote "example.com"]
	pushDenyMessage = "Please use HTTPS when you push to example.com"

I don't think it has to be implemented now though (better have users get
used to the basic feature and see if more is needed later).

> +static const char *string_url_normalize(const char *repo_name)
> +{
> +	if (starts_with(repo_name, "file://"))
> +		return repo_name + 7;

There are many instances of this in Git's codebase, but we now try to
avoid magic numbers like this, and would use strlen("file://") instead.
Actually, we even have skip_prefix() precisely for this use-case.

> +	if (is_url(repo_name)) {
> +		struct url_info url_infos;
> +		url_normalize(repo_name, &url_infos);
> +		return url_infos.url + url_infos.host_off;

I think this would deserve a comment to explain why and what this is
doing, like /* turn ... into ... to ... */.

> +test_expect_success 'unsetup' '

"cleanup" ?

(I just did a very quick look at the code, I think we need an agreement
on the details of specification before a more detailed review)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
