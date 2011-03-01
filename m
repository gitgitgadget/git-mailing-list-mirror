From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 0/3] Fix unnecessary (mtime) updates of files during merge
Date: Mon, 28 Feb 2011 18:08:49 -0700
Message-ID: <1298941732-19763-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 02:09:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuE5E-0004rS-9B
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 02:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab1CABIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 20:08:55 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55990 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370Ab1CABIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 20:08:54 -0500
Received: by ewy6 with SMTP id 6so1493924ewy.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 17:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=GIe9PlL4pF/I8EfavT3pdUzmiZ2o6lQ2Nu4pxp1MyDY=;
        b=Uia3Bu1DxHlzAtbEIQ87Fj611gzZagogtXqV/t3LZP5Z9eJ/tBRC93DBdYyAPQ5eKS
         BR+4J1z3AtKS3RsSatPrzMhWJ4hjOEH5xjow0+PUbg9Nj2TM2zX4epkhci08bXp2IkOA
         yU9cmEnvvANZnqIhgZaMFv+zPcAslx21PunmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=juAAEnej3YD0odfBUuA21ujDuPDxxwV5P3javMkJui7a8zX9CAit/tgCTd5DVQQbv6
         EJ7lINIgmbeFTu6B2R3rRUKKXedvFgSvmwzHqra4fqSDQNHmhODMSK9oW+ZycQWNdN0n
         6X3upENV8jLer2tAMSxcF7OQFuAPTHl5i+dDY=
Received: by 10.213.103.7 with SMTP id i7mr1631179ebo.88.1298941733150;
        Mon, 28 Feb 2011 17:08:53 -0800 (PST)
Received: from Miney.hsd1.nm.comcast.net. (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id q52sm3692922eei.9.2011.02.28.17.08.50
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 17:08:52 -0800 (PST)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168173>

This patch series fixes a bug reported by Stephen Rothwell -- that
during merges git would unnecessarily update modification times of
files.

There are two testcases included in this patch series.  The first is a
simple case to test the originally reported bug; this testcase is
fixed in this series (as is Stephen's original linux-next testcase).
The second testcase suffers from the exact same problem, but arises
from a different situation and is not fixed in this series.  That
testcase is slightly harder to solve because:

  * unpack_trees + threeway_merge throws away the original index entry
    with stat information when it notices the directory/file conflict

  * make_room_for_directories_of_df_conflicts() must remove such files
    from the working copy or the corresponding directory and files
    below it will be unable to be written to the working copy (which
    can cause spurious conflicts, or make resolving conflicts very
    hard for users who don't know how to access the many files missing
    from their working copy).

We could fix this second testcase by recording stat information for
files removed by make_room_for_directories_of_df_conflicts(), and
then, if those files are reinstated at the end of conflict resolution
(i.e. the directory of the D/F conflict went away during the merge),
then call utime() to reset the modification times on those files back
to what they originally were.

(Technically, the second testcase that I left unfixed is not a
regression; prior versions of git would fail the merge and record the
file's content in an alternative file to "avoid" the directory it
thought was in the way, so the modification time was the least of the
worries.)


Elijah Newren (3):
  t6022: New test checking for unnecessary updates of renamed+modified files
  t6022: New test checking for unnecessary updates of files in D/F conflicts
  merge-recursive: When we detect we can skip an update, actually skip it

 merge-recursive.c       |   17 +++++++----
 t/t6022-merge-rename.sh |   68 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 6 deletions(-)

-- 
1.7.4
