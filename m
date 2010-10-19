From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [BUG] git repack fails if .git/objects/pack is on a separate
 partition
Date: Tue, 19 Oct 2010 00:40:40 -0700 (PDT)
Message-ID: <1287474040065-5649864.post@n2.nabble.com>
References: <1287469706023-5649732.post@n2.nabble.com> <201010190859.43098.trast@student.ethz.ch> <1287473363910-5649843.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 19 09:40:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P86oQ-0002QB-8x
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 09:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933130Ab0JSHkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 03:40:41 -0400
Received: from kuber.nabble.com ([216.139.236.158]:54670 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab0JSHkk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 03:40:40 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <marat@slonopotamus.org>)
	id 1P86oK-0008LK-2K
	for git@vger.kernel.org; Tue, 19 Oct 2010 00:40:40 -0700
In-Reply-To: <1287473363910-5649843.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159310>


Testcase:

# tell it where is other partition
OTHER_PARTITION=/path/to/other/partition/

# init repo
mkdir foo && cd foo && git init

# put some stuff and run gc to create packfile
cp /etc/fstab . && git add fstab && git commit -m "initial" && git gc

# move pack dir to other partition and install symlink
mv .git/objects/pack $OTHER_PARTITION && ln -s $OTHER_PARTITION/pack
.git/objects/pack

# run gc (it fails)
strace -f git gc 2>&1 | grep rename

[pid  3792] rename(".git/packed-refs.lock", ".git/packed-refs") = 0
[pid  3793] rename(".git/logs/refs/heads/master.lock",
".git/logs/refs/heads/master") = 0
[pid  3793] rename(".git/logs/HEAD.lock", ".git/logs/HEAD") = 0
[pid  3808] rename(".git/objects/pack/tmp_pack_8ZhS92",
"/home/marat/foo/.git/objects/.tmp-3795-pack-da13ceb9f70c2762595a7a2932411db339bdab46.pack")
= -1 EXDEV (Invalid cross-device link)
[pid  3808] write(2, "fatal: unable to rename temporar"..., 71fatal: unable
to rename temporary pack file: Invalid cross-device link

So you see, it tries to move packfile from .git/objects/pack to .git/objects
-- 
View this message in context: http://git.661346.n2.nabble.com/BUG-git-repack-fails-if-git-objects-pack-is-on-a-separate-partition-tp5649732p5649864.html
Sent from the git mailing list archive at Nabble.com.
