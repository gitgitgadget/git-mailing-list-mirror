From: Sam Vilain <sam@vilain.net>
Subject: Re: Git performance results on a large repository
Date: Mon, 06 Feb 2012 13:17:15 -0800
Message-ID: <4F30435B.5070709@vilain.net>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>,<CACsJy8DkLCK0ZUKNz_PJazsxjsRbWVVZwjAU5n2EAjJfCYtpoQ@mail.gmail.com> <243C23AF01622E49BEA3F28617DBF0AD5912CA85@SC-MBX02-5.TheFacebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 22:17:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuVwH-0005w7-E2
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 22:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707Ab2BFVRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 16:17:20 -0500
Received: from uk.vilain.net ([92.48.122.123]:48359 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753979Ab2BFVRS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 16:17:18 -0500
Received: by uk.vilain.net (Postfix, from userid 1001)
	id C3C538275; Mon,  6 Feb 2012 21:17:17 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by uk.vilain.net (Postfix) with ESMTP id D18F08075;
	Mon,  6 Feb 2012 21:17:15 +0000 (GMT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <243C23AF01622E49BEA3F28617DBF0AD5912CA85@SC-MBX02-5.TheFacebook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190106>

 > Sam Vilain: Thanks for the pointer, i didn't realize that
 > fast-import was bi-directional.  I used it for generating the
 > synthetic repo.  Will look into using it the other way around.
 > Though that still won't speed up things like git-blame,
 > presumably?

It could, because blame is an operation which primarily works on
the source history with little reference to the working copy.  Of
course this will depend on the quality of the implementation
server-side.  Blame should suit distribution over a cluster, as
it is mostly involved with scanning candidate revisions for
string matches which is the compute intensive part.  Coming up
with candidate revisions has its own cost and can probably also
be distributed, but just working on the lowest loop level might
be a good place to start.

What it doesn't help with is local filesystem operations.  For
this I think a different approach is required, if you can tie
into fam or a similar inode change notification system, then you
should be able to avoid the entire recursive stat on 'git
status'.  I'm not sure --assume-unchanged on its own is a good
idea, you could easily miss things.  Those stat's are useful.

Making the index able to hold just changes to the checked-out
tree, as others have mentioned, would also save the massive reads
and writes you've identified.  Perhaps a more high performance
back-end could be developed.

 > The sparse-checkout issue you mention is a good one.

It's actually been on the table since at least GitTogether 2008;
there's been some design discussion on it and I think it's just
one of those features which doesn't have enough demand yet for it
to be built.  It keeps coming up but not from anyone with the
inclination or resources to make it happen.  There is a protocol
issue, but this should be able to fit into the current extension
system.

 > There is a good question of how to support quick checkout,
 > branch switching, clone, push and so forth.

Sure.  It will be much more network intensive as you are
replacing the part which normally has a very fast link through
the buffercache to pack files etc.  A hybrid approach is also
possible, where objects are fetched individually via fast-import
and cached in a local .git repo.  And I have a hunch that LZOP
compression of the stream may also be a win, but as with all of
these ideas, it would be after profiling identifies it as a choke point 
than just because it sounds good.

 > I'll look into the approaches you suggest.  One consideration
 > is coming up with a high-leverage approach - i.e. not doing
 > heavy dev work if we can avoid it.

Right.  You don't actually need to port the whole of git to Hadoop 
initially, to begin with it can just pass through all commands to a 
server-side git fast-import process.  When you find specific operations 
which are slow then these specific operations can be implemented using a 
Hadoop back-end, and the rest backed to the standard git.  If done using 
a useful plug-in system, these systems could be accepted by the core 
project as an enterprise scaling option.

This could let you get going with the knowledge that the scaling option 
is there should it come out.

 > On the other hand, it would be nice if we (including the entire
 > community:) ) improve git in areas that others that share
 > similar issues benefit from as well.

Like I say, a lot of people have run into this already...

HTH,
Sam
