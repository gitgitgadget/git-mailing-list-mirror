From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCHv10 01/11] fast-import: Proper notes tree
	manipulation
Date: Mon, 7 Dec 2009 08:41:30 -0800
Message-ID: <20091207164130.GD17173@spearce.org>
References: <1260185254-1523-1-git-send-email-johan@herland.net> <1260185254-1523-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 17:42:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHgeq-0006Al-3v
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 17:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935379AbZLGQlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 11:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934935AbZLGQln
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 11:41:43 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:45844 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbZLGQlm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 11:41:42 -0500
Received: by ywh36 with SMTP id 36so4444933ywh.15
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 08:41:49 -0800 (PST)
Received: by 10.101.179.18 with SMTP id g18mr428780anp.57.1260204109289;
        Mon, 07 Dec 2009 08:41:49 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 36sm2583904yxh.13.2009.12.07.08.41.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 08:41:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1260185254-1523-2-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134765>

Johan Herland <johan@herland.net> wrote:
> As stated in the cover letter, I simply cannot store note information in
> the tree_entry mode bits. So, I chose this somewhat more simple and crude
> approach, which I still think solves the problems quite nicely.

Oh, duh.  Of course you can't.  You lose the note mode when the
tree is flushed to disk, purged from memory, and reloaded later.
Whoops, sorry I missed that during the last round of review.
 
> +static uintmax_t do_change_note_fanout(
> +		struct tree_entry *orig_root, struct tree_entry *root,
> +		char *hex_sha1, unsigned int hex_sha1_len,
> +		char *fullpath, unsigned int fullpath_len,
> +		unsigned char fanout)

I think this function winds up processing all notes twice.  Yuck.

tree_content_set() adds a new tree entry to the end of the current
tree.  So when converting "1a9029b006484e8b9aca06ff261beb2324bb9916"
into "1a" (to go from fanout 0 to fanout 1) we'll place 1a at the
end of orig_root, and this function will walk 1a/ recursively,
examining 1a9029b006484e8b9aca06ff261beb2324bb9916 all over again.

If we're here, isn't it likely that *all* notes are in the wrong
path in the tree, and we need to move them all to a new location?
If that's true then should we instead just build an entirely new
tree and swap the root when we are done?

As we empty out a tree the object will be recycled into a pool of
trees which can be reused at a later point.  It might actually make
sense to build the new tree under a different root.  We won't scan
entries we've moved, and the memory difference should be fairly
small as tree_content_remove() will make a subtree available for
reuse as soon as its empty.  So we're only dealing with a handful
of additional tree objects as we do the conversion.

-- 
Shawn.
