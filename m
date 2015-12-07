From: Eric Vander Weele <ericvw@gmail.com>
Subject: Re: [PATCH] filter-branch: pass tag name via stdin without newline
Date: Sun, 6 Dec 2015 21:15:33 -0800
Message-ID: <CAGhVqYv5ZwDbj3NK=34vUx136JfyyDvrVr0fWF=vaiHZ8gQhtg@mail.gmail.com>
References: <1449451046-19752-1-git-send-email-ericvw@gmail.com> <xmqqd1ujnf1i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 06:16:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5oAH-0006AN-50
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 06:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbbLGFQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 00:16:06 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:35872 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbbLGFQE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 00:16:04 -0500
Received: by iofh3 with SMTP id h3so170784304iof.3
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 21:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZOGlPOfiT8h23/aejzy8vneLfyzUccW1KCvPLBONYkk=;
        b=ix8lVyqy3oz5o+2tP7yF49zohtB2BrlltZUA2OJN+EhwX7CZ8AVvAz+xQN/jEUplvH
         UY0/RkcIROItmLYKmCiLMtMaFI2yruopoHEWsUXSwqo2P+lJ+VckLHuZxQJ1+PnGprL6
         /KWSV9wzTOIEltaSdjhTU/NWttGQh2XOy0t4nfKJViBRRpiCOnea3nQncozZXb+Z0ZH2
         bZzinOasMibPIxv0WfFy/LdIh2WT614jnpQcB6VoPEKquUsuuquBqX5S5uninoZvyyOC
         E35nP1DpZ1X4CNZUb6mNSzYSv3JgfY/BkjqqigkxRS6jX7dDyT5NbH9wgRVxlJZTNPPF
         z6Ew==
X-Received: by 10.107.4.213 with SMTP id 204mr28336729ioe.195.1449465363362;
 Sun, 06 Dec 2015 21:16:03 -0800 (PST)
Received: by 10.36.44.3 with HTTP; Sun, 6 Dec 2015 21:15:33 -0800 (PST)
In-Reply-To: <xmqqd1ujnf1i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282078>

On Sun, Dec 6, 2015 at 6:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Eric N. Vander Weele" <ericvw@gmail.com> writes:
>
>> "git filter-branch --tag-name-filter" fails when the user-provided
>> command attempts to trivially append text to the originally tag name,
>> passed via stdin, due to an unexpected newline ('\n').  The newline is
>> introduced due to "echo" piping the original tag name to the
>> user-provided tag name filter command.
>
> Is there any other place where we feed such an incomplete line
> (i.e. a line without the terminating LF) to the filters in this
> command?
>
> I am guessing that the answer to that question would be no, and all
> existing scripts by users expect the newline at the end of each
> line.  So I would have to say that "due to an unexpected newline" is
> a misleading statement--isn't it a bug in your filter that it did
> not expect one?
>
I agree that there isn't any other place in "git filter-branch" where
an incomplete line is fed to the filters.

My surprise was due to asymmetry between of the filter receiving a tag
name with a newline and that the behavior of trailing newlines being
stripped from what is fed to stdout (due to behavior of command
substitution).  Given that an embedded newline within a ref name is
invalid, I thought it may be desirable suppress newline.  Actually,
now that I think about, POSIX standard defines a line as "a sequence
of zero or more non- <newline> characters plus a terminating <newline>
character."

My apologies for the misleading statement and will correct my filter
accordingly to handle the terminating newline for appending text.
>
>> The only portable usage of "echo" is without any options and escape
>> sequences.  Therefore, replacing "echo" with "printf" is a suitable,
>> POSIX compliant alternative.
>
> Yes, if we wanted to emit an incomplete line, we would be using
>
>     printf "%s" "$var"
>
> instead of
>
>     echo -n "$var"
>
> for portability.  But that would not belong to the log message for
> this patch.  If the patch were to correct a script that originally
> used "echo -n" to produce an incomplete line to instead use "printf",
> these three lines would have been a perfect log message.
>
I appreciate the feedback - thanks.  The intention of those three
lines were to give context for using "printf" instead of adding
options to "echo" to suppress the newline; however, that was under the
assumption that suppressing the newline was desired behavior.
>
> Thanks.
>
>> Signed-off-by: Eric N. Vander Weele <ericvw@gmail.com>
>> ---
>>  git-filter-branch.sh     | 2 +-
>>  t/t7003-filter-branch.sh | 5 +++++
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
>> index 98f1779..949cd30 100755
>> --- a/git-filter-branch.sh
>> +++ b/git-filter-branch.sh
>> @@ -503,7 +503,7 @@ if [ "$filter_tag_name" ]; then
>>               new_sha1="$(cat "../map/$sha1")"
>>               GIT_COMMIT="$sha1"
>>               export GIT_COMMIT
>> -             new_ref="$(echo "$ref" | eval "$filter_tag_name")" ||
>> +             new_ref="$(printf "$ref" | eval "$filter_tag_name")" ||
>>                       die "tag name filter failed: $filter_tag_name"
>>
>>               echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
>> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
>> index 869e0bf..0db6808 100755
>> --- a/t/t7003-filter-branch.sh
>> +++ b/t/t7003-filter-branch.sh
>> @@ -269,6 +269,11 @@ test_expect_success 'Tag name filtering retains tag message' '
>>       test_cmp expect actual
>>  '
>>
>> +test_expect_success 'Tag name filter does not pass tag ref with newline' '
>> +     git filter-branch -f --tag-name-filter "cat && printf "_append"" -- A &&
>> +     git rev-parse A_append > /dev/null 2>&1
>> +'
>> +
>>  faux_gpg_tag='object XXXXXX
>>  type commit
>>  tag S
