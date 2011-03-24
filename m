From: Jay Soffian <jaysoffian@gmail.com>
Subject: merge recursive and code movement
Date: Thu, 24 Mar 2011 17:18:20 -0400
Message-ID: <AANLkTi=h6jUsjqXofd0QeWbNBjc9DeodJJ3FN7caW4XC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 24 22:19:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2rvl-0006sA-Qx
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 22:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567Ab1CXVSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 17:18:51 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59867 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab1CXVSu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 17:18:50 -0400
Received: by iyb26 with SMTP id 26so372538iyb.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 14:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=JlxXUpoHYwui0lg3o1RHQupYvLXHBUTqU1eBgJb4yD8=;
        b=afoJlWTZ17NPNcELkff+cmyCeSn5/VoaW9BTBx/euWaTO++dWrGg4dq7Mb03E7T08f
         kuyo3kBOoYj/l1aPltLxKS/qSKBwrDEHgUDuA+w80EgA3wdB28SWirMowaWEqF6E/URu
         oSmHrukvWYzPhIyc5mv/pGiB4OvO/+WyIfp+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Q1JhMVwS2DyZFrrgDZQA527WChvZ//zH6hE4YkUWPoNE6iyQk5aaElThklVVf3umeC
         Hw+pgVk5Z7n7Pc1gNXY2kfhm/eYpYi4vLwCgCcZbd3ztGq8TL9vhAgWDSSJiWrLkfxq/
         MYB6lRPDZ7DsScXPeTftEfyRjkNRE7CmCPiPo=
Received: by 10.42.75.137 with SMTP id a9mr1754996ick.194.1301001530206; Thu,
 24 Mar 2011 14:18:50 -0700 (PDT)
Received: by 10.231.181.91 with HTTP; Thu, 24 Mar 2011 14:18:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169944>

There's a use case that merge recursive doesn't seem to handle, and I
wonder how difficult it would be to add.

Say you have a merge between OURS and THEIRS, with common ancestor BASE.

Between BASE and THEIRS, a file named header.h has the following changes:

  # Rename header.h to header_new.h
  git mv header.h header_new.h

  # Minor edits to account for the rename such as fixing the
  # include guard:
  perl -pi -e 's/HEADER_H_/HEADER_NEW_H_/' header_new.h

  # Drop a compatibility header.h in place till we can fix all the
  # files which include header.h
  cat > header.h <<-__EOF__
	#ifndef HEADER_H_
	#define HEADER_H_
	#include "header_hew.h"
	#endif // HEADER_H_
  __EOF__

  git add header.h header_new.h
  git commit -m 'rename header.h to header_new.h'

Meanwhile, between BASE and OURS, a few minor changes are made to
header.h. This could be as little as a single line change in the
middle of the header.h.

Now you merge THEIRS to OURS. Git will just show header.h in conflict.
99% of the time I can do the following:

  git diff MERGE_BASE... header.h | patch header_new.h
  git checkout --theirs header.h
  git add header.h header_new.h

But it would seem like this is something merge recursive should be
capable of handling on its own.

j.
