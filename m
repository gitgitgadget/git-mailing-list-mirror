From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minimum libCurl version for git
Date: Fri, 20 Mar 2009 14:44:16 -0700
Message-ID: <7vy6uzg98v.fsf@gitster.siamese.dyndns.org>
References: <e2b179460903201059j20e37c1cr7ccfa4b42e45c9d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>, Daniel Stenberg <daniel@haxx.se>,
	Nick Hengeveld <nickh@reactrix.com>,
	Mike Hommey <mh@glandium.org>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 22:46:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkmXO-0001Bq-Ld
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 22:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbZCTVo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 17:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753618AbZCTVo3
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 17:44:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbZCTVo2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 17:44:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7EBF6A3110;
	Fri, 20 Mar 2009 17:44:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 43CD5A310B; Fri,
 20 Mar 2009 17:44:17 -0400 (EDT)
In-Reply-To: <e2b179460903201059j20e37c1cr7ccfa4b42e45c9d9@mail.gmail.com>
 (Mike Ralphson's message of "Fri, 20 Mar 2009 17:59:08 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 48015560-1598-11DE-804B-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114006>

Mike Ralphson <mike.ralphson@gmail.com> writes:

> Going forward there are various options:
>
> 1. Do nothing - go with the status quo.
>
> 2. Correct the #ifdefs for CURLOPT_SSLKEY
>
> 3. Drop the #ifdefs for CURLOPT_SSLKEY entirely and make 7.9.3 our
> minimum supported version. I feel slightly embarrassed about that, as
> that's exactly the version I have here on AIX (unless I wrest it back
> from being sysadmin-installed to being user-supported). Add a check t=
o
> the Makefile and error if libCurl is too old.
>
> 4. Drop all current #ifdefs and one of the deprecated symbol names.
> Our minimum supported libCurl version would be 7.9.8 from Jun 2002.
>
> 5. Drop all current #ifdefs and both of the deprecated symbol names.
> Our minimum supported libCurl version would be 7.10.8 from Nov 2003.
>
> 6. Warn (not error) if libCurl is older than say the 3 years suggeste=
d
> by Daniel. This would seem to require periodic updates to the Makefil=
e
> check.
>
> I'm happy to whip up a patch if required, but I thought a series of
> mutually-exclusive alternative patches would be confusing without
> prior agreement on the approach.
>
> Mike
>
> [1]=C2=A0 http://cool.haxx.se/cvs.cgi/curl/docs/libcurl/symbols-in-ve=
rsions?rev=3DHEAD&content-type=3Dtext/vnd.viewcvs-markup

Thanks for a detailed analysis.

My gut feeling is we should be able to do 3 safely.

I am not sure if you are reading the "deprecated" column correctly,
though:

 Name                           Introduced  Deprecated  Removed
CURLINFO_HTTP_CODE              7.4.1         7.10.8
CURLOPT_INFILE                  7.1           7.9.7

These two symbols are what we do use in our code, so the
deprecated/removed column would give us the upper bound of the versions=
,
not the lower bound.

We can have these two macro definitions on our side

	#if curl older than 7.10.8
        #define CURLINFO_RESPONSE_CODE CURLINFO_HTTP_CODE
	#endif

	#if curl older than 7.9.7
        #define CURLOPT_READDATA CURLOPT_INFILE
	#endif

for backward compatibility, while writing our code to the recent API by
using CURLINFO_RESPONSE_CODE and CURLOPT_READDATA, and people with olde=
r
curl would not have to suffer a bit.

So I think your 4 and 5 are non issues.

But this is without having a handy tally of what releases of various
distros shipped their libcurl with.  If we had a table like this...

Distro			Last update		libcurl version
----------------------------------------------------------------
Debian 3.1 sarge	2005-06-06		???
Debian 4.0 etch		2009-02-10 (4.0r7)	7.15.5
Debian 5.0 lenny	2009-02-14		7.18.2

=2E.. then we could say "This is git, a tool primarily for developers t=
o
keep track of sources; nobody would be running on a box that was update=
d
the last time four years ago, so we can safely assume libcurl more rece=
nt
than version ???".

It would also be valid to argue that "4.0 etch may have been updated la=
st
month, but libcurl 7.15.5 has been available on the release a lot befor=
e
that, as of 200X-XX-XX, which is more than N years ago, which makes it
safe to assume that assuming 7.15.5 or later is fine for Debian folks; =
do
not get fooled by the date of last update," in which case it would be g=
ood
to have entry for the original release date.

=46or non-commercial Linux folks I think it should be Ok to assume not =
too
ancient libcurl, but I have no clue on how the table like the above wou=
ld
look like for things like AIX, IRIX, HPUX etc.  ... Oh, and SCO.
