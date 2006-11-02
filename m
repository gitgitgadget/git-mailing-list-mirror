X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 02 Nov 2006 13:52:33 +0000
Message-ID: <4549F821.9090600@shadowen.org>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org>	 <4549C083.9060805@xs4all.nl> <4549CA6B.4090909@shadowen.org>	 <4549CE2A.3010808@xs4all.nl>	 <8aa486160611020312v42047716t6a13e6fa16eeae8@mail.gmail.com>	 <4549D4B4.4030601@shadowen.org> <8aa486160611020439r255bcdb1q6e7ece46c77de11c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 2 Nov 2006 13:53:34 +0000 (UTC)
Cc: hanwen@xs4all.nl, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <8aa486160611020439r255bcdb1q6e7ece46c77de11c@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30750>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfd0Q-0007MW-LC for gcvg-git@gmane.org; Thu, 02 Nov
 2006 14:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752334AbWKBNxN convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006 08:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbWKBNxN
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 08:53:13 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4108 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1752334AbWKBNxM
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 08:53:12 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gfczf-0004Pw-PB; Thu, 02 Nov 2006 13:52:31 +0000
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
Sender: git-owner@vger.kernel.org

Santi B=E9jar wrote:
> On 11/2/06, Andy Whitcroft <apw@shadowen.org> wrote:
>> Santi B=E9jar wrote:
>> > One problem I see with this scheme (either 'g', 'git' of '+') is t=
hat
>> > it does not provide an increasing version number, even for
>> > fast-forwarding commits. Then it is not useful as a package versio=
n
>> > number (deb or rpm). I've already seen deb packages with
>> > version+git20061010. One possibility could be to add the number of
>> > commits between the tag and the commit as:
>> >
>> > v1.4.3.3-git12g1e1f76e
>> >
>> > to provide a weak ordering for fast-forwarding commits. What do yo=
u
>> thing?
>>
>> I think you'll restart the 1.2.3.4 versioning is better 'debate' aga=
in!
>=20
> Sorry, I don't undestand this.

There was a long running debate between sha1's and version 'numbers'
1.2.3.4 for each revision.
>=20
>> Surly if things are being pushed into a .deb or .rpm we should be us=
ing
>> a real release version.  We should be tagging that.  If the project =
is
>> not providing release number, there is nothing stopping you from tag=
ging
>> them yourself in your copy of the repository and using your tag.  yo=
u
>> could use like 'unofficial-N' where N increments in the way you want=
=2E
>=20
> And where do you store this tag? It is an upstream commit and you jus=
t
> refer to this. With the unofficial-N there is no way to know which
> upstream commit you are refering without having access to the git
> repository of the packager  .

Yes that is completly true, but its normally the packer who is doing th=
e
bug fixing of the .deb when its broken.  The key problem is you need
your numbering to be stable.  The only guarenteed stable thing is the
sha1, tags can change.  IMHO you should be including the full sha1 in
the --version output and the package descript, whatever versioning you
are using on the .deb itself.

That said I guess it would be pretty easy to come up with something to
count the number of commits since the last valid tag, something like
that below.  Might not be pretty, nor so easy to turn back into a commi=
t
of course.

-apw

#!/bin/sh

let n=3D0
git log --pretty=3Done "$@" | \
        awk '{print $1}' | \
        git name-rev --tags --stdin | \
{
        while read sha1 name
        do
                if [ "$name" !=3D "" ]; then
                        echo "$sha1 $name $n"
                        exit 0
                fi
                let "n=3Dn+1"
        done
        echo "- unknown 0"
        exit 1
