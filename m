From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Port git-tag.sh to C.
Date: Sat, 09 Jun 2007 11:26:48 -0700
Message-ID: <7v7iqdf0gn.fsf@assigned-by-dhcp.cox.net>
References: <11813427591137-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 20:26:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5eG-00059A-D2
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756489AbXFIS0v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 9 Jun 2007 14:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756681AbXFIS0v
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:26:51 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:35849 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbXFIS0u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2007 14:26:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070609182650.ZIGX25947.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 9 Jun 2007 14:26:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9WSp1X00N1kojtg0000000; Sat, 09 Jun 2007 14:26:50 -0400
In-Reply-To: <11813427591137-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Fri, 8 Jun 2007 18:45:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49601>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> Content-Type: TEXT/PLAIN; charset=3DISO-8859-1
>
> From: Kristian H=C3=83=C2=B8gsberg <krh@redhat.com>
>
> A more or less straight-forward port of git-tag.sh to C.
>
> Signed-off-by: Kristian H=C3=83=C2=B8gsberg <krh@redhat.com>
> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>

I think your name in your commit message is in UTF-8 but munged your
mail was mismarked as iso-8859-1.

> +static int launch_editor(const char *path, const char *template,
> +			  char *buffer, size_t size)
> +{

It would have been nicer to have this in editor.c or somesuch,
as other commands will be redone in C in the future.

We could do the moving later, but the problem is that later is
conditional: "if we are lucky enough to remember that we already
have this function in builtin-tag when doing so".

> +	fd =3D open(path, O_CREAT | O_TRUNC | O_WRONLY, 0644);

I would understand an argument to use 0666 (honor umask) or 0600
(this is a temporary file and others have no business looking at
it while an edit is in progress), but I cannot justify 0644.

> +	fd =3D open(path, O_RDONLY, 0644);

Open for reading with mode ;-)?

> +	if (fd =3D=3D -1)
> +		die("could not read %s.", path);
> +	len =3D read_in_full(fd, buffer, size);
> +	if (len < 0)
> +		die("failed to read '%s', %m", path);
> +	close(fd);
> +
> +	blank_lines =3D 1;
> +	for (i =3D 0, j =3D 0; i < len; i++) {
> ...
> +	}
> +
> +	if (buffer[j - 1] !=3D '\n')
> +		buffer[j++] =3D '\n';
> +
> +	unlink(path);
> +
> +	return j;
> +}

I really think this function needs to be refactored into three.

 * A generic "spawn an editor with this initial seed template,
   return the result of editing in memory and also give exit
   status of the editor" function that does not take path
   parameter (instead perhaps mkstemp a temporary file on your
   own);

 * A function that does what git-stripspace does in core;

 * A function for builtin-tag to use, that calls the above two
   and uses the result (e.g. "did the user kill the editor?
   does the resulting buffer have any nonempty line?") to decide
   what it does.

> +static void create_tag(const unsigned char *object, const char *tag,
> +		       const char *message, int sign, unsigned char *result)
> +{
> +	enum object_type type;
> +	char buffer[4096];
> +	int header, body, total;
> +
> +	type =3D sha1_object_info(object, NULL);
> +	if (type <=3D 0)
> +	    die("bad object type.");
> +
> +	header =3D snprintf(buffer, sizeof buffer,
> +			  "object %s\n"
> +			  "type %s\n"
> +			  "tag %s\n"
> +			  "tagger %s\n\n",
> +			  sha1_to_hex(object),
> +			  typename(type),
> +			  tag,
> +			  git_committer_info(1));
> +
> +	if (message =3D=3D NULL)
> +		body =3D launch_editor(git_path("TAGMSG"), tag_template,
> +				     buffer + header, sizeof buffer - header);
> +	else
> +		body =3D snprintf(buffer + header, sizeof buffer - header,
> +				"%s\n", message);
> +
> +	if (body =3D=3D 0)
> +		die("no tag message?");
> +
> +	if (header + body > sizeof buffer)
> +		die("tag message too big.");

Two issues:

 * It used to be a tag had limit of 8kB which was lifted some
   time ago; now it is limited to 4kB.  Fixing this implies that
   the "launch editor and get results in core" function I
   mentioned above may need to realloc, and probably the buffer
   is better passed as (char *, ulong) pair as done everywhere
   else (although we know this is text so you can pass only a
   pointer and have the user run strlen() when needed).

 * I do not see any validation on the value of "tag".  Do we want
   to allow passing "" to it?  What about "my\ntag"?
