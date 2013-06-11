From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/4] Fix a race condition when reading loose refs
Date: Tue, 11 Jun 2013 16:26:16 +0200
Message-ID: <1370960780-1055-1-git-send-email-mhagger@alum.mit.edu>
References: <20130507023802.GA22940@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 16:26:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmPX4-0005eD-2Q
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 16:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317Ab3FKO0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 10:26:43 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:48791 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753804Ab3FKO0l (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 10:26:41 -0400
X-AuditID: 12074411-b7f296d000001209-86-51b733a12c6e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id E6.E5.04617.1A337B15; Tue, 11 Jun 2013 10:26:41 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BEQVIR026521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 10:26:39 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <20130507023802.GA22940@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqLvQeHugwdSLHBZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTtj0Zcd7AW7uCruzPzI3sB4maOLkYNDQsBEouWbVxcjJ5ApJnHh3nq2LkYuDiGBy4wS
	PTeOM0I4F5gkHr6/zAZSxSagK7Gop5kJxBYRUJOY2HaIBaSIWaCdUeJd8z5mkKnCAo4S0yaD
	1bAIqEpM2HYUzOYVcJbYc+EqG8Q2OYn3d3axgNicAtYSv98tAqsRErCS6H/wnHECI+8CRoZV
	jHKJOaW5urmJmTnFqcm6xcmJeXmpRbqmermZJXqpKaWbGCEhJbiDccZJuUOMAhyMSjy8CYzb
	AoVYE8uKK3MPMUpyMCmJ8k4x2B4oxJeUn1KZkVicEV9UmpNafIhRgoNZSYS3UQ4ox5uSWFmV
	WpQPk5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4G0yAmoULEpNT61Iy8wpQUgzcXCC
	CC6QDTxAG5hACnmLCxJzizPTIYpOMSpKifPGgyQEQBIZpXlwA2DR/4pRHOgfYd46kCoeYOKA
	634FNJgJaPAU9S0gg0sSEVJSDYwxesxmvfv+enU7x4v3bXN7feFH+RlthqfNT18+f3O5Jndd
	T1pcpXOE6BPR7yuXm75/7lGl8ST8amLs7IJY60/PDy9y065+E9fbppz7O/lbws71a7YVTA4U
	E7sSXZx05ftl21eye3at3+lYmHbc6eo2q/8L+be4brAL+bi02GdPNNvVZwqOtp5K 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227443>

This patch series is inspired by the first patch [1] in a series by
Peff and solves the race condition that he discovered plus a second,
similar race.  The general problem is that loose ref files are read in
two steps: lstat() followed by readlink() or open().  If another
process changes the file between our two steps, then the old code gets
confused and can give incorrect results.  The new code detects if an
error reported by readlink()/open() is inconsistent with the results
of the previous lstat(), and if so, tries anew.

The first three commits are just preparatory.  All four commits could
easily be squashed together if it is preferred (especially commits 2
through 4), but I did it this way to separate the
code-churning-but-trivial changes from the functional changes to make
review easier.

[1] http://article.gmane.org/gmane.comp.version-control.git/223525

Michael Haggerty (4):
  resolve_ref_unsafe(): extract function handle_missing_loose_ref()
  resolve_ref_unsafe(): handle the case of an SHA-1 within loop
  resolve_ref_unsafe(): nest reference-reading code in an infinite loop
  resolve_ref_unsafe(): close race condition reading loose refs

 refs.c | 187 ++++++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 114 insertions(+), 73 deletions(-)

-- 
1.8.3
