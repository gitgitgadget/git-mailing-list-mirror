From: Jake Goulding <goulding@vivisimo.com>
Subject: post-receive-email - does not handle creating a new branch with same
 HEAD as other branch
Date: Wed, 21 Jan 2009 17:12:51 -0500
Message-ID: <49779DE3.8010906@vivisimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 23:14:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPlL1-0003O5-Qa
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 23:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbZAUWMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 17:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753058AbZAUWMy
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 17:12:54 -0500
Received: from scalix.vivisimo.com ([207.97.211.28]:51830 "EHLO
	mail.vivisimo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbZAUWMy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 17:12:54 -0500
Received: from mail.office.vivisimo.com (mail.office.vivisimo.com [206.210.75.84])
	by mail.vivisimo.com (Postfix) with ESMTP id 35EE7850B30
	for <git@vger.kernel.org>; Wed, 21 Jan 2009 17:12:53 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.office.vivisimo.com (Postfix) with ESMTP id 0B6632E68D0
	for <git@vger.kernel.org>; Wed, 21 Jan 2009 17:12:53 -0500 (EST)
X-Virus-Scanned: amavisd-new at vivisimo.com
Received: from mail.office.vivisimo.com ([127.0.0.1])
	by localhost (mail.office.vivisimo.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fMBWdJb3SjJt for <git@vger.kernel.org>;
	Wed, 21 Jan 2009 17:12:52 -0500 (EST)
Received: from [192.168.0.20] (unknown [192.168.0.20])
	by mail.office.vivisimo.com (Postfix) with ESMTP id 7890A2E68CF
	for <git@vger.kernel.org>; Wed, 21 Jan 2009 17:12:52 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106687>

Given the simple case of two commits:

A--B

with branches setup like:
master: A
b1: B

If I create a new branch b2 at the same point as b1 from a remote server:

$ git push origin B:b2

The following code will be run in post-receive-email:

git rev-parse --not --branches |
grep -v $(git rev-parse $refname) |
git rev-list --pretty --stdin $newrev

(refname = refs/heads/b2, newrev=B)

The problem occurs because the first rev-parse reports:

^A
^B
^B

And the grep removes lines matching B, leaving:

^A

which causes the eventual rev-list command to be:

git rev-list --pretty ^A B

This problem could be exaggerated if there were a lot of commits between
 A and B, which would cause each commit A..B to be reported.

Is there any alternate way to write this command to cause these false
positives to not be reported? I tried to write a version that uses the
ref name instead of the hash, but it did not end up very pretty (and I
don't think it worked...).

Thanks!

-Jake
