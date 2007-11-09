From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] builtin-commit: Refresh cache after adding files.
Date: Fri, 09 Nov 2007 13:39:56 -0500
Message-ID: <1194633596.30909.18.camel@hinata.boston.redhat.com>
References: <1194626427-2419-1-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0711091702190.4362@racer.site>
	 <7vhcjvtgz5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:43:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYpA-0003yz-64
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbXKISnI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 13:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbXKISnH
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:43:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52937 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754746AbXKISnF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 13:43:05 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA9IeAwI003308;
	Fri, 9 Nov 2007 13:40:10 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA9Ie8N0002795;
	Fri, 9 Nov 2007 13:40:08 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA9Ie2OS004928;
	Fri, 9 Nov 2007 13:40:07 -0500
In-Reply-To: <7vhcjvtgz5.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64248>


On Fri, 2007-11-09 at 10:24 -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > On Fri, 9 Nov 2007, Kristian H=C3=B8gsberg wrote:
> >
> >> This fixes the race in the last test int t3700.
> >
> > Well, it is not a race.  My fault.  I thought it was.
> >
> > What you basically did was to make sure that the index is up-to-dat=
e after=20
> > adding the files.  You might even want to say that in the commit me=
ssage,=20
> > and only then say that it fixes t3700, too.
>=20
> Ah, it all makes sense.  I should have been more relaxed and
> careful when I first read your t3700 patch.
>=20
> If this were a breakage in racy-git-avoidance code, then
> refresh_cache() Kristian added (or "add --refresh" immediately
> after "git commit" in the test script) would have been fooled by
> the same raciness and wouldn't have changed a thing.
>=20
> This discussion exposes a problem with add_files_to_cache()
> function.
>=20
> Try this in a clean repository that tracks Makefile:
>=20
> 	$ git diff-files --name-only    ;# no output
>         $ touch Makefile
>         $ git diff-files --name-only
> 	Makefile
>         $ git add -u
>         $ git diff-files --name-only
> 	Makefile
>         $ git add Makefile
>         $ git diff-files --name-only    ;# no output
>=20
> I think this is a broken behaviour.  As long as we are adding
> the contents from a path on the filesystem to the corresponding
> location in the index, it should sync the stat bits for the
> entry in the index with the filesystem to make the entry
> stat-clean.  IOW, we should not see stat-dirtiness reported
> after "add -u".

Yup, that's what I expected, and why I couldn't quite understand why th=
e
refresh was necessary.

> The funny thing is that add_files_to_cache() run by "git add -u"
> calls add_file_to_cache() to add the updated contents for
> touched paths, but the latter function is used in the more
> explicit "git add Makefile" codepath, without any magic
> postprocessing after the function returns to sync the stat
> info.  IOW, both "add -u" and "add Makefile" ends up calling
> add_file_to_cache("Makefile") and I do not see why we are
> getting different results.

There is some timing involved in this, which may explain the different
results you see.  On my laptop I can trigger the add_files_to_cache()
problem roughly 4 out of 5 times, but on my faster desktop, it can't
trigger it.

> And add_file_to_cache(), which calls add_file_to_index() on
> the_index, does call the fill_stat_cache_info() to sync the stat
> information by itself, as it should be.  I am still puzzled with
> this.
>=20
> So I think Kristian's two refresh_cache() do fix the issue, but
> at the same time I _think_ it is a workaround for broken
> add_files_to_cache() behaviour, which is what we should fix.

OK, I'll resend the patch with a better description, and add a refresh
call for the user index too, for the git commit <file> case.

cheers,
Kristian
