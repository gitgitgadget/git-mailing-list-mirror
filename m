From: Duy Nguyen <pclouds@gmail.com>
Subject: Store refreshed stat info in a separate file?
Date: Fri, 18 Apr 2014 21:20:31 +0700
Message-ID: <CACsJy8CzZ7H4pffNccBBpvpn5oT5tud-Tx=Nu1c=q2SB7Zi8eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 18 16:21:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wb9fC-0003JO-30
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 16:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbaDROVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 10:21:05 -0400
Received: from mail-qc0-f177.google.com ([209.85.216.177]:34001 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbaDROVD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 10:21:03 -0400
Received: by mail-qc0-f177.google.com with SMTP id w7so1712213qcr.36
        for <git@vger.kernel.org>; Fri, 18 Apr 2014 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=TZcguBm26QcSzhX3e+SGFnBpiuRHuOSTMlDzNCt7IyQ=;
        b=qdt+5uuUspBGyzjfK5CGD/PXBiPNz+dqQhBzGUg0nsvN5uyvI7bfx2ER4zoLh3SsK6
         RuvZ/gm2LZZRkWWF+dy7d5lK/bNgRiuD5pUBzFxkkkcsrdsfKDhZw6WmoqfPjbsjkucT
         t+NInhCU8iY4mWL06VpPL/aw47PpPW0hRBxb271DEpt78Myj8uLSFTQ9ZDRXLZKcS1Oh
         /3aJdxECjUggIzHNyPlnNX6Jv/FBkxBzLItc3dkGlF5jW9ghU2c3NmwDVx0t+1rqNh5y
         +/k/SAbYvh/e7SY2ionINFUcSNCTgdBLH8ymup3kU8tlo/hPdEZ6FsG9aunPBJ/u18X8
         qU5w==
X-Received: by 10.229.216.72 with SMTP id hh8mr18980414qcb.9.1397830861616;
 Fri, 18 Apr 2014 07:21:01 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Fri, 18 Apr 2014 07:20:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246471>

With git status, writing refreshed index takes 252ms per total 1s,
361s/1.4s, 86ms/360ms on gentoo-x86, webkit and linux-2.6 respectively
(*). It's takes a significant amount of time from "git status". And
this happens whenever you touch a single tracked file, then do "git
status". We tried to solve this with index v5, but it's been years(?)
since its start as a GSoC project. So I'm thinking of another way
around..

The major cost of writing an index is the SHA-1 hashing. The bigger
the written part is, the higher cost we pay. So what if we write
stat-only data to a separate file? Think of it as an index extension,
only it stays outside the index. On webkit with 182k files, the stat
data size would be about 6MB (its index v4 is 15M for comparison). But
with stat-only we could employ some cheap but efficient compressing,
sd_dev, sd_uid and sd_gid are likely the same for every entry. And we
could store the stat data of updated entries only. So I'm hoping to
get that 6MB down to a few hundred KBs. That makes hashing lightning
fast.

So the idea is, when we do refresh, we note what entry has stat
updated. Then we write $GIT_DIR/index.stat (and leave $GIT_DIR/index
alone), which is a valid index except that it has zero entries and a
only one (new) extension storing (maybe compressed) stat data of
updated entries. The extension also contains the trailing SHA-1 of
$GIT_DIR/index for verification later. When we read $GIT_DIR/index, we
check for the existence of index.stat. If it does and its attached
SHA-1 matches, we overwrite some stat data with the info from
index.stat.

Back to the original question, I'm hoping to reduce some significant
numbers above to less than 10ms with this. So I see all good points
but no bad ones. Time to ask git@vger to give some. I'm actually
trying this idea in my untracked cache because I can't afford to lose
50% of the gain from untracked cache, just because I have to save some
bits in the giant $GIT_DIR/index and take the cost of rehashing.

(*) this is with the "untracked cache" enabled and total time is about
40% less than upstream "git status". The numbers against upstream "git
status" are actually less signficant. But I have to think positive
that one day untracked cache may be merged :)
-- 
Duy
