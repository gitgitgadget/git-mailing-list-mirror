From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] submodule--helper: initial clone learns retry logic
Date: Thu, 9 Jun 2016 12:47:40 -0700
Message-ID: <CAGZ79kbpurbwAB4H5_JPMsaGHmbeZA=EWjMOfQGB6apLhEXVeA@mail.gmail.com>
References: <20160609190637.21177-1-sbeller@google.com> <20160609190637.21177-2-sbeller@google.com>
 <xmqqy46egofw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 21:48:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB5vu-0007b8-I0
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 21:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbcFITrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 15:47:45 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:33284 "EHLO
	mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbcFITrm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 15:47:42 -0400
Received: by mail-qt0-f169.google.com with SMTP id c34so12860391qte.0
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 12:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OPB1V79dlUfVskeCFVk03i+jo6P5wlvJtXDT90ePvpw=;
        b=TaUZR/lmoahNyaUhq+wQnFxp6Mhp9rfrwZBZNcJje4GGSQRgib7/q3x2/dzFb3ALuT
         p/I1mlYx4otGzzo0qvRP3RcsvQqcw0D3n5x2Du/c3x3L3eFYpcDnQBpCJI7s45uoFTUU
         ULT4WWyheIMsN1Jy4jlfZ8bAjva0ODbzro3rsy8fAEAA2MTpgRfS4tKQpyqsbbV794l/
         bMrBvXPrP+lvsagW3K1Lk0zdbqD62hS8YXnUCTmPAnEvJDRl77yFy+Dy/2b6RdRKCyri
         aBiuJ0CcD5BkM5BD31uQ05Zapj7F5/quO4OVWOKeIJJ2VbxkTDZNtv/HmNiBf9Oxj1ql
         bSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OPB1V79dlUfVskeCFVk03i+jo6P5wlvJtXDT90ePvpw=;
        b=URXw+CQYtQfp78ppzmUMMB+wmoz+1WK2fmlcdEyo2suA1DwQvAUyAETpUIeQSrmMII
         g7prlx+zUKUBIJCHAWjoK7A7/twefZkKKNnFmqr/1v+pc58Q0pRP3WEi7iNnpahHT6ki
         6/nkwZxn3XcFmKp/0EZMNK/9SL/RRKZ3fD+D07CpqDC86RHy6J70KwAf5rL7huHNgkd9
         mpwH9LTHSnskhZpR5YdCtItq7/4TqS04hxj2AGW3eNY7vTAsUtcDW5mYO5NRw+lWBjqQ
         +hFspa6oaJGwUhXG/SjLj9IGKb9bAj0mv4irSd7y3sA37rN2nWN5plnnUM9za8KIapoN
         cVVA==
X-Gm-Message-State: ALyK8tIcewS1otGS24oElmM3gZQPpg/YeVJbvXxz2ZRsYMjBIBI6K0X712nr/h34OmrFkDCBdU8X2ndW0lpaDj5z
X-Received: by 10.200.39.142 with SMTP id w14mr11748386qtw.59.1465501661111;
 Thu, 09 Jun 2016 12:47:41 -0700 (PDT)
Received: by 10.237.42.226 with HTTP; Thu, 9 Jun 2016 12:47:40 -0700 (PDT)
In-Reply-To: <xmqqy46egofw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296921>

On Thu, Jun 9, 2016 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +static int compare_ce(const void *one, const void *two, void *cb_data)
>> +{
>> +     const struct cache_entry *ce_one = one, *ce_two = two;
>> +     return ce_two - ce_one;
>> +}
>
> This would work in practice, but I suspect that this is not ANSI-C
> kosher; as address comparison for ordering (not equality) is
> undefined if two pointers are not pointing into the same array or
> into the same struct's fields.

Uh :(

I thought about that for a while as I was about to send a 'simplification'
patch for commit.c:compare_commits_by_{author,commit}_date
There it made sense to keep it the way it is because
    sizeof(date) > sizeof(return value)

At the time of writing it made sense for this to be a subtractions,
but I think we want to make it

    if (ce_one < ce_two)
        return 1;
    else if (ce_one > ce_two)
        return -1;
    else
        return 0;

instead. But that is still unspecified, so we rather go with

static int compare_ce(const void *one, const void *two, void *cb_data)
{
    const struct cache_entry *ce_one = one, *ce_two = two;
    return strcmp(ce_one->name, ce_two->name);
}

When reading the prio queue code correctly, we can be sure there
is no NULL passed to either of one or two.

>
> I think we have one or two other instances of such fishy pointer
> comparison already in the codebase, so it is not a show-stopper, but
> it would be better if this can be avoided and be replaced with
> something that I do not have to raise eyebrows at ;-)
