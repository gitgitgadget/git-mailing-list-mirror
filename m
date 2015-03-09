From: "Gondek, Andreas" <Andreas.Gondek@dwpbank.de>
Subject: AW: Git merge driver / attributes bug in 2.3.1?
Date: Mon, 9 Mar 2015 09:02:31 +0000
Message-ID: <D8780C527EB1E642B3150E6D705B46D448E8063B@DWPWHMS531.dwpbank.local>
References: <D8780C527EB1E642B3150E6D705B46D448E7E48C@DWPWHMS531.dwpbank.local>
	<54F98EBE.8080903@drmicha.warpmail.net>
	<D8780C527EB1E642B3150E6D705B46D448E8058B@DWPWHMS531.dwpbank.local>
	<54F9B5C0.9050604@drmicha.warpmail.net>
 <xmqqlhj9yftb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 09 10:02:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUtaD-00041p-SU
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 10:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbbCIJCg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 05:02:36 -0400
Received: from mail2.dwpbank.de ([145.253.155.115]:58634 "EHLO
	mail2.dwpbank.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbbCIJCf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2015 05:02:35 -0400
X-IronPort-AV: E=Sophos;i="5.11,366,1422918000"; 
   d="scan'208";a="16374678"
Received: from DWPWHMS531.dwpbank.local ([169.254.2.62]) by
 DWPFRMS531.dwpbank.local ([169.254.4.207]) with mapi id 14.03.0195.001; Mon,
 9 Mar 2015 10:02:32 +0100
Thread-Topic: Git merge driver / attributes bug in 2.3.1?
Thread-Index: AQHQWFTBxxr16gR1Rkq4toiUl+/Nop0T2yKg
In-Reply-To: <xmqqlhj9yftb.fsf@gitster.dls.corp.google.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.101.236.155]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265137>

We used a merge driver to create a conflict semaphore file whenever a m=
erge conflict occurs in Atlassian Stash. This worked for several month =
until we got to update our Git version because of another problem.

If I understand it correctly, a merge driver is executed before the nor=
mal internal merge happens? So I would need to call a git merge-file in=
 my merge driver, test the result and return the exit code of the git m=
erge-file?

Greetings

Andreas Gondek
Applications
________________________________

Deutsche WertpapierService Bank AG
ITTAS
Derendorfer Allee 2
40476 D=FCsseldorf
Tel.: +49 69 5099 9503
=46ax: +49 69 5099 85 9503
E-Mail: Andreas.Gondek@dwpbank.de
http://www.dwpbank.de

Deutsche WertpapierService Bank AG | Wildunger Stra=DFe 14 | 60487 Fran=
kfurt am Main=20
Sitz der AG: Frankfurt am Main, HRB 56913 | USt.-ID: DE 813759005=20
Vorstand: Thomas Klanten, Dr. Christian Tonnesen
Aufsichtsrat: Wilfried Groos (Vors.)

-----Urspr=FCngliche Nachricht-----
Von: Junio C Hamano [mailto:gitster@pobox.com]=20
Gesendet: Freitag, 6. M=E4rz 2015 22:30
An: Michael J Gruber
Cc: Gondek, Andreas; git@vger.kernel.org
Betreff: Re: Git merge driver / attributes bug in 2.3.1?

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Gondek, Andreas venit, vidit, dixit 06.03.2015 14:31:
>> The archive contains my test repository, the merge driver and the
> .gitconfig of the user. We don't have a global .gitconfig.
>
> Thanks for the test repo!
>
> Alas, the merge driver gets executed with v1.9.0-rc3, v1.8.5 and=20
> v1.7.0, at least over here - as it should be because of the conflict:=
=20
> two patches changing the same file. That conflict can be resolved=20
> automatically by the internal driver, of course.

That matches my expectation.  The whole point to have the merge driver =
plug-in mechanism is to allow overriding the internal textual 3-way fil=
e-level merge, so we would have always called out to the custom driver =
when the tree-level merge machinery says that the content needs a file-=
level merge [*1*].


[Footnote]

*1* This is a tangent, but I've been wondering if we want some cases wh=
ere the tree-level merge machinery currently says that there is no need=
 for file-level merge to be fed to the merge driver.

Specifically, the tree-level merge machinery considers a case where you=
 and the other party changed the files identically to be cleanly merged=
, but for contents of certain nature, that may not be always desirable.

Imagine that I and my wife are sharing a note to record what is in our =
refrigerator.  After I buy a carton of milk, I'd do

    $ echo "1 carton of milk" >>fridge.txt
    $ git commit && git push

and my wife would do the same.

    $ echo "1 carton of milk" >>fridge.txt
    $ git commit && git push

which would not fast-forward, and then she would

    $ git pull

which would result in only one carton of milk in our fridge, even thoug=
h when both of us got home, we will realize that we now have two of the=
m.
