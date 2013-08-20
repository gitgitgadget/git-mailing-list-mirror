From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] mailmap: fix check for freeing memory
Date: Tue, 20 Aug 2013 16:17:07 +0200
Message-ID: <52137A63.3010609@googlemail.com>
References: <1377004958-14489-1-git-send-email-stefanbeller@googlemail.com> <878uzw7a6l.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE68D27DC1AC377474F51B53C"
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 20 16:17:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBmkO-0000nO-3x
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 16:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab3HTORO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 10:17:14 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:45688 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab3HTORL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 10:17:11 -0400
Received: by mail-ea0-f174.google.com with SMTP id z15so251705ead.19
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=1UwGgFh7KBJtm6KncfGbeGEe55zNwqdqWyYwmwlOYmE=;
        b=Q1iDPrMMbVOgPnGC4NMGHqjnFeNA473jcuwDXLFOywt0COrV2zxbHkTjfN2F1l+89Y
         NTXz/MgeLQ409DzfO7h6+3bYUVS6rl5XOLuxi4ZYuVYleSrz6ikpERcncmEG+Tf1QNwV
         5ADbArp+TuEO0OLXQotEE24FYxNnexMVK4vq8ptdkIc5mCRumWLmjz5FjKroZudXZojn
         yl3srm/cUx9X8FvaA8KQA53okLgMbGYcWJeANE9rNz1eIFsgp131wO6Yn7wznu0qXMXi
         cP2Gnj+ViL1pYppXBqVzr3YufAwBw9RnJCTIHwSo2xqGyUVd9tkFvr6aGpzt8aPGz5x+
         gXlQ==
X-Received: by 10.14.210.8 with SMTP id t8mr2664072eeo.39.1377008229868;
        Tue, 20 Aug 2013 07:17:09 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id l47sm2688435eex.15.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 07:17:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <878uzw7a6l.fsf@linux-k42r.v.cablecom.net>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232600>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE68D27DC1AC377474F51B53C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/20/2013 03:40 PM, Thomas Rast wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>> The condition as it is written in that line was most likely intended t=
o
>> check for the pointer passed to free(), rather than checking for the
>> 'repo_abbrev', which is already checked against being non null at the
>> beginning of the function.
> [...]
>> -			if (repo_abbrev)
>> +			if (*repo_abbrev)
>>  				free(*repo_abbrev);
>=20
> But now the test is useless, because free(NULL) is defined to be a
> no-op.
>=20

Yes, indeed. Thanks for reviewing.

Stepping two steps back, I am trying to figure out, what this repo_abrev
thing is doing, as I could find no documentation.

It's passed as a double pointer as declared in mailmap.h:
int read_mailmap(struct string_list *map, char **repo_abbrev);

However grepping for "read_mailmap(" (bracket to prevent finding=20
read_mailmap_XXX as often used in mailmap.c itself)=20
	grep -nHIirF --exclude-dir=3D.git -- "read_mailmap("
throughout all the sources I just find one occurence having the
second argument not being 'NULL' and that is in=20
	builtin/shortlog.c:212:	read_mailmap(&log->mailmap, &log->common_repo_pr=
efix);

which turns out to be:

void shortlog_init(struct shortlog *log)
{
	memset(log, 0, sizeof(*log));

	read_mailmap(&log->mailmap, &log->common_repo_prefix);
	...

So we're passing there an address, which was just set to zero.
This is the only occurence of passing a value at all and the value
being passed is 0, so the free in the original patch doesn't need=20
that check either.

As I am resending the patch, could somebody please explain me
the mechanism of the "# repo-abbrev:" line? Even git itself doesn't
use it in the .mailmap file, but a quick google search shows up only
kernel repositories.

Stefan



--------------enigE68D27DC1AC377474F51B53C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSE3pkAAoJEJQCPTzLflhqQ2UQAL2+vrgdN1Kr2unj/jjeZMRV
uX9ODD1nX5UJKWbM74FyY0Zu+rsoEa7/r9QQts4CbWu64Ra8atQx75LVJ9bsXF6c
5QZaoLV/Z9M/NOnKSVttBdf4hJgCkuasZOMogiHA2QdByudvYMIEUsYZp0KKKbOa
wZKRif4vGqWxjsFr7M/ZLXjwj4jvI5j8umh7TFyPHtVN5zWk19OOPiCLwJC2mR2U
ogRcNXR9yZMsMa+L9gChcUoNEyblYn8NibkGvYGiA/ALoVEOFWCtQ8klMVBhk1WZ
5E8IEP2PxaZRjiEhMPuyCUndhTUwO0AvqFPZQcTy38E/Pc/R18MjPbk2xC2dmpEa
vfF/z1bXCCCHiHfzTxVjU1BSJGHrpeOXoPHYpd1RE3O/Hm5LMloq36cc2EPjR7kz
S6oxJHN8UwlRkUKj0He9X2lAEZNlgsCPitOFW7hM0lBkXiIBUG26eOoOgsJxJiFt
/B4MZaNLToyXSpYm2THJlIBoGALdGa3R9bIouD6g72fFAohj+O5poPzv5MTg8mct
Z3iyt/dCXgxYztHFI+oBI7H+KzW7CHHxgNb1ZcR42JexmHvP9HVzEI3HrMmXfSgI
aLOjuz6KK0aW0tjsQFyuJHO+5+vSoCq2FJh9UNO7R48j3OGBbaeCvGCZeDRvnBog
aEgQpfLy5W94nGlSHv3Y
=7x40
-----END PGP SIGNATURE-----

--------------enigE68D27DC1AC377474F51B53C--
