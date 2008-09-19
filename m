From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [BUG?]: unpack-file behavior for blobs corresponding to symlinks
Date: Fri, 19 Sep 2008 16:51:04 +0200
Message-ID: <237967ef0809190751k38defaabk9efc74711f7c63c4@mail.gmail.com>
References: <51419b2c0809190731j5a77b8ccmba2feecb9c44cc1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Elijah Newren" <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 16:52:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KghLC-0005ww-Sc
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 16:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbYISOvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 10:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbYISOvI
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 10:51:08 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:4114 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbYISOvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 10:51:07 -0400
Received: by ik-out-1112.google.com with SMTP id c30so287871ika.5
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WDHTdnR0I9pCOuUpTcw9HwnwUI7tTBhtSyBGEgGMDO0=;
        b=eniRdX6zi8gToVlRQr2HRe9GJ5SljZVpMJ1EgEPSs9NBT1fVQ7uxpASiAVpni0A5T9
         iwMA483z8u0WmlGVILhZCnnyGHJkQRd2ae6YlZdzKyoi3XKuwWab3aJr5wCsT7aHFENy
         n1UWIv9xkeyXphBmScE263TXEC/1Oqt+zdNYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qT8JjzNhzSEdJ4HhZpFYqHjpcSJ9e7lO/aONuBrSOTcFbSV7YzFs+edNtKtgZT3eSL
         n7fnAIEyj9U/eugRMSOwFgjGKumXAUcUGJGspQ5J0pJTrbf2uTJw91FxBQ+5FujdedvF
         EdbAshfcWKnI0s/UmZCo91B+Wpeh3kjaWOB8U=
Received: by 10.210.25.19 with SMTP id 19mr158669eby.134.1221835864361;
        Fri, 19 Sep 2008 07:51:04 -0700 (PDT)
Received: by 10.210.19.20 with HTTP; Fri, 19 Sep 2008 07:51:04 -0700 (PDT)
In-Reply-To: <51419b2c0809190731j5a77b8ccmba2feecb9c44cc1c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96292>

2008/9/19 Elijah Newren <newren@gmail.com>:
> Hi,
>
> unpack-file doesn't create symlinks as I'd expect.  I'm not sure if
> this is a bug in unpack-file, or in my expectations.
>
> To reproduce:
>
> $ git init
> Initialized empty Git repository in /home/newren/testing/.git/
> $ echo bla > bar
> $ ln -s bar foo
> $ git add bar foo
> $ git ls-files -s foo
> 120000 ba0e162e1c47469e3fe4b393a8bf8c569f302116 0       foo
> $ git unpack-file ba0e162e1c47469e3fe4b393a8bf8c569f302116
> .merge_file_J1hTaV
> $ ls -l foo .merge_file_J1hTaV
> lrwxrwxrwx  1 enewren enewren 3 Sep 19 08:22 foo -> bar
> -rw-------  1 enewren enewren 3 Sep 19 08:23 .merge_file_J1hTaV
> $ echo $(cat .merge_file_J1hTaV)
> bar
>
> Why is .merge_file_J1hTaV a regular file instead of a symlink?  Is
> there an alternative command I can use that would create a symlink to
> bar given the information I have from the git ls-files command (and
> which also works for creating normal files and other special file
> types)?

This is not a bug. The type of a file is in the tree, not the blob, see:

% echo -n foo > file
% ln -s foo symlink
% git add file symlink
% git commit
Created initial commit 31ad9b0 on master: file and symlink
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 file
 create mode 120000 symlink
% git ls-tree HEAD
100644 blob 19102815663d23f8b75a47e7a01965dcdc96468c	file
120000 blob 19102815663d23f8b75a47e7a01965dcdc96468c	symlink


-- 
Mikael Magnusson
