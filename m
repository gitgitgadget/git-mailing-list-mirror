From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH v4 0/5] Patches to avoid reporting conversion changes.
Date: Fri, 4 Jun 2010 13:59:23 +0200 (CEST)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1006041212200.27465@shipon.roxen.com>
References: <cover.1275309129.git.grubba@grubba.org> <7vfx16oxmz.fsf@alter.siamese.dyndns.org>
 <Pine.GSO.4.63.1006031543340.22466@shipon.roxen.com> <20100604005603.GA25806@progeny.tock>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-758783491-1275652763=:27465"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 14:00:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKVZe-0004Ct-9p
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 14:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042Ab0FDL71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 07:59:27 -0400
Received: from mail.roxen.com ([212.247.29.220]:50343 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754405Ab0FDL70 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 07:59:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 3E37B6282A2;
	Fri,  4 Jun 2010 13:59:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 64sNcyIfARLt; Fri,  4 Jun 2010 13:59:23 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 3B19A62828C;
	Fri,  4 Jun 2010 13:59:23 +0200 (CEST)
In-Reply-To: <20100604005603.GA25806@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148399>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-758783491-1275652763=:27465
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 3 Jun 2010, Jonathan Nieder wrote:

> Hi Henrik,

Hi.

> Henrik Grubbström wrote:
>
>> I believe that users typically aren't interested in if data in the
>> repository is on normalized form or not (witness the autocrlf=true
>> discussion a few weeks ago, where one of the main complaints was
>> that it required a renormalization (which fg/autocrlf attempts to
>> solve for that specific case by not normalizing)), as long as they
>> get the expected content on checkout.
>
> I agree.  (In the case of autocrlf, it is also not very easy to
> renormalize.  The usual recommendation I have seen is "git rm -r \
> --cached . && git add .", which is not exactly simple.)
>
>> This set of patches allows for an incremental, on-demand normalization.
[...]
> ... but if I understand correctly, I don't agree with this at all.
>
> Imagine someone with an old copy of git that does not do
> normalization.  If you convert everything at once, she sees a single
> enormous, semantically uninteresting cleanup patch (and she can check
> the result with 'diff -w' or sed if suspicious).  If you wait for some
> real change to piggy-back onto, on the other hand, then the per-file
> normalization patches will make it hard to find what changed.

This seems more like an argument against repositories where 
renormalizations have occurred, than against the feature as such.

> Of course, very few people use such old copies of git.  The real
> problem is that git itself sees what this person would see; you are
> asking to slow down everyone who tries to use diff or blame on your
> repository by implicitly requiring the -w option.

Well, diff and blame would be confused by a crlf renormalization 
regardless of whether the renormalization was piggy-backed or not. 
I haven't looked at the implementation of blame, but it was possible 
to reduce the confusion in the diff case by letting it normalize the 
old blob according to the current set of attributes (this was part of 
my original patch set, but Junio didn't like the feature).

> The Right Thing would be to not set the relevant attributes until it
> is time for the file to be normalized.  I can understand that that
> might be hard and could require tool support.

True, but then the .gitattributes file would start to resemble
a manifest file for the entire repository, which would be a
pain to maintain.

I did do an experiment with a .gitattributes file like:

   *.c crlf ident
   [attr]foreign_ident -ident block_commit=Remove-foreign_ident-attribute-before-commit.
   # A list of files that haven't been changed since import follows.
   /foo.c foreign_ident
   /bar.c foreign_ident
   # etc

and a suitable pre-commit hook that looked at the block_commit
attribute, but there were two problems in addition to the long
list of files in the .gitattributes file:

   * The attributes file parsing was broken (recently fixed in the
     master branch), and the above actually caused foo.c and bar.c
     to have the ident attribute.

   * Hooks are not copied by git clone. Support for copying of hooks
     to non-POSIX-like systems is not something I'd like to attempt.

The latter problem could in this case be solved by adding support
for the block_commit attribute to the core of git, but it doesn't
seem like something most users would understand how to use, and I
doubt that Junio would accept such a patch.

> This is not an argument against your patches, since I haven't read
> them (for all I know, they make everything better :)).

:-)

I don't believe that they make everything better, but that they're
a step on the way.

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-758783491-1275652763=:27465--
