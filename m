From: "Jon Nelson" <jnelson@jamponi.net>
Subject: pack.packSizeLimit and --max-pack-size not working?
Date: Wed, 12 Nov 2008 09:12:17 -0600
Message-ID: <cccedfc60811120712o7fcbf648l9f4b8e6f52e50e39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 16:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0HPX-0003Ic-Tz
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 16:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbYKLPMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 10:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYKLPMU
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 10:12:20 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:46925 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbYKLPMT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 10:12:19 -0500
Received: by yw-out-2324.google.com with SMTP id 9so198820ywe.1
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 07:12:18 -0800 (PST)
Received: by 10.64.208.8 with SMTP id f8mr8828376qbg.44.1226502737982;
        Wed, 12 Nov 2008 07:12:17 -0800 (PST)
Received: by 10.65.107.14 with HTTP; Wed, 12 Nov 2008 07:12:17 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100756>

I'm using 1.6.0.4 and I've found some weird behavior with
pack.packSizeLimit and/or --max-pack-size.

Initially, I thought I could just use pack.packSizeLimit and set it to
(say) 1 to try to limit the size of individual packfiles to 1MiB or
less. That does not appear to be working.

In one case I performed the following set of commands:

# set pack.packSizeLimit to 20
git config --global pack.packSizeLimit 20

# verify that it's 20
git config --get pack.packSizeLimit # verify it's 20

# run gc --prune
git gc --prune

# show the packfiles
# I find a *single* 65MB packfile, not a series
# of 20MB (or less) packfiles.
ls -la .git/objects/pack/*.pack

# try repack -ad
git repack -ad

# I find a *single* 65MB packfile, not a series
# of 20MB (or less) packfiles.
ls -la .git/objects/pack/*.pack


So it would appear that the pack.packSizeLimit param
is just being ignored??

Then I tested using --max-pack-size explicitly. This works, to a degree.

git repack -ad --max-pack-size 20

# the following shows *4* pack files none larger
# than (about) 20MB
ls -la .git/objects/pack/*.pack

# try again with 3MB. This also works.
git repack -ad --max-pack-size 3
find .git/objects/pack -name '*.pack' -size +3M -ls # nothing

# try again with 1MB. This does NOT work.
git repack -ad --max-pack-size 1

# here, I find a *single* 65MB pack file again:
find .git/objects/pack -name '*.pack' -size +1M -ls

Am I doing something completely wrong with pack.packSizeLimit?
What is going on with --max-pack-size in the 1MB case?


-- 
Jon
