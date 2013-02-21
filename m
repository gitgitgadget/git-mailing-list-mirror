From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v4.1 09/12] sequencer.c: teach append_signoff to avoid
 adding a duplicate newline
Date: Thu, 21 Feb 2013 12:26:52 -0800
Message-ID: <CA+sFfMcNWvPKuQpNWnacegbfgN0ZP=zfuDPDRkXs1G2FMrb+iA@mail.gmail.com>
References: <1360664260-11803-10-git-send-email-drafnel@gmail.com>
	<1360665222-3166-1-git-send-email-drafnel@gmail.com>
	<7vip5lv6tv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <bcasey@nvidia.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:27:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8cjs-0006ne-8F
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 21:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281Ab3BUU0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 15:26:55 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:47690 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878Ab3BUU0y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 15:26:54 -0500
Received: by mail-wi0-f173.google.com with SMTP id hq4so117302wib.0
        for <git@vger.kernel.org>; Thu, 21 Feb 2013 12:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=9AHDo0EzKZoKEiGE+ghJ2uDgYE532rjUBHaIJ+L2e6o=;
        b=HsTCr+DMHOqoCz3LQcNzdBv1Gl8cbS/XTvYOjNhdl4nBXOUcizupxKoOnDYtzfsnFW
         9bBZIrIYFYrgBBErtmoMMlvmQZ8iIgT8Bqrn4ddxAkpmEr0P/PZv6cMPkA1UW8BH/7Dp
         84IgOs38F67PNn8RvU/EuomEJ0cBalvsg8aeqVEcLnjGyAwvV0aeL8LFBN/ecmt9X7yP
         V5GA/gJ+3e7kS3cyLHqrhTAXkMzJrHy5kNwMZCRZQCadto97b5IqjZuJF83Ys9WkywtN
         Xmn92qWfbVwCA7GVac8wJcwNmViAaQoEjNnVvOfNWYRltDKhhEtvVZ2t7uxwcmpMruqN
         G2nA==
X-Received: by 10.195.13.11 with SMTP id eu11mr44498926wjd.39.1361478413097;
 Thu, 21 Feb 2013 12:26:53 -0800 (PST)
Received: by 10.194.63.46 with HTTP; Thu, 21 Feb 2013 12:26:52 -0800 (PST)
In-Reply-To: <7vip5lv6tv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216795>

On Thu, Feb 21, 2013 at 10:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> Teach append_signoff to detect whether a blank line exists at the position
>> that the signed-off-by line will be added, and refrain from adding an
>> additional one if one already exists.  Or, add an additional line if one
>> is needed to make sure the new footer is separated from the message body
>> by a blank line.
>>
>> Signed-off-by: Brandon Casey <bcasey@nvidia.com>
>> ---
>>
>>
>> A slight tweak.  And I promise, no more are coming.
>
> When I do
>
>         $ git commit -s
>
> it should start my editor with this in the buffer:
>
>         ----------------------------------------------------------------
>
>         Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         ----------------------------------------------------------------
>
> and the cursor blinking at the beginning of the file.  Annoyingly
> this step breaks it by removing the leading blank line.

Yes.  The fix described by John Keeping restores the above behavior
for 'commit -s'.  Or the fix I described which inserts two preceding
newlines so it looks like this:

   ----------------------------------------------------------------


   Signed-off-by: Junio C Hamano <gitster@pobox.com>
   ----------------------------------------------------------------

So then the cursor would be placed on the first line and a space would
separate it from the sob which is arguably a better indication to the
user that a blank line should separate the commit message body from
the sob.

But, this does not fix the same problem for 'cherry-pick --edit -s'
when used to cherry-pick a commit without a sob.  The cherry-pick part
of it would add the extra preceding newlines, but then cherry-pick
passes the buffer to 'git commit' via .git/MERGE_MSG which then
"cleans" the buffer, removing the empty lines, in prepare_to_commit()
before allowing the editor to operate on it.

Using 'cherry-pick --edit -s' to cherry-pick a commit with an empty
commit message is going to be a pretty rare corner case.  It would be
nice to have the same behavior for it that we decide to have for
'commit -s', but it's probably not worth going through contortions to
make it happen.

-Brandon
