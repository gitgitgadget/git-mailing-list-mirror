From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Git ksshaskpass to play nice with https and kwallet
Date: Tue, 04 Oct 2011 12:19:59 +0200
Message-ID: <4E8ADDCF.6090406@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 04 12:20:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB26b-0008HW-5m
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 12:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860Ab1JDKUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 06:20:03 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:35878 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755800Ab1JDKUB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 06:20:01 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EB4DE2D929
	for <git@vger.kernel.org>; Tue,  4 Oct 2011 06:20:00 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Tue, 04 Oct 2011 06:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:content-type:content-transfer-encoding; s=smtpout; bh=I
	m/r2SXbx+0wsmJiEVhhji6tm8o=; b=ceLPMVjynzlThB7Kt+ymE3hwPeWpU0DQH
	t73Co1d+HXaa5HMHIEPTEouqemwqLEJJnEFjQtG+17vvD5W8Tlzq4z/x4muRthSj
	Q8DysGz5dExyE8xHneb9iUjIEVN9o82a0P5ufiQF5a+rIugQFhLOrWwGBSeGEbxU
	5YiKTbCsLY=
X-Sasl-enc: 5zaEjPK3cL1sLFdbxH0iS/CoEw9MNcoSo/RRmiQBowIt 1317723600
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 90610B21A76
	for <git@vger.kernel.org>; Tue,  4 Oct 2011 06:20:00 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182752>

Checking out bitbucket and https, I came across a stupid issue between
the default KDE setup (SSH_ASKPASS=/usr/bin/ksshakspass and KDE wallet)
and the way we call the askpass helper, which makes the combo not work
out of the box.

For those interested in getting it to work (or learning why it does not
work out of the box), you can read the details formatted on my sparse
blog (brain dump)

http://grubix.blogspot.com/2011/10/git-ksshaskpass-to-play-nice-with-https.html

or below if you don't feel like clicking through.

Cheers
Michael

By default (with GIT_ASKPASS not set etc.), Git invokes $SSH_ASKPASS
when it needs to ask you for credential info. In a KDE environment,
SSH_ASKPASS is set to /usr/bin/ksshaskpass. So far so good.

But Git calls the askpass helper with a command line like
/usr/bin/ksshaskpass Username for 'bitbucket.org':
and once again with
/usr/bin/ksshaskpass Password for 'bitbucket.org':
So far so good.

But when asked to store the credentials in the KDE wallet, ksshaskpass
tries (too) hard to guess a good key from that line. And for both
invocations, it comes up with the same key (the URL), so that when the
password info is needed, the username info from the wallet is returned.
Authentication fails.
Far from good.

If you still want to use the KDE helpers, you can save the little snippet
#!/bin/bash
set $*
exec ksshaskpass $1\@$3
into ~/bin/git-ksshaskpass (and make it executable) and set

git config --global core.askpass ~/bin/git-ksshaskpass
Gitcha!

NB:

    tested and works with https
    not tested with other methods (use ssh-agent)
    new credential helper interface coming in Git after 1.7.7
