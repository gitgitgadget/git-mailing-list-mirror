From: Johan Herland <johan@herland.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Wed, 13 Jun 2012 23:27:57 +0200
Message-ID: <CALKQrgedkyA71Kr935Hdo6KGAg4c-1NbY4RB432zmuvSVU6mqw@mail.gmail.com>
References: <20120611213948.GB32061@sigill.intra.peff.net>
	<20120611221439.GE21775@thunk.org>
	<20120611222308.GA10476@sigill.intra.peff.net>
	<alpine.LFD.2.02.1206112024110.23555@xanadu.home>
	<20120612171048.GB12706@sigill.intra.peff.net>
	<alpine.LFD.2.02.1206121326490.23555@xanadu.home>
	<20120612173214.GA16014@sigill.intra.peff.net>
	<alpine.LFD.2.02.1206121345500.23555@xanadu.home>
	<20120612175438.GB16522@sigill.intra.peff.net>
	<alpine.LFD.2.02.1206121359260.23555@xanadu.home>
	<20120612191528.GB16911@sigill.intra.peff.net>
	<loom.20120613T185623-81@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 23:28:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sev6o-0003Xg-Bs
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 23:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350Ab2FMV2F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 17:28:05 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:50441 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134Ab2FMV2E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 17:28:04 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Sev6f-000Ij6-NJ
	for git@vger.kernel.org; Wed, 13 Jun 2012 23:28:01 +0200
Received: from mail-ob0-f174.google.com ([209.85.214.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Sev6f-000DFQ-De
	for git@vger.kernel.org; Wed, 13 Jun 2012 23:28:01 +0200
Received: by obbtb18 with SMTP id tb18so1386292obb.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 14:27:57 -0700 (PDT)
Received: by 10.182.31.47 with SMTP id x15mr25906913obh.62.1339622877785; Wed,
 13 Jun 2012 14:27:57 -0700 (PDT)
Received: by 10.76.138.167 with HTTP; Wed, 13 Jun 2012 14:27:57 -0700 (PDT)
In-Reply-To: <loom.20120613T185623-81@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199947>

On Wed, Jun 13, 2012 at 8:17 PM, Martin Fick <mfick@codeaurora.org> wro=
te:
> Jeff King <peff <at> peff.net> writes:
>> > Then, the creation of unreferenced objects from successive 'git ad=
d'
>> > shouldn't create that many objects in the first place. =C2=A0They =
currently
>> > never get the chance to be packed to start with.
>>
>> I don't think these objects are necessarily from successive "git add=
"s.
>> That is one source, but they may also come from reflogs expiring. I
>> guess in that case that they would typically be in an older pack,
>> though.
> ...
>> That is satisfyingly simple, but the storage requirement is quite ba=
d.
>> The unreachable objects are very much in the minority, and an
>> occasional duplication there is not a big deal; duplicating all of t=
he
>> reachable objects would double the object directory's size.
> ...
> (I don't think this is a valid generalization for servers)
>
> I am sorry to be coming a bit late into this discussion, but I think =
there
> =C2=A0is an even worse use case which can cause much worse loose obje=
ct
> explosions which does not seem to have been mentioned yet: =C2=A0 "th=
e
> server upload rejected case". =C2=A0For example, think of a client pu=
shing a
> change from the wrong repository to a server. =C2=A0Since there will =
be no
> history in common, the client will push the entire repository and if =
for
> =C2=A0some reason this gets rejected by the server (perhaps a pre-rec=
eive
> hook, or a gerrit server which says: =C2=A0"way too many new changes.=
=2E."),
> then the pack file may stay abandonned on the server. =C2=A0When gc r=
uns:
> boom the entire history of that other project will explode but not ge=
t
> =C2=A0pruned since the pack file may be fairly new!

[...]

Just a +1 from me. We had the same problem at my former $dayjob, and
worked around it by running a "git gc --prune=3Dnow" in the server repo
(which is a command you'd rather not want to run in a server repo) to
remove exploded loose objects.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
