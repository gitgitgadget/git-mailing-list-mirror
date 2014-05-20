From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: EXT :Re: GIT and large files
Date: Tue, 20 May 2014 20:27:20 +0200
Message-ID: <1400610440.14137.18.camel@thomas-debian-x64>
References: <C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD53E@XMBVAG73.northgrum.com>
	 <xmqqmwec1i9f.fsf@gitster.dls.corp.google.com>
	 <C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD631@XMBVAG73.northgrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Stewart, Louis (IS)" <louis.stewart@ngc.com>
X-From: git-owner@vger.kernel.org Tue May 20 20:27:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmol8-0004Kw-1m
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbaETS10 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 May 2014 14:27:26 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:60606 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750851AbaETS1Z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 May 2014 14:27:25 -0400
Received: from p5ddc1dd3.dip0.t-ipconnect.de ([93.220.29.211] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1Wmokz-00012m-EE; Tue, 20 May 2014 20:27:21 +0200
In-Reply-To: <C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD631@XMBVAG73.northgrum.com>
X-Mailer: Evolution 3.4.4-3 
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1400610445;69b632cb;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249720>

Am Dienstag, den 20.05.2014, 17:24 +0000 schrieb Stewart, Louis (IS):
> Thanks for the reply.  I just read the intro to GIT and I am concerne=
d
> about the part that it will copy the whole repository to the develope=
rs
> work area.  They really just need the one directory and files under
> that one directory. The history has TBs of data.
>=20
> Lou
>=20
> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]=20
> Sent: Tuesday, May 20, 2014 1:18 PM
> To: Stewart, Louis (IS)
> Cc: git@vger.kernel.org
> Subject: EXT :Re: GIT and large files
>=20
> "Stewart, Louis (IS)" <louis.stewart@ngc.com> writes:
>=20
> > Can GIT handle versioning of large 20+ GB files in a directory?
>=20
> I think you can "git add" such files, push/fetch histories that
> contains such files over the wire, and "git checkout" such files, but
> naturally reading, processing and writing 20+GB would take some time.=
=20
> In order to run operations that need to see the changes, e.g. "git lo=
g
> -p", a real content-level merge, etc., you would also need sufficient
> memory because we do things in-core.

Preventing that a clone fetches the whole history can be done with the
--depth option of git clone.

The question is what do you want to do with these 20G files?
Just store them in the repo and *very* occasionally change them?
=46or that you need a 64bit compiled version of git with enough ram. 32=
G
does the trick here. Everything with git 1.9.1.

Doing some tests on my machine with a normal harddisc gives (sorry for
LC_ALL !=3D C):
$time git add file.dat; time git commit -m "add file"; time git status

real    16m17.913s
user    13m3.965s
sys     0m22.461s
[master 15fa953] add file
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file.dat

real    15m36.666s
user    13m26.962s
sys     0m16.185s
# Auf Branch master
nichts zu committen, Arbeitsverzeichnis unver=C3=A4ndert

real    11m58.936s
user    11m50.300s
sys     0m5.468s

$ls -lh
-rw-r--r-- 1 thomas thomas 20G Mai 20 19:01 file.dat

So this works but aint fast.

Playing some tricks with --assume-unchanged helps here:
$git update-index --assume-unchanged file.dat
$time git status
# Auf Branch master
nichts zu committen, Arbeitsverzeichnis unver=C3=A4ndert

real    0m0.003s
user    0m0.000s
sys     0m0.000s

This trick is only save if you *know* that file.dat does not change.

And btw I also set=20
$cat .gitattributes=20
*.dat -delta
as delta compresssion should be skipped in any case.

Pushing and pulling these files to and from a server needs some tweakin=
g
on the server side, otherwise the occasional git gc might kill the box.
=20
Btw. I happily have files with 1.5GB in my git repositories and also
change them. And also work with git for windows. So in this region of
file sizes things work quite well.
