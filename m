From: Daniel Cheng <j16sdiz+freenet@gmail.com>
Subject: [JGit] Push to new Amazon S3 does not work? ("funny refname")
Date: Sun, 8 Mar 2009 00:05:02 +0800
Message-ID: <ff6a9c820903070805m34f792dard6b17d2029e41dfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 17:06:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfz2r-0005Kr-21
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 17:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883AbZCGQFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 11:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbZCGQFI
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 11:05:08 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:22922 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbZCGQFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 11:05:05 -0500
Received: by wa-out-1112.google.com with SMTP id v33so541283wah.21
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 08:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=j33/D/Av/ioJ2+OR4SWzW9eyOn+AZ3Hbx6NcQAuyeyg=;
        b=oaXQ09TAZ+0yExi7mPuuQ2/AOXQV6lkQvv2G3O9DBZeuSOQoFWlUxZ4qRzArRZvVbQ
         ST5fAn27id+5CQq5HCBwPGMkua5OA35EzVYcIsN4lMBMh+gkm4ut5PvgF6JPytcKmJxm
         uB5rR69GlJBwsNwKaUQ9umMsm66ytorWvuTpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=PAqkglKaIHC0K7PaLZPLkgLp8oD6gsv9k9TgtuQ7SbrSlC7K/JF4dF3+u7/oj03vLU
         8DcKYKvODfdLwS6nmwuMqiGoHFmu8rG4wsHrLpNTTueVavvHdr14tQhAfvExnvnLylxN
         kxCCQXyOuh8qjeQo1tDRIWxiSp41FhCR6No04=
Received: by 10.114.24.5 with SMTP id 5mr2301354wax.106.1236441902286; Sat, 07 
	Mar 2009 08:05:02 -0800 (PST)
X-Google-Sender-Auth: e0764b85682b5d20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112547>

Pushing to new Amazon S3 repository does not work.
It say "funny refname" without pushing anything:

<<<<<<<<<
$ jgit push s3 master
To amazon-s3://0NQ4APQ8R7S6HQ65TWR2@egitsdiz/1.git
 ! [remote rejected] master -> master (funny refname)
$ s3cmd la
         DIR   s3://egitsdiz/1.git/
$
>>>>>>>>>

Any idea what's happening here?


The code is in WalkPushConnection.java line 137:
<<<<<<<<<
134    final List<RemoteRefUpdate> updates = new ArrayList<RemoteRefUpdate>();
135    for (final RemoteRefUpdate u : refUpdates.values()) {
136        final String n = u.getRemoteName();
137        if (!n.startsWith("refs/") || !Repository.isValidRefName(n)) {
138            u.setStatus(Status.REJECTED_OTHER_REASON);
139            u.setMessage("funny refname");
140            continue;
141        }
>>>>>>>>>

u.getRemoteName() gives "master" here.
Removing  n.startsWith("refs/") would generate a bad `packed-refs`
file in later code.
I tried to fix this, but failed to do so without breaking GitSsh transports
