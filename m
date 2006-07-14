From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb.cgi: Teach tree->raw to not require the hash of the blob
Date: Thu, 13 Jul 2006 22:49:06 -0700
Message-ID: <7vhd1kspm5.fsf@assigned-by-dhcp.cox.net>
References: <20060712175220.73131.qmail@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 07:49:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1GYh-0000Pg-UI
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 07:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161264AbWGNFtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 01:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWGNFtJ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 01:49:09 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:10371 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1161265AbWGNFtI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 01:49:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060714054907.LXBT6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Jul 2006 01:49:07 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060712175220.73131.qmail@web31813.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Wed, 12 Jul 2006 10:52:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23876>

Luben Tuikov <ltuikov@yahoo.com> writes:

>> I think _allowing_ to accept filename not hash is a sane change,
>> and would be useful if you want to allow linking to always the
>> HEAD version from external sites,
>
> Indeed, it is useful.
>
>> but I do not think listing the
>> raw link in the tree view without the hash is a good idea.  It
>> makes things quite confusing that "blob" link in its
>> neighbourhood gives the blob from that specific version, but
>> "raw" gives the version from HEAD, even when you are browsing
>> something other than HEAD.
>
> I just thought it to be an easy place to put the "raw"-no-hash
> link.
>
> BTW, Junio, it would be a shame to lose this capability.  How
> would you like to proceed with this?  Where would you like to
> see this kind of link go?

My preference?

Allowing to link the HEAD version from an _external_ source is
useful (i.e. you can put a link in gitwiki to point at a file
and say "the latest is always available at this URL").

We already support these:

        a=blob&f=README
        a=blob&f=README&hb=HEAD
        a=blob&f=README&hb=HEAD~20

but not these:

        a=blob_plain&f=README
        a=blob_plain&f=t/test4012.png

The last example that does not generate text is less of a
problem, thanks to your previous patch, because "sub git_blob"
supports the "filename with or without hash base" syntax and
sends the correct hash to git_blob_plain to fall back, but that
does not help for text files.  This patch corrects that, which
is nice.

However, I do not think the change to "sub git_tree" makes much
sense.  The links within gitweb-generated pages are about
browsing the history.  As I already said, having <blob> link
that is history specific and <raw> link which is not (iow always
goes to HEAD) next to each other is confusing, and you are
making it less easy to get a raw output from a specific version
because you removed that feature from the link and replaced it
with something less useful.

If somebody wants to see what the latest version of a blob looks
like while browsing the history with gitweb, I think it is a
more natural workflow to go to <history> link and find the
latest version.  So maybe you might want to add <raw> link in
the output of the history action?

        Side note: right now, <history> link does not show any
        history newer than the commit that has the link itself;
        maybe there is a room for improvement there but we need
        to be careful not to trash the webserver caching.

Obviously you could go back to the repository top page and start
digging the latest tree from the top, but that is a bit more
cumbersome.
