From: Kyle Moffett <mrlinuxman@mac.com>
Subject: Re: Git string manipulation functions wrong?
Date: Tue, 22 May 2007 23:22:35 -0400
Message-ID: <20070522232235.1cecb880.mrlinuxman@mac.com>
References: <20070521131103.GN8200@gateway.home>
	<20070521143616.GG4489@pasky.or.cz>
	<20070521145925.GA6474@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, Erik Mouw <mouw@nl.linux.org>,
	git@vger.kernel.org
To: Karl =?ISO-8859-1?B?SGFzc2Vsc3Ry9m0=?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed May 23 05:39:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqhge-0001NO-2w
	for gcvg-git@gmane.org; Wed, 23 May 2007 05:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbXEWDiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 May 2007 23:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755494AbXEWDiu
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 23:38:50 -0400
Received: from smtpout.mac.com ([17.250.248.185]:64316 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754200AbXEWDit convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2007 23:38:49 -0400
X-Greylist: delayed 936 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 May 2007 23:38:49 EDT
Received: from mac.com (smtpin05-en2 [10.13.10.150])
	by smtpout.mac.com (Xserve/smtpout15/MantshX 4.0) with ESMTP id l4N3MxY7007972;
	Tue, 22 May 2007 20:22:59 -0700 (PDT)
Received: from hephaestus.moffetthome.net (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin05/MantshX 4.0) with ESMTP id l4N3MuTg008797
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 May 2007 20:22:57 -0700 (PDT)
In-Reply-To: <20070521145925.GA6474@diana.vm.bytemark.co.uk>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; powerpc-unknown-linux-gnu)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48139>

On Mon, 21 May 2007 16:59:25 +0200 Karl Hasselstr=F6m <kha@treskal.com>=
 wrote:
> On 2007-05-21 16:36:16 +0200, Petr Baudis wrote:
> > It's the opposite for me - we don't properly set the NUL byte for
> > smoe of our strncpy() calls, but I don't really see his problem wit=
h
> > snprintf(), we seem to handle its return value correctly everywhere
> > (except diff.c, but there the buffer sizes should be designed in
> > such a way that an overflow should be impossible).
>=20
> I think this kind of detailed case-by-case analysis defeats Timo's
> point, though: that the C library functions make it too easy to write
> bugs. If it's necessary to do non-trivial bounds checking etc. at
> every call site, it doesn't really matter if we currently do get them
> all right; at some point, we _are_ going to miss one. Instead of usin=
g
> our collective C-fu to get difficult calls right, we should be using
> it to construct string routines that have low enough overhead that
> it's lost in the noise, and are dead simple to use (and, of course,
> that can be cleanly bypassed in the 1% of cases where it's necessary)=
=2E

That would be mostly true, except for the fact that without snprintf()
returning how many bytes _would_ have been written, it's much harder to
reliably allocate buffers for the result on the first pass.  For
example, this is a trivial implementation of an function which returns
a freshly-allocated formatted string:

	char *data;
	unsigned long len;
	len =3D snprintf(NULL, 0, some_fmt, arg1, arg2, arg3);
	if (!len)
		return NULL;
	data =3D malloc(len+1);
	if (!data)
		return NULL;
	data[len] =3D '\0';
	snprintf(data, len, some_fmt, arg1, arg2, arg3);
	return data;

You can't do that without a loop if it returns how many bytes were
actually written (although some braindead platforms do that already).
Here's a function which handles both use-cases in an optimal way:

	char *data =3D NULL;
	unsigned long datalen =3D 0, len;
	do {
		len =3D snprintf(data, datalen, some_fmt, arg1, arg2, arg3);
		if (!datalen) {
			datalen =3D len ? len : 16;
			data =3D malloc(datalen);
			if (!data)
				return NULL;
		} else if (len >=3D datalen) {
			void *newmem;
			datalen =3D (len > datalen)?(len + 1):(datalen +16);
			newmem =3D realloc(data, datalen);
			if (!newmem) {
				free(data);
				return NULL
			}
		}
	} while (len >=3D datalen);
	data[len] =3D '\0';
	return data;

Hopefully, on a nice modern platform, the first iteration will have len
equal to the ideal actual required length and so it will hit the first
case and carefully allocate exactly enough bytes, then on the second
loop through it will fill in exactly the required bytes and return
success.  On one of the abovementioned dain-bramaged systems, this will
loop until snprintf doesn't use all the space in the buffer,
incrementing by some fixed value each time (in this implementation,
16).  It should be obvious that correctly-implemented systems will be
significantly more performant than ones without the useful "feature" of
POSIX-compliance. :-D

Cheers,
Kyle Moffett
