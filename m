From: Junio C Hamano <junkio@cox.net>
Subject: Re: updated design for the diff-raw format.
Date: Sat, 21 May 2005 16:16:00 -0700
Message-ID: <7vr7g0dvbj.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 01:15:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZdBH-0003y7-ML
	for gcvg-git@gmane.org; Sun, 22 May 2005 01:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVEUXQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 19:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVEUXQH
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 19:16:07 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:25477 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261275AbVEUXQC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 19:16:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521231601.IADP1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 19:16:01 -0400
To: git@vger.kernel.org
In-Reply-To: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 21 May 2005 16:12:57 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(first of the replayed exchange)

To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half of copy
 detection.
From: Junio C Hamano <junkio@cox.net>
Date: Sat, 21 May 2005 10:56:06 -0700
Message-ID: <7v4qcwihu1.fsf@assigned-by-dhcp.cox.net>

GIT_DIFF_OPTS=--unified=0 is good to me as well (GNU diffutils
2.8.1).

Now I think I am done with diff, except one thing.  And this is
quite an incompatible change so I do not know how well it would
work in practice.  I am not even advocating this.  It is more
like me thinking aloud.

The diff-raw format we have been dealing with (sorry about '\t'
vs ' ' gotcha again) is internally enhanced by diff-core.  It
first introduces entries for unmodified paths; '*' entries that
has the same mode/sha1 in from->to pair are such entries, and
that is what the change in the [PATCH 3/3] is about.

    *100644->100644 blob 233a250...->66818b4... file0
    *100755->100755 blob fc77389...->7b72d3d... file1
    +100644 blob 233a250... file2
    -100755 blob fc77389... file3
    *100644->100644 blob 233a250...->233a250... file4

Then diff-core internally extends the format to make things all
look like this ('*' and '-' are gone and each record acquires
the second path).

    100644->100644 233a250...->66818b4... file0 file0
    100755->100755 fc77389...->7b72d3d... file1 file1
    ______->100644 _______...->233a250... file2 file2
    100755->______ fc77389...->_______... file3 file3
    100644->100644 233a250...->233a250... file4 file4

Internally "______" above are represented with a separate flag
(file_valid), and denotes the absense of either src or dst.

The diff-core is all about manipulating this type of list and
changing one such list into a different list.

For example, rename-edit of file3 into file2 is detected by
diffcore-rename module and these entries:

    ______->100644 _______...->233a250... file2 file2
    100755->______ fc77389...->_______... file3 file3

become:

    100755->100644 fc77389...->233a250... file3 file2

What the diffcore-pickaxe does can also be explained clearly
with this model.  It takes such a list and works as a "grep".

Once we start to think of it this way, it becomes quite tempting
to change the diff-raw format to actually match the above
concept.  Meaning, (1) drop the operation letter +/-/*
(inferrable by looking at the both sides of ->); (2) drop
blob/tree (inferrable it from mode); (3) give two paths (usually
they are the same paths); (4) and perhaps replace '->' with the
same column separator.  Like this:

    100644 100644 233a250... 66818b4... file0 file0
    100755 100755 fc77389... 7b72d3d... file1 file1
    ______ 100644 _______... 233a250... file2 file2
    100755 ______ fc77389... _______... file3 file3
    100644 100644 233a250... 233a250... file4 file4

Again, I am not even advocating this.  It is more like me
still thinking aloud.






