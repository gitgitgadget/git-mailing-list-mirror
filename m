From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http authentication via prompts
Date: Wed, 04 Mar 2009 23:34:39 -0800
Message-ID: <7vd4cw4e40.fsf@gitster.siamese.dyndns.org>
References: <49AF25BF.5060706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 08:36:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf87t-0002MF-0M
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 08:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbZCEHet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 02:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbZCEHes
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 02:34:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbZCEHer (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 02:34:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A7AB9FC6E;
	Thu,  5 Mar 2009 02:34:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C3E739FC6D; Thu,
  5 Mar 2009 02:34:41 -0500 (EST)
In-Reply-To: <49AF25BF.5060706@gmail.com> (Mike Gaffney's message of "Wed, 04
 Mar 2009 19:07:11 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1939A3C8-0958-11DE-B9F7-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112261>

Mike Gaffney <mr.gaffo@gmail.com> writes:

> Currently git over http only works with a .netrc file which required that you store your password on the file system in plaintext. This commit adds to configuration options for http for a username and an optional password. If a http.username is set, then the .netrc file is ignored and the username is used instead. If a http.password is set, then that is used as well, otherwise the user is prompted for their password.
>
> With the old .netrc working, this patch provides backwards compatibility while adding a more secure option for users whose http password may be sensitive (such as if its a domain controller password) and do not wish to have it on the filesystem.

Please wrap lines to readable length, such as under 72 cols.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f5152c5..821bf48 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -920,6 +920,13 @@ help.autocorrect::
>  	value is 0 - the command will be just shown but not executed.
>  	This is the default.
>  
> +http.username, http.password:
> +    The username and password for http authentication. http.username is
> +    required, http.password is optional. If supplied, the .netrc file will
> +    be ignored. If a password is not supplied, git will prompt for it.
> +    Be careful when configuring a password as it will be stored in plain text
> +    on the filesystem.
> +
>  http.proxy::

List item ends with double colons; two headline items that are described
with the same description are listed each on its own line.  I.e.

	http.username::
        http.password::
        	The username and ...

> diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
> index 622ee5c..462a9d4 100644
> --- a/Documentation/howto/setup-git-server-over-http.txt
> +++ b/Documentation/howto/setup-git-server-over-http.txt
> @@ -189,8 +189,19 @@ Make sure that you have HTTP support, i.e. your git was built with
>  libcurl (version more recent than 7.10). The command 'git http-push' with
>  no argument should display a usage message.
>  
> -Then, add the following to your $HOME/.netrc (you can do without, but will be
> -asked to input your password a _lot_ of times):
> +There are 2 ways to authenticate with git http, netrc and via the git config.
> +The netrc option requires that you put the username and password for the connection
> +in $HOME/.netrc. The configuration method allows you to specify a username and
> +optionally a password. If the password is not supplied then git will prompt you
> +for the password. The downside to the netrc method is that you must have your
> +username and password in plaintext on the filesystem, albeit in a protected file.
> +If the username/password combo is a sensitive one, you may wish to use the
> +git config method. The downside of the config method is that you will be prompted
> +for your password every time you push or pull to the remote repository.

The contents look readable, but each line is a bit too long.

> @@ -204,7 +215,7 @@ instead of the server name.
>  
>  To check whether all is OK, do:
>  
> -   curl --netrc --location -v http://<username>@<servername>/my-new-repo.git/HEAD
> +   curl --netrc --location -v http://<servername>/my-new-repo.git/HEAD

Why?

> @@ -213,12 +224,31 @@ Now, add the remote in your existing repository which contains the project
>  you want to export:
>  
>     $ git-config remote.upload.url \
> -       http://<username>@<servername>/my-new-repo.git/
> +       http://<servername>/my-new-repo.git/

Why?

> +Using git config:

The bulk of text before this does not have a subtitle like this.  Perhaps
you would want to add one?  The presense of this subtitle makes it clear
that you are going to talk about _another_ way, but for first time readers
it is unclear how that other way is different and what its advantages are.

Perhaps drop this subtitle, and instead give one short paragraph, e.g.

    Instead of storing your password in plaintext $HOME/.netrc file, you
    can store only the username in the configuration file and have the
    program prompt for a password.  Here is how.

Alternatively keep the subtitle and explain what the subsection is about
in a similar way.

But I think this section raises a bigger usability and user perception
issue.

When "http://user@host/rest" URL is given to your "git push/fetch",
without .netrc nor http.username configuration, we allow the curl library
to prompt for a password, and because we do not reuse the password (and
reinstantiate the curl handle), we end up asking the user million times.

But from the end user's point of view, that's all implementation detail.
It does not explain why "http://user@host/rest" acts in a silly way, and
"http://host/rest" with http.username configuration doesn't.

Perhaps you instead inspect the URL and see if you have the "user" part
(without password), and then:

 (1) transform the URL to http://host/rest" before giving it to libcurl;
     and

 (2) use your CURLOPT_USERPWD logic with your own getpass() call in
     init_curl_http_auth()?

That way you do not have (even though you could) to introduce a new
configuration, nor have a new section in the documentation.  It will be a
straightforward fix of the "will be asked ... a lot of times" bug you
removed from the documentation, no?

> diff --git a/http.c b/http.c
> index ee58799..348b9fb 100644
> --- a/http.c
> +++ b/http.c
> @@ -26,6 +26,9 @@ static long curl_low_speed_time = -1;
>  static int curl_ftp_no_epsv = 0;
>  static const char *curl_http_proxy = NULL;
>  
> +static const char *curl_http_username = NULL;
> +static const char *curl_http_password = NULL;
> +

Please do not introduce new initializations of static variables to 0 or
NULL.  As a clean-up, before your patch, you can send in a patch to fix
existing such initializations.

> +static void init_curl_http_auth(CURL* result){
> +#if LIBCURL_VERSION_NUM >= 0x070907
> +        struct strbuf userpass;
> +        strbuf_init(&userpass, 0);
> +        if (curl_http_username != NULL) {
> +                strbuf_addstr(&userpass, curl_http_username);
> +		strbuf_addstr(&userpass, ":");
> +		if (curl_http_password != NULL) {
> +			strbuf_addstr(&userpass, curl_http_password);
> +		} else {
> +			strbuf_addstr(&userpass, getpass("Password: "));
> +		}
> +		curl_easy_setopt(result, CURLOPT_USERPWD, userpass.buf);
> +		curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_IGNORED);

Why NETRC_IGNORED?

On CURLOPT_NETRC, http://curl.haxx.se/libcurl/c/curl_easy_setopt.html says 

	libcurl uses a user name (and supplied or prompted password)
	supplied with CURLOPT_USERPWD in preference to any of the options
	controlled by this parameter.

Does it not work as advertised?

In short, I think what you did in init_curl_http_auth() makes a lot of
sense except for the NETRC_IGNORED bit, but:

 (1) I think http.password configuration has the exact same "plaintext
     password in a read-protected file" issue as .netrc; it is
     unnecessary.

 (2) http.username is used by your patch primarily as a way to trigger the
     new logic to call getpass() and use CURLOPT_USERPWD.  It would be a
     lot nicer to inspect the URL to notice that there is a username part
     in it and triggering the same codepath.  That would be a genuine
     improvement (and you can even claim it is a bugfix).  And if that
     works, the new configuration variable does not add much value (except
     that different people involved in the same project can use the same
     URL but their own (username, password) pair to access it.
