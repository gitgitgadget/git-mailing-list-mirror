From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Comments pack protocol description in "Git Community Book"
	(second round)
Date: Sun, 7 Jun 2009 13:43:43 -0700
Message-ID: <20090607204343.GC16497@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com> <200906022339.08639.jnareb@gmail.com> <200906062338.02451.jnareb@gmail.com> <d411cc4a0906061458g494d80dbwe3a5358edfd1d49e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Tony Finch <dot@dotat.at>,
	Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 22:43:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDPDb-0001Z7-Iq
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 22:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbZFGUnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 16:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbZFGUnm
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 16:43:42 -0400
Received: from george.spearce.org ([209.20.77.23]:56142 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbZFGUnl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 16:43:41 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DB3F2381FD; Sun,  7 Jun 2009 20:43:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <d411cc4a0906061458g494d80dbwe3a5358edfd1d49e@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121001>

Scott Chacon <schacon@gmail.com> wrote:
> In addition to that, I started taking a shot at putting together an
> RFC formatted documentation of this protocol as was requested.
...
> http://git-scm.com/gitserver.txt

SSH is described by RFC 4251 and RFC 4254.  Reference it when you
mention it.

Section 2.2.3 Commit is missing spaces after the parent, author,
committer, encoding headers:

>  parent    = "parent" + sha + \n
>  userinfo  = NAME <EMAIL> TIME
>  author    = "author" + userinfo + \n
>  committer = "committer" + userinfo + \n
>  encoding  = "encoding" + encoding + \n

2.2.4. Tag, same problem.

>   At the end of the
> packfile is a 20-byte SHA1 sum of all the shas in that packfile.

No.  The SHA-1 checksum on the footer of the pack is over all of
the preceeding bytes of the pack.

> (B << 4) & A bytes when expanded

No.  (B << 4) | A bytes when expanded.

>  [1 byte]   | 1 | type (3) | size A (4)     |  |- object #3 header
>             +-------------------------------+  |
>  [1 byte]   | 0 | size data B (7)           |  |
>             +-------------------------------+  |
>  [1 byte]   | 0 | size data C (7)           |  |
>             +-------------------------------+ -+
>             | compressed object data        | (C << 11) & (B << 4) & A
>             |                               | bytes when expanded

The B byte has the high bit set (1).  And the length is
(C << 11) | (B << 4) | A.

Also, I found reading that difficult, and it doesn't mention the
OBJ_REF_DELTA or OBJ_OFS_DELTA cases.

You also need to note that the version number in the file header
is currently '2', as described by this RFC.

>    Finally, the trailer records 20-byte SHA1 checksum of the rest of the
>   file.

Like I said above, its the preceeding bytes of the pack.

Section 4.2 Git Protocol, explain the git:// URI first, and then
how a client splits that into the request, and then how it formats
the request.  Don't forget to include an example with a non-standard
port number.

Also document what the standard port number is.

Elsewhere in the document you say 'upload-pack' or 'receive-pack'.
I think you should be saying 'git-upload-pack' or 'git-receive-pack'
everywhere, as these are the formal names in the protocol.

Section 5.2, Capabilities:

>  Client sends space separated list of capabilities it wants.  It
>  SHOULD send a subset of server capabilities, i.e do not send
>  capabilities served does not advertise.  The client SHOULD NOT ask
>  for capabilities the server did not say it supports.

I thought we had said it was client MUST send a subset of server
capabilities; client MUST NOT ask for capabilities server did
not advertise support of.

>  Server MUST ignore capabilities it does not understand.  Server MUST
>  NOT ignore capabilities that client requested and server advertised.

I think that's just lazy coding on the server part.  If the server
gets a capability request it can't honor, it MUST abort, it might
corrupt the stream to the client.

> 5.2.1.  multi-ack
>
>  The 'multi-ack' capability allows the server to return "ACK $SHA1

multi_ack

>  Without multi_ack, a client sends have lines in --date-order until
>  the server has found a common base.  That means the client will send

Explain --date-order, don't assume the reader knows it.

I'm giving up for now.  :-)

-- 
Shawn.
