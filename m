From: Phil Hord <hordp@cisco.com>
Subject: Stash during incomplete merge
Date: Sun, 26 Feb 2012 13:36:55 -0500
Message-ID: <4F4A7BC7.5010702@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 26 19:37:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1iyM-0005lI-HY
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 19:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab2BZSg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 13:36:56 -0500
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:18153 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab2BZSgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 13:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2325; q=dns/txt;
  s=iport; t=1330281415; x=1331491015;
  h=message-id:date:from:mime-version:to:cc:subject:
   content-transfer-encoding;
  bh=ozTWnoKPEyLf2ASjIxB87/vNMwXxtfGJlB/Qrl9AkQw=;
  b=W3EZL2PeS7B/GBZzJLzq7Y9Q+2UgBJgfTQJGEMEq2nbdfRinyemgfFsg
   Kqld3KUjOI06CTiO0xCmjWI+oUufJ4WCDGsn3paczmtEX9GyfG/9BvFqG
   mDRNokVuT/GXuZuE41sCPtR6fE5zD/rucWHR4qvZwwhBsX4lTuJg9dday
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AoEGAIJ6Sk+tJV2a/2dsb2JhbABDgxOwHoEHggwBYQQBPBYYAwIBAgFLDQEHAQEeh2QLoE4BlgSNDQYTARsCAgcGBAMEAwgECggOAQkBCQKFCjYHAQ4HBw8Ggy8EiE+MboVdjS8
X-IronPort-AV: E=Sophos;i="4.73,486,1325462400"; 
   d="scan'208";a="61904979"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-5.cisco.com with ESMTP; 26 Feb 2012 18:36:55 +0000
Received: from [10.117.80.99] (rtp-hordp-8912.cisco.com [10.117.80.99])
	by rcdn-core-3.cisco.com (8.14.3/8.14.3) with ESMTP id q1QIas2N022792;
	Sun, 26 Feb 2012 18:36:54 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20111229 Thunderbird/9.0
X-Enigmail-Version: 1.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191572>

Hi list,

I was cherry-picking changes from an old branch recently when I ran into
unexpected behavior with git stash pop.  When I git-stash-save after
resolving a  merge-conflict, the subsequent git-stash-pop does not
restore my index.

I think it is the same problem being asked about here:
http://stackoverflow.com/questions/9009354/git-stash-during-a-merge-conflict

Is this expected behavior or a bug?

<http://stackoverflow.com/questions/9009354/git-stash-during-a-merge-conflict>Here's
a script the demonstrates the anomaly, but my actual encounter involved
more files, some of which I added to the index and some I did not:

# Create a sample merge-conflict
git init  tmp-repo && cd tmp-repo
echo foo > foo.txt && git add foo.txt && git commit -m "foo"
git checkout -b A master && echo foo-A > foo.txt && git commit -am "foo-A"
git checkout -b B master && echo foo-B > foo.txt && git commit -am "foo-B"
git merge A
git status
# Resolve the conflict
echo foo-AB > foo.txt && git add foo.txt
git status
git stash
# test test test...  Resume...
git stash pop






Here's some of the final output:

$ git merge A
Auto-merging foo.txt
CONFLICT (content): Merge conflict in foo.txt
Recorded preimage for 'foo.txt'
Automatic merge failed; fix conflicts and then commit the result.

$ git status
# On branch B
# Unmerged paths:
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#       both modified:      foo.txt
#
no changes added to commit (use "git add" and/or "git commit -a")

$ # Resolve the conflict
$ echo foo-AB > foo.txt && git add foo.txt
$ git status
# On branch B
# Changes to be committed:
#
#       modified:   foo.txt
#

$ # Now foo.txt is in my index.  But I have to test something before I
commit.
$ git stash
Saved working directory and index state WIP on B: 80f2a13 foo-B
HEAD is now at 80f2a13 foo-B

$ # test test test...  Resume...
$ git stash pop

# On branch B
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
directory)
#
#       modified:   foo.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
Dropped refs/stash@{0} (460a6d5c67a3db613fd27f1854ecc7b89eeaa207)
