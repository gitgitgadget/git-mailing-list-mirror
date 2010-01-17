From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/8] Rescuing repeated merge of Documentation/git-merge.txt
Date: Sun, 17 Jan 2010 01:38:56 -0800
Message-ID: <1263721144-18605-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 17 10:39:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWRbN-0003nL-IA
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 10:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648Ab0AQJjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 04:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753640Ab0AQJjK
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 04:39:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab0AQJjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 04:39:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D6CD913FC
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=itaml3Vfg1n8gGGLRLKjRF/E0wE
	=; b=T3X913ME8RzWhZT3tZtvU3nhrpDHOX0BjKWs+ckuNBkQSEaADGE3Gexk2Xx
	MnerCchJ2TB7jyRd0Y6s4XY4yynxWIic6tFk/XrJQE4OoXmwU10P6OPIZOjvlYVe
	m19sTphC19LP4pSP6wyQmhd0nCbdnBYq+jlAww1ih7nPhcQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=cV1Rv9sETgAUCUl2xztQE0PxC7WQT
	lJw5la7J1EG4WC5UGlzE+PZUy5AtYCqbFcj9snl5lYfEcDGnKPGEZlRQh6rKWXWB
	/K7XorDuzrXT3tg1KW16V8YmENrbIUIoDWZfHJQQn9k1iQ62cW93xnVqlgEbzz3x
	T2MqtgGJ8aHxgo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59F3F913FB
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0B88913F9 for
 <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:05 -0500 (EST)
X-Mailer: git-send-email 1.6.6.405.g80ed6.dirty
X-Pobox-Relay-ID: 27BAE350-034C-11DF-B287-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137281>

Ever since I started queuing Thomas's documentation updates in 'pu',
rebuilding the branch involved manual re-integration for conflicts in
Documentation/git-merge.txt.  This is because the tracked contents in
the file has lines that exactly match the conflict marker patterns (of
course, they are examples of how conflicts are shown).

I am not blaming Thomas; the blame lies squarely on the inability of
'rerere' to deal with such a situation.  It often is enough to do:

	git diff pu@{4.hours} Documentation/git-merge.txt

to check that nothing else has changed since the last merge, and then

	git co pu@{4.hours} Documentation/git-merge.txt

to resurrect the previous result, but it still is irritating.

This series is to help me cope with this particular merge by allowing the
attribute mechanism.  By having this entry in my .git/info/attributes:

	Documentation/git-merge.txt	conflict-marker-size=32

"git merge" leaves conflict markers that are 32 chars long (instead of the
usual 7), "git rerere" that is run internally when "git merge" results in
conflicts sees only the real conflict markers as such without getting
confused by the example in the contents, and "git rerere" called to record
the resolution does the right thing.

Junio C Hamano (8):
  git_attr(): fix function signature
  xdl_merge(): introduce xmparam_t for merge specific parameters
  xdl_merge(): allow passing down marker_size in xmparam_t
  merge-tree: use ll_merge() not xdl_merge()
  rerere: use ll_merge() instead of using xdl_merge()
  conflict-marker-size: new attribute
  rerere: prepare for customizable conflict marker length
  rerere: honor conflict-marker-size attribute

 archive.c              |    4 +-
 attr.c                 |   11 +++++--
 attr.h                 |    2 +-
 builtin-check-attr.c   |    2 +-
 builtin-merge-file.c   |    4 +-
 builtin-pack-objects.c |    2 +-
 convert.c              |    6 ++--
 ll-merge.c             |   80 +++++++++++++++++++++++++++++++-----------------
 ll-merge.h             |    2 +
 merge-file.c           |   16 ++++-----
 merge-tree.c           |    4 +-
 rerere.c               |   57 +++++++++++++++++++++++++--------
 userdiff.c             |    2 +-
 ws.c                   |    2 +-
 xdiff/xdiff.h          |    9 +++++-
 xdiff/xmerge.c         |   26 ++++++++++-----
 16 files changed, 151 insertions(+), 78 deletions(-)
