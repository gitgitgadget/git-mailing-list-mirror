From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH RFC 5/5] cache: Use ce_norm_sha1().
Date: Sun, 25 Apr 2010 13:25:11 +0200 (CEST)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1004251252250.4423@shipon.roxen.com>
References: <cover.1271432034.git.grubba@grubba.org>
 <c68d98b384086925da0194e560ae01d83a29f80c.1271432034.git.grubba@grubba.org>
 <7vsk6qio1f.fsf@alter.siamese.dyndns.org> <Pine.GSO.4.63.1004201622050.4296@shipon.roxen.com>
 <7v7ho2gcpb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1841205112-1272194711=:4423"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 13:25:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5zxv-0005zq-OQ
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 13:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab0DYLZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 07:25:17 -0400
Received: from mail.roxen.com ([212.247.29.220]:51559 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab0DYLZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 07:25:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id D40026282F4;
	Sun, 25 Apr 2010 13:25:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CEEpwC+k2-Vd; Sun, 25 Apr 2010 13:25:11 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 142876282EF;
	Sun, 25 Apr 2010 13:25:11 +0200 (CEST)
In-Reply-To: <7v7ho2gcpb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145735>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1841205112-1272194711=:4423
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 20 Apr 2010, Junio C Hamano wrote:

> Henrik Grubbström <grubba@roxen.com> writes:
>
>>> 3. "git update-index --refresh" does not improve the situation, as it
>>>    (thinks) it knows the blob and the working tree file are different.
>>
>> False. "git update-index --refresh" uses
>> read-cache.c:ce_compare_data() to compare the content of the blob with
>> the normalized content of the working tree,...
>
> I don't think you tried it yourself.  Here is what should happen with the
> current code.
>
> 	# step 0 & 1. a project with LF ending
> 	$ git init two && cd two
>        $ echo a quick brown fox >kuzu
>        $ git add kuzu && git commit -m kuzu
>
>        # step 2. you want CRLF in your work area
>        $ echo -e "a quick brown fox\015" >kuzu
>        $ git config core.autocrlf true

Ok, right. I thought step 2 was

 	$ git config core.autocrlf true
 	$ rm kuzu
 	$ git checkout -- kuzu

In which case the index will be clean.

> And it is a common thing people wish to do.  Admittedly, this is an one-off
> event, so it is not _that_ urgent to fix.  You can for example do:

I've fixed this case in my current version of the patches.

>> Let's take the reverse case instead:
[...]

Seems to depend on whether is_racy_timestamp is true or not. As you've 
noted, adding a touch forces the issue.

[...]
> If you are trying to somehow make this last "git diff" silent, then I
> think you are solving a _wrong_ problem.  By setting retroactively the
> CRLF setting, you are saying that you do not want to have CRLF in the
> blobs recorded in the repository, and it is a _good thing_ that there are
> differences (tons of them) between what is recorded currently and what you
> are going to commit to fix the earlier mistake.

Ok, I've removed the diff-related changes from the current set of patches.

> As I already said, I agree that it would be beneficial to store what
> normalization settings were used and comparing that with what settings are
> in effect to detect the possible phamtom difference caused by the change
> of the settings.  But once we know that the result of a re-normalization
> is different from what is recorded in the index (or tree), then the
> difference should be shown.  The actual difference would change every time
> the work tree file is edited, so I don't see the benefit of contaminate
> the object database with intermediate "blobs" that is not "added".

Ok. With the diff patches gone, there's no need to store the normalized 
blob data.

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-1841205112-1272194711=:4423--
