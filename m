From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-revover-tags-script
Date: Sun, 17 Jul 2005 23:36:16 -0700
Message-ID: <7vr7dw8vtr.fsf@assigned-by-dhcp.cox.net>
References: <m1u0iuo63i.fsf@ebiederm.dsl.xmission.com>
	<7vr7dy9rw4.fsf@assigned-by-dhcp.cox.net>
	<m1psthomf0.fsf@ebiederm.dsl.xmission.com>
	<7voe91jmc6.fsf@assigned-by-dhcp.cox.net>
	<m1hdetnfjq.fsf@ebiederm.dsl.xmission.com>
	<7v64v8j4qn.fsf@assigned-by-dhcp.cox.net>
	<m164v8oenn.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 08:36:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuPEx-0006iI-OE
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 08:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVGRGgU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 02:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVGRGgU
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 02:36:20 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:48261 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261540AbVGRGgS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2005 02:36:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050718063616.SUUT19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Jul 2005 02:36:16 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> The big question is in what format should we return the heads?
> Just a space separated list of sha1's or a directory hierarchy
> like git-clone-pack uses.

My knee-jerk reaction is something like this:

    $ git-list-remote jg-libata
    9956d54ace3c64512d0c5498e0137180741e5d04	heads/adma
    433e7832818faf93c0f366fea3e14773cdcf3811	heads/adma-mwi
    ...
    80ebd62e0cca50869da2d5159fa4d6b723f0c014	heads/sil24
    9e734775f7c22d2f89943ad6c745571f1930105f	tags/v2.6.12-rc2
    26791a8bcf0e6d33f43aef7682bdb555236d56de	tags/v2.6.12
    ...
    a339981ec18d304f9efeb9ccf01b1f04302edf32	tags/v2.6.13-rc3

That is, SHA1 and path relative to .git/refs separated with a
TAB, and terminated with LF.

I do not care too much about the protocol level, but since we
are not talking about hundreds of heads and tags, probably
the simplest would be to match the same, or use SP instead of
TAB there to match upload-pack protocol.

I think the bigger question is how to help the user manage and
store this information in his .git/refs/tags hierarchy.

The mechanism to store the URL and head in branches/<name>, and
copy the head value in the corresponding refs/heads/<name> was
borrowed from Cogito, and I think it covers the refs/heads side
quite well.  The user gives a name to the branch of a foreign
repository he is interested in, the fetched head from there is
stored in the same <name>, so the namespace under refs/heads and
branches are totally under the user's control.

If somebody cares about automated fetching of all the tags from
a remote repository, probably the easiest way would be to create
a subdirectory that corresponds to the short-hand name and use
that directory to store all tags slurped from there.  But I am
not convinced myself this is that much useful.
