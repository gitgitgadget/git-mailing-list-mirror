From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] streaming conversion API
Date: Fri, 20 May 2011 23:58:43 -0700
Message-ID: <1305961127-26540-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:59:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg9N-0006cw-TC
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab1EUG66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:58:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab1EUG65 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:58:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 786355DE5
	for <git@vger.kernel.org>; Sat, 21 May 2011 03:01:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=Y5Bl03E5dgs6NiD1I5oEUff6Qmo
	=; b=G/6T9+UNm2+72Yl6x0RlU7Qz8k8vIN46JIjHLKrxHb/pGnwqiWHg2WVFHZk
	uNfyEdu2+18QCJ+AiM+QDtqM4BZxhTbb+yqbh/fLRLum/4SCrfzURHedjCpc1+nN
	XmekToEhS8ybkpTMY6baX2CCW2GarbCRl1qmVM9Zmbtnrwt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=LmYgAYhnuM2+z9oMzaHVPIIDsG2oP
	6pbpeBv8+wEwOZ8zpyvDhXZThXZRXehneT0rPqXoJm5GSIjHjQcNB2I+BZu3tnFP
	ztYcKGz0KA9QOCJRk6ygi9umsXfIXn7hjDD1hPwS20enma52/NT+M1kFPJopkgWi
	R7PFH3dcz+BKqQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7633C5DDA
	for <git@vger.kernel.org>; Sat, 21 May 2011 03:01:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F39E25DD9 for
 <git@vger.kernel.org>; Sat, 21 May 2011 03:01:02 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
X-Pobox-Relay-ID: 1775505E-8378-11E0-89B7-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174107>

This builds on top of jc/streaming topic, in which I earlier hinted that a
filtering mechanism that does not need to slurp everything in core can
later be plugged into the git_istream API. This topioc does exactly that.

The first patch moves declarations related to conversion from cache.h to
its own convert.h header file, so that new streaming conversion API can be
added to it without bloating cache.h even more.

The second patch defines the streaming filter API, adds a pass-through
"null" filter, plugs the streaming filter API to the git_istream API and
updates the write out codepath to use it.  The design of this API is an
object-oriented one that is similar to the istream API. The user of the
git_istream API first grabs "stream_filter" object based on the path, and
passes that filter object when creating a git_istream. The data read from
the underlying object is fed to the filter, and the output from the filter
is returned to the caller of the read_istream().

The third patch adds a non-guessing LF-to-CRLF streaming filter.

The fourth patch implements the ident filter. As both LF-to-CRLF and ident
filters can be active at the same time, it also introduces the "cascade"
mechanism that takes two filters, plugs one's output to the other's input,
and feeds the former and returns what is read from the latter.

I suspect that "smudge" filter should be relatively easy to add and
combine with the existing filters using the same cascade mechanism,
but I'll leave it as an exercise to interested readers.

Junio C Hamano (4):
  convert.h: move declarations for conversion from cache.h
  Add streaming filter API
  Add LF-to-CRLF streaming conversion
  streaming filter: ident filter and filter cascading

 cache.h     |   38 +------
 convert.c   |  363 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 convert.h   |   65 +++++++++++
 entry.c     |   16 ++-
 streaming.c |  100 ++++++++++++++++-
 streaming.h |    2 +-
 6 files changed, 530 insertions(+), 54 deletions(-)
 create mode 100644 convert.h

-- 
1.7.5.2.369.g8fc017
