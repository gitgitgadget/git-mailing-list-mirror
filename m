From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Sun, 21 Oct 2012 07:57:29 +0200
Message-ID: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 07:58:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPoYV-0006Vm-RQ
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 07:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482Ab2JUF6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 01:58:14 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:52422 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751217Ab2JUF6N (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 01:58:13 -0400
X-AuditID: 12074414-b7f846d0000008b8-aa-50838ef4720d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C2.9E.02232.4FE83805; Sun, 21 Oct 2012 01:58:12 -0400 (EDT)
Received: from michael.fritz.box (p57A24D34.dip.t-dialin.net [87.162.77.52])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9L5w2Wn013120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 21 Oct 2012 01:58:09 -0400
X-Mailer: git-send-email 1.7.11.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqPulrznAYMIeVosjb54wW3Rd6Way
	aOi9wmzxZO5dZoujpywsbq+Yz2yx/t1VZgd2j7/vPzB5vGnvZfTYOesuu8fDV13sHhcvKXt8
	3iQXwBbFbZOUWFIWnJmep2+XwJ0x6fRLpoJ7UhUTjvayNDD+F+5i5OSQEDCR+D71HDOELSZx
	4d56ti5GLg4hgcuMEuduTwRLCAmcYZLoXGoPYrMJ6Eos6mlmArFFBNQkJrYdYgFpYBa4wyix
	8MobsAZhAU+JD7MuAhVxcLAIqEr8PJkEEuYVcJGY/XIrE8QyRYkf39cwT2DkXsDIsIpRLjGn
	NFc3NzEzpzg1Wbc4OTEvL7VI10IvN7NELzWldBMjJHxEdjAeOSl3iFGAg1GJh5fJujlAiDWx
	rLgy9xCjJAeTkijvi16gEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe3YJAOd6UxMqq1KJ8mJQ0
	B4uSOO+3xep+QgLpiSWp2ampBalFMFkZDg4lCd53IEMFi1LTUyvSMnNKENJMHJwgggtkAw/Q
	BvY+kA3FBYm5xZnpEEWnGBWlxHlvgkwQAElklObBDYBF+itGcaB/hHkvgVTxAJMEXPcroMFM
	QIPNuRtBBpckIqSkGhjbLrR5C73TWfptivb2upQccevqnK9r7KUzIrYnM8buq9yTlGa39Mjl
	+RNadl1+6tZvX6uzWejbD44bXyaczprdO2t/3/drQqzHspeu+L2lWHqL0t83++SeWvywvMJ+
	ac+/h9WzIjU/+LwUamAxzq+bMl9DRaP8rc6p1IY/EfZvfQMLIiKCXigqsRRnJBpq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208102>

v3 of the series, reworked WRT v2:

* Change longest_ancestor_length() to take a string_list for its
  prefixes argument (instead of a PATH_SEP-separated string).

* Move the responsibility for canonicalizing prefixes from
  longest_ancestor_length() to its caller in
  setup_git_directory_gently_1().  This keeps
  longest_ancestor_length() testable, though the test inputs now have
  to be canonicalized.

* Remove function string_list_longest_prefix(), which was mainly
  intended to be used in the implementation of
  longest_ancestor_length() but is now unneeded.

Thanks to Junio for his comments.

I would like to explicitly point out a possible objection to this
whole enterprise.  GIT_CEILING_DIRECTORIES is used to prevent git from
mucking around in certain directories, to avoid expensive accesses
(for example of remote directories).  The original motivation for the
feature was a user whose home directory /home/$USER was automounted.
When git was invoked outside of a git tree, it would crawl up the
filesystem tree, eventually reaching /home, and then try to access the
paths

    /home
    /home/.git
    /home/.git/objects
    /home/objects

The last three accesses would be very expensive because the system
would attempt to automount the entries listed.

This patch series has the side effect that all of the directories
listed in GIT_CEILING_DIRECTORIES are accessed *unconditionally* to
resolve any symlinks that are present in their paths.  It is
admittedly odd that a feature intended to avoid accessing expensive
directories would now *intentionally* access directories near the
expensive ones.  In the above scenario this shouldn't be a problem,
because /home would be the directory listed in
GIT_CEILING_DIRECTORIES, and accessing /home itself shouldn't be
expensive.  But there might be other scenarios for which this patch
series causes a performance regression.

Another point: After this change, it would be trivially possible to
support non-absolute paths in GIT_CEILING_DIRECTORIES; just remove the
call to is_absolute_path() from normalize_ceiling_entry().  This might
be convenient for the test suite.

Michael Haggerty (8):
  Introduce new static function real_path_internal()
  real_path_internal(): add comment explaining use of cwd
  Introduce new function real_path_if_valid()
  longest_ancestor_length(): use string_list_split()
  longest_ancestor_length(): take a string_list argument for prefixes
  longest_ancestor_length(): require prefix list entries to be
    normalized
  normalize_ceiling_entry(): resolve symlinks
  string_list_longest_prefix(): remove function

 Documentation/technical/api-string-list.txt |   8 ---
 abspath.c                                   | 105 ++++++++++++++++++++++------
 cache.h                                     |   3 +-
 path.c                                      |  46 ++++++------
 setup.c                                     |  32 ++++++++-
 string-list.c                               |  20 ------
 string-list.h                               |   8 ---
 t/t0060-path-utils.sh                       |  41 ++++-------
 t/t0063-string-list.sh                      |  30 --------
 test-path-utils.c                           |   8 ++-
 test-string-list.c                          |  20 ------
 11 files changed, 157 insertions(+), 164 deletions(-)

-- 
1.7.11.3
