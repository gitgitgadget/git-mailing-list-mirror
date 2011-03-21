From: Jeff King <peff@peff.net>
Subject: Re: brtfs COW links and git
Date: Mon, 21 Mar 2011 08:00:51 -0400
Message-ID: <20110321120051.GG16334@sigill.intra.peff.net>
References: <20110319201532.GA6862@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Mon Mar 21 13:01:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1dnA-0002uc-V9
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 13:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229Ab1CUMAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 08:00:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50138
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab1CUMAy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 08:00:54 -0400
Received: (qmail 12576 invoked by uid 107); 21 Mar 2011 12:01:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Mar 2011 08:01:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2011 08:00:51 -0400
Content-Disposition: inline
In-Reply-To: <20110319201532.GA6862@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169586>

On Sat, Mar 19, 2011 at 04:15:32PM -0400, Larry D'Anna wrote:

> I wish git could use COW links.  I wish I could put a large binary into git and
> have the only underlying filesystem operation be to cp --reflink and to save the
> metadata.  There are a few complications:

I have never used reflink, but my understanding is that the proposed
system call just lets us reflink one entire file. So basically the
useful points would be:

  1. on "git add", we could reflink the file into the object db

  2. on "git checkout", we could reflink the object into the working
     tree

The biggest stumbling block is that the object db does not currently
hold unadorned files. They have an object type and size header at the
beginning, and I believe even uncompressed files are stored with a zlib
header. So it would require a completely new section of the object db to
store these files (as opposed to the current loose objects and
packfiles).

Note also that during "git add" we will need to get the sha1 of the
data. So you'll still have to pull all the data from disk, though not
making a copy will save some space and time.

I'm not very knowledgeable on the current state of such things, but
is there any automatic de-duplication in btrfs? If so, does it depend on
data being at the same offsets within files?

> How does it know which files to reflink?  attributes?  a size limit?

Probably supporting both would make sense.

> What does git gc do with reflinks?

If we had a "giant literal blobs" section of the object database, we
would not want to pack those objects during a regular gc. It would kill
your reflink, but also there's just no point in copying some gigantic
file into a pack where it won't actually be delta-compressed.

> Should diff-delta be reflink-aware?  Perhaps it could query the fs for
> blocklists.

Wouldn't it just be sharing underlying data between the working tree and
the object database? How would that help us make deltas between objects?

> Before I dive into implementing this, I'd like to get your comments and advice,
> to maximize the chances of success.

I'm not exactly clear on what you want to implement.

-Peff
