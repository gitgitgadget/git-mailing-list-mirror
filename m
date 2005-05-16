From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Summary of core GIT while you are away.
Date: Mon, 16 May 2005 09:10:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: pasky@ucw.cz, braddr@puremagic.com, nico@cam.org,
	david@dgreaves.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 16 18:09:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXi8q-0001Ca-5R
	for gcvg-git@gmane.org; Mon, 16 May 2005 18:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVEPQIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 12:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVEPQIo
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 12:08:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:52690 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261724AbVEPQId (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2005 12:08:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4GG87U3026205
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 May 2005 09:08:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4GG85qa008837;
	Mon, 16 May 2005 09:08:06 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.39__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org




On Sat, 14 May 2005, Junio C Hamano wrote:
>
> Hoping that you had a good time during your vacation, and at the
> same time also hoping to help you catch up with GIT traffic,
> here is my version of the summary of things that happened in the
> GIT community around core GIT [*1*].

Thanks. I'm back and reading email, but have by no means caught up yet.

Anyway, everythign I've read so far makes sense, and it might make sense
to continue git development using just git-pb. The only thing I personally
think sucks is the author/committer matching of git-rev-list/tree, since
it would seem like somebody might well like to match on an arbitrary part
of a commit, and special-casing author/committer seems somewhat broken. 
But that's a fairly minor nit.

I personally suspect that both git-rev-list and git-rev-tree should have
an alternate output format that could be more easily grepped by subsequent
commands. For example, right now git-rev-list just outputs a list of
commit ID's, and it might make sense to have a flag to just append the
commit message to the output, and zero-terminate it (and if the commit
message has a NUL byte in it, just truncate it at that point).

Then you could just do

	git-rev-list -v --header HEAD | grep -z 'author[^\n]*Linus'

to tell it to do the "verbose" thing (only showing the header of the 
commit, not the whole message), and grep for "Linus" in the author line.

Or, if you want to see all commits that are signed off by so-and-so, do:

	git-rev-list -v HEAD | grep -zi 'signed-off-by:[^\n]*so-and-so'

and it would still be pretty efficient, and a _lot_ more generic and 
flexible than the "--author" and "--committer" flags.

I also suspect that a lot of uses if git-rev-{tree|list} actually want to 
see the commit stuff anyway, ie things like gitweb etc currently likely 
end up doing a separate "git-cat-file commit <sha1>" to get the whole 
commit information, which the "-v" flag would just give directly.

The only question is whether you want to have it be human-readable by
default (indent the message lines with a <tab>, and nonheaders with
<tab>+4*<space> or something), and then have a "-z" flag to do the
machine-readable version described above.

Hmm?

		Linus
