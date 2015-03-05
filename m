From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/5] Retry if fdopen() fails due to ENOMEM
Date: Thu,  5 Mar 2015 17:07:44 +0100
Message-ID: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 17:08:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTYJm-0001QX-7A
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 17:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014AbbCEQIC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 11:08:02 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:51159 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932998AbbCEQH7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 11:07:59 -0500
X-AuditID: 12074412-f79e46d0000036b4-94-54f87f5c6c5e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id EA.48.14004.C5F78F45; Thu,  5 Mar 2015 11:07:56 -0500 (EST)
Received: from michael.fritz.box (p5DDB3EC9.dip0.t-ipconnect.de [93.219.62.201])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t25G7s7e031040
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 5 Mar 2015 11:07:55 -0500
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsUixO6iqBtT/yPEYN0cVYuuK91MFg29V5gt
	3t5cwmhxe8V8ZgcWj7/vPzB57Jx1l93j4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M2Z9ky+Y
	xVnx6MYplgbGaexdjJwcEgImEhPbljNC2GISF+6tZ+ti5OIQErjMKDHj4T5GCOc4k8TvT9eY
	QKrYBHQlFvU0g9kiAmpA3YdYQGxmgXyJ77tPAMU5OIQFrCQOPfAGMVkEVCWuzVMGMXkFXCRm
	3kyBWCUncf74T+YJjNwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6eVmluilppRuYoQE
	gtAOxvUn5Q4xCnAwKvHwftj8PUSINbGsuDL3EKMkB5OSKO+Pqh8hQnxJ+SmVGYnFGfFFpTmp
	xYcYJTiYlUR4r0QC5XhTEiurUovyYVLSHCxK4rw/F6v7CQmkJ5akZqemFqQWwWRlODiUJHj3
	1AI1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxINCPL4YGOQgKR6gvedB2nmLCxJz
	gaIQracYFaXEeWfXASUEQBIZpXlwY2Hx/YpRHOhLYd4fIO08wNQA1/0KaDAT0GAtMbDBJYkI
	KakGxvSyE8UbniQLBe/unLBgzRxLvunh3x9+FV/3SLSyzbD8S+v9B56M4sqM7dJavFbM01tO
	qa8Qt07d55k3dfm1eWy2By+u+3evjN3URigqvcJxT0Yd05p5m84cyHHbZ/rcxPZAbaHLtKy2
	a1kSzCdy2MP4bL9OX/2qjGXtjsqlS158vBE2K71ouxJLcUaioRZzUXEiAP47/oHK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264846>

One likely reason for fdopen() to fail is the lack of memory for
allocating a FILE structure. When that happens, try freeing some
memory and calling fdopen() again in the hope that it will work the
second time.

This change was suggested by Jonathan Nieder [1]

In the first patch it is unsatisfying that try_to_free_routine() is
called with a magic number (1000) rather than sizeof(FILE). But the C
standard doesn't guarantee that FILE is a complete type, so I can't
think of a better approach. Suggestions, anybody?

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/260848

Michael Haggerty (5):
  xfdopen(): if first attempt fails, free memory and try again
  fdopen_lock_file(): use fdopen_with_retry()
  copy_to_log(): use fdopen_with_retry()
  update_info_file(): use fdopen_with_retry()
  buffer_fdinit(): use fdopen_with_retry()

 daemon.c              |  4 ++--
 git-compat-util.h     | 11 +++++++++++
 lockfile.c            |  2 +-
 server-info.c         |  2 +-
 vcs-svn/line_buffer.c |  2 +-
 wrapper.c             | 28 +++++++++++++++++++++++++---
 6 files changed, 41 insertions(+), 8 deletions(-)

-- 
2.1.4
