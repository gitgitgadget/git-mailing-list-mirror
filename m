From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Retry conflicting merge with matching line endings?
Date: Tue, 17 Feb 2009 18:18:58 -0800
Message-ID: <7v8wo41o8d.fsf@gitster.siamese.dyndns.org>
References: <2729632a0902171755n3e89e717p6b3a38b556252bfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 18 03:20:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZc38-0004hS-Nq
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 03:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbZBRCTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 21:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752947AbZBRCTG
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 21:19:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbZBRCTF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 21:19:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 660A19AFFE;
	Tue, 17 Feb 2009 21:19:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 461199AFFC; Tue,
 17 Feb 2009 21:18:59 -0500 (EST)
In-Reply-To: <2729632a0902171755n3e89e717p6b3a38b556252bfb@mail.gmail.com>
 (skillzero@gmail.com's message of "Tue, 17 Feb 2009 17:55:42 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 82CB002C-FD62-11DD-8FB3-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110496>

skillzero@gmail.com writes:

> I've been running into a lot of merge conflicts due to line endings
> changing. For example, I branch from master when a file has CRLF line
> endings (incorrectly) then somebody fixes a bug in that file (still
> has CRLF line endings) on master then I realize the file should have
> LF line endings so I change them. When I try to rebase on master
> later, I get a merge conflict because it looks like every line has
> changed and it conflicts with that other bug fix.
>
> Would it be reasonable that if you get a conflict during a merge and
> the line endings of the two commits are different then change the line
> endings to match, retry the merge of that file, then apply the line
> ending change commit?

This is not specific to fixing line ending but applies any "global token
replacement" (e.g. you renamed a variable) operation in general.

Suppose the conflicted path is hello.c when you were merging branch
"other", e.g. 

	$ git merge other
	$ git ls-files -u
        100644 b040a96e50... 1	hello.c	
	100644 6b9c715d21... 2	hello.c
	100644 1c57d4c958... 3	hello.c

You can first extract the blobs involved into plain files, apply such
"global token replacement" (be it fixing the line ending or renaming a
variable) to the common ancestor version and the other's version, and run
three-way file-level merge.

	$ git cat-file blob :1:hello.c | replacement_filter >ancestor
        $ git cat-file blob :2:hello.c >mine
        $ git cat-file blob :3:hello.c | replacement_filter >theirs
	$ git merge-file mine ancestor theirs

where replacement_filter would be whatever global replacement you did to
your version since the ancestor (e.g. dos2unix).

The "mine" file merge-file leaves will hopefully have much smaller
conflicts, as it won't have to see your line endings change.  If it looks
Ok, cat it into hello.c and "git add" it.
