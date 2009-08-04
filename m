From: Thell Fowler <tbfowler4@gmail.com>
Subject: Help/Advice needed on diff bug in xutils.c
Date: Tue, 04 Aug 2009 18:33:24 -0500
Message-ID: <1249428804.2774.52.camel@GWPortableVCS>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 01:35:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYTXJ-000887-D0
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 01:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377AbZHDXfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 19:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754907AbZHDXfH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 19:35:07 -0400
Received: from mail-yw0-f177.google.com ([209.85.211.177]:64110 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577AbZHDXfF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 19:35:05 -0400
Received: by ywh7 with SMTP id 7so5736369ywh.21
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 16:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=bDiBayZDrZqfzTejUGfrRdOM2x+9SxvblG8nuy5tTbk=;
        b=MFARoerApAqTENl4rQ1Ybpb91wbqPHDUKlZHB8nI1QbdfsBu2eVl1Tg4RpSnlziqHH
         mvZAHpA9fGiMHLrq6jBE1txEXzrCWwqQA4f0kEnKT3e0bkmY4zicbPO/Ad2yO9DqFoLx
         Qid/7EHHe+oCn17pFc0J6WDn0f5zQiqYZ+6Gs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=KTGwdi3JOYKEsFITGqOgdBrkilyXQ0GfS69x3l7LTmtCWxsRSVFR0fDJlNSHcFbeGf
         K7Uub2LJa94GAqrrykkitFwNfu478dHd8MtuDdyWiTXzAxEJmJb/ANRMffA1b/b8moK3
         hETxw//NgXgx8FzXG04ZtxsjMGSCRsW/sVVnE=
Received: by 10.100.171.17 with SMTP id t17mr10797468ane.145.1249428905476;
        Tue, 04 Aug 2009 16:35:05 -0700 (PDT)
Received: from ?192.168.1.106? (ip70-178-75-143.ks.ks.cox.net [70.178.75.143])
        by mx.google.com with ESMTPS id c28sm136883anc.9.2009.08.04.16.35.03
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 16:35:04 -0700 (PDT)
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124834>

Hi all!  Please give me a sanity check before I go crazy...

There is a bug in git diff (ignoring whitespace) that does not take into
account a trailing space at the end of a line at the end of a file when
no new line follows.

Here is the example of the bug:
mkdir test_ws_eof
cd test_ws_eof
git init
echo -n "Test" > test.txt
git add .
git commit -m'test'
git symbolic-ref HEAD refs/heads/with_space
rm .git/index
git clean -f
echo -n "Test ">test.txt
git add .
git commit -m'test'
# Ignoring all whitespace there shouldn't be a diff.
git diff -w master -- test.txt
# Ignoring space at eol there shouldn't be a diff
git diff --ignore-space-at-eol master -- test.txt
# Ignoring with -b might have a case for a diff showing.
git diff -b master -- test.txt


In the xutils.c xdl_hash_record_with_whitespace function the trailing
space prior to eof was being calculated into the hash, I fixed that
with the change below, but there is still a difference being noted in
xdl_recmatch because of the size difference.

Before I go changing something that shouldn't be changed could someone
provide some input please?

Thanks for reading,
Thell

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 04ad468..623da92 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -243,17 +243,17 @@ static unsigned long
xdl_hash_record_with_whitespace(char
const **data,
                if (isspace(*ptr)) {
                        const char *ptr2 = ptr;
                        while (ptr + 1 < top && isspace(ptr[1])
-                                       && ptr[1] != '\n')
+                                       && ( ptr[1] != '\n' && ptr[1] !=
'\0' ) )
                                ptr++;
                        if (flags & XDF_IGNORE_WHITESPACE)
                                ; /* already handled */
                        else if (flags & XDF_IGNORE_WHITESPACE_CHANGE
-                                       && ptr[1] != '\n') {
+                                       && ( ptr[1] != '\n' && ptr[1] !=
'\0' ) ) {
                                ha += (ha << 5);
                                ha ^= (unsigned long) ' ';
                        }
                        else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
-                                       && ptr[1] != '\n') {
+                                       && ( ptr[1] != '\n' && ptr[1] !=
'\0' ) ) {
                                while (ptr2 != ptr + 1) {
