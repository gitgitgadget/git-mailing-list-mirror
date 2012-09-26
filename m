From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Wed, 26 Sep 2012 21:34:42 +0200
Message-ID: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
References: <50406C82.2070005@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:35:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGxON-0004ad-VO
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 21:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758063Ab2IZTfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 15:35:22 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:55608 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757422Ab2IZTfV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 15:35:21 -0400
X-AuditID: 1207440c-b7f616d00000270b-a9-506358f95ffb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B7.1F.09995.9F853605; Wed, 26 Sep 2012 15:35:21 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8QJZFfe010704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Sep 2012 15:35:19 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <50406C82.2070005@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsUixO6iqPszIjnA4PR5QYuuK91MFg29V5gt
	jp6ysLi9Yj6zxfp3V5kdWD3+vv/A5LFz1l12j4uXlD0+b5ILYInitklKLCkLzkzP07dL4M7o
	b25gKdgtWnF5ynrGBsbtgl2MnBwSAiYS5xeuYYSwxSQu3FvP1sXIxSEkcJlR4sjZwywgCSGB
	M0wS3Sf8QGw2AV2JRT3NTCC2iICaxMS2QywgDcwCkxglejY8YAdJCAu4SXw4eweoiIODRUBV
	4s7OQpAwr4CLxMbm48wQyxQlfnxfA2ZzCuhIvDk2iW0CI88CRoZVjHKJOaW5urmJmTnFqcm6
	xcmJeXmpRbqGermZJXqpKaWbGCHhwrOD8ds6mUOMAhyMSjy8Hg7JAUKsiWXFlbmHGCU5mJRE
	ea3DgEJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeJ9lJQUI8aYkVlalFuXDpKQ5WJTEeVWXqPsJ
	CaQnlqRmp6YWpBbBZGU4OJQkeJeHAw0VLEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmI
	B0VAfDEwBkBSPEB7hYFRKcRbXJCYCxSFaD3FqMvRcnPBA0Yhlrz8vFQpcd5/IDsEQIoySvPg
	VsCSwytGcaCPhXlvgFTxABML3KRXQEuYgJYs3QTyXHFJIkJKqoGRo/PpjmJZzdqHGo8fTlHp
	zX/PuMJUbXZ027dr1e8OdDTIF53M+nNSxKIpiMtGvk+33XX/Pr6nEXybd/vnXrG5oruiy/q+
	j6W2ZdHUU50OdgZWfhuTkw/ZOjvKtp8Rab2wbm7x598PHszO+e/38ep3uXVbMpef 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206432>

This series fixes longest_ancestor_length() so that it works even if
prefix_list contains entries that involve symlinks.  The basic goal of
the series is to call real_path() on each of the entries so that a
textual comparison of the potential prefix to the front of path
correctly decides whether the path is located inside of the entry.
But along the way some other things had to be changed:

* real_path() die()s if the path passed to it is invalid, whereas it
  is allowed for GIT_CEILING_DIRECTORIES to contain invalid paths.  So
  create a new function real_path_if_valid() that returns NULL for
  invalid paths.

* Changing longest_ancestor_length() to call real_path_if_valid()
  would make the former very difficult to test (because the tests
  would depend on the contents of the whole filesystem).  Therefore,
  rewrite longest_ancestor_length() in terms of functions
  string_list_split(), string_list_longest_prefix(), and
  real_path_if_valid() which are tested individually.

The net results of these changes are that:

1. t1504 used to have to canonicalize TRASH_DIRECTORY to make itself
   work even if the --root directory contains symlinks.  This
   canonicalization is no longer necessary (and has been removed).

2. t4035, which used to fail if the --root directory contained
   symlinks, now works correctly in that situation.

After this change, all tests pass if the --root directory does *not*
contain symlinks, but t9903 still fails if the --root directory
contains symlinks.  I haven't analyzed the cause of t9903's failure,
but it does not appear to be related to the GIT_CEILING_DIRECTORIES
feature.

On the mailing list I suggested *purposely* inserting symlinks into
the "trash directory.*" paths to test symlink handling more
systematically.  This patch series does *NOT* make that change.

Michael Haggerty (8):
  Introduce new static function real_path_internal()
  Introduce new function real_path_if_valid()
  longest_ancestor_length(): use string_list_split()
  longest_ancestor_length(): explicitly filter list before loop
  longest_ancestor_length(): always add a slash to the end of prefixes
  longest_ancestor_length(): use string_list_longest_prefix()
  longest_ancestor_length(): resolve symlinks before comparing paths
  t1504: stop resolving symlinks in GIT_CEILING_DIRECTORIES

 abspath.c               | 98 ++++++++++++++++++++++++++++++++++++++-----------
 cache.h                 |  1 +
 path.c                  | 54 ++++++++++++++++-----------
 t/t0060-path-utils.sh   | 64 --------------------------------
 t/t1504-ceiling-dirs.sh | 67 +++++++++++++++++----------------
 5 files changed, 144 insertions(+), 140 deletions(-)

-- 
1.7.11.3
