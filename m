From: Santiago Torres <santiago@nyu.edu>
Subject: [RFC] Malicously tampering git metadata?
Date: Tue, 15 Dec 2015 22:26:39 -0500
Message-ID: <20151216032639.GA1901@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 16 04:26:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a92jm-0002PG-Tm
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 04:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933915AbbLPD0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 22:26:43 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34310 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932552AbbLPD0m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 22:26:42 -0500
Received: by mail-qk0-f174.google.com with SMTP id p187so45786779qkd.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 19:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition;
        bh=ztigY8C+gjZbjLINWvOIjrhX+akqjtMh0zmMiJrdOHw=;
        b=yI0DR9TLUGSDSvaOz/fOvmfU9ATHSljl0fcR7ld9kLIBKfwAGVS63BOYIpPZVuo7ek
         Aqs0PhoLlQCIGejNm4BFR8Zltc6zSWlLNRVuezAN50LyTcRp0RVroaJ84sJ/y4ecx8Tq
         7MCWIA099pUHjU6kQDszzE8B+tHDVoTvB0xxW5jV/RVNo4Qhv7OkJ+84BZS9ewap/GkD
         l+LR7yT9y7yQTrFKOdHuxmTUU86G/f9cnN2LqdCC+zv+zuNylhAXA0sJMH9hRLVvtuAg
         Srr57t1XV5wjgo9v+OUcazzSIxRdTFEGxMVCvRYkXbsNmcNraBp+hJJmCut+oIaE2uJq
         eqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition;
        bh=ztigY8C+gjZbjLINWvOIjrhX+akqjtMh0zmMiJrdOHw=;
        b=ShTdGevdQbZUC1G2AJsm4/WT4wptw2ecAx39oRVtwkfHDquPwQAfwNGtdjXRUieSD/
         uV722MtzGkcG/n+EwOoJrX1Ln4XC0r8njrkv86+4guwQMH+uPjQuEQDlAwC/ev+HVwbT
         3LLDJF9gHauulCp8ocondilYseeJwIYDJCkGd4N40e5DnM7TizczLWD1tA1/Umuq8YLp
         F2+dKBw+bKzlmCqEJnEaHgOZYS0p490+hLLiqFcb7Jt/k7UChNSy+LHvlI4tTPdQEYYt
         dkJfq4lN+yBhrDsz7Qq7jc8S9JICs5U0M/y8sA6LhCz9x3DGyznUordy1pKbKzuZauUz
         l4Aw==
X-Gm-Message-State: ALoCoQkay7fWB5tfcae2SnqUUmJUNhL2IMFn6GT5fehBYyzNOflZj1Bkdd8qkjMu9cLlJIy9WNuWj0mf++HbOCLVk787+2Malw==
X-Received: by 10.55.20.1 with SMTP id e1mr12788652qkh.60.1450236401737;
        Tue, 15 Dec 2015 19:26:41 -0800 (PST)
Received: from LykOS (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id s131sm1848931qhs.11.2015.12.15.19.26.41
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Dec 2015 19:26:41 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282532>

Hello everyone,

I'm Santiago, a PhD student at NYU doing research about secure software
development pipelines. We've been studying different aspects of Git
lately, (as it is an integral part of many projects) and we believe
we've found a vulnerabilty in the way Git structures/signs metadata. 

An attacker capable of performing as a Man in the Middle between a
GitHub server and a developer is able to trick such developer into
merging vulnerable commit objects, or omit security patches --- even if
all users sign all commit objects. Given that Git metadata is unsigned,
it can be modified to provide incorrect views of a repository to
downstream developers.

An example of a malicious commit merge follows:

1) The attacker controlling or acting as the upstream server identifies
two branches: one in which the unsuspecting developer is working on, and
another in which a vulnerable piece of code is located.

2) Branch pointers are modified: the packed-refs file (or ref/heads/*)
is edited so that the master branch points to the vulnerable commit
object. Having performed the change, no additional configuration must be
made by the attacker, who now waits for an unsuspecting developer to
pull.

3) Once a developer pulls, he or she will be prompted to merge his code
with the new change-set (the vulnerable commit). This operation will
only resemble developer negligence. If no conflicts arise, the attack
will pass unsuspected.

4) The developer pushes to upstream. All the traffic can be re-routed
back to the original repository. The target branch now contains a
vulnerable piece of code.

We have identified additional attack scenarios for modifying the
metadata that result in a incorrect state of the target repository, and
we are ready to disclose information about other variants of this attack
as well.

We also designed a backwards-compatible defense mechanism to prevent
attacks based on Git metadata tampering. Also we implemented a proof of
concept of the scheme, and performed timing, stress and concurrency
tests; our results show that the overhead should be minimal, even in
large software repositories such as the Linux Kernel.

We already approached people from CERT and GitHub regarding this attack
scenario, and we'd also like to hear your comments regarding this.

Thanks!
-Santiago.

P.S. We also elaborate more about this attack vector in this document: 
https://drive.google.com/a/nyu.edu/file/d/0B2KBm0fULlS1RDR5UHVESjVua3M/view?usp=sharing
