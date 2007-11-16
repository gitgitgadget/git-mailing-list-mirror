From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [BUG] t9101 (master) busted on Leopard
Date: Fri, 16 Nov 2007 12:00:02 +0100
Message-ID: <73246E38-9C22-4279-A53E-678434238E5C@wincent.com>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com> <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com> <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com> <1D7CC3C0-46C1-40D9-AAD5-B9ADFF99B58A@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Fri Nov 16 12:00:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isyw0-0004Pt-S2
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 12:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250AbXKPLAM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 06:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754591AbXKPLAL
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 06:00:11 -0500
Received: from wincent.com ([72.3.236.74]:41685 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939AbXKPLAJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2007 06:00:09 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAGB03PQ017200;
	Fri, 16 Nov 2007 05:00:04 -0600
In-Reply-To: <1D7CC3C0-46C1-40D9-AAD5-B9ADFF99B58A@lrde.epita.fr>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65215>

El 15/11/2007, a las 22:13, Benoit Sigoure escribi=F3:

> On Nov 15, 2007, at 5:11 PM, Wincent Colaiuta wrote:
>
>> El 15/11/2007, a las 17:04, Brian Gernhardt escribi=F3:
>>
>>> On Nov 15, 2007, at 8:46 AM, Wincent Colaiuta wrote:
>>>
>>>> Was just running the test suite against the master branch and saw =
=20
>>>> that t9101 is currently failing on Leopard, and a review with git-=
=20
>>>> bisect indicates that it has been ever since it was first =20
>>>> introduced (in commit 15153451). Not sure if this problem is =20
>>>> Leopard-specific or not as I only have one machine.
>>>
>>> It is not a Leopard specific problem, as far as I can tell.  I =20
>>> just ran the test and had no errors on my Leopard machine.  So =20
>>> perhaps it's some other detail of your setup?
>>>
>>>> I'm not a git-svn user myself, but if there's anything I can do =20
>>>> to help diagnose this problem further on Leopard please let me =20
>>>> know.
>>>
>>> I just tested it using svn from fink and (after discovering it =20
>>> exists) from Leopard.  No problems.  Do you have an old svn =20
>>> package (client, admin, or perl binding) installed from Darwin =20
>>> Ports or Fink perhaps?
>>
>> I don't use Darwin Ports or Fink, and this is a clean Leopard =20
>> install (ie. nothing installed in /usr/local apart from git and a =20
>> very small number of other tools that aren't related to Subversion).
>>
>> This is the output of "/usr/bin/svn --version":
>>
>> svn, version 1.4.4 (r25188)
>>   compiled Sep 23 2007, 22:32:34
>>
>> Perhaps then it is something in the environment.
>
> Hi Wincent,
> Can you reproduce this deterministically?  If yes, can you re-run =20
> the test with the --verbose flag and post the gzipped output (or =20
> send it to me if the list doesn't like this sort of attachment).

Inspecting the output of --verbose has allowed me to the point where =20
things are failing; look at the very first test in t9101-git-svn-=20
props.sh and witness the following:

- before the test we are at revision 1
- there are 3 "svn commits" in the test
- but it looks like only 2 of the commits proceed
- so the revision number goes up to 2 then 3, when it should be 4
- as a result, in one of the later tests we fail because the test =20
expects revision 8 but we only have revision 7

Checked out revision 1.
*   ok 1: checkout working copy from svn

* expecting success: cd test_wc &&
		echo Greetings >> kw.c &&
		poke kw.c &&
		svn commit -m "Not yet an Id" &&
		echo Hello world >> kw.c &&
		poke kw.c &&
		svn commit -m "Modified file, but still not yet an Id" &&
		svn propset svn:keywords Id kw.c &&
		poke kw.c &&
		svn commit -m "Propset Id" &&
	cd ..
Sending        kw.c
Transmitting file data .
Committed revision 2.
Sending        kw.c
Transmitting file data .
Committed revision 3.
property 'svn:keywords' set on 'kw.c'
*   ok 2: setup some commits to svn

That last commit is a no-op because, for some reason, the svn propset =20
before it is also a no-op:

svn propset svn:keywords Id kw.c

In other words, it echos "property 'svn:keyword' set on 'kw.c'" but if =
=20
I insert an "svn status" as the next command then I get no output at =20
all. If I run the exact same commands manually from the terminal then =20
they work (ie. it is not a no-op and "svn status" shows that the file =20
is modified).

Actually, it's not really a no-op, because if I insert an "svn =20
proplist -v kw.c" I get:

Properties on 'kw.c':
   svn:keywords : Id

So the property is being set, it's just that "svn commit" and "svn =20
status" don't recognize the file as being modified. The "poke" in the =20
test has no effect (file still shows up as unmodified) and only =20
modifying the actual content (ie. appending to it by inserting another =
=20
"echo" statement) is enough to make that commit actually happen.

So now we know a bit more about *what* is happening, but I still don't =
=20
know *why*. I'd start to suspect some kind of weird filesystem issue =20
if it weren't for the fact that these same commands work when executed =
=20
by hand outside of the test script.

Cheers,
Wincent
