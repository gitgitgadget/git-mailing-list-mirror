From: Mike Hommey <mh@glandium.org>
Subject: Re: Minimum libCurl version for git
Date: Fri, 20 Mar 2009 23:13:58 +0100
Message-ID: <20090320221358.GA24390@glandium.org>
References: <e2b179460903201059j20e37c1cr7ccfa4b42e45c9d9@mail.gmail.com> <7vy6uzg98v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	git list <git@vger.kernel.org>,
	Daniel Stenberg <daniel@haxx.se>,
	Nick Hengeveld <nickh@reactrix.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 23:15:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkn01-00028V-6w
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 23:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbZCTWOF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 18:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbZCTWOD
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 18:14:03 -0400
Received: from vuizook.err.no ([85.19.221.46]:55131 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060AbZCTWOB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 18:14:01 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LkmyI-0001J5-B6; Fri, 20 Mar 2009 23:13:49 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LkmyU-0005Il-BR; Fri, 20 Mar 2009 23:13:58 +0100
Content-Disposition: inline
In-Reply-To: <7vy6uzg98v.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114009>

On Fri, Mar 20, 2009 at 02:44:16PM -0700, Junio C Hamano wrote:
> Mike Ralphson <mike.ralphson@gmail.com> writes:
>=20
> > Going forward there are various options:
> >
> > 1. Do nothing - go with the status quo.
> >
> > 2. Correct the #ifdefs for CURLOPT_SSLKEY
> >
> > 3. Drop the #ifdefs for CURLOPT_SSLKEY entirely and make 7.9.3 our
> > minimum supported version. I feel slightly embarrassed about that, =
as
> > that's exactly the version I have here on AIX (unless I wrest it ba=
ck
> > from being sysadmin-installed to being user-supported). Add a check=
 to
> > the Makefile and error if libCurl is too old.
> >
> > 4. Drop all current #ifdefs and one of the deprecated symbol names.
> > Our minimum supported libCurl version would be 7.9.8 from Jun 2002.
> >
> > 5. Drop all current #ifdefs and both of the deprecated symbol names=
=2E
> > Our minimum supported libCurl version would be 7.10.8 from Nov 2003=
=2E
> >
> > 6. Warn (not error) if libCurl is older than say the 3 years sugges=
ted
> > by Daniel. This would seem to require periodic updates to the Makef=
ile
> > check.
> >
> > I'm happy to whip up a patch if required, but I thought a series of
> > mutually-exclusive alternative patches would be confusing without
> > prior agreement on the approach.
> >
> > Mike
> >
> > [1]=A0 http://cool.haxx.se/cvs.cgi/curl/docs/libcurl/symbols-in-ver=
sions?rev=3DHEAD&content-type=3Dtext/vnd.viewcvs-markup
>=20
> Thanks for a detailed analysis.
>=20
> My gut feeling is we should be able to do 3 safely.
>=20
> I am not sure if you are reading the "deprecated" column correctly,
> though:
>=20
>  Name                           Introduced  Deprecated  Removed
> CURLINFO_HTTP_CODE              7.4.1         7.10.8
> CURLOPT_INFILE                  7.1           7.9.7
>=20
> These two symbols are what we do use in our code, so the
> deprecated/removed column would give us the upper bound of the versio=
ns,
> not the lower bound.
>=20
> We can have these two macro definitions on our side
>=20
> 	#if curl older than 7.10.8
>         #define CURLINFO_RESPONSE_CODE CURLINFO_HTTP_CODE
> 	#endif
>=20
> 	#if curl older than 7.9.7
>         #define CURLOPT_READDATA CURLOPT_INFILE
> 	#endif
>=20
> for backward compatibility, while writing our code to the recent API =
by
> using CURLINFO_RESPONSE_CODE and CURLOPT_READDATA, and people with ol=
der
> curl would not have to suffer a bit.
>=20
> So I think your 4 and 5 are non issues.
>=20
> But this is without having a handy tally of what releases of various
> distros shipped their libcurl with.  If we had a table like this...
>=20
> Distro			Last update		libcurl version
> ----------------------------------------------------------------
> Debian 3.1 sarge	2005-06-06		???
> Debian 4.0 etch		2009-02-10 (4.0r7)	7.15.5
> Debian 5.0 lenny	2009-02-14		7.18.2
>=20
> ... then we could say "This is git, a tool primarily for developers t=
o
> keep track of sources; nobody would be running on a box that was upda=
ted
> the last time four years ago, so we can safely assume libcurl more re=
cent
> than version ???".
>=20
> It would also be valid to argue that "4.0 etch may have been updated =
last
> month, but libcurl 7.15.5 has been available on the release a lot bef=
ore
> that, as of 200X-XX-XX, which is more than N years ago, which makes i=
t
> safe to assume that assuming 7.15.5 or later is fine for Debian folks=
; do
> not get fooled by the date of last update," in which case it would be=
 good
> to have entry for the original release date.

Original release date for etch is 2007-04-08.
Sarge was released with libcurl 7.13.2.
Woody, which was Debian 3.0, and can be considered dead already, was
released on 2002-07-19 with libcurl 7.9.5.

Mike
