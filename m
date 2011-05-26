From: Chris Wilson <cwilson@vigilantsw.com>
Subject: [PATCH] Fix useless comparison bug
Date: Thu, 26 May 2011 10:01:52 -0400
Message-ID: <20110526140152.GA19748@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 16:02:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPb8V-00049z-IS
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 16:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757928Ab1EZOB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 10:01:58 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57186 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757898Ab1EZOB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 10:01:57 -0400
Received: by pvg12 with SMTP id 12so314839pvg.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 07:01:57 -0700 (PDT)
Received: by 10.143.97.7 with SMTP id z7mr143137wfl.9.1306418517242;
        Thu, 26 May 2011 07:01:57 -0700 (PDT)
Received: from localhost (c-76-126-142-103.hsd1.ca.comcast.net [76.126.142.103])
        by mx.google.com with ESMTPS id k2sm679720wfe.3.2011.05.26.07.01.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 07:01:56 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174512>

The variable 'actual' was declared with a size_t type. In this line:

  actual = read_in_full(fd, buf, sz);

read_in_full returns a ssize_t type. Since size_t is unsigned and
ssize_t is signed, the value is implicitly converted from a signed
type to an unsigned type. That makes this comparison useless,

  if (actual < 0)
    die_errno("index-stream: reading input");

as it will always be false. This means, on an error path, git will
continue when it should die gracefully.

This bug was introduced in 4dd1fbc.

Signed-off-by: Chris Wilson <cwilson@vigilantsw.com>
---

Hi Folks,

Sentry found this committed in last nights snapshot.

Chris Wilson
http://vigilantsw.com/
Vigilant Software

 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 064a330..c251af8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2704,7 +2704,7 @@ static int index_stream(unsigned char *sha1, int fd, size_t size,
        while (size) {
                char buf[10240];
                size_t sz = size < sizeof(buf) ? size : sizeof(buf);
-               size_t actual;
+               ssize_t actual;

                actual = read_in_full(fd, buf, sz);
                if (actual < 0)
-- 
1.6.3.3
