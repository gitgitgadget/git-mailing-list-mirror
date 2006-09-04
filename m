From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH][RFC] Add git-archive-tree
Date: Tue, 05 Sep 2006 00:02:26 +0200
Message-ID: <44FCA272.7040907@lsrfire.ath.cx>
References: <44F977C0.4060901@lsrfire.ath.cx>	<44F982BD.1050509@lsrfire.ath.cx>	<cda58cb80609021313p5156a14du4895e53387dd24dc@mail.gmail.com>	<44FC6EDE.4010300@lsrfire.ath.cx> <7vy7szmm1u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 05 00:03:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKMXe-0005rM-Ba
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 00:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWIDWDi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 4 Sep 2006 18:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWIDWDi
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 18:03:38 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:45011
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S964948AbWIDWDh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 18:03:37 -0400
Received: from [10.0.1.3] (p508E6401.dip.t-dialin.net [80.142.100.1])
	by neapel230.server4you.de (Postfix) with ESMTP id 7E8321B029;
	Tue,  5 Sep 2006 00:03:19 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7szmm1u.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26438>

Junio C Hamano schrieb:
> So to recap:
>=20
> - "git-archive-tree --format <foo> <foo specific options> <tree>"=20
> would know how to create <foo> format archive and send the result to
> stdout.
>=20
> - "git-download-archive <repo> <git-archive-tree-command-line>" would
> talk with "git-upload-archive" in the remote repository, give
> archive-tree command line to it and receives the result.
>=20
> - "git-upload-archive <repo>" is not used by the end user. Underlying
> git-archive-tree command line options are sent over the protocol from
> download-archive, just like upload-tar does.
>=20
> If this is what you mean, I think three of us are in agreement here.

Well, this is just _one_ of the positions I've taken on this topic, I
have to admit.  Franck then convinced me that merging downloader and
archiver into one command is nice for users (less commands to remember,
keeps existing --remote option) even if it doesn't make sense
technically, because their implementations have nothing in common.

This is a bikeshed colour discussion, and I'm bad at it.  I'll shut up
on this and simply follow the directions above.

>> My next steps will be to make traverse_tree() support path specs,
>> in order to achieve feature parity with read_tree_recursive().  I
>> hope that the former keeps being significantly faster than the
>> latter even after that.
>=20
> A thing that have been bothering me for some time in pathspec area is
> that we have two (eh perhaps three) quite different pathspec
> semantics.
>=20
> - diff-tree family (and anything based on revision.c including=20
> git-log) is a strict prefix directory match (e.g. no wildcards, and
> "Documentation/howto" matches the directory but not
> "Documentation/howto-index.sh")
>=20
> - ls-files family (ls-files used to be an one odd man out, but=20
> git-grep mimics it, and "git-commit <paths>" uses ls-files internally
> so they form a family) is prefix match with fnmatch match upon
> wildcard (e.g. "Documentation/howto" still matches the directory but
> not "Documentation/howto-index.sh", but you can say
> "Documentation/howto*" to match both, and you can even say
> "Document*").
>=20
> The former semantics is very friendly with "struct tree_desc" based
> traversal.  Allowing pathspecs with ls-files style matching would
> probably more useful but more work.  And there are at least four
> implementations of pathspec matcher with slightly different
> interfaces (ugh, sorry) if I am not mistaken: builtin-ls-files.c has
> one (match), tree-diff.c has another (interesting), builtin-grep.c
> has one (pathspec_matches), dir.c has another (match_pathspec).
>=20
> We might be able to share code with para-walk.c in "pu" (it is=20
> designed to walk zero or more trees optionally with index and working
> tree in parallel and we would be using it to walk only single tree
> without index nor working tree).  That would give me an incentive to
> clean up the code ;-) Currently it is a ten "WIP" patch series.
>=20
> One thing it attempts to do on the side is to consolidate the=20
> diff-tree style ones into one by introducing another in read-cache.c
> (pathname_included) but it does not convert existing users of other
> matchers to use it yet.

Interesting.  OK, I'll check out the existing implementations with an
eye on consolidation and also take a look around that scary place named
'pu'. ;-)

So far I have failed in creating a traverse_tree() function with path
spec match support which also is faster than read_tree_recursive().
Maybe the speed difference between 'git-tar-tree' and 'git-archive-tree
-ftar' is caused by something else.  I keep on trying.

Ren=E9
