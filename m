From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] cache_tree_find(): remove redundant checks
Date: Tue, 04 Mar 2014 10:40:02 +0100
Message-ID: <87ppm2i9ot.fsf@fencepost.gnu.org>
References: <1393921868-4382-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 04 10:40:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKlpd-0005N7-JY
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 10:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608AbaCDJkG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2014 04:40:06 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:43848 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbaCDJkE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 04:40:04 -0500
Received: from localhost ([127.0.0.1]:42890 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WKlpT-0000Dw-56; Tue, 04 Mar 2014 04:40:03 -0500
Received: by lola (Postfix, from userid 1000)
	id AE72ADF3DC; Tue,  4 Mar 2014 10:40:02 +0100 (CET)
In-Reply-To: <1393921868-4382-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 4 Mar 2014 09:31:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243334>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The beginning of the loop ensures that slash can never be NULL.  So
> don't keep checking whether it is NULL later in the loop.
>
> Furthermore, there is no need for an early
>
>     return it;
>
> from the loop if slash points at the end of the string, because that
> is exactly what will happen when the while condition fails at the
> start of the next iteration.

Hm.  Another suggestion.  You have

		const char *slash =3D strchr(path, '/');
 		if (!slash)
 			slash =3D path + strlen(path);
[...]
		sub =3D find_subtree(it, path, slash - path, 0);
[...]
		path =3D slash;
		while (*path =3D=3D '/')
			path++;
	}

At the price of introducing another variable, this could be

		const char *slash =3D strchr(path, '/');
 		size_t len =3D slash ? slash - path : strlen(path);
[...]
		sub =3D find_subtree(it, path, len, 0);
[...]
                if (!slash)
			break;
		for (path =3D slash; *path =3D=3D '/';)
			path++;
	}

This introduces another variable and another condition.  The advantage
is that "slash" indeed points at a slash or is NULL, so the variable
names correspond better to what happens.  Alternatively, it might make
sense to rename "slash" into "end" or "endpart" or whatever.  Since
I=A0can't think of a pretty name, I lean towards preferring the latter
version as it reads nicer.  I prefer code to read like children's books
rather than mystery novels.

--=20
David Kastrup
