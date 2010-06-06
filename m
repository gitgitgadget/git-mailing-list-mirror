From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH v4 0/5] Patches to avoid reporting conversion changes.
Date: Sun, 6 Jun 2010 12:50:08 +0200 (CEST)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1006061143000.27465@shipon.roxen.com>
References: <cover.1275309129.git.grubba@grubba.org> <7vfx16oxmz.fsf@alter.siamese.dyndns.org>
 <Pine.GSO.4.63.1006031543340.22466@shipon.roxen.com> <20100604005603.GA25806@progeny.tock>
 <Pine.GSO.4.63.1006041212200.27465@shipon.roxen.com> <20100604194201.GB21492@progeny.tock>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-579758561-1275821408=:27465"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 06 12:50:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLDR7-0006g7-Es
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 12:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab0FFKuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 06:50:16 -0400
Received: from mail.roxen.com ([212.247.29.220]:54245 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755738Ab0FFKuM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 06:50:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 7CBEA62820A;
	Sun,  6 Jun 2010 12:50:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D5MTVAT99fOw; Sun,  6 Jun 2010 12:50:08 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id B2ED96281D1;
	Sun,  6 Jun 2010 12:50:08 +0200 (CEST)
In-Reply-To: <20100604194201.GB21492@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148512>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-579758561-1275821408=:27465
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 4 Jun 2010, Jonathan Nieder wrote:

> Henrik Grubbström wrote:
>> On Thu, 3 Jun 2010, Jonathan Nieder wrote:
>
>>> If you wait for some
>>> real change to piggy-back onto, on the other hand, then the per-file
>>> normalization patches will make it hard to find what changed.
>>
>> This seems more like an argument against repositories where
>> renormalizations have occurred, than against the feature as such.
>
> No, it is an argument against making the process of renormalization
> more painful than it has to be (and against piggy-backing in general).
> It is kindest to have a flag day and yank the carriage returns off all
> at once like a bandage.

In the crlf case, yes, probably. In the ident case there might be good 
reasons to want to have the ident strings stay unmodified as long as 
possible (since otherwise there'll be two ident strings that identify
the same code).

Currently (as I believe you know), git has no detection of when the 
conversion mode for a file has changed, and it might even take a while 
before the users notice that the repository is not normalized. eg:

   0) There's a repository with some files containing crlf line endings.

   1) User A notices that git now has native support for crlf
      line endings, and adds the attribute eol=crlf for the
      affected files.

   2) User A does a git status, sees that .gitattributes is
      modified, and commits it.

   3) User A does a new git status, and has a clean index.

   4) User B who has been developing on the project for a while
      does a git pull from user A, and gets the new .gitattributes.

   5) User B does a git status, and has a clean index.

   6) User C is new to the project and does an initial git clone,
      and ends up with a dirty index.

I believe we both agree that the above is undesireable behaviour. The 
above behaviour also means that it's likely that there are repositorys
out there which contain unnormalized files.

What my patch set achieves is that user C above also gets a clean index.

What it seems you want is that user A above should have all files that got 
denormalized by the attribute change marked dirty at 2 (and 3).

With a minor change of the read-cache.c:ce_compare_data() patch (returning 
1 if conv_flags has CONV_NORM_NEEDED), you should get the behaviour you 
want (all files which are unnormalized in the repository will be dirty).

As I believe both behaviours may be desireable a config option and/or 
attribute is needed. Any suggestions for a name (and default value)?

>> Well, diff and blame would be confused by a crlf renormalization
>> regardless of whether the renormalization was piggy-backed or not.
>
> Only if they cross the revision where renormalization occurred.

Which is true in both cases.

> Wouldn't something like
>
> /foo.c -ident has_foreign_ident
>
> work?

Yes, but it sort of reduces the usefulness of macros if you need to expand 
them by hand... :-)

Better to fix the bug and wait for the fix to enter a released version.

>>   * Hooks are not copied by git clone. Support for copying of hooks
>>     to non-POSIX-like systems is not something I'd like to attempt.
>
> Can't you include a hooks/pre-commit file and a HACKING file: "copy
> this file to .git/hooks if you want your patches to be accepted"?

Yes, but you still have to remember to do it everytime you clone the 
repository.

Thanks for taking the time to discuss the problem.

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-579758561-1275821408=:27465--
