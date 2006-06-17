From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: safely output binary files for 'blob_plain' action
Date: Sat, 17 Jun 2006 14:13:30 -0700
Message-ID: <7v8xnv8ozp.fsf@assigned-by-dhcp.cox.net>
References: <200606171332.15591.jnareb@gmail.com>
	<20060617153540.GI2609@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Kay Sievers <kay.sievers@vrfy.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 23:13:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fri6p-0005qB-EX
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 23:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWFQVNc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 17:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWFQVNc
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 17:13:32 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:235 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750910AbWFQVNc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 17:13:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060617211331.ZNKM554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Jun 2006 17:13:31 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22030>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Sat, Jun 17, 2006 at 01:32:15PM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>> Introduced new configuration variables: $default_blob_plain_mimetype 
>> and $default_text_plain_charset (only 'utf-8' is guaranteed to work
>> for the latter).
>
> Nah, defaulting to 'utf-8' is horrible - usually, you just don't have a
> clue and should refrain from sending any charset information at all, so
> I think undef is a much saner default.

Concurred.  I see Jakub's second patch to make this
configurable, but I wonder about a few things:

 - we might want to have a configuration mechanism in place
   before enhancing gitweb.  My gut feeling is that we can use
   [gitweb] section in project.git/config (and probably
   duplicate first and deprecate later existing "description" as
   well).

 - the blob charset should be per path -- otherwise the feature
   would be not useful for projects that maintains bunch of po
   files.

In other words, something like this:

  (in torvalds/linux-2.6.git/config)

	[gitweb]
        description = "Linus's kernel tree"
        ; defaultblobcharset = "latin1"
        blobmimemapfile = "mime-map"

  (in torvalds/linux-2.6.git/mime-map, first match decides)

	fs/nls/nls_euc-jp.c	text/plain; charset=euc_jp
        *.c	text/plain; charset=utf-8
        *.h     text/plain; charset=utf-8

I do not think defaultblobcharset above is a good idea though.
You could just have the last entry in mime-map file to be:

        *	text/plain; charset=latin1
