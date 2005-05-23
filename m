From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make sure diff-helper can tell rename/copy in the new
 diff-raw format.
Date: Mon, 23 May 2005 11:43:01 -0700
Message-ID: <7vwtpp3hsa.fsf@assigned-by-dhcp.cox.net>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 20:44:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaHs2-0008CA-5a
	for gcvg-git@gmane.org; Mon, 23 May 2005 20:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVEWSnL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 14:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVEWSnL
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 14:43:11 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:31914 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261899AbVEWSnD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 14:43:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523184302.FNRR22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 14:43:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 23 May 2005 07:49:01 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Btw, I still disagree with this notion that the order of the
LT> use of the names makes a difference.

Having slept over it, I think I tend to agree.  I do not mind
annotating diff-raw output with "is this copy or is this rename"
bit anymore.  While we are at it, I would also want to either
(1) add similarity index field to diff-raw output, or (2) drop
similarity index output from the built-in patch output.  I am
inclined to vote for the former right now (if only it is more
fun to watch), but I can easily be dissuaded.

The proposed diff-raw format, in its fully expended form, is this:

in-place edit  :100644 100644 bcd1234... 0123456... file0 file0 . 0
copy-edit      :100644 100644 abcd123... 1234567... file1 file2 C 68
rename-edit    :100644 100644 abcd123... 1234567... file1 file3 R 86
create         :000000 100644 0000000... 1234567... file4 file4 . 0
delete         :100644 000000 1234567... 0000000... file5 file5 . 0
unmerged       :000000 000000 0000000... 0000000... file6 file6 . 0

The two columns added are rename/copy bit and similarity index.
When one->path and two->path are the same, they do not mean
anything but for parser simplicity's sake I'd like to have 0 in
the similarity index field and a dot in copy/rename bit field.

Human readable form should omit two->path and later fields
altogether if one->path == two->path, so the above becomes:

in-place edit  :100644 100644 bcd1234... 0123456... file0
copy-edit      :100644 100644 abcd123... 1234567... file1 file2 C 68
rename-edit    :100644 100644 abcd123... 1234567... file1 file3 R 86
create         :000000 100644 0000000... 1234567... file4
delete         :100644 000000 1234567... 0000000... file5
unmerged       :000000 000000 0000000... 0000000... file6

This has a nice property that diff-helper, aside from its
diff-raw parsing part, can become quite simplified.  It should
lose rename/copy related flags (-M, -C) because they are already
detected by the tool in the upstream of the pipe; and because
rename-copy is an asymmetric operation, it should also lose the
-R flag.  I think it already does a wrong thing when you use
diff-tree brothers with -M or -C and feed diff-helper -R with
the output that contains already matched rename/copy.

The only thing diff-helper _will_ continue to do is to take a
diff-raw output prepared by diff-tree brothers, and generate
what the upstream tool would have generated if it were given
'-p' (and that should have been the case from the beginning).  

Although I think diffcore transformers other than rename/copy
may still be useful (like pickaxe) in diff-helper, that also can
be handled upstream.

