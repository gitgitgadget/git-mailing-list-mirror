From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Honor extractor's umask in git-tar-tree.
Date: Mon, 03 Oct 2005 09:30:18 -0700
Message-ID: <43415C9A.1090502@zytor.com>
References: <20050930160353.F025C352B7B@atlas.denx.de>	<Pine.LNX.4.64.0510010934290.3378@g5.osdl.org>	<7vr7b53y0n.fsf@assigned-by-dhcp.cox.net>	<7vk6gx3vkt.fsf_-_@assigned-by-dhcp.cox.net>	<433F52DC.5090906@zytor.com>	<pan.2005.10.02.09.55.52.564046@smurf.noris.de>	<4340B73B.1090409@zytor.com> <7virwfuqwv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 18:30:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMTCv-0004zI-Lh
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 18:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVJCQa1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 12:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVJCQa1
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 12:30:27 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:57230 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1751163AbVJCQa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2005 12:30:26 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j93GUDJv011578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Oct 2005 09:30:14 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virwfuqwv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9637>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>My point is that I believe it should.  It has the bitfield for it, it 
>>just doesn't use it at the moment.
> 
> 
> It is a bit more complicated than that.
> 
> Long time ago, we used to store the full permission bits and
> ended up storing files in 0644 and 0664 modes, depending on who
> is writing the tree object.  People with umask 022 checked out
> from a tree that recorded blobs with 0664 bits and ended up
> getting "mode changed" diff all the time, which was unacceptable
> from the SCM point of view.  We _could_ have really changed the
> mode bits representation in the tree objects back then to have
> type + executable bit, but to preserve backward compatibility,
> we chose to keep the bitfield layout and changed the code to
> treat 1006xx and 1007yy in older trees to be equivalent to
> 100644 and 100755.  These days, for newly written tree objects,
> above xx and yy 6-bit fields are "Must Be 4" and "Must Be 5"
> fields, respectively, not bitfields to store arbitrary group and
> other permission information.  git-fsck-objects even complains
> about them.
> 
> So in that sense, it does _not_ have the bitfield for it, and
> obviously we cannot use what we do not have.
> 

Welcome to the wonderful world of evolving file formats.

As you stated above, we currently use this field in a very inefficient 
manner, because of old mistakes.  There are several ways to recover from 
here, some of which are more complex than others.

In the case of git, there isn't just the requirement to maintain old 
formats indefinitely (due to the cryptographic chain), but also that new 
objects that are compatible with old format should be written in the old 
format to maintain the aliasing properties.  These are obstacles that 
are perfectly possible to overcome, although it takes a bit of legwork.

If the old-format (with random write bits) is out of circulation -- 
which I can't tell for sure they it is, but Linus' kernel tree doesn't 
seem to have any of these objects -- then the answer is very simple: 
redefine this field _a posteori_ to be the mode ^ 022 (or perhaps more 
sanely,
mode ^ (mode & 0200 ? 022 : 0)).  Compatibility and contents is fully 
preserved.  No problem.

If there are still old-format trees in circulation and compatibility 
with these very old trees need to be maintained, then it's a bit more 
complicated, but literally just a bit.  This data is already stored in 
text form in the object store, so there aren't any funnies with 
expanding it.  For example, encode a leading + on the octal value if 
this is a value with "I really mean it" permissions (and *only* those 
values.)  This is even readable by older versions of git, since they 
will just blindly ignore the + sign.

	-hpa
