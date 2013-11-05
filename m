From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] git_connect: factor out discovery of the protocol
 and its parts
Date: Tue, 05 Nov 2013 22:22:51 +0100
Message-ID: <527961AB.2010606@kdbg.org>
References: <201311042220.50178.tboegi@web.de> <52789AE5.2010702@viscovery.net> <52794882.2020108@kdbg.org> <5279496A.2090202@kdbg.org> <527958E1.2080805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 05 22:23:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vdo5T-0003xe-Bg
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 22:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392Ab3KEVWz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Nov 2013 16:22:55 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:44237 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755167Ab3KEVWy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 16:22:54 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BE7C5130050;
	Tue,  5 Nov 2013 22:22:52 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B7BA419F3EE;
	Tue,  5 Nov 2013 22:22:51 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <527958E1.2080805@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237344>

Am 05.11.2013 21:45, schrieb Torsten B=C3=B6gershausen:
> On 2013-11-05 20.39, Johannes Sixt wrote:
> Thanks for picking this up, please see some minor nits inline,
> and git_connect() is at the end
>=20
>> -struct child_process *git_connect(int fd[2], const char *url_orig,
>> -				  const char *prog, int flags)
>> +static enum protocol parse_connect_url(const char *url_orig, char *=
*ret_host,
>> +				       char **ret_port, char **ret_path)
>>  {
>>  	char *url;
>>  	char *host, *path;
>>  	char *end;
> Can we put all the char * into one single line?

The idea here was to keep the diff minimal, and that further slight
cleanups should be combined with subsequent rewrites that should happen
to this function.

>>  	int c;
>> @@ -645,6 +628,49 @@ struct child_process *git_connect(int fd[2], co=
nst char *url_orig,
>>  	if (protocol =3D=3D PROTO_SSH && host !=3D url)
>>  		port =3D get_port(end);
>> =20
>> +	*ret_host =3D xstrdup(host);
>> +	if (port)
>> +		*ret_port =3D xstrdup(port);
>> +	else
>> +		*ret_port =3D NULL;
>> +	if (free_path)
>> +		*ret_path =3D path;
>> +	else
>> +		*ret_path =3D xstrdup(path);
>> +	free(url);
>> +	return protocol;
>> +}
>> +
>> +static struct child_process no_fork;
>> +
>> +/*
>> + * This returns a dummy child_process if the transport protocol doe=
s not
>> + * need fork(2), or a struct child_process object if it does.  Once=
 done,
>> + * finish the connection with finish_connect() with the value retur=
ned from
>> + * this function (it is safe to call finish_connect() with NULL to =
support
>> + * the former case).
>> + *
>> + * If it returns, the connect is successful; it just dies on errors=
 (this
>> + * will hopefully be changed in a libification effort, to return NU=
LL when
>> + * the connection failed).
>> + */
>> +struct child_process *git_connect(int fd[2], const char *url,
>> +				  const char *prog, int flags)
>> +{
>> +	char *host, *path;
>> +	struct child_process *conn =3D &no_fork;
>> +	enum protocol protocol;
>> +	char *port;
>> +	const char **arg;
>> +	struct strbuf cmd =3D STRBUF_INIT;
>> +
>> +	/* Without this we cannot rely on waitpid() to tell
>> +	 * what happened to our children.
>> +	 */
>> +	signal(SIGCHLD, SIG_DFL);
>> +
>> +	protocol =3D parse_connect_url(url, &host, &port, &path);
>> +
>>  	if (protocol =3D=3D PROTO_GIT) {
>>  		/* These underlying connection commands die() if they
>>  		 * cannot connect.
>> @@ -666,9 +692,9 @@ struct child_process *git_connect(int fd[2], con=
st char *url_orig,
>>  			     prog, path, 0,
>>  			     target_host, 0);
>>  		free(target_host);
> This is hard to see in the diff, I think we don't need target_host an=
y more.

I though that as well first, but no, we still need it. Further rewrites
are needed that move the port discovery from git_proxy_connect() and
git_tcp_connect() to the new parse_connect_url() before target_host can
go away. And even then it is questionable because target_host is used i=
n
an error message and is intended to reflect the original combined
host+port portion of the URL, if I read the code correctly.

>> -		free(url);
>> -		if (free_path)
>> -			free(path);
>> +		free(host);
>> +		free(port);
>> +		free(path);
>>  		return conn;
>>  	}
>> =20
>> @@ -709,9 +735,9 @@ struct child_process *git_connect(int fd[2], con=
st char *url_orig,
>>  	fd[0] =3D conn->out; /* read from child's stdout */
>>  	fd[1] =3D conn->in;  /* write to child's stdin */
>>  	strbuf_release(&cmd);
>> -	free(url);
>> -	if (free_path)
>> -		free(path);
>=20
> This "end of function, free everything and return conn",
> could we re-arange so that it is in the code only once ?

That would be quite simple now; just place the part after the first
return into the else branch. That opens opportunities to move variable
declarations from the top of the function into the else branch.

But all of these changes should go into a separate commit, IMO, so that
the function splitting that happens here can be verified more easily.

-- Hannes
