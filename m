From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/7] Fix leak of color/attributes in "git log --decorate"
Date: Wed,  4 Mar 2015 13:33:16 -0800
Message-ID: <1425504803-16039-1-git-send-email-gitster@pobox.com>
References: <xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 22:33:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTGv6-0007Af-DJ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 22:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbbCDVd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 16:33:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751678AbbCDVd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 16:33:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC5F43C766;
	Wed,  4 Mar 2015 16:33:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ldgx
	PjVA5LP+w9AMScDE4OA9ViI=; b=mx8ieQyW9ZJkl1nd3lYWMu28KMhf7PPY/CzQ
	T6MfvF8zh98ebFeiTbVI8wfVBrThgBlplU6XUl1dzeKf3rjV9iQHKjLZrmEZa1di
	pBPuV3EYNPqV92rNVmNIErThTa90b7TnpSIMet0uzpFdN5WRvoDnvhDVC2TEca46
	IOKCcy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=WjRAu0
	SE1TcS4Yh11gVSh4e98DMVxkIrSqIpt64ylF3vExXtdoBwgeL4FLSuTaMMQd9fvN
	b/IPE2oOMTdY7q4rLsPyAfkkKMllZ/ub1f9ztUiAAk81ZpQ4zoMmEEuspBAFQUVk
	gn0Zox8cmpZd3aODjClmhVFYB/zHuqwWR+FmQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4FA03C765;
	Wed,  4 Mar 2015 16:33:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D98553C763;
	Wed,  4 Mar 2015 16:33:24 -0500 (EST)
X-Mailer: git-send-email 2.3.1-318-g5233f23
In-Reply-To: <xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: 16B9920C-C2B6-11E4-8890-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264781>

In "git log --decorate", you would see the commit header like this:

    commit ... (HEAD, jc/decorate-leaky-separator-color)

where "commit ... (" is painted in color.diff.commit, "HEAD" in
color.decorate.head, ", " in color.diff.commit, the branch name in
color.decorate.branch and then closing ")" in color.diff.commit.

However, setting color.decorate.head to normal does not paint "HEAD"
in the "normal" color you have for your terminal.  It just uses the
same color it used to paint the "(", i.e. color.diff.commit.

Fixing this was a simple one-liner; the code forgot to reset the
terminal attributes before moving on to the next item.

It however turns out that the existing documentation was rather
messy and I ended up doing some preparatory clean-up on the
documentation around how configuration variables are explained
before updating the documentation to clarify that 'normal' ought to
work (in other words, the colors and attributes are not cumulative).

I am reasonably happy with the result, and I can go with or without
[6/7].

The previous round starts at $gmane/264065 [*1*]

Junio C Hamano (7):
  Documentation/config.txt: avoid unnecessary negation
  Documentation/config.txt: explain multi-valued variables once
  Documentation/config.txt: describe the structure first and then meaning
  Documentation/config.txt: have a separate "Values" section
  Documentation/config.txt: describe 'color' value type in the "Values" section
  Documentation/config.txt: simplify boolean description in the syntax section
  log --decorate: do not leak "commit" color into the next item

 Documentation/config.txt         | 111 ++++++++++++++++++++++++---------------
 log-tree.c                       |   1 +
 t/t4207-log-decoration-colors.sh |  16 +++---
 3 files changed, 77 insertions(+), 51 deletions(-)

[Footnote]

*1* http://thread.gmane.org/gmane.comp.version-control.git/264063/focus=264065
    http://mid.gmane.org/xmqqpp9628tl.fsf@gitster.dls.corp.google.com

-- 
2.3.1-316-g7c93423
