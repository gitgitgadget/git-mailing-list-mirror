From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Introduce rename factorization in diffcore.
Date: Thu, 06 Nov 2008 17:10:09 -0800
Message-ID: <7vy6zwgx3i.fsf@gitster.siamese.dyndns.org>
References: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth>
 <20081101220319.1116.50509.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 02:12:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyFtC-0004qB-K5
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 02:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbYKGBK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 20:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754103AbYKGBK2
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 20:10:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbYKGBK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 20:10:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B9CA79437;
	Thu,  6 Nov 2008 20:10:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 213C27942B; Thu,
  6 Nov 2008 20:10:16 -0500 (EST)
In-Reply-To: <20081101220319.1116.50509.stgit@gandelf.nowhere.earth> (Yann
 Dirson's message of "Sat, 01 Nov 2008 23:03:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC1B75D0-AC68-11DD-BA4E-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100274>

Yann Dirson <ydirson@altern.org> writes:

> Rename factorization tries to group together files moving from and to
> identical directories - the most common case being directory renames.
> We do that by first identifying groups of bulk-moved files, and then
> hiding those of the individual renames which carry no other
> information (further name change, or content changes).
> This feature is activated by the new --factorize-renames diffcore
> flag.

I have a mixed feeling about this one, primarily because I cannot
visualize how a useful output should look like.  Unless you rename one
directory to another without any content changes, you would have to say
"this directory changed to that, and among the paths underneath them, this
file have this content change in addition".

A related feature that would benefit from something like your change
without any downside/complication of output format issues is to boost
rename similarity score of a path when its neighbouring paths are moved to
the same location.  E.g. when you see:

 - three files a/{1,2,3} deleted;
 - three files b/{1,2,3} created;
 - (a/1 => b/1) and (a/2 => b/2) are similar enough;
 - (a/3 => b/3) are not similar enough.

we currently detect only two renames and leave deletion of a/3 and
creation of b/3 unpaired.  You should be able to help them paired up by
noticing that the entire a/* goes away (for that, reading the full
postimage like you do in your patch helps) and boost the similarity score
between these two.

Although I do not offhand think a good format to show the information you
are trying to capture in the textual diff output, one thing that would be
helped by the grouping of renames like you do would be process_renames()
in merge_recursive.c.  This is especially so when you have added a new
path in a directory that has been moved by the other branch you are
merging.  For this usage, there is no "textual output format" issues.  It
does not even have to be expressed by replacing individual entries from
diffq with entries that represent a whole subtree --- you could for
example keep what diffq.queue records intact, and add a separate list of
directory renames as a hint for users like process_renames() to use.
