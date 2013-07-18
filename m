From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] Deprecating "diff-files -q"
Date: Wed, 17 Jul 2013 17:30:00 -0700
Message-ID: <1374107406-14357-1-git-send-email-gitster@pobox.com>
References: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 02:30:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzc74-0006bR-Ca
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 02:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640Ab3GRAaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 20:30:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756545Ab3GRAaM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 20:30:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA07120A8F;
	Thu, 18 Jul 2013 00:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=AE/y
	2SGdn7HpXfWnTTtLDl1IqI4=; b=mODwUwepTSWgTSsaAZlomFhQ8tWZFFjBUhyn
	nQBdlzsnFq8xiSEBN6V8tkPWVs164FEN9WFYZ8DO8AMDL+IJpKiG1q0vukjRYXRo
	CUU7iqzpxhStt23FKvc6RUmZfe5eADaxueScq51G609czu2Dg50J/waBUl3cAy+A
	DwL/1+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	uRgKXbgGGW/d1hmO+b3Wcv6sUt3ay++xXFhuWECUN8k8wi0HanaVezeFu/TdNM98
	XICGPSFzeNdmXv9K53oflJPTkaaiLFpmaG/BbqC/EtJdWFqFnreCvkbejXO2AEbu
	rdebMjbh5nsr1swo6EFXo3fbvo2jGFZNJBppUZ12mNE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0B6620A8D;
	Thu, 18 Jul 2013 00:30:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38A8B20A8A;
	Thu, 18 Jul 2013 00:30:08 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.3-962-gf04df43
In-Reply-To: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 3304A86A-EF41-11E2-A85B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230666>

The "-q" option given to "git diff-files" is a remnant of the
"show-diff" command, the precursor of today's "git diff-files" (back
then, we didn't even have "git" potty.  The user literally typed
"show-diff", not "git show-diff").

ca2a0798 ([PATCH] Add "-q" option to show-diff.c, 2005-04-15) added
that option.  Back then, we did not have pathspec matching, and we
iterated over command line arguments, and required all of them exist
as filesystem entities.  "-q" was a way to defeat that "you name a
file, it must exist in the working tree" safety, and also at the
same time not give output for such a file that was removed from the
working tree.

These days, the command line parsing infrastructure has changed
vastly since "show-diff" days, and the former "safety" is enforced
by the generalized revision parser ("is it a path or is it a rev?")
code and the "--" delimiter on the command line is the way to defeat
it.  The latter is done by giving a filtering specification that
lack D to the "--diff-filter", e.g. "--diff-filter=ACMRTUB".

This is however a bit cumbersome to type.  This miniseries updates
the diff-filter mechanism to let you say --diff-filter=d (lowercase)
to express that you are interested in the changes in general, but
not the changes in the 'D' class (i.e. deletion).

The last step tweaks the command line parser of "git diff-files"
(and "git diff" without any object on the command line, which goes
to the same codepath) and "git diff --no-index" to notice "-q", warn
and then turn it into "--diff-filter=d".  We should remove the
entire thing at a major version bump, like Git 2.0.


This is still a bit rough, without any documentation updates nor
tests.


Junio C Hamano (6):
  diff: pass the whole diff_options to diffcore_apply_filter()
  diff: factor out match_filter()
  diff: preparse --diff-filter string argument
  diff: reject unknown change class given to --diff-filter
  diff: allow lowercase letter to specify what change class to exclude
  diff: deprecate -q option to diff-files

 diff-lib.c      |   8 ++--
 diff-no-index.c |   7 +++-
 diff.c          | 125 ++++++++++++++++++++++++++++++++++++++++++++++----------
 diff.h          |   7 +++-
 4 files changed, 118 insertions(+), 29 deletions(-)

-- 
1.8.3.3-962-gf04df43
