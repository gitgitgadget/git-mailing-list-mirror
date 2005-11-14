From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] GIT commit statistics.
Date: Sun, 13 Nov 2005 22:06:19 -0800
Message-ID: <7vwtjb4vc4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	<7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
	<43758D21.3060107@michonline.com>
	<7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net>
	<46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
	<7vy83s95k0.fsf@assigned-by-dhcp.cox.net>
	<46a038f90511131242p4692c74fn20c015998620b9f4@mail.gmail.com>
	<7vlkzr6gzz.fsf@assigned-by-dhcp.cox.net>
	<46a038f90511132001x6a9109fk17593b7ceaf3177e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 07:06:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbXU1-0000wv-LA
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 07:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVKNGGW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 01:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVKNGGW
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 01:06:22 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:10946 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750837AbVKNGGW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 01:06:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114060556.KEYM15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 01:05:56 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90511132001x6a9109fk17593b7ceaf3177e@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 14 Nov 2005 17:01:43 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11768>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On 11/14/05, Junio C Hamano <junkio@cox.net> wrote:
>> In your message you indicated that you use "format-patch" piped
>> to "am".  I think that is a better approach than "rebase" these
>> days
>
> Hmmm. But doesn't deal well with binary changes. We deal with a large
> set of projects, and while we don't manage that many binary files, it
> is just enough that I'll have to pass on only using format-patch.

It shouldn't be too tricky to enhance "git am" (git-apply called
at around line 49 in it) to grok binary differences for this
purpose, because you would have both pre- and post-image blob in
your object database, because the patch is being used only to
replay what you have in your reository, and it records their
abbreviated SHA1 name.

I've never felt need to "merge" the binary files myself and had
never got around doing this, but if you are interested, it would
go something like this:

. Make "index %.7s..%.7s" that abbreviates pre- and post- image
  blob SHA1s in diff.c configurable to spit out full 40 bytes.
  Call that option --full-index-sha1.

. The updated "git rebase" that uses the "format-patch | am" I
  outlined would pass the --full-index-sha1 to format-patch
  (which is pased onto underlying diff-tree -p).

. In apply.c, check if all of the following holds:

    * we have both the full 40-byte old_sha1_prefix[] and
      new_sha1_prefix[]; and

    * what the index records matches old_sha1_prefix[]; and

    * the new blob is found in the object database;

  and for such a path:

    * change parse_chunk() not to barf even on a binary patch.

    * change apply_data() to just declare the patch application
      result is the new blob recorded in the patch.

Hmm.
