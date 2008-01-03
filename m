From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git over webdav: what can I do for improving http-push ?
Date: Thu, 3 Jan 2008 22:15:21 +0100
Message-ID: <20080103211521.GA4225@efreet.light.src>
References: <477822C3.9060002@gbarbier.org> <alpine.LNX.1.00.0712302145500.13593@iabervon.org> <47791F90.8030302@pobox.com> <20080101113301.GC9214@efreet.light.src> <477A26FD.7020408@gbarbier.org> <m3myrpo1p0.fsf@roke.D-201> <20080101202352.GA4295@efreet.light.src> <477D3401.2010005@gbarbier.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?R3LDqWdvaXJl?= Barbier <gb@gbarbier.org>
X-From: git-owner@vger.kernel.org Thu Jan 03 22:16:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAXQ3-0006pU-07
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 22:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbYACVPe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2008 16:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbYACVPe
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 16:15:34 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:39327 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbYACVPd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 16:15:33 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 544DD5745C;
	Thu,  3 Jan 2008 22:15:31 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id aeTNbD90EsqT; Thu,  3 Jan 2008 22:15:27 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id EB10557420;
	Thu,  3 Jan 2008 22:15:26 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1JAXPN-0002Gi-Sh; Thu, 03 Jan 2008 22:15:21 +0100
Content-Disposition: inline
In-Reply-To: <477D3401.2010005@gbarbier.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69534>

On Thu, Jan 03, 2008 at 20:14:09 +0100, Gr=C3=A9goire Barbier wrote:
> Jan Hudec a =C3=A9crit :
[...]
>> It is what bzr and mercurial do and I think it would be quite good w=
ay to go
>> for cases like this.
> Ok, I will have to look at bzr and mercurial...

Bzr is quite far, design-wise, I fear. The mercurial might be a little =
more
interesting to study, but being in python and internally somewhat
file-oriented, I wouldn't think it is of much use.

You should start with upload, leaving the download direction to the dum=
b
machinery git currently uses.

[...]
>> I have also thought about optimizing download using CGI, but than I =
thought,
>> that maybe there is a way to statically generate packs so, that if t=
he client
>> wants n revisions, the number of revisions it downloads is O(n) and =
the
>> number of packs it gets them from (and thus number of round-trips) i=
s
>> O(log(n)). Assuming the client always wants everything up to the tip=
, of
>> course. Now this is trivial with linear history (pack first half, th=
an half
>> of what's left, etc., gives logarithmic number of packs and you alwa=
ys
>> download at most twice as much as you need), but it would be nice if=
 somebody
>> found a way (even one that satisfies the conditions on average only)=
 to do
>> this with non-linear history, it would be very nice improvement to t=
he http
>> download -- native git server optimizes amount of data transfered ve=
ry well,
>> but at the cost of quite heavy CPU load on the server.
>>  =20
> Well... frankly I don't think I'm able of such things.
> Writing a walker over webdav or  a simple cgi is a thing I can do (I=20
> think),  but I'm not tought enough (or not ready to take the time nee=
ded)=20
> to have a look on the internals of packing revisions (whereas I can i=
magine=20
> it would means that "my" walker would be suitable only for small proj=
ects=20
> in terms of code amount and commit frequency).

Well, it does not depend on the walker -- the walker is quite simple an=
d
already written anyway.

> I had a quick look on bzr and hg, and it seems that bzr use the easy =
way=20
> (walker, no optimizations)

That's not quite true -- bzr has both dumb (walker over plain HTTP) and=
 smart
(CGI) methods. But their CGI is really just tunelling their custom prot=
ocol
over HTTP and that protocol will not be anywhere near what we want for =
git
because of vastly different design of the storage.

> and hg a cgi (therefore, maybe optimizations).=20
> By quick look I mean that I sniff the HTTP queries on the network dur=
ing a=20
> clone. I need to look harder...

Yes, mercurial uses a CGI. But I am not sure how similar their approach=
 is to
anything that would make sense for git, so looking at the details might=
 or
might not be useful.

> BTW I never looked at the git:// protocol. Do you think that by tunne=
ling=20
> the git protocol in a cgi (hg uses URLs of the form=20
> "/mycgi?cmd=3Dmycommand&...", therefore I think "tunnel" is not a bad=
=20
> word...) the performance would be good?

It would be pretty hard to tunnel it and it would loose all it's nice
properties. The git protocol, for pull, basically works like this:

 - server sends a list of it's refs
 - client tells server which ones it wants
 - client starts listing revisions it has, newest to oldest
 - server tells client whenever it finds common ancestor with one of th=
e
   heads desired
 - client restarts the listing from next ref
 - server starts sending the data when client runs out of refs to list

The main point about the protocol is, that the client is listing the re=
fs, as
fast as it can and server will stop it when it sees a revision it knows=
=2E
Therefore there will only be one round-trip to discover each common anc=
estor.

However, you can't do this over HTTP, because response won't be started=
 until
the request is received. You could be sending a lot of smallish request=
s and
quick, often empty, responses to them. However, that will waste a lot o=
f
bandwidth (because of the HTTP overhead) and loose much of the speed an=
yway.
Also the HTTP protocol is stateless, but this is inherently stateful, s=
o you
would have to work that around somehow too. Therefore a different appro=
ach is
preferable on HTTP.

Now to keep it stateless, I thought that:
 - client would first ask for list of refs
 - client would than ask for pack containing the first ref
 - server would respond with pack containing just that commit plus all
   objects that are not referenced by any of it's parents
 - if client does not have it's parent, it would ask for pack containin=
g that
 - since it's second request, server would pack 2 revisions (with neces=
sary
   objects) this time
 - if client still does not have all parents, it would again ask for a =
pack,
   receiving 4 revisions this time (next 8, 16, etc...)

This would guarantee, that when you want n revisions, you make at most
log2(n) requests and get at most 2*n revisions (well, the requests are =
for
each ref separately, so it's more like m*log2(n) where m is number of r=
efs,
but still). Additionally, it would be stateless, because the client wou=
ld
simply say 'I want commit abcdef01 and this is my 3rd request' and serv=
er
would provide that commit and 7 it's parents (ie. 2^3 commits).

Now generating the packs takes it's CPU. The servers like git.kernel.or=
g have
quite high CPU load. But in this schema, all clients would most of the =
time
get the same packs (unlike native git protocol, where the client always=
 gets
single pack with exactly what it needs). So the idea struck me, that th=
ey
could simply be statically generated and fetched via the existing dumb
protocol. It would get the efficiency and save a lot of CPU power, whic=
h
is allows one to serve quite busy git repository from a limited (and
therefore cheap) virtual machine or even (yes, I saw such idea on the l=
ist)
serving any repository from NSLU2.

Now to create a packing policy to create such packs, you don't actually=
 need
to touch any C -- because git-repack is still in shell -- and you don't
really need to touch any internals, because you only need to change how=
 the
pack-objects command will be called and leave all the dirty details to =
that
command.

I would personally not re-split the already generated packs. Only find =
some
algorithm for choosing when packs are deep enough in history so they sh=
ould
be merged together. It would also might not make sense to ever pack unp=
acked
objects to more than one pack -- a dumb-HTTP-served might have a requir=
ement
of running this kind of repack after every push and clients will rarely=
 have
part of single push to the server.

> Maybe it's not that hard to write a performant HTTP/CGI protocol for =
Git if=20
> it's based upon existing code such as the git protocol.

=46or push it might, or might not be easy. But in the worst case you sh=
ould be
able to calculate a pack to upload locally (fetching from the server
beforehead if necessary), upload that pack (or bundle) and update all t=
he
refs.

=46or pull it certainly won't be. You might be able to reimplement the =
common
ref discovery using some kind of gradually increasing ref list and then
generate a bundle for the server, but optimizing the dumb protocol seem=
s more
useful to me. As I said, generating the packs only requires devising a =
way of
selecting which objects should go together and git pack-objects will ta=
ke
care of the dirty details of generating the packs and git update-server=
-info
will take care of the dirty details of presenting the list of packs to
client.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
