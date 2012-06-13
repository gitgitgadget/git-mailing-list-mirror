From: =?utf-8?B?UmFmYcWCIE11xbx5xYJv?= <galtgendo@gmail.com>
Subject: A slight inconvenience with 'git archive --format=tar'
Date: Wed, 13 Jun 2012 16:47:58 +0200
Message-ID: <20120613144758.GA2438@blackspire>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 16:57:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sep0v-0007d5-Ia
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 16:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab2FMO51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 10:57:27 -0400
Received: from moh1-ve3.go2.pl ([193.17.41.134]:57228 "EHLO moh1-ve3.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274Ab2FMO5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 10:57:24 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jun 2012 10:57:23 EDT
Received: from moh1-ve3.go2.pl (unknown [10.0.0.134])
	by moh1-ve3.go2.pl (Postfix) with ESMTP id EAC759D83BC
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 16:48:02 +0200 (CEST)
Received: from unknown (unknown [10.0.0.74])
	by moh1-ve3.go2.pl (Postfix) with SMTP
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 16:48:02 +0200 (CEST)
Received: from host-89-228-35-253.elk.mm.pl [89.228.35.253]
	by poczta.o2.pl with ESMTP id xQMGfQ;
	Wed, 13 Jun 2012 16:48:02 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-O2-Trust: 2, 62
X-O2-SPF: neutral
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199894>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I just stumbled upon this while checking a few mailing lists.
I haven't found any mails about in in the archives yet, so I assume, that
no mail have been written yet.

The problem is described here:
http://sourceforge.net/projects/sevenzip/forums/forum/45798/topic/5322604

Basically, while this is not a problem for GNU tar, the correct checksum
should be computed using unsigned values.

Attached trivial testcase shows the difference.

Patch making the change shown in the testcase also attached.


--7JfCtLOvnd9MIVvH
Content-Type: text/x-c; charset=utf-8
Content-Disposition: attachment; filename="cksum-test.c"
Content-Transfer-Encoding: 8bit

#include <stdio.h>
#include <string.h>

static unsigned int ustar_header_chksum(const void *buffer, int sign)
{
  const char *p = (const char *)buffer;
  unsigned int chksum = 0;
  while (p < (const char *)buffer + strlen(buffer))
  {
    if (sign) chksum += *p++; else chksum += (unsigned char)*p++;
  }
  return chksum;
}

int main(int argc, char** argv)
{
const char* teststring = "żółte źrebię";
printf("%u\n", ustar_header_chksum(teststring, 0));
printf("%u\n", ustar_header_chksum(teststring, 1));
return 0;
}
--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git-tar.patch"

--- archive-tar.c	2012-04-26 21:25:49.000000000 +0200
+++ archive-tar.c	2012-06-13 16:43:59.220945967 +0200
@@ -104,11 +104,11 @@ static unsigned int ustar_header_chksum(
 	char *p = (char *)header;
 	unsigned int chksum = 0;
 	while (p < header->chksum)
-		chksum += *p++;
+		chksum += (unsigned char)*p++;
 	chksum += sizeof(header->chksum) * ' ';
 	p += sizeof(header->chksum);
 	while (p < (char *)header + sizeof(struct ustar_header))
-		chksum += *p++;
+		chksum += (unsigned char)*p++;
 	return chksum;
 }
 

--7JfCtLOvnd9MIVvH--
