From: Michael G Schwern <schwern@pobox.com>
Subject: git-svn SVN 1.7 fix, take 2
Date: Tue, 24 Jul 2012 14:46:11 -0700
Message-ID: <500F17A3.60307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 24 23:46:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stmvv-0002si-DU
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 23:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab2GXVqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 17:46:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792Ab2GXVqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 17:46:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CC0681A3;
	Tue, 24 Jul 2012 17:46:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:content-type
	:content-transfer-encoding; s=sasl; bh=TueQtMyZyUER2GPKxu08/DLJT
	yU=; b=Iao9Cnh/bZHLxbY8B7AMY9VdfBBXpr3+wTzXfgw+yrMu0Wx66MlTogkEC
	yFV+CCrqxiWrFO+i2MQvFlfcxCSzVMMA0PEar/1nHmI6BgMU+xCbuE9R4BxPWxvs
	SCUC7wxC3CwLswW8/VZXVRlhgN+ghZxZjucE6GZ09Tb8OYrg1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=aB5IKkVEdfUDug5300K
	o3n/11Kmm9kFn1PXL5MbAVkjJTZQrxVn1rs/k7sUahnTg+samRVM7vCN5vreZX0w
	PZPvK4BJwdHVQLng0SQI5wCq5Y+N2/8nnUgJimfSTVO8mV/COymYF+WG++vdviJQ
	2cChh86Gqk0VOUinjT1KpG7c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 297F081A2;
	Tue, 24 Jul 2012 17:46:16 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 399AB819F; Tue, 24 Jul
 2012 17:46:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: FE89F5FE-D5D8-11E1-B7CE-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202074>

It's post OSCON so I can take another crack at this again.

I'm struggling with how best to present all this to you folks.  There's
etiquette for how one presents a git pull request... but there's conflicting
etiquette about how one presents patches to a mailing list.  I'm not sure
which bit of which applies when here.  Documentation/SubmittingPatches focuses
on single patches and basic commit etiquette.

A big one is "do not blast 10 emails to a mailing list" but I gather that's ok
here if a submission needs 10 commits to be well expressed and its done via
git-send-email?  And then if patch #3 needs revision I'm to do it in a rebase
and resend the whole 10 commits?  Am I to think of git-send-email less as a
means of sending patches to a mailing list and more as a git transport mechanism?

I'm trying to bust it up into easier to digest pieces.  I came into this cold
without much knowledge of the problem ("something to do with
canonicalization") and no knowledge of the code.  While each commit is sharp,
the work as a whole is mixed up.

Here's the first pieces, as I see them, along with their branches.  The whole
work is in https://github.com/schwern/git/tree/git-svn/fix-canonical

* Change the Makefile.PL so it automatically finds the .pm files.
https://github.com/schwern/git/tree/git-svn/easier_modules
(Going to remove the Error.pm movement as off-topic)

* Extract each of the internal Git::* packages from inside git-svn.
https://github.com/schwern/git/tree/git-svn/extract_classes

There's five classes, and I did each in at least two commits.  First is a
straight cut & paste with no further changes.  Second (or more) fixes it so
things work again.  This is better for review (if it were done in a single
commit the real change would be lost in the cut & paste), but it means you
have a commit that breaks thing which will be a problem for bisecting.  I'm
inclined to stick with two commits and you folks can squash them if you decide
bisecting is more important.

The Git::SVN extraction is more complicated than the rest, so I'll probably do
that separately and bust it up into a few commits.

Next I'm going to...

1) Submit easier_modules.
2) Break up the Git::SVN fix into more commits.
3) Submit the Git::SVN extraction.


-- 
Reality is that which, when you stop believing in it, doesn't go away.
    -- Phillip K. Dick
