From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/9] Extending the shelf-life of "git describe" output
Date: Sat, 23 Jun 2012 17:11:22 -0700
Message-ID: <1340496691-12258-1-git-send-email-gitster@pobox.com>
Cc: Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 02:12:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiaRC-0001US-9C
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 02:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160Ab2FXALf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 20:11:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43696 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432Ab2FXALf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 20:11:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 374AC8F13;
	Sat, 23 Jun 2012 20:11:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=40iMFsaJ1ZXcyg1iTjY4yz/OCNA
	=; b=L//oaw7zUydmVuCiOFBtLpEXKW5iMFQXCy9GjyPzYyrXSzKAU9rhUdtcRzU
	K4E7AuRxPe2vgNIfn7Mmw9alBMJjYuZo1OuEd0vIIBzNj0yz9i7W+x68uAdcK9CA
	+U17lvHFAaRpPhNkgHxNzDG5xi+ptFo/ctY0a/6wyEfE1+9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=G4x7PS/Z4TeEInRFvIr8R
	gOEK85SVC7eWYgSi2MTPSRF440d74a9PhYf+XmhtQ6/DGqPG6c3kuRj9LDM8eIRL
	kUXPiXxcwi18AdmgXutKkAHarC4OksXoWTu/6cu1z82zERVf1BHfCjbrJlfIShOG
	WplJ8cFphZCP2e8qNBfo+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EE1D8F12;
	Sat, 23 Jun 2012 20:11:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD11C8F10; Sat, 23 Jun 2012
 20:11:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.29.gf71be5c
X-Pobox-Relay-ID: 28058C82-BD91-11E1-8FDF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200506>

This is take 3.  The earlier rounds were $gmane/200165 and 200387.

Only the [9/9] is different.  It adds a test that creates a history
with many objects whose names share the same prefix, and tries to
check how the implementation employs various possible
disambiguations, e.g.

 (1) "$tagname-$generation-g$shortname" can only name a commit
     object, which is the topic of this series;

 (2) "$shortname" in "$tagname-$generation-g$shortname" alone may
     not be sufficiently unambiguous to name a commit, but there may
     be only one such commit if we take $tagname and $generation
     into account, which I hinted as a possible enhancement in the
     cover letter of the first round of this series;

 (3) "$shortname" in "$shortname:$path" can only name a tree-ish,
     which Thomas volunteered to build on top of this series;

 (4) "$shortname" in "$shortname^0" and "$shortname^{commit}" can
     only name a commit-ish, which is a natural extension of (3);

 (5) "$shortname" in "$shortname^0" and "$shortname^{commit}" might
     name more than one commit-ish, but when they are peeled to
     commits, they may name the same one (e.g. one is the commit,
     the other is a tag to the commit), which is a natural extension
     of (4).

Currently, the code implements only (1) and all other tests are
marked as test_expect_failure.

Junio C Hamano (9):
  sha1_name.c: indentation fix
  sha1_name.c: clarify what "fake" is for in
    find_short_object_filename()
  sha1_name.c: rename "now" to "current"
  sha1_name.c: refactor find_short_packed_object()
  sha1_name.c: correct misnamed "canonical" and "res"
  sha1_name.c: restructure disambiguation of short names
  sha1_name.c: allow get_short_sha1() to take other flags
  sha1_name.c: teach get_short_sha1() a commit-only option
  sha1_name.c: get_describe_name() by definition groks only commits

 sha1_name.c                         | 282 +++++++++++++++++++++++-------------
 t/t1512-rev-parse-disambiguation.sh | 172 ++++++++++++++++++++++
 2 files changed, 354 insertions(+), 100 deletions(-)
 create mode 100755 t/t1512-rev-parse-disambiguation.sh

-- 
1.7.11.1.29.gf71be5c
