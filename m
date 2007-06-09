From: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>
Subject: Re: [PATCH] Port git-tag.sh to C.
Date: Sat, 09 Jun 2007 19:27:41 -0400
Message-ID: <466B376D.8040303@redhat.com>
References: <11813427591137-git-send-email-krh@redhat.com> <7v7iqdf0gn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 01:27:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxALa-0006Wt-VP
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 01:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757474AbXFIX1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 9 Jun 2007 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757449AbXFIX1v
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 19:27:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57496 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757176AbXFIX1u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2007 19:27:50 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l59NRmsb014924;
	Sat, 9 Jun 2007 19:27:48 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l59NRmot021617;
	Sat, 9 Jun 2007 19:27:48 -0400
Received: from [127.0.0.1] (sebastian-int.corp.redhat.com [172.16.52.221])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l59NRjJ1027140;
	Sat, 9 Jun 2007 19:27:48 -0400
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <7v7iqdf0gn.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49639>

Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
>> Content-Type: TEXT/PLAIN; charset=3DISO-8859-1
>>
>> From: Kristian H=C3=83=C2=B8gsberg <krh@redhat.com>
>>
>> A more or less straight-forward port of git-tag.sh to C.
>>
>> Signed-off-by: Kristian H=C3=83=C2=B8gsberg <krh@redhat.com>
>> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>=20
> I think your name in your commit message is in UTF-8 but munged your
> mail was mismarked as iso-8859-1.

That's odd both the email I cc'ed to my redhat.com address and the one =
I got=20
on gmail.com through the list have

   Content-Type: text/plain; charset=3Dutf-8

and saving the raw message and asking /usr/bin/file, it tells me its

   /home/krh/Desktop/hep: UTF-8 Unicode mail text

>> +static int launch_editor(const char *path, const char *template,
>> +			  char *buffer, size_t size)
>> +{
>=20
> It would have been nicer to have this in editor.c or somesuch,
> as other commands will be redone in C in the future.
>=20
> We could do the moving later, but the problem is that later is
> conditional: "if we are lucky enough to remember that we already
> have this function in builtin-tag when doing so".

Yeah, true.  I did write it as a generally usable "launch editor" funct=
ions,=20
but I didn't want to move it until there was a second user.  Is there a=
nything=20
else that git-commit that will use this, btw?

>> +	fd =3D open(path, O_CREAT | O_TRUNC | O_WRONLY, 0644);
>=20
> I would understand an argument to use 0666 (honor umask) or 0600
> (this is a temporary file and others have no business looking at
> it while an edit is in progress), but I cannot justify 0644.

Oh hehe, yeah, I didn't think much about the permission bits... 0666 so=
unds fine.

>> +	fd =3D open(path, O_RDONLY, 0644);
>=20
> Open for reading with mode ;-)?

Even less thinking here :)

>> +	if (fd =3D=3D -1)
>> +		die("could not read %s.", path);
>> +	len =3D read_in_full(fd, buffer, size);
>> +	if (len < 0)
>> +		die("failed to read '%s', %m", path);
>> +	close(fd);
>> +
>> +	blank_lines =3D 1;
>> +	for (i =3D 0, j =3D 0; i < len; i++) {
>> ...
>> +	}
>> +
>> +	if (buffer[j - 1] !=3D '\n')
>> +		buffer[j++] =3D '\n';
>> +
>> +	unlink(path);
>> +
>> +	return j;
>> +}
>=20
> I really think this function needs to be refactored into three.
>=20
>  * A generic "spawn an editor with this initial seed template,
>    return the result of editing in memory and also give exit
>    status of the editor" function that does not take path
>    parameter (instead perhaps mkstemp a temporary file on your
>    own);
>=20
>  * A function that does what git-stripspace does in core;
>=20
>  * A function for builtin-tag to use, that calls the above two
>    and uses the result (e.g. "did the user kill the editor?
>    does the resulting buffer have any nonempty line?") to decide
>    what it does.

and that last function should be useful for git-commit too, no?  The re=
ason I=20
didn't split it up was that I don't see any use for the two parts on th=
eir=20
own, and the functions is a total of 70 lines.  And wouldn't returning =
0 bytes=20
for either an empty buffer or editor quit be sufficient?  Do we need to=
 handle=20
the two cases differently?

>> +static void create_tag(const unsigned char *object, const char *tag=
,
>> +		       const char *message, int sign, unsigned char *result)
>> +{
>> +	enum object_type type;
>> +	char buffer[4096];
>> +	int header, body, total;
>> +
>> +	type =3D sha1_object_info(object, NULL);
>> +	if (type <=3D 0)
>> +	    die("bad object type.");
>> +
>> +	header =3D snprintf(buffer, sizeof buffer,
>> +			  "object %s\n"
>> +			  "type %s\n"
>> +			  "tag %s\n"
>> +			  "tagger %s\n\n",
>> +			  sha1_to_hex(object),
>> +			  typename(type),
>> +			  tag,
>> +			  git_committer_info(1));
>> +
>> +	if (message =3D=3D NULL)
>> +		body =3D launch_editor(git_path("TAGMSG"), tag_template,
>> +				     buffer + header, sizeof buffer - header);
>> +	else
>> +		body =3D snprintf(buffer + header, sizeof buffer - header,
>> +				"%s\n", message);
>> +
>> +	if (body =3D=3D 0)
>> +		die("no tag message?");
>> +
>> +	if (header + body > sizeof buffer)
>> +		die("tag message too big.");
>=20
> Two issues:
>=20
>  * It used to be a tag had limit of 8kB which was lifted some
>    time ago; now it is limited to 4kB.  Fixing this implies that
>    the "launch editor and get results in core" function I
>    mentioned above may need to realloc, and probably the buffer
>    is better passed as (char *, ulong) pair as done everywhere
>    else (although we know this is text so you can pass only a
>    pointer and have the user run strlen() when needed).

Oh... read_pipe() reallocs... OK.  I took the limit from mktag.c and di=
dn't=20
realize that the buffer could get realloced.  I did wonder about the xm=
alloc()=20
for a fixed buffer though...

>  * I do not see any validation on the value of "tag".  Do we want
>    to allow passing "" to it?  What about "my\ntag"?

I do

         if (check_ref_format(ref))
                 die("'%s' is not a valid tag name.", tag);

on the ref, which is what git-tag.sh ends up doing, and it catches the =
two=20
examples you mention:

[krh@dinky git]$ ./git tag "hello
 > world"
fatal: 'hello
world' is not a valid tag name.
[krh@dinky git]$ ./git tag ""
fatal: '' is not a valid tag name.

so I think it's fine.

But I think I'll leave it to Carlos to finish his builtin-tag work, and=
 he can=20
cherry pick the bits from my patch that work for him.  This was more of=
 a=20
friday afternoon hacking sprint, for my part.

cheers,
Kristian
