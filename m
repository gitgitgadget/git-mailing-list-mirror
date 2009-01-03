From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2008, #04; Mon, 29)
Date: Sat, 03 Jan 2009 02:31:02 -0800
Message-ID: <7vhc4gadg9.fsf@gitster.siamese.dyndns.org>
References: <7vocyt1is2.fsf@gitster.siamese.dyndns.org>
 <200901030640.36426.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jan 03 11:32:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ3o2-0007Tc-Ql
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 11:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbZACKbN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jan 2009 05:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbZACKbM
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 05:31:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbZACKbL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jan 2009 05:31:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 447A01BA98;
	Sat,  3 Jan 2009 05:31:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 00BD21BA95; Sat, 
 3 Jan 2009 05:31:04 -0500 (EST)
In-Reply-To: <200901030640.36426.chriscool@tuxfamily.org> (Christian Couder's
 message of "Sat, 3 Jan 2009 06:40:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A295383C-D981-11DD-A328-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104458>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le mardi 30 d=C3=A9cembre 2008, Junio C Hamano a =C3=A9crit :
>>
>> * cc/bisect-replace (Mon Nov 24 22:20:30 2008 +0100) 9 commits
>>  - bisect: add "--no-replace" option to bisect without using replace
>>    refs
>>  - rev-list: make it possible to disable replacing using "--no-
>>    bisect-replace"
>>  - bisect: use "--bisect-replace" options when checking merge bases
>>  - merge-base: add "--bisect-replace" option to use fixed up revs
>>  - commit: add "bisect_replace_all" prototype to "commit.h"
>>  - rev-list: add "--bisect-replace" to list revisions with fixed up
>>    history
>>  - Documentation: add "git bisect replace" documentation
>>  - bisect: add test cases for "git bisect replace"
>>  - bisect: add "git bisect replace" subcommand
>>
>> I think a mechanism like this should be added to replace grafts,=20
>
> The problem with replacing grafts is that a graft can specify many pa=
rents=20
> for one commit while a ref associates only one object to a name.

Sorry, maybe I misunderstood your implementation.  What I thought we
discussed during GitTogether was to write out the object name of the
replacement object in refs/replace/<sha1>.

When the caller asks read_sha1_file() for an object whose object name i=
s
<sha1>, you see if there is refs/replace/<sha1> in the repository, and
read the ref to learn the object name of the object that replaces it.  =
And
you return that as if it is the original object.

So if your commit cca1704897e7fdb182f68d4c48a437c5d7bc5203 looks like:

    tree 7ccf394b2e80536442703e0013bf0dde86547e08
    parent 3827210b91a7d363ea67bcf0b9c6ee1c91d2f3c5
    author Johannes Schindelin <Johannes.Schindelin@gmx.de> 1230919672 =
+0100
    committer Junio C Hamano <gitster@pobox.com> 1230931180 -0800

    git wrapper: Make while loop more reader-friendly
    ...

and you would want to lie about its author (or add/subtract different
parent lines, or record a fixed-up tree, or whatever), you first prepar=
e a
replacement commit object:

    $ R=3D$(git cat-file commit cca17048 |
      sed -e 's/Johannes /&E /' |
      git hash-object -t commit --stdin -w)
    $ git cat-file commit $R
    tree 7ccf394b2e80536442703e0013bf0dde86547e08
    parent 3827210b91a7d363ea67bcf0b9c6ee1c91d2f3c5
    author Johannes E Schindelin <Johannes.Schindelin@gmx.de> 123091967=
2 +0100
    committer Junio C Hamano <gitster@pobox.com> 1230931180 -0800

    git wrapper: Make while loop more reader-friendly
    ...

and then tell git to replace the original object with this one:

    $ git update-ref refs/replace/$(git rev-parse cca17048) $R

With such a layout, if your arrange the object reachability traverser
(e.g. fsck, pack-objects, bundle and prune) ignore refs/replace mechani=
sm,
while everybody else pay attention to it, you will be able to safely
transfer the "graft" information via usual clone/fetch/push mechanism,
while making things like log, bisect and show just work, pretending as =
if
the commit cca17048 were made by JES and not by JS.
