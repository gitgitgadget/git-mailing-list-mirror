From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Performance issue with excludes (was: Re: git-svn and submodules)
Date: Mon, 15 Oct 2007 18:17:36 +0200
Message-ID: <C7EA8AD7-BACA-4116-9C6B-90BA23F0005C@lrde.epita.fr>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp> <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma> <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled> <Pine.LNX.4.64.0710142359020.25221@racer.site> <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr> <alpine.LFD.0.999.0710150848380.6887@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4--590508339"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 19:07:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhSeB-0003DJ-LB
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 18:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759152AbXJOQSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 12:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757828AbXJOQSR
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 12:18:17 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:48069 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758226AbXJOQSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 12:18:16 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IhSdw-00040O-ED; Mon, 15 Oct 2007 18:18:12 +0200
In-Reply-To: <alpine.LFD.0.999.0710150848380.6887@woody.linux-foundation.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61012>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-4--590508339
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 15, 2007, at 5:53 PM, Linus Torvalds wrote:

> On Mon, 15 Oct 2007, Benoit SIGOURE wrote:
>>
>>  - git svn create-ignore (to create one .gitignore per directory  
>> from the
>> svn:ignore properties.  This has the disadvantage of committing  
>> the .gitignore
>> during the next dcommit, but when you import a repo with tons of  
>> ignores
>> (>1000), using git svn show-ignore to build .git/info/exclude is  
>> *not* a good
>> idea, because things like git-status will end up doing >1000  
>> fnmatch *per
>> file* in the repo, which leads to git-status taking more than 4s  
>> on my
>> Core2Duo 2Ghz 2G RAM)
>
> Ouch.
>
> That sounds largely unavoidable.. *But*.
>
> Maybe we have a bug here. In particular, we generally shouldn't  
> care about
> the exclude/.gitignore file for ay paths that we know about, which  
> means
> that during an import, we really shouldn't ever even care about
> .gitignore, since all the files are files we are expected to know  
> about.
>
> So yes, in general, "git status" is going to be slow in a tree that  
> has
> been built (since things like object files etc will have to be checked
> against the exclude list! (*)), but if it's a clean import with no
> generated files and only files we already know about, that should  
> not be
> the case.

I re-used the test that was posted some time ago:

------------------------------------------------------------------------ 
---
#
# first create a tree of roughly 100k files
#
mkdir bummer
cd bummer
for ((i=0;i<100;i++)); do
mkdir $i && pushd $i;
for ((j=0;j<1000;j++)); do
echo "$j" >$j; done; popd;
done

#
# init and add this to git
#
time git init
git config user.email "no@thx"
git config user.name "nothx"
time git add .
time git commit -m 'buurrrrn' -a

for ((j=0;j<1000;j++)); do
   echo "/pattern$j" >.git/info/exclude
done

#
# git-status, tunes in at around ~8s for me
#
time git-status
time git-status
time git-status
------------------------------------------------------------------------ 
---

[...]
git commit -m 'buurrrrn' -a  5.62s user 16.84s system 87% cpu 25.634  
total
# On branch master
nothing to commit (working directory clean)
git-status  2.48s user 5.97s system 96% cpu 8.718 total
# On branch master
nothing to commit (working directory clean)
git-status  2.48s user 5.94s system 97% cpu 8.646 total
# On branch master
nothing to commit (working directory clean)
git-status  2.48s user 5.95s system 96% cpu 8.720 total

My machine is a Core2Duo 2Ghz 2G RAM.

>
> So maybe we have a totally unnecessary performance issue, and do  
> all the
> fnmatch() on every path, whether we know about it or not?
>
> 		Linus
>
> (*) It might be that we could also re-order the exclude list so that
> entries that trigger are moved to the head of the list, because it's
> likely that if you have tons of exclude entries, some of them  
> trigger a
> lot more than others (ie "*.o"), and trying those first is likely a  
> good
> idea.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-4--590508339
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHE5KgwwE67wC8PUkRAknDAJ9FA1Y9Q+Fe2wIGdry+FYO5lXCDpgCg0rL6
YSuC78pgNNnbuuKjNgn2p+A=
=0iTs
-----END PGP SIGNATURE-----

--Apple-Mail-4--590508339--
