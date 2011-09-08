From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/7] "push -s"
Date: Thu,  8 Sep 2011 13:01:35 -0700
Message-ID: <1315512102-19022-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 00:57:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nXM-0005F6-4T
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 00:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797Ab1IHW5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 18:57:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38595 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab1IHW4n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 18:56:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6910C462E
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=OazZBbR+ioINqX6lyUbfmorggH4
	=; b=GuGXdvx/M8YI1UiUJSNP43WZkhsJkl72GY+9wM2AMI35Xgl5Y9HjfAcRMDN
	YWn//IWUCEobrZfFmHaDalNKD082X9+dPXk8+wv2iQV4NFXQyOBiRUvRAcgDu9Fo
	OircTE1ezcKr9WJ6Xz4TC32n/G2PWDZb4ex/NI8D+thgQOuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=HMgQJsVxbJOKYTwn0VxUkjerG775V
	2VIXc+e9R0IPoDcB7tQ02AzFwWR6JszAVC1lTART5cYVfsyrs0xYSql8jfWD7IIX
	YHXFD8/EeRrpkmhmv57WgdY3E/LV8n/AcHO1/oB5eAuon+Ulxaat+gRghnz+j14d
	ikL5k/9EK1wV98=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6108F462C
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA650462B for
 <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:43 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.188.g3793ac
X-Pobox-Relay-ID: 6003AAC6-DA55-11E0-A1A6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180986>

Slightly re-rolled from last night.

 - Marked push-certificate format as version 0 while we are
   still experimenting;
 - The push certificate records new object name and the refname;
 - Add support for an external hook "pre-receive-signature".

One issue internally debated was if we want to list the refs that matched
the pushing criteria but were found to be already up to date, and this can
be argued both ways.

 - You can say that you are making assertion that you want to have a
   certain object at that ref, in which case you would want to include
   them.

 - On the other hand, for the purpose of leaving audit-trail, if the ref
   you tried to push already had the object you wanted to see at the tip
   of a ref, you weren't the person who made the ref point at the object,
   and it would be sensible not to include them.

Taking the latter stance is slightly easier on the end users, because
"Everything up-to-date" case becomes a no-op as the natural consequence,
and we do not have to ask them to unlock their GPG key in such a case.  It
however makes it impossible to say "Earlier I pushed that object to the
tip of my branch but forgot to sign the push, and I want to make a signed
push, even though I didn't add anything to my history."

People who configured to push out more than one branches with "git push"
often work on one branch, run "git push" which ends up pushing that branch
but not other branches, then work on another branch and run "git push" to
push out that other branch, while the branch he earlier pushed out stays
the same since his last push. For such people, the first "push" is not
necessarily even an assertion that he wants to have both branches pointing
at certain commits, and from that point of view, not including the latter
branch he hasn't worked on (and stayed up-to-date) in the push certifiate
is a sensible thing to do.

As there is no single right answer, this round of re-roll keeps the latter
semantics to record only what you pushed out as the original series.

Junio C Hamano (7):
  send-pack: typofix error message
  Split GPG interface into its own helper library
  push -s: skeleton
  push -s: send signed push certificate
  push -s: receiving end
  refactor run_receive_hook()
  push -s: support pre-receive-signature hook

 Makefile               |    2 +
 builtin/push.c         |    1 +
 builtin/receive-pack.c |  206 +++++++++++++++++++++++++++++++++++++++++++-----
 builtin/send-pack.c    |   61 +++++++++++++-
 builtin/tag.c          |   60 ++------------
 builtin/verify-tag.c   |   35 +--------
 gpg-interface.c        |   94 ++++++++++++++++++++++
 gpg-interface.h        |   11 +++
 send-pack.h            |    1 +
 transport.c            |    4 +
 transport.h            |    4 +
 11 files changed, 369 insertions(+), 110 deletions(-)
 create mode 100644 gpg-interface.c
 create mode 100644 gpg-interface.h

-- 
1.7.7.rc0.188.g3793ac
