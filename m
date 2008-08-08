From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: Make it scream by minimizing temp files
Date: Fri, 08 Aug 2008 15:59:16 -0700
Message-ID: <7vd4kjazaz.fsf@gitster.siamese.dyndns.org>
References: <1218235313-19480-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Sat Aug 09 01:00:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRawk-00025p-27
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 01:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760777AbYHHW71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 18:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761214AbYHHW70
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 18:59:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760777AbYHHW7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 18:59:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3DA2C4DD5D;
	Fri,  8 Aug 2008 18:59:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9AAAC4DD5A; Fri,  8 Aug 2008 18:59:19 -0400 (EDT)
In-Reply-To: <1218235313-19480-1-git-send-email-marcus@griep.us> (Marcus
 Griep's message of "Fri, 8 Aug 2008 18:41:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A456B388-659D-11DD-B779-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91723>

Marcus Griep <marcus@griep.us> writes:

> Currently, git-svn would create a temp file on four occasions:
> 1. Reading a blob out of the object db
> 2. Creating a delta from svn
> 3. Hashing and writing a blob into the object db
> 4. Reading a blob out of the object db (in another place in code)
>
> Any time git-svn did the above, it would dutifully create and then
> delete said temp file.  Unfortunately, this means that between 2-4
> temporary files are created/deleted per file 'add/modify'-ed in
> svn (O(n)).  This causes significant overhead and helps the inode
> counter to spin beautifully.
>
> By its nature, git-svn is a serial beast.  Thus, reusing a temp file
> does not pose significant problems.  "truncate and seek" takes much
> less time than "unlink and create".  This patch centralizes the
> tempfile creation and holds onto the tempfile until they are deleted
> on exit.  This significantly reduces file overhead, now requiring
> at most three (3) temp files per run (O(1)).

Beautifully written analysis of the issue being tackled.

But optimization patch should be backed by numbers --- do you have a
benchmark result of some sort that you would want to include here?
