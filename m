From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tree_entry_interesting: Only recurse when the pathspec
 is a leading path component
Date: Fri, 03 Apr 2009 09:25:29 -0700
Message-ID: <7veiw9aeme.fsf@gitster.siamese.dyndns.org>
References: <20090331094107.GC3307@atjola.homenet>
 <20090331150501.GA11446@atjola.homenet>
 <7vbprfn0ai.fsf@gitster.siamese.dyndns.org>
 <20090402113851.GA12675@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, Anton Gyllenberg <anton@iki.fi>,
	git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 03 18:28:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpmFS-0003SD-1l
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 18:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934994AbZDCQZk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2009 12:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933201AbZDCQZj
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 12:25:39 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763640AbZDCQZi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2009 12:25:38 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 70CFBBF06;
	Fri,  3 Apr 2009 12:25:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 83435BF05; Fri, 
 3 Apr 2009 12:25:31 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0FFD91C2-206C-11DE-BEA2-781813508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115544>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> On 2009.04.01 21:32:05 -0700, Junio C Hamano wrote:
>> I'm planning to queue this.
>> [Improved version of my patch]
>
> Ah, thanks. Got busy with other stuff, and tried to fix another relat=
ed
> bug in ls-tree which made me forget to send the match_tree_entry fix =
:-/
>
> That other ls-tree bug is with recursing into subdirectories, because
> match_tree_entry matches even when the base is a subdirectory, but
> ls-tree doesn't actually want that behaviour, I think. For example:
>
> $ git ls-tree --abbrev HEAD git-gui/macosx/AppMain.tcl
> 100644 blob ddbe633	git-gui/macosx/AppMain.tcl
>
> $ git ls-tree --abbrev HEAD  git-gui/
> 100644 blob f96112d	git-gui/.gitattributes
> 100644 blob 6483b21	git-gui/.gitignore
> 100755 blob b3f937e	git-gui/GIT-VERSION-GEN
> 100644 blob 3ad8a21	git-gui/Makefile
> 100755 blob 12e117e	git-gui/git-gui--askpass
> 100755 blob e018e07	git-gui/git-gui.sh
> 040000 tree f723285	git-gui/lib
> 040000 tree 73f3c34	git-gui/macosx
> 040000 tree 11cd1a0	git-gui/po
> 040000 tree 144728d	git-gui/windows
>
> $ git ls-tree --abbrev HEAD git-gui/macosx/AppMain.tcl git-gui/
> 100644 blob f96112d	git-gui/.gitattributes
> 100644 blob 6483b21	git-gui/.gitignore
> 100755 blob b3f937e	git-gui/GIT-VERSION-GEN
> 100644 blob 3ad8a21	git-gui/Makefile
> 100755 blob 12e117e	git-gui/git-gui--askpass
> 100755 blob e018e07	git-gui/git-gui.sh
> 040000 tree f723285	git-gui/lib
> 100644 blob ddbe633	git-gui/macosx/AppMain.tcl
> 100644 blob b3bf15f	git-gui/macosx/Info.plist
> 100644 blob 77d88a7	git-gui/macosx/git-gui.icns
> 040000 tree 11cd1a0	git-gui/po
> 040000 tree 144728d	git-gui/windows
>
> The last ls-tree shows all entries from git-gui/macosx/, beacuse the
> first pattern makes it descend into that tree and all entries are
> matched by the git-gui/ prefix. So the combined ls-tree shows more th=
an
> what the individual calls show. Seems wrong to me, but I'm unsure how=
 to
> tackle that, assuming that match_tree_entry is right in allowing any
> base that's a subdirectory of a specified pathspec.

What might be confusing is how ls-tree, when run without an explicit
option -r (ecurse), comes up with candidates to show.  With pathspecs, =
you
are instructing it to recurse into subtrees as deep as needed to discov=
er
all the paths that can match them, and your first pathspec causes the
contents of macosx subtree to be looked at for this reason.

Pathspecs are always OR'ed together, never AND'ed, and your second
pathspec git-gui covers them, so I do not think it is a bug.

If we had a glob support in the "leading path components" pathspec matc=
her
used by ls-tree/diff-tree, I would imagine you could do something like;

	ls-tree --recurse-to=3D'*/*/*' $other $pathspec

to say "recurse three levels, but do not use */*/* as a filter to decid=
e
what to show; the filters are only $other and $pathspec", iow, using

	(AND "*/*/*" (OR $other $pathspec))

semantics.  But I think this kind of complexity falls out of the "usefu=
l"
category and into a "mental exercise" category.
