From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 2/2] git_connect: factor out discovery of the protocol
 and its parts
Date: Wed, 06 Nov 2013 16:31:14 +0100
Message-ID: <527A60C2.8090607@web.de>
References: <201311042220.50178.tboegi@web.de> <52789AE5.2010702@viscovery.net> <52794882.2020108@kdbg.org> <5279496A.2090202@kdbg.org> <527958E1.2080805@web.de> <527961AB.2010606@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 06 16:31:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve54j-0002ex-Gx
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 16:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522Ab3KFPbR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Nov 2013 10:31:17 -0500
Received: from mout.web.de ([212.227.15.3]:64855 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754406Ab3KFPbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 10:31:16 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0M5Oct-1Vq0Sb2Cul-00zTto for <git@vger.kernel.org>;
 Wed, 06 Nov 2013 16:31:14 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527961AB.2010606@kdbg.org>
X-Provags-ID: V03:K0:yCbuum4nRgffTud/wzPO6UFGKP6sDvvrh5gqPhSg3y3ETe7kEzK
 q/+KK8ySt3zE+IPhS8hR5nSXy+CAgGRwNRuhvsZext4YcNioYu2+xW4MnLSr0q9nYRxxWO3
 C8uR4VnPRxtIpzUMuKUbKwSS+UjRzdbvI4zu9IuRWbn1okU7VLW481daLW7zQbTW0wXNWTz
 Ww9Ff9juCGWvV36O4UO2w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237355>

On 2013-11-05 22.22, Johannes Sixt wrote:
> Am 05.11.2013 21:45, schrieb Torsten B=C3=B6gershausen:
>> On 2013-11-05 20.39, Johannes Sixt wrote:
>> Thanks for picking this up, please see some minor nits inline,
>> and git_connect() is at the end
>>
>>> -struct child_process *git_connect(int fd[2], const char *url_orig,
>>> -				  const char *prog, int flags)
>>> +static enum protocol parse_connect_url(const char *url_orig, char =
**ret_host,
>>> +				       char **ret_port, char **ret_path)
>>>  {
>>>  	char *url;
>>>  	char *host, *path;
>>>  	char *end;
>> Can we put all the char * into one single line?
>=20
> The idea here was to keep the diff minimal, and that further slight
> cleanups should be combined with subsequent rewrites that should happ=
en
> to this function.
>=20
>>>  	int c;
>>> @@ -645,6 +628,49 @@ struct child_process *git_connect(int fd[2], c=
onst char *url_orig,
>>>  	if (protocol =3D=3D PROTO_SSH && host !=3D url)
>>>  		port =3D get_port(end);
>>> =20
>>> +	*ret_host =3D xstrdup(host);
>>> +	if (port)
>>> +		*ret_port =3D xstrdup(port);
>>> +	else
>>> +		*ret_port =3D NULL;
>>> +	if (free_path)
>>> +		*ret_path =3D path;
>>> +	else
>>> +		*ret_path =3D xstrdup(path);
>>> +	free(url);
>>> +	return protocol;
>>> +}
>>> +
>>> +static struct child_process no_fork;
>>> +
>>> +/*
>>> + * This returns a dummy child_process if the transport protocol do=
es not
>>> + * need fork(2), or a struct child_process object if it does.  Onc=
e done,
>>> + * finish the connection with finish_connect() with the value retu=
rned from
>>> + * this function (it is safe to call finish_connect() with NULL to=
 support
>>> + * the former case).
>>> + *
>>> + * If it returns, the connect is successful; it just dies on error=
s (this
>>> + * will hopefully be changed in a libification effort, to return N=
ULL when
>>> + * the connection failed).
>>> + */
>>> +struct child_process *git_connect(int fd[2], const char *url,
>>> +				  const char *prog, int flags)
>>> +{
>>> +	char *host, *path;
>>> +	struct child_process *conn =3D &no_fork;
>>> +	enum protocol protocol;
>>> +	char *port;
>>> +	const char **arg;
>>> +	struct strbuf cmd =3D STRBUF_INIT;
>>> +
>>> +	/* Without this we cannot rely on waitpid() to tell
>>> +	 * what happened to our children.
>>> +	 */
>>> +	signal(SIGCHLD, SIG_DFL);
>>> +
>>> +	protocol =3D parse_connect_url(url, &host, &port, &path);
>>> +
>>>  	if (protocol =3D=3D PROTO_GIT) {
>>>  		/* These underlying connection commands die() if they
>>>  		 * cannot connect.
>>> @@ -666,9 +692,9 @@ struct child_process *git_connect(int fd[2], co=
nst char *url_orig,
>>>  			     prog, path, 0,
>>>  			     target_host, 0);
>>>  		free(target_host);
>> This is hard to see in the diff, I think we don't need target_host a=
ny more.
>=20
> I though that as well first, but no, we still need it. Further rewrit=
es
> are needed that move the port discovery from git_proxy_connect() and
> git_tcp_connect() to the new parse_connect_url() before target_host c=
an
> go away. And even then it is questionable because target_host is used=
 in
> an error message and is intended to reflect the original combined
> host+port portion of the URL, if I read the code correctly.
>=20
>>> -		free(url);
>>> -		if (free_path)
>>> -			free(path);
>>> +		free(host);
>>> +		free(port);
>>> +		free(path);
>>>  		return conn;
>>>  	}
>>> =20
>>> @@ -709,9 +735,9 @@ struct child_process *git_connect(int fd[2], co=
nst char *url_orig,
>>>  	fd[0] =3D conn->out; /* read from child's stdout */
>>>  	fd[1] =3D conn->in;  /* write to child's stdin */
>>>  	strbuf_release(&cmd);
>>> -	free(url);
>>> -	if (free_path)
>>> -		free(path);
>>
>> This "end of function, free everything and return conn",
>> could we re-arange so that it is in the code only once ?
>=20
> That would be quite simple now; just place the part after the first
> return into the else branch. That opens opportunities to move variabl=
e
> declarations from the top of the function into the else branch.
>=20
> But all of these changes should go into a separate commit, IMO, so th=
at
> the function splitting that happens here can be verified more easily.
>=20
> -- Hannes
Agreed on all points, (some re-reading was needed)

I will first focus on the test cases,
since having god test cases eases us the re-factoring later on.
Thanks
/Torsten
