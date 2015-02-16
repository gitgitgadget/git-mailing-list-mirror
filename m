From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Pack v4 again..
Date: Sun, 15 Feb 2015 23:59:02 -0500 (EST)
Message-ID: <alpine.LFD.2.11.1502152221480.22104@knanqh.ubzr>
References: <CACsJy8CMCTirggRhD28xvv4tM8b4+NL_ruF4LgW293dHAmLYdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 06:14:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNE0Y-0005q3-57
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 06:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbbBPFOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 00:14:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17651 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbbBPFOE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 00:14:04 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Feb 2015 00:14:04 EST
Received: from yoda.home ([66.131.180.142]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0NJU000ULLUFYE90@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 15 Feb 2015 23:59:03 -0500 (EST)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id C9D6C2DA0496; Sun, 15 Feb 2015 23:59:02 -0500 (EST)
In-reply-to: <CACsJy8CMCTirggRhD28xvv4tM8b4+NL_ruF4LgW293dHAmLYdA@mail.gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263868>

On Fri, 13 Feb 2015, Duy Nguyen wrote:

> After taking 1.5 years "vacation" from pack v4, I plan to do something
> about it again. Will post more when I have some patches to discuss.
> Only one question for now (forgive me if I asked already, it's been
> quite some time)

Yeah.  I had to re-study my own code before replying.

> I think pack v4 does not deliver its best promise that walking a tree
> is simply following pointers and jumping from place to place. When we
> want to copy from the middle of another tree, we need to scan from the
> beginning of the tree. Tree offset cache helps, but the problem
> remains. What do you think about an alternative format that each
> "copy" instruction includes both index of the tree entry to copy from
> (i.e. what we store now)  _and_ the byte offset from the beginning of
> the tree? With this byte offset, we know exactly where to start
> copying without scanning from the beginning. It will be a bit(?)
> bigger, but it's also faster.

That would make the format inflexible.  If we want to do partial 
repacking by, say, copying some objects and repacking others (some 
objects might need repacking because the objects they refer to are 
omitted from the repack) then if those repacked objects are themselves 
referred to by byte offset then we lose as the offset is no longer 
valid.

> I imagine this is an optimization that can be done locally. The pack
> transferred over network does not have these byte offsets. After the
> pack is stored and verified by index-pack, we can rewrite it and add
> this info. The simplest way is use a fixed size for this offset (e.g.
> uint16_t or even uint8_t), add the place holder in copy instructions
> of all v4 trees. After that object offsets will not change again and
> we can start filling real offsets to placeholders.

Having a local extra index is fine.  Just like the pack index which is 
always created locally and can be recreated at any time.  Some tree 
offset cache might be beneficial, but I'd avoid making it into the pack 
file itself.

Yet, I think the biggest problem with pack v4 at the moment is the 
packing algorithm for tree objects.  We are piggy-backing on the pack v2 
object delta compression sorting and that produces suboptimal results 
due to deep recursions.  And it is the recursion that kills us. The pack 
v4 requires a new packing algorithm for its tree objects.

What I imagined is something like this:

- Each canonical tree entry is made of a SHA1, mode and path.  Let's 
  assume this is hashed into a 24-bit value.

- Each tree object can therefore be represented as a string of 24-bit 
  "characters".

- Delta-compressing a tree object becomes a substring search where we 
  try to replace a sequence of "characters" with the longest "string" 
  possible from another object.  Repeat with the remaining sequences.

Having a 24-bit hash value is totally arbitrary.  It could be 16 bits 
with more collisions but much faster search and less memory usage.  The 
optimal value would need to be determined after some experimentation.

Algorithms for the longest common substring problem already exist.  So 
one of the classical algorithms could probably be adapted here.

This would allow for exploiting the provision in pack v4 to copy from 
more than one tree object.  And this would also favor shallower 
recursions and even smaller packs.  Imposing a minimum substring length 
(rather than a maximum delta depth) would determine the runtime 
performance when using the pack afterwards.

If you have enough free cycles to work on this, that's what I'd suggest 
you explore at this point. I wish I could myself as I think this ought 
to be rather cool work.


Nicolas
