From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: upload-pack timing issue on windows?
Date: Sat, 6 Feb 2010 00:51:56 +0100
Message-ID: <40aa078e1002051551o6d116a50uee3f6a32b16adb46@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:52:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXy0-0006r2-OU
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934061Ab0BEXv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:51:59 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:49613 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933393Ab0BEXv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:51:58 -0500
Received: by wwi18 with SMTP id 18so719622wwi.19
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 15:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:message-id
         :subject:from:to:content-type;
        bh=8nbc/hFr17cWkPYxdb+iaF6mSLBLYeLcyF3BNn8KK2Q=;
        b=Xn0KvMrLKAbOky5WnyzkYEHmVSRKfYQHoJrZAYPxBvAktNIRcsHCeXmoq+LZ40tevQ
         KMRBtNXuu0fdGurCCj01U84Do+lhcd5B029j2hgOwbhD+ztJqAEXkqyzpPOrY8a3Aqn/
         obd3HKUxNBi/CMcJf/f4AOrCTJkqU6s8fQqBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=paYhShiigChL7LlJcqFSWhHex5u1cHYzcdOgpRwX7HPe76ukbmPw1tz7xd/X/F5+0D
         z5k5SQc0t6zsbOuMmLWgB7LhuqWHCNTiEME2DBjVPWAPtRSQwFUrNN7MhntGq9q1cfKu
         N6Hy+VVEu2WFcN5aC9oFSPzPrg9AsfhEF01S8=
Received: by 10.216.88.7 with SMTP id z7mr1984645wee.19.1265413916271; Fri, 05 
	Feb 2010 15:51:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139126>

As some of you might know, I've been working on porting git-daemon to
Windows for quite some time now. As it stands now, there's really only
one known issue that is blocking on my end here:

Something weird happens *sometimes* when upload-pack is exiting,
leading to a client dying with a "fatal: read error: Invalid
argument\nfatal: early EOF"-error. If I place a sleep(1) at some place
after exiting the while(1)-loop in create_pack() in upload-pack.c, the
symptom goes away. create_pack() contains some async-code, but this
doesn't seem to be triggered in my minimal case at all. I've tried
flushing stdout and stderr explicitly, no luck.

How often the issue triggers seems to depend on two things, the size
of the repo and the connection speed. If I clone from localhost, I
can't get it to trigger at all. If the repo is of some size, it
triggers rarely. However if I have a repo with only one commit, it
seems to trigger every single time for me.

I've noticed that one of the last things that happens is a call to
poll with nfds=1. This triggers a special case in our poll-emulation
on Windows; but removing that special case hasn't given me any
positive results.

Does anyone have a hunch about what might trigger this issue?

-- 
Erik "kusma" Faye-Lund
