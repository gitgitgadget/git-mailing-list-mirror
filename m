From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Fri, 3 Sep 2010 21:57:10 -0400
Message-ID: <04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com> <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com> <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com> <4C7FC3DC.3060907@gmail.com> <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com> <alpine.LFD.2.00.1009021249510.19366@xanadu.home> <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com> <alpine.LFD.2.00.1009021624170.19366@xanadu.home> <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu> <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org> <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 04 03:57:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ori0O-0002Nq-Ae
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 03:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab0IDB5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 21:57:15 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:45273 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753320Ab0IDB5O convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 21:57:14 -0400
X-AuditID: 12074422-b7bbfae000005e9b-fb-4c81a776bd4b
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id D5.AD.24219.677A18C4; Fri,  3 Sep 2010 21:57:10 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o841vCYi015834;
	Fri, 3 Sep 2010 21:57:12 -0400
Received: from [10.0.42.101] (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o841vAdP004362
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Sep 2010 21:57:11 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
X-Mailer: Apple Mail (2.1081)
X-Brightmail-Tracker: AAAAAhXbpxsV3H9p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155298>


On Sep 3, 2010, at 3:41 PM, Nicolas Pitre wrote:

>=20
> Let's see what such instructions for how to make the canonical pack=20
> might look like:

But we don't need to replicate any particular pack.  We just need to pr=
ovide instructions that can be replicated everywhere to provide *a* can=
onical pack.

>=20
> First you need the full ordered list of objects.  That's a 20-byte SH=
A1
> per object.  The current Linux repo has 1704556 objects, therefore th=
is
> list is 33MB already.

Assume the people creating this "gitdo" pack (i.e., much like jigdo) ha=
ve a superset of Linus's objects.  So if we have all of the branches in=
 Linus's repository, we can construct all of the necessary objects goin=
g back in time to constitute his repository.   If Linus has only one br=
anch in his repo, we only need a single 20-byte SHA1 branch identifier.=
   For git, presumbly we would need three (one for next, maint, and mas=
ter).

What abort the order of the objects in the pack?  Well, ordering doesn'=
t matter, right?   So let's assume the pack is sorted by hash id.   Is =
there any downside to that?  I can't think of any, but you're the pack =
expert...

If we do that, we would thus only need to send 20 bytes instead of 33MB=
=2E =20

> Then you need to identify which of those objects are deltas, and agai=
nst
> which object.  Assuming we can index in the list of objects, that mea=
ns,
> say, one bit to identify a delta, and 31 bits for indexing the base. =
In
> my case this is currently 1393087 deltas, meaning 5.3 MB of additiona=
l
> information.

OK, this we'll need which means 5.3MB.


>=20
> But then, the deltas themselves can have variations in their encoding=
=2E
> And we did change the heuristics for the actual delta encoding in the
> past too (while remaining backward compatible), but for a canonical p=
ack
> creation we'd need to describe that in order to make things totally
> reproducible.
>=20
> So there are 2 choices here: Either we specify the Git version to mak=
e=20
> sure identical delta code is used, but that will put big pressure on=20
> that code to remain stable and not improve anymore as any behavior=20
> change will create a compatibility issue forcing people to upgrade th=
eir=20
> Git version all at the same time.  That's not something I want to see=
=20
> the world rely upon.

I don't think the choice is that stark.  It does mean that in addition =
to whatever pack encoding format is used by git natively, the code woul=
d also need to preserve one version of the delta hueristics for "Canoni=
cal pack version 1". After this version is declared, it's true that you=
 might come up with a stunning new innovation that saves some disk spac=
e.  How much is that likely to be?  3%?  5%?   Worst case, it means tha=
t (1) the bittorent-distributed packs might not be as efficient, and (2=
) the code would be made more complex because we would either need to (=
a) keep multiple versions of the code, or (b) the code might need to ha=
ve some conditionals:

	if (canonical pack v1)
		do_this_code;
	else
		do_this_more_clever_code;

Is that really that horrible?  And certainly we should be able to set t=
hings up so that it won't be a brake on innovation...

>=20
> The other choice is to actually provide the delta output as part of t=
he=20
> instruction for the canonical pack creation.
>=20
> So that makes for a grand total of 33 MB + 148 MB =3D 181 MB of data =
just
> to be able to unambiguously reproduce a pack with a full guarantee of
> perfect reproducibility.

So if we use the methods I've suggested, we would only need to send 5.3=
MB instead of 33MB or 181MB....

>=20
> But even with the presumption of stable delta code, the recipee would=
=20
> still take 38 MB that everyone would have to download every month whi=
ch=20
> is far more than what a monthly incremental update of a kernel repo=20
> requires.  Of course you could create a delta between consecutive=20
> recipees, but that is becoming rather awkward.

The "recipee" would only need to download this if they are willing to p=
articipate as being one of the "seeders" in the BitTorrent network.   P=
eople who are willing to do this are presumably willing to transmit man=
y more megabytes of data than 5MB or 33MB or 181MB.  Given the draconia=
n policies of various ISP such as Comcast, it's not clear to me how man=
y people will be willing to be seeders.   But if they are, I don't thin=
k downloading 5.3MB of instructions to generate a 600MB canonical pack =
to be distributed to hundreds or thousands of strangers will stop them.=
  :-)

> I still think that if someone really want to apply the P2P principle =
=E0=20
> la BitTorrent to Git, then it should be based on the distributed=20
> exchange of _objects_ as I outlined in a previous email, and not file=
=20
> chunks like BitTorrent does.  The canonical Git _objects_ are fully=20
> defined, while their actual encoding may change.

The advantages of sending a canonical pack is that it's relatively less=
 code to write, since we can reuse the standard BitTorrent clients and =
servers to transmit the git repository.  The downsides are that it's ma=
inly useful for downloading the entire repository, but I think that's t=
he most useful place for peer2peer anyway.

The advantage of a distributed exchange of _objects_ is you can use it =
to update a random repository --- but normally it's so efficient to dow=
nload an incremental set of objects from github or kernel.org, so I'm n=
ot sure what would be the point.   It would also require exchanging a l=
ot more metadata, since presumably the client would first have to recei=
ve all of the object id's (which would be 33MB), and then use that to d=
ecide how to distribute asking for those objects from his/her peers.   =
Which means sending object lists to different servers.   If these peers=
 do not yet have a complete set of objects, they'll have to nack some o=
f the object requests.   Furthermore with only a partial set of objects=
 downloaded, how will the client do the delta compression?   Which mean=
s the client will need to store all of the objects in a decompressed fo=
rm, and only when it has received all of the objects  will it be able t=
o compress them.   So it's going to be fairly inefficient in terms of d=
isk space.  I suppose the server could send the delta information (anot=
her 5.3MB) and then the client could use that to prioritize its object =
request lists.   But still, this is quite different form the git protoc=
ol, and a lot will have to be written from scratch.

-- Ted
