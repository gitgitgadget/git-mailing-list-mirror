From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] get_tree_entry: map blank requested entry to tree root
Date: Tue, 9 Jan 2007 19:46:33 -0500
Message-ID: <20070110004633.GA14345@coredump.intra.peff.net>
References: <20070109161147.GA9313@coredump.intra.peff.net> <7vk5zviwxa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Rbz-0005AO-AJ
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbXAJAqg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbXAJAqg
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:46:36 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1024 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932548AbXAJAqg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:46:36 -0500
Received: (qmail 27471 invoked from network); 9 Jan 2007 19:46:47 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 9 Jan 2007 19:46:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jan 2007 19:46:33 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk5zviwxa.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36446>

On Tue, Jan 09, 2007 at 03:48:33PM -0800, Junio C Hamano wrote:

> Makes sense, although I somewhat worry about changing the
> behaviour and potentially breaking the expectation of callers
> of get_tree_entry() other than "git show".

Previously, trying to get an empty name would always return -1. Most of
the users besides sha1_name are getting the paths by enumerating the
index or an existing tree, so they will never be blank. The exceptions
are:
 - git-blame ''; this fails in both the root and a subdir (though with
   different errors); behavior is unchanged with my patch
 - git-archive feeds the 'prefix' variable to get_tree_entry; it works
   fine in the root with or without the patch. I seem to be getting an
   error, with or without my patch, when doing a git-archive from a
   subdirectory:
     $ git-archive --format=tar origin >/dev/null
     $ cd Documentation
     $ git-archive --format=tar origin >/dev/null
     fatal: cannot read c87c61af00c6d2cd7212240e260809000000aaab
   but I haven't been able to track it down further. It's clearly
   unrelated to my patch, though.

The main difference is that looking up a ref through sha1_name used to
fail to match 'HEAD:'; now it does. So if you were trying to match a
file 'HEAD:' without using '--', you're out of luck.

-Peff
