From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/3] avoiding unintended consequences of git_path() usage
Date: Wed, 16 Nov 2011 01:59:55 -0600
Message-ID: <20111116075955.GB13706@elie.hsd1.il.comcast.net>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com>
 <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net>
 <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 09:00:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQaPi-00034H-IP
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 09:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab1KPIAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 03:00:04 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43531 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688Ab1KPIAC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 03:00:02 -0500
Received: by ywt32 with SMTP id 32so4469124ywt.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 00:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=A6RjSdtHkws7A/pParI3pz+3zEd9eXhYmbAvfWyVdyY=;
        b=vjsHmKJqU41GPAdDZyUyFW8NK1Na4DSN7fIo2sQhV5TCEq7n3AgJqvjL0hauLeqfJ3
         Jclo0JPxyGLn14isWq7lnEVXbr6cTtL2xjwMU8/PezpzkUMLbjYXSd/7fJUp/wrPmzdM
         VAmyjaoKoU0gi2cBGstp4gp40gzP46hKlOaQg=
Received: by 10.101.201.1 with SMTP id d1mr556304anq.44.1321430401889;
        Wed, 16 Nov 2011 00:00:01 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 33sm67836651ano.1.2011.11.16.00.00.00
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 00:00:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185521>

Ramkumar Ramachandra wrote:
> Junio C Hamano wrote:

>> Or perhaps http://thread.gmane.org/gmane.comp.version-control.git/184963/focus=185436
>
> I noticed that sha1_to_hex() also operates like this.  The
> resolve_ref() function is really important, but using the same
> technique for these tiny functions is probably an overkill

I don't follow.  Do you mean that not being confusing is overkill,
because the function is small that no one will bother to look up the
right semantics?  Wait, that sentence didn't come out the way I
wanted. ;-)

Jokes aside, here's a rough series to do the git_path ->
git_path_unsafe renaming.  While writing it, I noticed a couple of
bugs, hence the two patches before the last one.  Patch 2 is the more
interesting one.

Patches are against "master", but patch 2 probably should be thought
of as being against maint-1.7.6.  Improvements welcome, as always.

Thanks,

Jonathan Nieder (3):
  do not let git_path clobber errno when reporting errors
  Bigfile: dynamically allocate buffer for marks file name
  rename git_path() to git_path_unsafe()

 Documentation/technical/api-string-list.txt |    5 +-
 attr.c                                      |    2 +-
 bisect.c                                    |    8 ++--
 branch.c                                    |   12 ++--
 builtin/add.c                               |    2 +-
 builtin/commit.c                            |   57 ++++++++++++-----------
 builtin/config.c                            |    4 +-
 builtin/fetch-pack.c                        |    4 +-
 builtin/fetch.c                             |    5 +-
 builtin/fsck.c                              |    2 +-
 builtin/init-db.c                           |   12 ++--
 builtin/merge.c                             |   67 +++++++++++++++------------
 builtin/notes.c                             |    2 +-
 builtin/remote.c                            |    6 +-
 builtin/reset.c                             |    2 +-
 builtin/revert.c                            |   25 +++++-----
 cache.h                                     |    3 +-
 contrib/examples/builtin-fetch--tool.c      |    4 +-
 dir.c                                       |    2 +-
 fast-import.c                               |    2 +-
 http-backend.c                              |    2 +-
 notes-merge.c                               |   22 +++++----
 pack-refs.c                                 |    6 +-
 path.c                                      |    2 +-
 refs.c                                      |   51 +++++++++++---------
 remote.c                                    |    4 +-
 rerere.c                                    |   12 ++--
 run-command.c                               |    4 +-
 sequencer.c                                 |    6 +-
 server-info.c                               |    2 +-
 sha1_file.c                                 |   22 ++++++--
 shallow.c                                   |    2 +-
 transport.c                                 |    4 +-
 unpack-trees.c                              |    2 +-
 34 files changed, 200 insertions(+), 167 deletions(-)

-- 
1.7.8.rc0
