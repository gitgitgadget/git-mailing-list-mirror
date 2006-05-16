From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] Add "rcs format diff" support
Date: Tue, 16 May 2006 21:49:00 +0100
Message-ID: <20060516204900.GA9051@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0605131405590.3866@g5.osdl.org> <20060514001214.GB27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Tue May 16 22:49:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg6U4-0003zD-FA
	for gcvg-git@gmane.org; Tue, 16 May 2006 22:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWEPUtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 16:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWEPUtJ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 16:49:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37578 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750751AbWEPUtI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 16:49:08 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1Fg6TU-0002TA-MD; Tue, 16 May 2006 21:49:00 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20060514001214.GB27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20137>

Use:
	diff-remap-data <dir1> <dir2> >map
or
	git-remap-data <git-diff arguments> >map
will build information for remapper,
	git-remap <map> <options>
will do line numbers remapping.

git-remap is a filter.  It takes map as argument and, in the simplest form,
will look at the lines in stdin that have form
<filename>:<number>:<text>
If the indicated line from old tree had survived into the new one, we will
get
N:<new-filename>:<new-number>:<text>
on the output.  If it hadn't, we get
O:<filename>:<number>:<text>
Lines that do not have such form are passed unchanged.

Even that is already very useful for log comparison.  E.g. if old-log is
from the old tree and new-log is from the new one, we can do
	git-remap map <old-log >foo
	git-remap /dev/null <new-log >bar
	diff -u foo bar
and have the noise due to line number changes excluded (empty map means
identity mapping, so the second line will simply slap N: on all lines of
form <filename>:<number>:<text> in new-log).

Note that it's not just for build logs; the thing is useful for sparse logs,
grep -n output, etc., etc. 

Behaviour described above is the default; what _really_ happens is
that we take lines of form
<original_prefix><filename>:<number>:<text>
and replace them with
<prefix_for_new><new-filename>:<new-number>:<text>
or
<prefix_for_old><filename>:<number>:<text>
Defaults are :", "N:" and "O:" resp.; what it gives us is the ability to
do multiple remappings.  IOW, we can say

diff-remap-data old-tree newer-tree > map1
diff-remap-data newer-tree current-tree > map2
git-remap -o old: map1 <old-log | git-remap -p N: -o newer: -n current: map2>foo

and get lines that didn't make it into the newer tree marked with old: and
otherwise be unchanged, ones that made it to newer, but not the current to
be marked with newer: and have the filenames/line numbers remapped and ones
that made it all the way be marked with current: and remapped all the way
to current tree.

That's quite useful when you want to carry logs for a while, basically using
them as annotated TODO ("logs" here can very well be results of grep -n with
annotations added to them).  You can have all still relevant bits stay with
the locations in text and see what had fallen out.

Note on relation to git:
	* git-remap, despite the name, doesn't need git to work
	* diff-remap-data doesn't need git to work
	* git-remap-data _does_ need it.  Aside of working on revisions in
git repository instead of a couple of directory trees, it generates slightly
better map than diff-remap-data does.  I.e. it manages to remap more lines -
it does notice renames.

This stuff lives on ftp.linux.org.uk/pub/people/viro/remapper/; I'm not
sure what to do with it wrt distributing - submit for inclusion into
git, or leave that sucker standalone.  It can be used without git, but
OTOH having it in git would make my life easier - I wouldn't have to
think about packaging it myself ;-)

Seriously,
	a) feel free to play with it; hopefully it will be useful.
	b) review and comments are welcome.
	c) so would any thoughts regarding the right way to distribute it.
