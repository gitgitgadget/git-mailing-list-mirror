From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Mon, 02 May 2016 10:40:28 -0700
Message-ID: <xmqqfuu0uzn7.fsf@gitster.mtv.corp.google.com>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
	<1461079290-6523-3-git-send-email-sbeller@google.com>
	<CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
	<20160420041827.GA7627@sigill.intra.peff.net>
	<xmqqa8kcxip9.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xpFCBU1xYbtcX8jtmDDyY8p0CiJJ=bexTmi=_vwWRZi0Q@mail.gmail.com>
	<xmqqwpngukin.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZu=keNaCbt4T=CzH3i9qr+BxXw6AiWR-q1Cs4U80Jzng@mail.gmail.com>
	<1461969582.731.1.camel@intel.com>
	<CAGZ79kYx22oYobPxMkC03fGk-E9zaZZd2f+qafESkhcmFog7-w@mail.gmail.com>
	<1461970113.731.3.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "sbeller\@google.com" <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"peff\@peff.net" <peff@peff.net>,
	"jacob.keller\@gmail.com" <jacob.keller@gmail.com>
To: "Keller\, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Mon May 02 19:40:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axHpl-0000Ad-Bb
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 19:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704AbcEBRke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 13:40:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754376AbcEBRkc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 13:40:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 958D518B37;
	Mon,  2 May 2016 13:40:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ycMgv7VIzNDIfR3YOVNaj5/qK9M=; b=ZiVdz8
	QBO6sLWXMKCXE+qsfrVMSQBncVo6dWQcCnHfW9KTPE5or5YxeJBt/0obcuCsYzNZ
	d9pp7KC+s26B077f69dkscjaVPRo8so3H5yT1BePoMUQ9HsR3cq5IRgYx+J3yZtx
	vAGYG3Jg7fMdJgThVhCj/nnp73GAli4QFEI4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cW6ak98gR68+Kd2jyKeJPMFBbI09LqR0
	Q7l/Pgmr4JHJdqYZYUfCl61chzO0SiRzFzaJk/tRXmR76CPQgn6UJJb9HIhvA9xk
	ZoyLkZVIFyYmxeuXpl+12QEoF1dZyRVlejH9jC+YqHoEnvTyJnmVwSxy9Gag8ZZ1
	Zj7o5BOqyuE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BAEE18B36;
	Mon,  2 May 2016 13:40:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE40018B35;
	Mon,  2 May 2016 13:40:29 -0400 (EDT)
In-Reply-To: <1461970113.731.3.camel@intel.com> (Jacob E. Keller's message of
	"Fri, 29 Apr 2016 22:48:33 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F68BD58C-108C-11E6-8499-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293246>

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

> True. I think the chances that it needs such a thing are quite minor,
> and if an undocumented knob gets exposed it would have to become
> documented and maintained, so I'd prefer to avoid it. Given that the
> risk is pretty small I think that's ok.

OK, then let's do only the "documentation" part.

-- >8 --
Subject: [PATCH] diff: undocument the compaction heuristic knobs for experimentation

It seems that people around here are all happy with the updated
heuristics used to decide where the hunks are separated.  Let's keep
that as the default.  Even though we do not expect too much trouble
from the difference between the old and the new algorithms, just in
case let's leave the implementation of the knobs to turn it off for
emergencies.  There is no longer need for documenting them, though.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-config.txt  | 5 -----
 Documentation/diff-options.txt | 6 ------
 2 files changed, 11 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 9bf3e92..6eaa452 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -166,11 +166,6 @@ diff.tool::
 
 include::mergetools-diff.txt[]
 
-diff.compactionHeuristic::
-	Set this option to enable an experimental heuristic that
-	shifts the hunk boundary in an attempt to make the resulting
-	patch easier to read.
-
 diff.algorithm::
 	Choose a diff algorithm.  The variants are as follows:
 +
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b513023..3ad6404 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -63,12 +63,6 @@ ifndef::git-format-patch[]
 	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
---compaction-heuristic::
---no-compaction-heuristic::
-	These are to help debugging and tuning an experimental
-	heuristic that shifts the hunk boundary in an attempt to
-	make the resulting patch easier to read.
-
 --minimal::
 	Spend extra time to make sure the smallest possible
 	diff is produced.
-- 
2.8.2-458-gacc1066
