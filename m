From: Anton Trunov <anton.a.trunov@gmail.com>
Subject: Re: [PATCH] xmerge.c: fix xdl_merge to conform with the manual
Date: Wed, 04 Mar 2015 12:43:12 +0300
Message-ID: <54F6D3B0.60600@gmail.com>
References: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com> <xmqqzj7takks.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jrnieder@gmail.com, tboegi@web.de,
	sunshine@sunshineco.com, charles@hashpling.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 10:42:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT5pD-0008R2-Hd
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 10:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759161AbbCDJmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 04:42:35 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:37165 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759073AbbCDJmc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 04:42:32 -0500
Received: by labhs14 with SMTP id hs14so43282410lab.4
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 01:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0AHqETDrFdDQWTEJngAHzQGNe1CkZNyNw5IkCb3lPIE=;
        b=j6I5NTqZHZNEk2/Fwij++C/6QkGiv7m4L7X5LqH9ezlAoa5uHRy1uF/1qWkIbXxU1D
         8PfsLiduteKuz5c0DFbfPt9wy0YdI83yeZovqmXyfgy4VEJhmrsJXCsf0TZKeGju1TLr
         wjkAhknEH8A6iDzMS6M703OxqCxJEbr+ApimbtCZi8IerDm4xIN4triK0gPIGediEVbi
         4KnQ1byj34Q29sCe1wPJoR1rxHHZHoWvzCDFxr5QjA+NZsBV7rPH482Jc5Va65BQgny2
         OxQSbTpjH03h8+AH0v0C7J4WTeQYNuZrhlNB7BhVDG1TBFc7XIxwhqsckruCMjKu38BG
         JX+w==
X-Received: by 10.152.182.196 with SMTP id eg4mr2640615lac.70.1425462150745;
        Wed, 04 Mar 2015 01:42:30 -0800 (PST)
Received: from [192.168.1.185] ([195.191.146.16])
        by mx.google.com with ESMTPSA id lf3sm671053lbc.2.2015.03.04.01.42.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2015 01:42:29 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqzj7takks.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264738>

On 03/03/15 23:32, Junio C Hamano wrote:
> Anton Trunov <anton.a.trunov@gmail.com> writes:
> 
>> The git-merge manual says that the ignore-space-change,
>> ignore-all-space, ignore-space-at-eol options preserve our version
>> if their version only introduces whitespace changes to a line.
>>
>> So far if there is whitespace-only changes to both sides
>> in *all* lines their version will be used.
> 
> I am having hard time understanding the last sentence, especially
> the "So far" part.  Do you mean "With the current code, if ours and
> theirs change whitespaces on all lines, we take theirs"?

By "so far" I mean "until now, but not including it", i.e. the code
before applying the patch.

> I find the description in the documentation is a bit hard to read.
> 
>   * If 'their' version only introduces whitespace changes to a line,
>     'our' version is used;
> 
>   * If 'our' version introduces whitespace changes but 'their'
>     version includes a substantial change, 'their' version is used;
> 
>   * Otherwise, the merge proceeds in the usual way.
> 
> And it is unclear if your reading is correct to me.  In your "So
> far" scenario, 'our' version does introduce whitespace changes and
> 'their' version does quite a bit of damage to the file (after all,
> they both change *all* lines, right?).  It does not seem too wrong
> to invoke the second clause above and take 'theirs', at least to me.

Let me elaborate on this a bit.
It doesn't matter if all lines are changed or not.
The point is if all the changes in all the *changed* lines are trivial
(non-whitespace), i.e. there is no one line with substantial change on
both sides, then we just through away their version and keep our
whitespace changes.
We are talking here about non-so-probable corner-case of trivial changes
in our and their versions, perhaps an uncoordinated tabs-vs-space clean-up.
So I think I should add "changed lines" to the commit message.

For the code version before applying this patch the following scenario
will take place if "git merge -Xignore-all-space remote" gets executed.

base file:
1st line
2nd line

master file:
  1st line
  2nd line with substantial change

remote file:
              1st line
              2nd line

merge result file:
  1st line
  2nd line with substantial change

So essentially it does what "git merge -s ours remote" does in case if
all their changes are trivial.
This seems like reasonable solution to me: we _are_ trying to ignore
whitespace changes and we are explicit about it.

But, in the scenario with trivial changes everywhere we get a completely
different result:

base file:
1st line
2nd line

master file:
  1st line
  2nd line

remote file:
              1st line
              2nd line

merge result file:
              1st line
              2nd line

In my opinion if we respect the principle of least astonishment this
behavior should be fixed to:

merge result file:
  1st line
  2nd line

Exactly so does this patch.

> It is an entirely different matter if the behaviour the document
> describes is sane, and I didn't ask "git log" what the reasoning
> behind that second point is, but my guess is that a change made by
> them being "substantial" is a sign that it is a whitespace cleanup
> change and we should take the cleanup in such a case, perhaps?

If we want to take in their clean-up why would we use the
-Xignore-space-change option in the first place?
It looks like we're explicitly saying "we don't want any changes that
are whitespace-only", right?
And if we introduced some cleanup too what should we do when the
cleanups conflict? (exactly our case)
As far as I am concerned one should either manually resolve that kind of
conflicts without using the -Xignore-... options or just
git merge -X theirs remote.
