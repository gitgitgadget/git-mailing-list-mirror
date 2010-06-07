From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH v4 0/5] Patches to avoid reporting conversion changes.
Date: Mon, 7 Jun 2010 18:37:56 +0200 (CEST)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1006071726170.22466@shipon.roxen.com>
References: <cover.1275309129.git.grubba@grubba.org> <7vfx16oxmz.fsf@alter.siamese.dyndns.org>
 <Pine.GSO.4.63.1006031543340.22466@shipon.roxen.com> <20100604005603.GA25806@progeny.tock>
 <Pine.GSO.4.63.1006041212200.27465@shipon.roxen.com> <20100604194201.GB21492@progeny.tock>
 <Pine.GSO.4.63.1006061143000.27465@shipon.roxen.com> <20100607085947.GA3924@pvv.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1144747756-1275928676=:22466"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon Jun 07 18:38:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLfKx-0006kb-Q7
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 18:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab0FGQiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 12:38:00 -0400
Received: from mail.roxen.com ([212.247.29.220]:51340 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107Ab0FGQh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 12:37:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 7DFDA6281F4;
	Mon,  7 Jun 2010 18:37:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r0+eI0cf0aEF; Mon,  7 Jun 2010 18:37:56 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 44D346281F0;
	Mon,  7 Jun 2010 18:37:56 +0200 (CEST)
In-Reply-To: <20100607085947.GA3924@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148612>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1144747756-1275928676=:22466
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT


Hi Finn,

On Mon, 7 Jun 2010, Finn Arne Gangstad wrote:

> On Sun, Jun 06, 2010 at 12:50:08PM +0200, Henrik Grubbström wrote:
> [...]
>>
>> Currently (as I believe you know), git has no detection of when the
>> conversion mode for a file has changed, and it might even take a while
>> before the users notice that the repository is not normalized. eg:
>>
>>   0) There's a repository with some files containing crlf line endings.
>>
>>   1) User A notices that git now has native support for crlf
>>      line endings, and adds the attribute eol=crlf for the
>>      affected files.
>>
>>   2) User A does a git status, sees that .gitattributes is
>>      modified, and commits it.
>
> I think it would be best if git at this time could decide that the
> affected files also become dirty. The ideal commit is one that
> both alters the .gitattributes _and_ the affected files at the same
> time, and git should make it easy to create that commit.

I agree in the case of newly added attributes. In the case of repositories 
already containing unnormalized files this however leads to problems.
eg

   Consider the case above, but a while later when the repository has been
   fixed at HEAD. If an old version from before the normalization is
   checked out, the index will once again become dirty, which means that
   git will refuse the user to check out some other version unless the
   --force flag is given. Excessive use of --force is not a good thing.
   If the user is aware of the problem, and checking out old versions is
   a common operation, toggling the suggested option might be a good
   solution.

>> [...]
>>   6) User C is new to the project and does an initial git clone,
>>      and ends up with a dirty index.
>
> And the reason for this is mostly that unless you perform some special
> actions, you will commit attributes and contents that are mismatched.
>
> In your suggested mode, whay would happen if you did this:
>
> $ git clone ......  (which has files that are "wrong" wrt line endings and
> attributes for some .c files)
> $ touch *.c
>
> Would it still believe all *.c files were clean? Does it require an
> actual other change at the same time to allow you to normalize the
> file? That would be detrimental I think.  Changing newlines is best
> done as a separate commit, intermingling newline changes and real
> changes in the same commmit is not where you want to go.

With the patch set as submitted, it would still claim that the files 
are clean. With the additional two-liner I suggested to Jonathan, the 
files would be dirty.

> However, for your ID string you obviously want this behaviour. I'm
> guessing that hook is alreasy set up so that if you just touch the
> file, it will still be treated as unmodified?

Yes.

>> What my patch set achieves is that user C above also gets a clean index.
>>
>> What it seems you want is that user A above should have all files that
>> got denormalized by the attribute change marked dirty at 2 (and 3).
>
> That would indeed be a very welcome change.
>
>> As I believe both behaviours may be desireable a config option and/or
>> attribute is needed. Any suggestions for a name (and default value)?
>
> I think the default behaviour should be to mark files dirty if there
> are ANY attribute changes that could cause content changes done to
> them at all. I'm not sure that is exactly what your patch series is
> allowing us to track though?

What it does, is to track the attributes affecting conversion that 
were active when the entries in the index were last updated, and 
also whether the entry is on normalized form in the repository. 
This makes it possible to invalidate entries when attributes change.

> Just to be clear:
>
> If you add this to your .gitattributes
>
> *.c eol=lf
>
> I think it would be very helpful if git then would treat all .c files
> as "stat-dirty" the next time it updates its index.

Ok.

> A for config variables, what about:
>
> core.rereadOnAttributeChanges = [true]/false    (default = true)
>
> Which makes some sense for detecting it in 2, but not so much for
> ignoring it in 6.

I was thinking more along the lines of

   core.allowUnnormalizedIndex = true/[false]	(default = false)

which unfortunately contains a negation.

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-1144747756-1275928676=:22466--
