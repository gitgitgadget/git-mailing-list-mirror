From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: t1450-fsck (sometimes/often) failes on Mac OS X
Date: Tue, 02 Oct 2012 18:06:35 +0200
Message-ID: <506B110B.2050802@web.de>
References: <5001644F.10901@web.de> <20120715090849.GB18385@sigill.intra.peff.net> <5059ED25.9090002@web.de> <7va9wlhnl3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 18:07:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ4zt-00065A-41
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 18:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825Ab2JBQGv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2012 12:06:51 -0400
Received: from mout.web.de ([212.227.15.3]:56209 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838Ab2JBQGu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 12:06:50 -0400
Received: from wanderer.site ([195.67.191.22]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0M6DuI-1TcWqg0rne-00yDC9; Tue, 02 Oct 2012 18:06:48
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <7va9wlhnl3.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:p/duBmm3Aq6X1gkIf+R8bC6aYWd/0hnq/gHnpU8HRZ3
 QvhxID7hStpgm6I2zSG3lafFvW243N3+YFIQNEdyzSqIfSq5/Y
 j38TyoVhAjMOKoiDt8KYanpXcrGx8bU/UqdTSCkgLvSle0tn2Q
 2JW5IV5YzvinT9fAkW0FD81AJvdo5xVk/hAc0gKBcSwdAMjcOt
 j8MetfDvu1XiPOFRj3SkA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206809>

On 09/19/2012 08:30 PM, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
> "is a blob, not a commit" is likely to come from validating of the
> tag 66f6581d that presumably point at 63499e4; it reads the tag,
> learns the name of the object that is tagged and the type of it,
> remembers that the object pointed at (which it hasn't and is going
> to validate next) _must_ be a commit (because tag says so) and then
> realizes when it reads 63499e4 it is a blob and barfs.
>
> And that is what _should_ happen in that test.  It crafts a
> malformed tag that points at a blob and claims that it is a commit.
> The test makes sure fsck catches that, and it does.
>
> On the other hand, "is a commit, not a blob", unless you have a tag
> that directly points at a blob, is more likely to come from
> validating some tree object.  It reads the tree, learns the name of
> the object contained in the tree and infers the type of that object
> from the mode bits in the tree (100644 or 100755 would mean the
> object must be a blob), goes on to validate that object and realizes
> it is a commit and barfs.
>


The good news:
With help of Junio's comments I probably found the reason why the test=20
behaves differently:

The objects are checked in a certain order, based on the inode number.

Which seems to be the same on most machines: when files are created
in a certain order, then the inode numbers are in the same order.

When the inode numbering changes for reasons known to the file system,=20
the order changes and fsck takes a different code path.

To provoke the error, the following helped at my Linux box:

diff --git a/builtin/fsck.c b/builtin/fsck.c
index a710227..bba8082 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -373,7 +373,7 @@ static struct {

  static int ino_compare(const void *_a, const void *_b)
  {
-       const struct sha1_entry *a =3D _a, *b =3D _b;
+       const struct sha1_entry *a =3D _b, *b =3D _a;
         unsigned long ino1 =3D a->ino, ino2 =3D b->ino;
         return ino1 < ino2 ? -1 : ino1 > ino2 ? 1 : 0;
  }

The bad news: I haven't found the time to prepare a fix.

/Torsten
