From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/3] Fix a race condition when reading loose refs
Date: Wed, 19 Jun 2013 08:36:25 +0200
Message-ID: <1371623788-7227-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 08:36:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpC0f-00056C-GM
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 08:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756451Ab3FSGgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 02:36:45 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:54246 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756393Ab3FSGgo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 02:36:44 -0400
X-AuditID: 1207440c-b7f016d000005997-61-51c1517c4a61
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id F6.5F.22935.C7151C15; Wed, 19 Jun 2013 02:36:44 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J6aXcS032032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 02:36:41 -0400
X-Mailer: git-send-email 1.8.3.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqFsTeDDQoHE6p0XXlW4mi4beK8wW
	8+7uYrK4vWI+s8WPlh5mi7uXV7E7sHn8ff+ByePSy+9sHrdfz2f2eNa7h9Hj4iVlj8+b5ALY
	orhtkhJLyoIz0/P07RK4M6b+uMZesJ+lou9xJ3sD423mLkYODgkBE4lTP2q7GDmBTDGJC/fW
	s3UxcnEICVxmlLi9tIkZwrnNJHHv5S42kCo2AV2JRT3NTCC2iICaxMS2QywgRcwCGxkljl/d
	xwiSEBZwkVjUupUdxGYRUJXYsO4SK4jNK+As0dW9lglinYLElIfvmScwci9gZFjFKJeYU5qr
	m5uYmVOcmqxbnJyYl5dapGuol5tZopeaUrqJERI4PDsYv62TOcQowMGoxMN7Y/WBQCHWxLLi
	ytxDjJIcTEqivKEBBwOF+JLyUyozEosz4otKc1KLDzFKcDArifDqOQDleFMSK6tSi/JhUtIc
	LErivKpL1P2EBNITS1KzU1MLUotgsjIcHEoSvGUgQwWLUtNTK9Iyc0oQ0kwcnCDDuaREilPz
	UlKLEktLMuJBoR5fDAx2kBQP0N40kHbe4oLEXKAoROspRl2OyWe3vGcUYsnLz0uVEuctAikS
	ACnKKM2DWwFLE68YxYE+Fua1BKniAaYYuEmvgJYwAS0R+r4PZElJIkJKqoExVldk5/JVRhUK
	869cDwqX/3Un8sGvZa1iLIsk5lq8etyc+fz2z7nbXWx3Xi19lhnSdHChQNx09W8sns1NO7ct
	ulhyZJVjZs30ct6DSmo/5Tp3qInLV4u/ePPN/MsqubbLdxf9rIs2ucSwsqBhQ/vE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228351>

This is v2 of mh/loose-refs-race-with-pack-ref

I took Peff's suggestion to use gotos rather than an infinite loop in
the last patch, which means that there is no need for the old patch
03/04.

Michael Haggerty (3):
  resolve_ref_unsafe(): extract function handle_missing_loose_ref()
  resolve_ref_unsafe(): handle the case of an SHA-1 within loop
  resolve_ref_unsafe(): close race condition reading loose refs

 refs.c | 106 ++++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 72 insertions(+), 34 deletions(-)

-- 
1.8.3.1
