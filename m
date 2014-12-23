From: Mike Hommey <mh@glandium.org>
Subject: fast-import's notemodify doesn't work the same as git notes
Date: Tue, 23 Dec 2014 09:06:11 +0900
Message-ID: <20141223000611.GB10980@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 01:11:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3D4G-00022A-NQ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 01:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbaLWAGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 19:06:24 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:54928 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbaLWAGX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 19:06:23 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Y3CzL-0004Br-6Q; Tue, 23 Dec 2014 09:06:11 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261703>

Hi,

There are two major differences between adding notes with fast-import
and git notes, one of which is a serious problem:

- fast-import doesn't want to add notes for non commits, while git notes
  does.

- fast-import and git notes have different, conflicting fanouts:
  - take e.g. the git repo (there needs to be a lot of commits to start
    to see the problem)
  - run the following to create notes for every commit:
      (echo 'blob';
       echo 'mark :1';
       echo 'data 0';
       echo 'commit refs/notes/foo';
       echo 'committer <foo> 0 +0000';
       echo 'data 0';
       git rev-list --all | awk '{print "N :1", $1}';
       echo) | git fast-import
  - pick a random commit. I'll pick
    bbcefffcea9789e4a1a2023a1c778e2c07db77a7 as it is current master as
    of writing. Take the first two characters of that sha1, and look at
    the ls-tree:
      git ls-tree refs/notes/foo bb/
    You'll see a number of blobs.
  - Now, remove the note for that commit with git notes:
      git notes --ref foo remove bbcefffcea9789e4a1a2023a1c778e2c07db77a7
  - ls-tree again, you'll now see a number of trees instead of blobs,
    because git notes will have done a fanout. -> git notes does fanouts
    for much less items than fast-import does.
  - Re-add a note for that commit with fast-import:
      git fast-import <<EOF
      blob
      mark :1
      data 0
      commit refs/notes/foo
      committer <foo> 0 +0000
      data 0
      from refs/notes/foo^0
      N :1 bbcefffcea9789e4a1a2023a1c778e2c07db77a7

      EOF
  - ls-tree again, and you'll see a number of trees and *one* blob, for
    bb/cefffcea9789e4a1a2023a1c778e2c07db77a7
  - See the thread starting with 20141126004242.GA13915@glandium.org,
    this type of notes branch make things very slow.
  - Now, if you take an even bigger repository (as long as there are more
    than 65536 commits, that's good ; I guess the linux kernel
    qualifies, I've been checking with a mozilla-central clone), and
    create exactly 65535 notes with git fast-import, you'll end up with
    a 1-level tree (2/38). Add one more note, and the entire tree turns
    into a 2-level tree (2/2/36). git notes would only add a level to
    the tree containing the added note. git notes's behavior scales
    better, because think about what happens on the next fanout with
    fast-import... adding one note would need to create millions of trees.

Cheers,

Mike
