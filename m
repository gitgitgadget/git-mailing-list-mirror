From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 2/2] git_connect: factor out discovery of the protocol
 and its parts
Date: Tue, 05 Nov 2013 21:45:21 +0100
Message-ID: <527958E1.2080805@web.de>
References: <201311042220.50178.tboegi@web.de> <52789AE5.2010702@viscovery.net> <52794882.2020108@kdbg.org> <5279496A.2090202@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 05 21:45:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdnVG-0006jC-1I
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 21:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079Ab3KEUpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 15:45:30 -0500
Received: from mout.web.de ([212.227.17.12]:63210 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754403Ab3KEUp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 15:45:29 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0M3k8j-1VvBrS1gfp-00rEWN for <git@vger.kernel.org>;
 Tue, 05 Nov 2013 21:45:27 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <5279496A.2090202@kdbg.org>
X-Provags-ID: V03:K0:E/ESZ7JDoVvA6/Ic0QKYMyVjSPB0CxGti9kdKf/Wg+5kdeMK/xp
 pkFuNThthyPimL08QlyCOYylvgOIx8v3CNAKrSIijtaPyn/3roDkmC4rgb8/M7yHfJTua/u
 AZ93u5lxVVAjmuQuBg5CUjuhD/Q03SXNTEKURro55Z4SPQcXV9sdi6r0xH3210+GG9BxgIf
 eEuBkw3NswB10nK2kaHbw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237341>

On 2013-11-05 20.39, Johannes Sixt wrote:
Thanks for picking this up, please see some minor nits inline,
and git_connect() is at the end

> -struct child_process *git_connect(int fd[2], const char *url_orig,
> -				  const char *prog, int flags)
> +static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
> +				       char **ret_port, char **ret_path)
>  {
>  	char *url;
>  	char *host, *path;
>  	char *end;
Can we put all the char * into one single line?

>  	int c;
> @@ -645,6 +628,49 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
>  	if (protocol == PROTO_SSH && host != url)
>  		port = get_port(end);
>  
> +	*ret_host = xstrdup(host);
> +	if (port)
> +		*ret_port = xstrdup(port);
> +	else
> +		*ret_port = NULL;
> +	if (free_path)
> +		*ret_path = path;
> +	else
> +		*ret_path = xstrdup(path);
> +	free(url);
> +	return protocol;
> +}
> +
> +static struct child_process no_fork;
> +
> +/*
> + * This returns a dummy child_process if the transport protocol does not
> + * need fork(2), or a struct child_process object if it does.  Once done,
> + * finish the connection with finish_connect() with the value returned from
> + * this function (it is safe to call finish_connect() with NULL to support
> + * the former case).
> + *
> + * If it returns, the connect is successful; it just dies on errors (this
> + * will hopefully be changed in a libification effort, to return NULL when
> + * the connection failed).
> + */
> +struct child_process *git_connect(int fd[2], const char *url,
> +				  const char *prog, int flags)
> +{
> +	char *host, *path;
> +	struct child_process *conn = &no_fork;
> +	enum protocol protocol;
> +	char *port;
> +	const char **arg;
> +	struct strbuf cmd = STRBUF_INIT;
> +
> +	/* Without this we cannot rely on waitpid() to tell
> +	 * what happened to our children.
> +	 */
> +	signal(SIGCHLD, SIG_DFL);
> +
> +	protocol = parse_connect_url(url, &host, &port, &path);
> +
>  	if (protocol == PROTO_GIT) {
>  		/* These underlying connection commands die() if they
>  		 * cannot connect.
> @@ -666,9 +692,9 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
>  			     prog, path, 0,
>  			     target_host, 0);
>  		free(target_host);
This is hard to see in the diff, I think we don't need target_host any more.
> -		free(url);
> -		if (free_path)
> -			free(path);
> +		free(host);
> +		free(port);
> +		free(path);
>  		return conn;
>  	}
>  
> @@ -709,9 +735,9 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
>  	fd[0] = conn->out; /* read from child's stdout */
>  	fd[1] = conn->in;  /* write to child's stdin */
>  	strbuf_release(&cmd);
> -	free(url);
> -	if (free_path)
> -		free(path);

This "end of function, free everything and return conn",
could we re-arange so that it is in the code only once ?

> +	free(host);
> +	free(port);
> +	free(path);
>  	return conn;
>  }
====================

struct child_process *git_connect(int fd[2], const char *url,
                  const char *prog, int flags)
{
    char *host, *port, *path;
    struct child_process *conn = &no_fork;
    enum protocol protocol;
    const char **arg;
    struct strbuf cmd = STRBUF_INIT;

    /* Without this we cannot rely on waitpid() to tell
     * what happened to our children.
     */
    signal(SIGCHLD, SIG_DFL);

    protocol = parse_connect_url(url, &host, &port, &path);

    if (protocol == PROTO_GIT) {
        /* These underlying connection commands die() if they
         * cannot connect.
         */
        if (git_use_proxy(host))
            conn = git_proxy_connect(fd, host);
        else
            git_tcp_connect(fd, host, flags);
        /*
         * Separate original protocol components prog and path
         * from extended host header with a NUL byte.
         *
         * Note: Do not add any other headers here!  Doing so
         * will cause older git-daemon servers to crash.
         */
        packet_write(fd[1],
                 "%s %s%chost=%s%c",
                 prog, path, 0,
                 host, 0);
    }
    else
    {
        conn = xcalloc(1, sizeof(*conn));

        strbuf_addstr(&cmd, prog);
        strbuf_addch(&cmd, ' ');
        sq_quote_buf(&cmd, path);

        conn->in = conn->out = -1;
        conn->argv = arg = xcalloc(7, sizeof(*arg));
        if (protocol == PROTO_SSH) {
            const char *ssh = getenv("GIT_SSH");
            int putty = ssh && strcasestr(ssh, "plink");
            if (!ssh) ssh = "ssh";

            *arg++ = ssh;
            if (putty && !strcasestr(ssh, "tortoiseplink"))
                *arg++ = "-batch";
            if (port) {
                /* P is for PuTTY, p is for OpenSSH */
                *arg++ = putty ? "-P" : "-p";
                *arg++ = port;
            }
            *arg++ = host;
        }
        else {
            /* remove repo-local variables from the environment */
            conn->env = local_repo_env;
            conn->use_shell = 1;
        }
        *arg++ = cmd.buf;
        *arg = NULL;

        if (start_command(conn))
            die("unable to fork");

        fd[0] = conn->out; /* read from child's stdout */
        fd[1] = conn->in;  /* write to child's stdin */
        strbuf_release(&cmd);
    }
    free(host);
    free(port);
    free(path);
    return conn;
}
