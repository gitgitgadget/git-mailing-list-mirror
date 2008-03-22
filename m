From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RFC] add Message-ID field to log on git-am operation
Date: Sat, 22 Mar 2008 12:51:34 -0700
Message-ID: <7v4payilkp.fsf@gitster.siamese.dyndns.org>
References: <1206136805-20115-1-git-send-email-agladkov@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anton Gladkov <agladkov@parallels.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 20:52:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd9lY-0005Yw-74
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 20:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbYCVTvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 15:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753978AbYCVTvv
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 15:51:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbYCVTvu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 15:51:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4EA78151D;
	Sat, 22 Mar 2008 15:51:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9453D151A; Sat, 22 Mar 2008 15:51:44 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77845>

This is a mixed bag.

Your changes to mailinfo is fine, and I think it may make even more sense
to also parse out In-Reply-To: and References: to capture the message
context better.

On the other hand, I'd NAK changes to pretty.c and commit-tree.c; it is
wrong to place that information in new commit object header.  The commit
object header is a place to store information common to all commit objects
(authorship and committer) and the structural information that is required
to correctly handle the commit objects (pointers to trees and commits, and
encoding that tells what the message part is in if it is not in UTF-8).

Just like workflows inspired by the kernel project use Signed-off-by: and
Acked-by: information in the commit message part to keep track of the flow
of patches, and some distro folks say "Closes #nnn" in their messages to
close their issue tracking system entries, your "message" is information
only useful to a particular workflow and convention, and belongs to the
commit log message body, not in the object header.

Wouldn't it work equally well to use applypatch-msg hook?  Use your
updated mailinfo to parse necessary information out of the incoming
message, and add Message-ID: to the commit log messsage, perhaps at the
end, in that hook?
