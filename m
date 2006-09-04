From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH][RFC] Add git-archive-tree
Date: Mon, 04 Sep 2006 20:22:22 +0200
Message-ID: <44FC6EDE.4010300@lsrfire.ath.cx>
References: <44F977C0.4060901@lsrfire.ath.cx> <44F982BD.1050509@lsrfire.ath.cx> <cda58cb80609021313p5156a14du4895e53387dd24dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 04 20:34:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKJGt-0008Vo-E2
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 20:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWIDSeF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 4 Sep 2006 14:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWIDSeF
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 14:34:05 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:44211
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751284AbWIDSWh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 14:22:37 -0400
Received: from [10.0.1.3] (p508E6401.dip.t-dialin.net [80.142.100.1])
	by neapel230.server4you.de (Postfix) with ESMTP id E35E41B000;
	Mon,  4 Sep 2006 20:22:35 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80609021313p5156a14du4895e53387dd24dc@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26429>

=46ranck Bui-Huu schrieb:
> 2006/9/2, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>:
>> The two patches I sent are what I have been able to come up with so =
far.
>> The next step would be to add archive-neutral upload and download
>> support.
>>
>> Having thought a bit about it I propose to keep git-archive-tree for
>> local operations, only.  It can be called by the uploader just like
>=20
> Well I don't see why putting the remote operations in an other file. =
I
> was more thinking on something like this:
>=20
> git-archive --format=3D<fmt> [--remote=3D<repo>] <tree-ish> [path...]

My intention was to put both halves of the wire protocol implementation
into the same source file.  I still think this is a good idea, but of
course it's independent from any command line interface considerations.

Internally, remote and local operations do completely different things,
so it doesn't make sense to mix them.  But users probably don't care
about such details and may prefer a single command to express "gimme
that archive, no matter if it's made here or there".  OK, sort of.

> This main porcelain function would call directly functions provided b=
y
> archivers lib. We will need to define an API which git-archive will
> use for local operations.

Yes, this would be write_archive_fn_t in archive.h.

> Symetrically, on the sever side we would have:
>=20
> git-upload-archive --format=3D<fmt> <repo> [path...]

No, git-upload-archive would accept only a single parameter: the path t=
o
the repository.  It'd receive all other options via the wire protocol,
just like git-upload-tar.

> used by git-daemon. It will deal with protocol, paths and use archive=
r's
> lib.

Except if you meant by this that git-daemon would handle the protocol
etc., which I'd disagree with ("It" is slightly ambiguous here).

> Eventually, we would have 2 commands:
>=20
> git-archive
> git-upload-archive
>=20
> and get ride of
>=20
> git-tar-tree
> git-zip-tree
> git-upload-tar
> git-upload-zip

Let's keep the git-<verb>-<object> nomenclature used for most commands
for the sake of consistency.  In both cases you'd only type
git-archiv<TAB> anyway. ;-)

We could remove the existing commands git-upload-tar and git-zip-tree
right now, as they were never part of a release, yet.  git-upload-zip
doesn't exist, yet, and git-tar-tree would probably survive as legacy
interface, calling git-archive-tree internals.  Junio, am I correct
regarding the cool-blooded killing of unreleased commands?

>> git-tar-tree is now called by git-upload-tar.  As Franck suggested, =
the
>> uploader should allow the list of archive formats it supports to be
>> restricted in a config file.  The range of allowed compression level=
s
>> should also be configurable.
>>
>> Does it make sense to change the wire protocol to simply send the
>> command line options one by one?
>=20
> That would make sense if the number of options grow up. Currently the
> remote protocol had been written by Junio, I just pick up that part
> from git-tar-tree and put it into git-archive. But if we allow
> pathspec for remote operations, then  we need to send them to the
> uploader.

If we simply send each option to the downloader without understanding
them then the uploader can be kept really simple.  The protocol can be
kept simple, and it would be future-proof: we will never have to update
it.  I'm a bit worried about the security implications of such a setup,
strangely _because_ I can't see a way to exploit it right now (and
because it allows arbitrary input, which we must be able to cope with
anyway).

>>
>> The interface could be something like this:
>>
>>    git-download-archive <repo> <git-archive-tree options...>
>>    git-upload-archive <directory>
>>
>> Or, if the big number of git command names is a concern:
>>
>=20
> I think it is, IMHO. And that's why I think we could have only one
> command for building localy/remotely archive whatever the format.
> git-archive should be a main procelain command, and we should get rid
> of git-{tar,zip}-tree commands.

OK, makes sense; users will never need to call git-upload-archive
directly, and having a single command for all archiving is a good thing=
=2E

My next steps will be to make traverse_tree() support path specs, in
order to achieve feature parity with read_tree_recursive().  I hope tha=
t
the former keeps being significantly faster than the latter even after
that.  If it works out I'm going to convert git-zip-tree to use
traverse_tree().

Other tasks: morphing git-upload-tar into git-upload-archive,
replacing/enhancing the protocol, and adding a matching uploader
(--remote=3D option handler).  I won't start with that stuff until I ge=
t
the performance sorted out.  I hope this keeps me from stepping on your
toes (again), Franck. ;-)

Thanks,
Ren=E9
