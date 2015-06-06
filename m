From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: Suggestion: add author info to TODO list in git-rebase--interactive
Date: Fri, 5 Jun 2015 21:00:51 -0400
Message-ID: <CANoM8SXnTU5bnyLKUUYEtnug89cC9cN3AU3E07qUmk85teamLw@mail.gmail.com>
References: <CANoM8SWX+UVWdV-Aeqqn8DuMf74zUWx=rbEaz3ctNDwa_ZZbeg@mail.gmail.com>
 <xmqq8ubyrlsc.fsf@gitster.dls.corp.google.com> <CAPig+cS0dW=KpD3C_6ugiJTccQqNu1NopcU6Pc71hf6iLLbcfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 03:01:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z12U9-0006j5-Uq
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 03:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbbFFBBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 21:01:13 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33500 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbbFFBBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 21:01:12 -0400
Received: by obcej4 with SMTP id ej4so14684272obc.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 18:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mrdqElTT042tJRxQWT1dUPKU6sR7UuSNJEboh95avRE=;
        b=wZEsPycU63Kl9RrLqrtydGTx+L9S3UtkyPURK1wzWzu8voJOcuyulZmKvh5nc5BgIc
         ooBDf/Wtfrna7zM23Gxv3Jzx5XpzQYNB1nsxh0l6XzJV6GOtE3BrRu8YvPbJc7ER4hEM
         x+OsPnL/Ut0P7GGgXmzUH5XT6ASRWs5kqKi2UfXaTUmtDwhPevP9WWMX5+mhT4oaSXrt
         KV4mQu+QN+6ynLBpSmtCembvu1Kmf/yjB/i88uL3aq9ypTV7+mZFWoxWUB9LLupDSEDi
         hz30d8BtBnR/JW/bBAPu0HDrnwcbxvRgZZvIZ41348ixWPakiW31EX+vT7URr4fdzuyC
         cxgg==
X-Received: by 10.182.118.163 with SMTP id kn3mr5301064obb.80.1433552471495;
 Fri, 05 Jun 2015 18:01:11 -0700 (PDT)
Received: by 10.202.204.20 with HTTP; Fri, 5 Jun 2015 18:00:51 -0700 (PDT)
In-Reply-To: <CAPig+cS0dW=KpD3C_6ugiJTccQqNu1NopcU6Pc71hf6iLLbcfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270899>

I think the custom format makes sense.  I took a first pass.

A config option 'rebase.interactive.todo-format' can override the
default 'oneline' format of the TODO list.  Since the list is
parsed using the left, right or boundary mark plus the sha1, then if the
custom format does not start with those values, they will be
automatically added to the beginning of the custom format.

For example, if author information is desired for the TODO list, then
setting the config value to '[%an] %s' will actually result in the
format being '%m%h [%an] %s'

---
 git-rebase--interactive.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index dc3133f..e2d5ffc 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -977,7 +977,18 @@ else
  revisions=$onto...$orig_head
  shortrevisions=$shorthead
 fi
-git rev-list $merges_option --pretty=oneline --reverse --left-right
--topo-order \
+custom_format=$(git config --get rebase.interactive.todo-format)
+if test -z "$custom_format"
+then
+   custom_format="oneline"
+else
+   # the custom format MUST start with %m%h or %m%H
+ if test "${custom_format:0:5}" != '%m%h '
+   then
+      custom_format="%m%h ${custom_format}"
+   fi
+fi
+git rev-list $merges_option --pretty="${custom_format}" --reverse
--left-right --topo-order \
  $revisions ${restrict_revision+^$restrict_revision} | \
  sed -n "s/^>//p" |
 while read -r sha1 rest
-- 

Is this closer to what you are looking for?  I also tried changing the
'--left-right' to '--left-only', but that seemed to not produce any
results.




On Fri, Jun 5, 2015 at 3:39 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Jun 5, 2015 at 3:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Mike Rappazzo <rappazzo@gmail.com> writes:
>>> I find that If I am doing a rebase with the intention to squash or
>>> re-order commits, it is helpful to know the commit author.
>>
>> There is not a fundamental reason why the remainder of the line
>> after the object name in the rebase insn sheet should not be
>> customizable, and I think your patch is a good first step to
>> identify where that customization should go.
>>
>> But that is a customization issue, not changing the default and the
>> only format used.
>
> The idea of being able to provide a custom format for insn sheet lines
> came up within the last year and was somewhat more well-developed and
> a bit more heavily discussed. I don't recall whether there was an
> accompanying patch, and I am unfortunately unable to locate the
> discussion in the archive.
