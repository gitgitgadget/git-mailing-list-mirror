From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [BUG] t9101 (master) busted on Leopard
Date: Fri, 16 Nov 2007 13:48:50 +0100
Message-ID: <20071116124850.GA14473@atjola.homenet>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com> <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com> <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com> <1D7CC3C0-46C1-40D9-AAD5-B9ADFF99B58A@lrde.epita.fr> <73246E38-9C22-4279-A53E-678434238E5C@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>,
	=?iso-8859-1?B?VuRpbvYgSuRydmVs5A==?= <v@pp.inet.fi>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 13:49:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It0dG-0004kB-OK
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 13:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbXKPMs6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 07:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbXKPMs6
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 07:48:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:43201 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751951AbXKPMs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 07:48:57 -0500
Received: (qmail invoked by alias); 16 Nov 2007 12:48:56 -0000
Received: from i577B9BAC.versanet.de (EHLO localhost) [87.123.155.172]
  by mail.gmx.net (mp004) with SMTP; 16 Nov 2007 13:48:56 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19n19A+905nY4aQ/McyxSIM1WVVC7ovSriHRf2y6K
	iq0+9Jmsa2P0fu
Content-Disposition: inline
In-Reply-To: <73246E38-9C22-4279-A53E-678434238E5C@wincent.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65220>

On 2007.11.16 12:00:02 +0100, Wincent Colaiuta wrote:
> El 15/11/2007, a las 22:13, Benoit Sigoure escribi=F3:
>> Hi Wincent,
>> Can you reproduce this deterministically?  If yes, can you re-run th=
e test=20
>> with the --verbose flag and post the gzipped output (or send it to m=
e if=20
>> the list doesn't like this sort of attachment).
>
> Inspecting the output of --verbose has allowed me to the point where =
things=20
> are failing; look at the very first test in t9101-git-svn-props.sh an=
d=20
> witness the following:
>
> - before the test we are at revision 1
> - there are 3 "svn commits" in the test
> - but it looks like only 2 of the commits proceed
> - so the revision number goes up to 2 then 3, when it should be 4
> - as a result, in one of the later tests we fail because the test exp=
ects=20
> revision 8 but we only have revision 7
>
> Checked out revision 1.
> *   ok 1: checkout working copy from svn
>
> * expecting success: cd test_wc &&
> 		echo Greetings >> kw.c &&
> 		poke kw.c &&
> 		svn commit -m "Not yet an Id" &&
> 		echo Hello world >> kw.c &&
> 		poke kw.c &&
> 		svn commit -m "Modified file, but still not yet an Id" &&
> 		svn propset svn:keywords Id kw.c &&
> 		poke kw.c &&
> 		svn commit -m "Propset Id" &&
> 	cd ..
> Sending        kw.c
> Transmitting file data .
> Committed revision 2.
> Sending        kw.c
> Transmitting file data .
> Committed revision 3.
> property 'svn:keywords' set on 'kw.c'
> *   ok 2: setup some commits to svn
>
> That last commit is a no-op because, for some reason, the svn propset=
=20
> before it is also a no-op:
>
> svn propset svn:keywords Id kw.c
>
> In other words, it echos "property 'svn:keyword' set on 'kw.c'" but i=
f I=20
> insert an "svn status" as the next command then I get no output at al=
l. If=20
> I run the exact same commands manually from the terminal then they wo=
rk=20
> (ie. it is not a no-op and "svn status" shows that the file is modifi=
ed).
>
> Actually, it's not really a no-op, because if I insert an "svn propli=
st -v=20
> kw.c" I get:
>
> Properties on 'kw.c':
>   svn:keywords : Id

It _is_ a no-op. At least here. Because I got an auto-props setting in
my ~/.subversion/config to automatically add Id for *.c files. So that
property was already there before we explicitly ask for it and the
propset turns into a no-op. If I remove that line from the subversion
configuration, the test succeeds. Same for you I guess.

That said, I had a quick glance over the subversion CLI help, but it
didn't tell me how to ignore/override ~/.subversion/config. Anyone less
clueless than me around, having a smart idea how to work around that
"bug"?

Bj=F6rn
