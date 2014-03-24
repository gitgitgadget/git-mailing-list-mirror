From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Parse-options: spell multi-word placeholders with dashes
Date: Mon, 24 Mar 2014 10:52:02 -0700
Message-ID: <1395683525-2868-1-git-send-email-gitster@pobox.com>
References: <1395481654-5920-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 18:52:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS92o-00031i-I1
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbaCXRwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:52:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34052 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672AbaCXRwL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 13:52:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FCEF75B0D;
	Mon, 24 Mar 2014 13:52:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=rrzC
	O1W8o4XYgSLaXQKgdYzw8Fk=; b=MtQATX8ZMoDyfdzj/pmDhR1lUJWT5m0Grfkg
	gbvXIWoD89C7pXLRSozpGHo6z9IuAEIOnzdEwheWOhaFfCO9Ya9SwIoj1s8Ova55
	vIfOOiWgifGwt//6uMMo+1vwMJU/CHhGjxOTi04HXvY/b1KBkIs0Kk7LpnCZ1SdK
	VlIAYJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	xGNCQ+Baha7E0W6brxqqM+YjW4bc802hiIr0FNWen4b88LzavvebQKfwlT7Nuqig
	cxAm3HwPL1jtyW8cZjPkLJpzBdJDNdWZCQj8rCO/6Vce5nEJy6cEdgpdp1SG+hZi
	N9QKY+HgMP/U+E1NYU74AJl3kKd8qZYDldjnhSLl5/g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0963B75B0C;
	Mon, 24 Mar 2014 13:52:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCAD275B0A;
	Mon, 24 Mar 2014 13:52:09 -0400 (EDT)
X-Mailer: git-send-email 1.9.1-471-g8d9dec6
In-Reply-To: <1395481654-5920-1-git-send-email-ilya.bobyr@gmail.com>
X-Pobox-Relay-ID: 05A8B928-B37D-11E3-A678-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244828>

This is a follow-up to Ilya's 4th round of letting scripted
porcelains to give argv-help to their users with their command line
option parser based on "rev-parse --parseopt".

While reviewing the patch, we found that a few options to the
built-in commands were described with an argv-help (the placeholder
for an option parameter, e.g. "key-id" in "--gpg-sign <key-id>")
that has multiple words to decribe a single entity, spelling these
multiple words separated in spaces.  It is more customary to spell a
multi-word parameter with dashes, and the first patch in series is
about making it so.

During the course of the development of the first patch, I needed a
mechanical way to catch existing offenders; the last patch teaches
the parse-options API implementation to find argv-help strings that
contain SP or underscore.

There is one glitch, though.  "update-index --cacheinfo" option
takes THREE parameters: mode, sha1, and path.  Because a command
line option that takes multiple options is very unusual, the second
patch introduces a new syntax to pass these three items as a single
parameter to "--cacheinfo" option, which brings our command line
argument convention more uniform and consistent.  We however cannot
deprecate or remove the traditional syntax, so it is still kept as
an alternative "backward compatibility" syntax.

Junio C Hamano (3):
  parse-options: multi-word argh should use dash to separate words
  update-index: teach --cacheinfo a new syntax "mode,sha1,path"
  parse-options: make sure argh string does not have SP or _

 Documentation/git-cherry-pick.txt  |  6 +++---
 Documentation/git-commit.txt       |  2 +-
 Documentation/git-merge.txt        |  2 +-
 Documentation/git-notes.txt        |  2 +-
 Documentation/git-rev-parse.txt    | 16 ++++++++--------
 Documentation/git-revert.txt       |  6 +++---
 Documentation/git-update-index.txt |  8 ++++++--
 builtin/checkout.c                 |  2 +-
 builtin/commit.c                   |  2 +-
 builtin/merge.c                    |  2 +-
 builtin/notes.c                    |  2 +-
 builtin/revert.c                   |  2 +-
 builtin/tag.c                      |  2 +-
 builtin/update-index.c             | 34 +++++++++++++++++++++++++++++++---
 parse-options.c                    |  3 +++
 parse-options.h                    |  2 +-
 t/t2107-update-index-basic.sh      | 13 +++++++++++++
 17 files changed, 77 insertions(+), 29 deletions(-)

-- 
1.9.1-471-gcccbd8b
