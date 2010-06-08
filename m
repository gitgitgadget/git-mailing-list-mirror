From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH v4 0/5] Patches to avoid reporting conversion changes.
Date: Tue, 8 Jun 2010 17:52:37 +0200 (CEST)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1006081731550.22466@shipon.roxen.com>
References: <cover.1275309129.git.grubba@grubba.org> <7vfx16oxmz.fsf@alter.siamese.dyndns.org>
 <Pine.GSO.4.63.1006031543340.22466@shipon.roxen.com> <20100604005603.GA25806@progeny.tock>
 <Pine.GSO.4.63.1006041212200.27465@shipon.roxen.com> <20100604194201.GB21492@progeny.tock>
 <Pine.GSO.4.63.1006061143000.27465@shipon.roxen.com> <20100607085947.GA3924@pvv.org>
 <Pine.GSO.4.63.1006071726170.22466@shipon.roxen.com> <20100607195013.GA27362@pvv.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-641078858-1276012357=:22466"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Jun 08 17:53:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM16p-0005J4-JB
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 17:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183Ab0FHPwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 11:52:42 -0400
Received: from mail.roxen.com ([212.247.29.220]:49700 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754210Ab0FHPwl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 11:52:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id CC3926281BA;
	Tue,  8 Jun 2010 17:52:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lQrxVwO-Ajvi; Tue,  8 Jun 2010 17:52:38 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id EB90F62816F;
	Tue,  8 Jun 2010 17:52:37 +0200 (CEST)
In-Reply-To: <20100607195013.GA27362@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148681>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-641078858-1276012357=:22466
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 7 Jun 2010, Finn Arne Gangstad wrote:

> On Mon, Jun 07, 2010 at 06:37:56PM +0200, Henrik Grubbström wrote:
>>
>> On Mon, 7 Jun 2010, Finn Arne Gangstad wrote:
>>
>>> I think it would be best if git at this time could decide that the
>>> affected files also become dirty. The ideal commit is one that
>>> both alters the .gitattributes _and_ the affected files at the same
>>> time, and git should make it easy to create that commit.
>>
>> I agree in the case of newly added attributes. In the case of
>> repositories already containing unnormalized files this however leads to
>> problems.
>> eg
>>
>>   Consider the case above, but a while later when the repository has been
>>   fixed at HEAD. If an old version from before the normalization is
>>   checked out, the index will once again become dirty, which means that
>>   git will refuse the user to check out some other version unless the
>>   --force flag is given. Excessive use of --force is not a good thing.
>>   If the user is aware of the problem, and checking out old versions is
>>   a common operation, toggling the suggested option might be a good
>>   solution.
>
> Maybe I misunderstand something, but if you check out an older
> version, the .gitattributes file will change to match the old version.
> The old version should not have the conversion attributes set, and
> should therefore result in a clean checkout?

True, there's no problem before the attribute change, but there is 
for commits between the attribute change and when the repository got 
normalized (which can be a while with the current git).

Re: configuration option naming:

   I've settled for core.normalizationPolicy, with the values
   'strict' (default) for the behaviour requested by you and Jonathan,
   and 'relaxed' for my initial behaviour.

Teaser:

   $ git init foo
   warning: templates not found /home/grubba/share/git-core/templates
   Initialized empty Git repository in /tmp/grubba/foo/.git/
   $ cd foo
   $ cat >expanded-keywords
   $Id: some id string $
   $ git add expanded-keywords
   $ git commit -m 'Initial commit.'
   [master (root-commit) 755d1f6] Initial commit.
    1 files changed, 1 insertions(+), 0 deletions(-)
    create mode 100644 expanded-keywords
   $ git status
   # On branch master
   nothing to commit (working directory clean)
   $ cat >.gitattributes
   * ident
   $ git status
   # On branch master
   # Changed but not updated:
   #   (use "git add <file>..." to update what will be committed)
   #   (use "git checkout -- <file>..." to discard changes in working directory)
   #
   #       modified:   expanded-keywords
   #
   # Untracked files:
   #   (use "git add <file>..." to include in what will be committed)
   #
   #       .gitattributes
   no changes added to commit (use "git add" and/or "git commit -a")
   $ git config core.normalizationPolicy relaxed
   $ git status
   # On branch master
   # Untracked files:
   #   (use "git add <file>..." to include in what will be committed)
   #
   #       .gitattributes
   nothing added to commit but untracked files present (use "git add" to track)
   $ git config core.normalizationPolicy strict
   $ git status
   # On branch master
   # Changed but not updated:
   #   (use "git add <file>..." to update what will be committed)
   #   (use "git checkout -- <file>..." to discard changes in working directory)
   #
   #       modified:   expanded-keywords
   #
   # Untracked files:
   #   (use "git add <file>..." to include in what will be committed)
   #
   #       .gitattributes
   no changes added to commit (use "git add" and/or "git commit -a")
   $ rm .gitattributes
   $ git status
   # On branch master
   nothing to commit (working directory clean)

Which I believe matches all the behaviours that have been requested.

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-641078858-1276012357=:22466--
