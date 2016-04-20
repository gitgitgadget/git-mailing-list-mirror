From: Yaroslav Halchenko <yoh@onerussian.com>
Subject: Re: problems serving non-bare repos with submodules over http
Date: Wed, 20 Apr 2016 15:45:33 -0400
Message-ID: <20160420194533.GO23764@onerussian.com>
References: <20160420152209.GH23764@onerussian.com>
 <CAGZ79kYS-F1yKpNP7jmhTiZT1R_pucUBBTCbmHKZz6Xd6dy8EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>, Jens Lehmann <Jens.Lehmann@web.de>
To: Git Gurus hangout <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 21:45:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asy4C-0001pI-UZ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 21:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbcDTTpg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 15:45:36 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:33852 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbcDTTpg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 15:45:36 -0400
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <yoh@onerussian.com>)
	id 1asy45-00007z-IV; Wed, 20 Apr 2016 15:45:33 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
	(envelope-from <yoh@onerussian.com>)
	id 1asy45-00007u-Bs; Wed, 20 Apr 2016 15:45:33 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYS-F1yKpNP7jmhTiZT1R_pucUBBTCbmHKZz6Xd6dy8EA@mail.gmail.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org, benjaminpoldrack@gmail.com, id@joeyh.name, Jens.Lehmann@web.de
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292064>


On Wed, 20 Apr 2016, Stefan Beller wrote:
> > I do realize that the situation is quite uncommon, partially I gues=
s due
> > to git submodules mechanism flexibility and power on one hand and
> > under-use (imho) on the other, which leads to discovery of regressi=
ons
> > [e.g. 1] and corner cases as mine.

> Thanks for fixing the under-use and reporting bugs. :)

I am thrilled to help ;)

> > [1] http://thread.gmane.org/gmane.comp.version-control.git/288064
> > [2] http://www.onerussian.com/tmp/git-web-submodules.sh

> > My use case:  We are trying to serve a git repository with submodul=
es
> > specified with relative paths over http from a simple web server.  =
With a demo
> > case and submodule specification [complete script to reproduce incl=
uding the
> > webserver using python is at 2] such as

> > (git)hopa:/tmp/gitxxmsxYFO[master]git
> > $> tree
> > .
> > =E2=94=9C=E2=94=80=E2=94=80 f1
> > =E2=94=94=E2=94=80=E2=94=80 sub1
> >     =E2=94=94=E2=94=80=E2=94=80 f2

> > $> cat .gitmodules
> > [submodule "sub1"]
> >     path =3D sub1
> >     url =3D ./sub1


> > 1. After cloning

> >     git clone http://localhost:8080/.git

> >    I cannot 'submodule update' the sub1 in the clone since its url =
after
> >    'submodule init' would be  http://localhost:8080/.git/sub1 .  If=
 I manually fix
> >    it up -- it seems to proceed normally since in original reposito=
ry I have
> >    sub1/.git/ directory and not the "gitlink" for that submodule.

> So the expected URL would be  http://localhost:8080/sub1/.git ?

ATM, yes

> I thought you could leave out the .git prefix, i.e. you can type

>      git clone http://localhost:8080

> and Git will recognize the missing .git and try that as well. The rel=
ative URL
> would then be constructed as http://localhost:8080/sub1, which will u=
se the
> same mechanism to find the missing .git ending.

[note1] Unfortunately it is not the case ATM (git version
2.8.1.369.geae769a, output is interspersed with log from the python's s=
imple
http server):

$> git clone http://localhost:8080 xxx                  =20
Cloning into 'xxx'...            =20
127.0.0.1 - - [20/Apr/2016 15:01:25] code 404, message File not found
127.0.0.1 - - [20/Apr/2016 15:01:25] "GET /info/refs?service=3Dgit-uplo=
ad-pack HTTP/1.1" 404 -
fatal: repository 'http://localhost:8080/' not found


> > 2. If I serve the clone [2 demos that too] itself, there is no easy=
 remedy at
> >    all since sub1/.git is not a directory but a gitlink.

> Not sure I understand the second question.

If I serve via http a repository where sub1/.git is a "gitlink":

    (git)hopa:/tmp/gitxxmsxYFO_[master]
    $> cat sub1/.git=20
    gitdir: ../.git/modules/sub1

Such repository cannot be cloned:

    (git)hopa:/tmp/gitxxmsxYFO_[master]git
    $> git clone http://localhost:8080/sub1 /tmp/xxx
    Cloning into '/tmp/xxx'...                     =20
    127.0.0.1 - - [20/Apr/2016 15:04:01] code 404, message File not fou=
nd
    127.0.0.1 - - [20/Apr/2016 15:04:01] "GET /sub1/info/refs?service=3D=
git-upload-pack HTTP/1.1" 404 -
    fatal: repository 'http://localhost:8080/sub1/' not found

    $> git clone http://localhost:8080/sub1/.git /tmp/xxx=20
    Cloning into '/tmp/xxx'...
    127.0.0.1 - - [20/Apr/2016 15:04:06] code 404, message File not fou=
nd
    127.0.0.1 - - [20/Apr/2016 15:04:06] "GET /sub1/.git/info/refs?serv=
ice=3Dgit-upload-pack HTTP/1.1" 404 -
    fatal: repository 'http://localhost:8080/sub1/.git/' not found


> > N.B. I haven't approached nested submodules case yet in [2]

> > I wondered

> > a. could 'git clone' (probably actually some relevant helper used b=
y fetch
> >    etc) acquire ability to sense for URL/.git if URL itself doesn't=
 point to a
> >    usable git repository?

> So you mean in case of relative submodules, we need to take the paren=
t
> url, and remove the ".git" at the end and try again if we cannot find
> the submodule?

that would be the a.2 which I have forgotten to outline ;)

in a.  I was suggesting what you have assumed [note 1 above] would be
happening (but doesn't) ATM: that /.git would be automagically sensed.

> >     I think this could provide complete remedy for 1 since then rel=
ative urls
> >     would be properly assembled, with similar 'sensing' for /.git f=
or the final urls

> >     I guess we could do it with rewrites/forwards on the "server si=
de",
> >     but it wouldn't be generally acceptable solution.

> > b. is there a better or already existing way to remedy my situation=
?

> > c. shouldn't "git clone" (or the relevant helper) be aware of remot=
e
> >    /.git possibly being a gitlink file within submodule?

> Oh. I think that non-bare repositories including submodules are not d=
esigned
> to be cloned, because they are for use in the file system.

Well -- that is the beauty of git being a distributed VCS, that non-bar=
e repos
seems to be as nicely cloneable as bare ones. And in general it seems t=
o work
with submodules as well, since they should be the "consistent"
philosophically...=20

>  Even a local clone fails:

>     # gerrit is a project I know which also has submodules:
>     git clone --recurse-submodules https://gerrit.googlesource.com/ge=
rrit g1
>     git clone --recurse-submodules g1 g2
>     ...
> fatal: clone of '...' into submodule path '...' failed

I guess that is just yet another bug with relative paths in the
submodules.

> So I think for cloning repositories you want to have each repository
> as its own thing (bare or non bare).

in your first line in the example above you somewhat have shown the
counter-argument to the statement.  Indeed each repository should be it=
s own
thing, just possibly registered as a submodule to another one.

> The submodule mechanism is just a way to express a relation between
> the reositories, it's like composing them together, but by that compo=
sition
> it breaks the properties of each repository to be easily clonable.

It doesn't really (unless in the cases we both pointed out).  E.g. I ca=
n as
easily clone original sub1 repository which was  registered as a submod=
ule of
another one.  Either treatment of them by git during cloning (and placi=
ng under
root repo's .git/modules, etc) undermines that feature -- that is the
question we could also discuss here somewhat I guess ;)

> I think we should fix that.

would be awesome! Thanks in advance ;)

> I guess the local clone case is 'easy' as you only need
> to handle the link instead of directory thing correctly.

> For the case you describe (cloning from a remote, whether it is http =
or ssh),
> we would need to discuss security implications I would assume? It sou=
nds
> scary at first to follow a random git link to the outer space of the =
repository.

more like "into the inner space".  git already (as  above example shown=
)
descends right away into  "/info/refs?", so how sensing "/.git/" would =
be any
different?

> (A similar thing is that you cannot have symlinks in a git repository=
 pointing
> outside of it, IIRC? At least that was fishy.)

that might indeed be dangerous.  but once again, per above argument sim=
ilarly
up to the "provider" I guess to guarantee protection, e.g. forbidding f=
ollowing
symlink on the webserver for that served directory, if content is not u=
nder his
control.

Cheers and thanks for your quick reply Stefan!
--=20
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik       =20
