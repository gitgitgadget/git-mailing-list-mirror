From: "Steven E. Harris" <seh@panix.com>
Subject: Confused over packfile and index design
Date: Fri, 08 Apr 2011 19:58:41 -0400
Organization: SEH Labs
Message-ID: <m2d3kw70su.fsf@Spindle.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 01:59:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8LZr-0006LI-SC
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 01:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757986Ab1DHX65 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 19:58:57 -0400
Received: from lo.gmane.org ([80.91.229.12]:59772 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757977Ab1DHX64 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 19:58:56 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q8LZm-0006Jm-OG
	for git@vger.kernel.org; Sat, 09 Apr 2011 01:58:54 +0200
Received: from 75-144-0-121-busname-pa.hfc.comcastbusiness.net ([75.144.0.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 01:58:54 +0200
Received: from seh by 75-144-0-121-busname-pa.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 01:58:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 75-144-0-121-busname-pa.hfc.comcastbusiness.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.50 (darwin)
Cancel-Lock: sha1:Xocap7Lsai6CWWKuwePzW4ChXKE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171175>

I was reading the Git Book discussion=C2=B9 on the packfile and index f=
ormats,
and there's a confusing set of assertions concerning the design choices
that sound contradictory.

=46irst, near the end of the section about the index format, we find th=
e
following paragraph:

,----
| Importantly, packfile indexes are /not/ neccesary to extract objects
| from a packfile, they are simply used to quickly retrieve individual
| objects from a pack. The packfile format is used in upload-pack and
| receieve-pack programs (push and fetch protocols) to transfer objects
| and there is no index used then - it can be built after the fact by
| scanning the packfile.
`----

That suggests that it's possible to read the packfile linearly and
deduce where the various objects start and end, without the index
available.

Later, in the section on the packfile format, we find this:

,----
| It is important to note that the size specified in the header data is
| not the size of the data that actually follows, but the size of that
| data /when expanded/. This is why the offsets in the packfile index a=
re
| so useful, otherwise you have to expand every object just to tell whe=
n
| the next header starts.
`----

Now that makes it sound like without the index, even if one knows where
a packed object starts, reading its header tells its /inflated/ size,
/not/ the number of remaining payload bytes representing the object. If
that's true, then how does one figure out where one object ends and the
next one begins /without the index/?

Recall that the first paragraph quoted above says that the index can be
built from the packfile, as opposed to it being essential to reading th=
e
packfile. Is one of these paragraphs incorrect?

The Git documentation on the pack format=C2=B2 mentions that the packed
object headers represent the lengths as variable-sized integers

,----
| n-byte type and length (3-bit type, (n-1)*7+4-bit length)
`----

but it doesn't say whether that's the number of (deflated) payload byte=
s
or the inflated object size, as the Git Book asserts.

I imagine that if the format is meant to record the size of the deflate=
d
payload, then it would be challenging to compress the data straight int=
o
the packfile, because one wouldn't know the final size until it was
written, which means that one wouldn't know how many bytes will be
necessary to write its length in the header, which means one wouldn't
know where to start writing the deflated payload.

Are there any other clarifying documents you can recommend to understan=
d
the design?


=46ootnotes:=20
=C2=B9 http://book.git-scm.com/7_the_packfile.html
=C2=B2 http://www.kernel.org/pub/software/scm/git/docs/technical/pack-f=
ormat.txt

--=20
Steven E. Harris
