From: Shawn Pearce <spearce@spearce.org>
Subject: Porting JGit HistogramDiff
Date: Mon, 31 Jan 2011 21:02:50 -0800
Message-ID: <AANLkTimisConBkVqCxYjd-HKL0=grFtVT5=fbqakA59O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 06:03:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk8Og-0007zX-GI
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 06:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859Ab1BAFDO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 00:03:14 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56912 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab1BAFDN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 00:03:13 -0500
Received: by fxm20 with SMTP id 20so6406431fxm.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 21:03:12 -0800 (PST)
Received: by 10.103.238.3 with SMTP id p3mr2785615mur.59.1296536590310; Mon,
 31 Jan 2011 21:03:10 -0800 (PST)
Received: by 10.103.1.2 with HTTP; Mon, 31 Jan 2011 21:02:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165793>

On Mon, Jan 31, 2011 at 09:05, Junio C Hamano <gitster@pobox.com> wrote=
:
>
> =A0* Shawn Pearce says that the diff implementation JGit uses (histog=
ram
> =A0 diff) performs way better than the xdiff implementation we use by
> =A0 default. It would be great if somebody can spend time taking a lo=
ok at
> =A0 it and possibly port it back to C-git.

The idea that JGit's HistogramDiff is faster came from Robin Rosenburg =
in [1]:

> $ time jgit log -M -p >jgit.txt
>
> real	0m3.880s
> user	0m7.137s
> sys	0m0.807s
>
> $ time git log -M -p >cgit.txt
>
> real	0m16.420s
> user	0m14.936s
> sys	0m0.899s
>
> Seems JGit beats the pants off C Git. A quick scans implies both vers=
ion
> produce correct diffs, but don't post this to the Git ML list just ye=
t :)


HistogramDiff is a variation of Patience Difference[2].  Within JGit
it is implemented as two classes:

  HistogramDiff[3] - the top level driver

  HistogramDiffIndex[4] - the hash table used to count and match occurr=
ences


Because its based on a hash table, the hash function for lines matters
a lot.  xdiff's hash is crap, it generates too many collisions on the
linux-2.6 repository's source files.  We use djb's hash function,
which you can find in our RawTextComparator class[5].  We actually
tested a number of hash functions using a test program [6].

I may try to port this myself, but it would be great if someone else
beat me to it.  :-)


[1]  http://dev.eclipse.org/mhonarc/lists/jgit-dev/msg00897.html
[2]  http://bramcohen.livejournal.com/73318.html
[3]  http://egit.eclipse.org/w/?p=3Djgit.git;a=3Dblob;f=3Dorg.eclipse.j=
git/src/org/eclipse/jgit/diff/HistogramDiff.java;hb=3DHEAD
[4]  http://egit.eclipse.org/w/?p=3Djgit.git;a=3Dblob;f=3Dorg.eclipse.j=
git/src/org/eclipse/jgit/diff/HistogramDiffIndex.java;hb=3DHEAD
[5]  http://egit.eclipse.org/w/?p=3Djgit.git;a=3Dblob;f=3Dorg.eclipse.j=
git/src/org/eclipse/jgit/diff/RawTextComparator.java;hb=3DHEAD
[6]  http://egit.eclipse.org/w/?p=3Djgit.git;a=3Dblob;f=3Dorg.eclipse.j=
git.pgm/src/org/eclipse/jgit/pgm/debug/TextHashFunctions.java;hb=3DHEAD

--=20
Shawn.
