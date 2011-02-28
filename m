From: Jay Soffian <jaysoffian@gmail.com>
Subject: [1.8.0] fix branch.autosetupmerge and branch.autosetuprebase
Date: Mon, 28 Feb 2011 17:37:49 -0500
Message-ID: <AANLkTi=Ei-Gr3=O0_dfaCekQ0+nB8v1kZYT7sTw-Ydm+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dustin Sallings <dustin@spy.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 28 23:38:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuBjV-0006uu-N4
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 23:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711Ab1B1WiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 17:38:21 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37606 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab1B1WiU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 17:38:20 -0500
Received: by iwn34 with SMTP id 34so3546731iwn.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 14:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=jg/TfHG5YJtJBpkhhGqIIKa/ojg3RFf9gguebLOI7vw=;
        b=LgpUGbviQycUfI23bKan/yJHJ6dk1dausnhK6joh6T07uenDe+qbqtjtIsMAPJshlp
         jKa7FhFK4z2lCvkJnmM97S7rFQF5el5dfjynXZp3w2f5u7z+KSl6KsCiS3rlNTzVUfkL
         KZKCsfiYIwQrfqDW/7z+hs2q7hhGILJTfGydo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=LqNo/EGCVw7m8Uuc32IhFf3mJUPXkELzX/yD6TMK/IFcO9jo8wlQXdKAUri/Rf4sNj
         cvSR/DD3C088UXLbd3D2i7Byn1K1JeXLlYrsTdLDGeVUdAqyjXDQTQG3nCpXbYi5wjwC
         iFRCGADNV02CRP1fXbBNFNL0giqHBIk2CoOl8=
Received: by 10.42.176.7 with SMTP id bc7mr1534864icb.257.1298932700183; Mon,
 28 Feb 2011 14:38:20 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Mon, 28 Feb 2011 14:37:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168157>

It strikes me that branch.autosetupmerge and branch.autosetuprebase
are a bit crufty. So a proposal:

Proposal
========

1. Deprecate branch.autosetupmerge. Right now it's got three choices:
false, true, and always, defaulting to "true"

But I wonder, does anyone use "false" and not set the upstream? And I
think that "always" is a misfeature (I'm qualified to say this, see
9ed36cf). 99% of the time, I think you are doing one of the following:

  $ git branch topic origin/master    # 1
  $ git branch topic master           # 2
  $ git branch topic some_other_topic # 3

In the case of (1), you want origin/master to be configured as the
upstream for topic. In the case of (2), even though you are starting
at master, I'll bet you want the upstream to be origin/master. In the
case of (3), even though you are starting at some_other_topic, I'll
bet you want topic to have the same configured upstream as
some_other_topic.

So, my proposal wrt to branch.autosetupmerge is that we deprecate it
and always do the following:

- When creating a local branch L from remote-tracking branch R, set R
as upstream of L.
- When creating a local branch L1 from other local branch L2, whose
upstream is remote-tracking branch R, set R as upstream of L1.

For the 1% of the time that you really want local branch L2 to be
upstream of L1, specify that explicitly when you create the branch.

2. Deprecate branch.autosetuprebase. Pull's default action shouldn't
be specified when the branch is created. Rather, add a "pull.rebase"
boolean defaulting to false, and which is overridden per-branch by
branch.<name>.rebase.

Migration
=========

Let's first see if the proposal flies because it's good, or whether it
has flies because it stinks. :-)

j.
