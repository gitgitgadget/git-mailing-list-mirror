X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 08 Dec 2006 16:31:56 +0200
Message-ID: <4579775C.2010608@dawes.za.net>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net> <200612081438.25493.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 14:32:13 +0000 (UTC)
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <200612081438.25493.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33697>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsglh-0005oU-1B for gcvg-git@gmane.org; Fri, 08 Dec
 2006 15:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425521AbWLHOcB convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 09:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425525AbWLHOcB
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 09:32:01 -0500
Received: from sd-green-bigip-211.dreamhost.com ([208.97.132.211]:35251 "EHLO
 spunkymail-a11.dreamhost.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
 with ESMTP id S1425521AbWLHOcA (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8
 Dec 2006 09:32:00 -0500
Received: from [192.168.201.102] (dsl-146-24-82.telkomadsl.co.za
 [165.146.24.82]) by spunkymail-a11.dreamhost.com (Postfix) with ESMTP id
 C393BB6E16; Fri,  8 Dec 2006 06:31:55 -0800 (PST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Dnia pi=B1tek 8. grudnia 2006 13:57, Rogan Dawes napisa=B3:

>> How about extending gitweb to check to see if there already exists a=
=20
>> cached version of these pages, before recreating them?
>>
>> e.g. structure the temp dir in such a way that each project has a pl=
ace=20
>> for cached pages. Then, before performing expensive operations, chec=
k to=20
>> see if a file corresponding to the requested page already exists. If=
 it=20
>> does, simply return the contents of the file, otherwise go ahead and=
=20
>> create the page dynamically, and return it to the user. Do not creat=
e=20
>> cached pages in gitweb dynamically.
>=20
> This would add the need for directory for temporary files... well,
> it would be optional now...
>=20
It would still be optional. If the "cache" directory structure exists,=20
then use it, otherwise, continue as usual. All it would cost is a stat(=
)=20
or two, I guess.

>> Then, in a post-update hook, for each of the expensive pages, invoke=
=20
>> something like:
>>
>> # delete the cached copy of the file, to force gitweb to recreate it
>> rm -f $git_temp/$project/rss
>> # get gitweb to recreate the page appropriately
>> # use a tmp file to prevent gitweb from getting confused
>> wget -O $git_temp/$project/rss.tmp \
>>    http://kernel.org/gitweb.cgi?p=3D$project;a=3Drss
>> # move the tmp file into place
>> mv $git_temp/$project/rss.tmp $git_temp/$project/rss
>=20
> Good idea... although there are some page views which shouldn't chang=
e
> at all... well, with the possible exception of changes in gitweb outp=
ut,
> and even then there are some (blob_plain and snapshot views) which
> doesn't change at all.
>=20
> It would be good to avoid removing them on push, and only remove
> them using some tmpwatch-like removal.

Well, my theory was that we would only cache pages that change when new=
=20
data enters the repo. So, using the push as the trigger is almost=20
guaranteed to be the right thing to do. New data indicates new rss=20
items, indicates an updated shortlog page, etc.

NOTE: This caching could be problematic for the "changed 2 hours ago"=20
notation for various branches/files, etc. But however we implement the=20
caching, we'd have this problem.

>> This way, we get the exact output returned from the usual gitweb=20
>> invocation, but we can now cache the result, and only update it when=
=20
>> there is a new commit that would affect the page output.
>>
>> This would also not affect those who do not wish to use this mechani=
sm.=20
>> If the file does not exist, gitweb.cgi will simply revert to its usu=
al=20
>> behaviour.
>=20
> Good idea. Perhaps I should add it to gitweb TODO file.
>=20
> Hmmm... perhaps it is time for next "[RFC] gitweb wishlist and TODO l=
ist"
> thread?
> =20
>> Possible complications are the content-type headers, etc, but you co=
uld=20
>> use the -s flag to wget, and store the server headers as well in the=
=20
>> file, and get the necessary headers from the file as you stream it.
>>
>> i.e. read the headers looking for ones that are "interesting"=20
>> (Content-Type, charset, expires) until you get a blank line, print o=
ut=20
>> the interesting headers using $cgi->header(), then just dump the=20
>> remainder of the file to the caller via stdout.
>=20
> No need for that. $cgi->header() is to _generate_ the headers, so if
> a file is saved with headers, we can just dump it to STDOUT; the poss=
ible
> exception is a need to rewrite 'expires' header, if it is used.

Good point. I guess one thing that will be incorrect in the headers is=20
the server date, but I doubt that anyone cares much. As you say, though=
,=20
this might relate to the expiry of cached content in upstream caches.

>=20
> Perhaps gitweb should generate it's own ETag instead of messing with
> 'expires' header?

Well, we can possibly eliminate the expires header entirely for dynamic=
=20
pages, and check the If-Modified-Since value against the timestamp of=20
the cached file, or the server date in the cached file, and return "304=
=20
Not Modified" responses. That would also help to reduce the load on the=
=20
server, by only returning the headers, and not the entire response.

The downside is that it would prevent upstream proxies from caching thi=
s=20
data for us.

Regards,

