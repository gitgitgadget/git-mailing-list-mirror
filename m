From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] tree_entry_interesting: Only recurse when the pathspec
	is a leading path component
Date: Thu, 2 Apr 2009 13:38:51 +0200
Message-ID: <20090402113851.GA12675@atjola.homenet>
References: <20090331094107.GC3307@atjola.homenet> <20090331150501.GA11446@atjola.homenet> <7vbprfn0ai.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, Anton Gyllenberg <anton@iki.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 13:41:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpLHo-00011e-05
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 13:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757327AbZDBLjE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2009 07:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755652AbZDBLjB
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 07:39:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:47071 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751218AbZDBLjA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 07:39:00 -0400
Received: (qmail invoked by alias); 02 Apr 2009 11:38:57 -0000
Received: from i59F556A8.versanet.de (EHLO atjola.local) [89.245.86.168]
  by mail.gmx.net (mp057) with SMTP; 02 Apr 2009 13:38:57 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+2h5thpHa2fyQHecyl1H2Dkuj/OjFClK6cmyfkuW
	Pf5Z5+xXnxKlYi
Content-Disposition: inline
In-Reply-To: <7vbprfn0ai.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115459>

On 2009.04.01 21:32:05 -0700, Junio C Hamano wrote:
> I'm planning to queue this.
> [Improved version of my patch]

Ah, thanks. Got busy with other stuff, and tried to fix another related
bug in ls-tree which made me forget to send the match_tree_entry fix :-=
/

That other ls-tree bug is with recursing into subdirectories, because
match_tree_entry matches even when the base is a subdirectory, but
ls-tree doesn't actually want that behaviour, I think. For example:

$ git ls-tree --abbrev HEAD git-gui/macosx/AppMain.tcl
100644 blob ddbe633	git-gui/macosx/AppMain.tcl

$ git ls-tree --abbrev HEAD  git-gui/
100644 blob f96112d	git-gui/.gitattributes
100644 blob 6483b21	git-gui/.gitignore
100755 blob b3f937e	git-gui/GIT-VERSION-GEN
100644 blob 3ad8a21	git-gui/Makefile
100755 blob 12e117e	git-gui/git-gui--askpass
100755 blob e018e07	git-gui/git-gui.sh
040000 tree f723285	git-gui/lib
040000 tree 73f3c34	git-gui/macosx
040000 tree 11cd1a0	git-gui/po
040000 tree 144728d	git-gui/windows

$ git ls-tree --abbrev HEAD git-gui/macosx/AppMain.tcl git-gui/
100644 blob f96112d	git-gui/.gitattributes
100644 blob 6483b21	git-gui/.gitignore
100755 blob b3f937e	git-gui/GIT-VERSION-GEN
100644 blob 3ad8a21	git-gui/Makefile
100755 blob 12e117e	git-gui/git-gui--askpass
100755 blob e018e07	git-gui/git-gui.sh
040000 tree f723285	git-gui/lib
100644 blob ddbe633	git-gui/macosx/AppMain.tcl
100644 blob b3bf15f	git-gui/macosx/Info.plist
100644 blob 77d88a7	git-gui/macosx/git-gui.icns
040000 tree 11cd1a0	git-gui/po
040000 tree 144728d	git-gui/windows

The last ls-tree shows all entries from git-gui/macosx/, beacuse the
first pattern makes it descend into that tree and all entries are
matched by the git-gui/ prefix. So the combined ls-tree shows more than
what the individual calls show. Seems wrong to me, but I'm unsure how t=
o
tackle that, assuming that match_tree_entry is right in allowing any
base that's a subdirectory of a specified pathspec.

Bj=F6rn
