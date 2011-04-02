From: Jonathan Michalon <johndescs@gmail.com>
Subject: Better big file support & GSoC
Date: Sat, 2 Apr 2011 16:40:51 +0200
Message-ID: <20110402164051.1f263aa0@RunningPinguin.chalmion.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 16:42:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q622H-0001FJ-9x
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 16:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587Ab1DBOmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 10:42:39 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49266 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1DBOmi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 10:42:38 -0400
Received: by wwa36 with SMTP id 36so5059859wwa.1
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=NTjT0FdKPxR97T0BpXs2jCsY5GC8NF6Y7ia01ZMfqhA=;
        b=FtY1DG9n1r+yNSPAKGDNVQJB5WYuuj7yH9l6JWFuer9/pPp0T18IHJxClzucTkbQxL
         0W8ebSg2ufrHmlRvTl0t9ZF/ENmlU+RtkV+cfonPFFtPpNz9rTd9FXhIODFKvs+Bo0R4
         FDZHir5/aMcZYEOIPvqjVL7zhNrGf/X6KEptw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=KHerpkVT9dsPz0f6bqQj7v7Ze8kBzM1X83m1KWiI+VPQoMDikNWY5vqFy1ZrdCNtU1
         rZceGeI8EISznvyq0d+1VbeV03qJa+yRJGOpcBEvgnx9Dv6+WnBsDwL6L1PZpT+mEPrt
         lByqFpsRIWwPFR+WEhupONzTJ1XfmAgH76Jlk=
Received: by 10.217.3.198 with SMTP id r48mr4855695wes.89.1301755357035;
        Sat, 02 Apr 2011 07:42:37 -0700 (PDT)
Received: from RunningPinguin.chalmion.homelinux.net (AStrasbourg-251-1-20-21.w82-126.abo.wanadoo.fr [82.126.210.21])
        by mx.google.com with ESMTPS id b15sm261540wer.12.2011.04.02.07.42.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Apr 2011 07:42:36 -0700 (PDT)
X-Mailer: Claws Mail 3.7.4 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170649>

Hi Git people,

I'm an applicant to the GSoC within git.
I would like to help building a better big file support mechanism.

I have read the latest threads on this topic:
http://thread.gmane.org/gmane.comp.version-control.git/165389/focus=165389
http://thread.gmane.org/gmane.comp.version-control.git/168403/focus=168852

Here's a compilation of what I read and what I think.

What come the most are OOM issues. But I think that the problem is, git tries
to work exactly the same on binaries and text. If we managed one way or another
to skip tasks (what "intelligent" operations are possible on binaries ?
Almost none...) we should be able to avoid them, like most of the time.
This means that a first step will be to introduce an autodetection mechanism.

Jeff King argues that, on binaries, we got uninteresting diffs, and compression
is often useless. I agree. We would better not compress any of them (okay, tons
of zeros would compress well but who's going to track zeroes?).

Eric Montellese says: "Don't track binaries in git. Track their hashes." I agree
here too. We should not treat computer data like source code (or whatever text).
He claims that he needs to handle repos containing source code + zipped tarballs
+ large and/or many binaries. Users seem to really need binary tracking and
therefore git should do it. I personally needed to a couple of times.

He also says that we could want to do download-as-needed and remove-unnecessary
operations, and I think that it may be clean enough to add a git command like
'git blob' to handle special operations for binaries. Perhaps in a second step.

Another idea was to create "sparse" repos, considered leafs as they may not be
cloned from because they lack full data. But it may or may not be in the
spirit of Git...


What I personally would like as a feature is the ability to store the main
repo with sources etc. into a conventional repo but put the data elsewhere
on a storage location. This would allow to develop programs which need data
to run (like textures in games etc.) without making the repo slow, big or
just messy.
I faced the situation on TuxFamily where the website, Git/SVN etc. are on one
quick server and the download area on another one. The first was limited to
something like 100MB and the second to 1GB, extensible to more if needed.
On the same idea, on my home server with multiple OpenVZ containers I host repos
for my projects on one free-to-access container which may be attacked, or even
compromised which has a small disk partition. On the other side my data is on a
ssh-only, secured, firewalled big partition. It may be useful to have code on
the first but ssh'd data on the other.
I suspect many other situations where a separation between code and data may
help administrators and/or users.
To handle this I thought of a mechanism allowing a sort of branch (to make use
of multiple 'remote') to be checked out at the same time as the code...
In addition we should use an extensible protocol layer to manage data.
git-annex or git-media which already address some of the problems here
are using various things like ssh, http, s3. And I just saw that Debian's git
package already recommend rsync.


What do you think about that whole? Would it fit on a GSoC background? Great
interesting task indeed. May sound too long. But of course if the summer went
too short I would not drop the project on the floor as soon as the time limit
will be reached.


Best regards,

--
Jonathan Michalon
