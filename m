From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Mon, 26 Aug 2013 12:49:15 -0400
Message-ID: <CABURp0odEGgZO1yWFgXS+akPb4wJHiTLoQcmqBd00oYnPZ77vA@mail.gmail.com>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
 <CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
 <xmqqa9k6moif.fsf@gitster.dls.corp.google.com> <20130825042314.GE2882@elie.Belkin>
 <xmqqk3jal4t7.fsf@gitster.dls.corp.google.com> <xmqqfvtwkjp8.fsf@gitster.dls.corp.google.com>
 <CABURp0oGMTEgX3TKKEMAOxe6T0=uij+bAyc+5u0x_UHwEPo3CQ@mail.gmail.com> <xmqqr4dgifp5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 18:49:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDzz3-0002BO-Bv
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 18:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756715Ab3HZQth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 12:49:37 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:50414 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab3HZQtg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 12:49:36 -0400
Received: by mail-ve0-f179.google.com with SMTP id c13so2229841vea.24
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NWg6SfCvzN70Y2E0XjjwjJMeJ8ZnjP62+wjAJ7kedJI=;
        b=tASmRRVR+5Yww1yHgTOwNC8xrmD6Cej2ILMnLnmfr/GCxWsjbzPuOtcSsLpkoqY3KS
         kZfhned1UF6qJC27a+xyheDuWxUr4DgXTpCelIqox4ZpfH1Jl4cVlJ5d7/4LEyuXSBaj
         FQsDYrXJiNKRLf0dqfcpasfZCKaj1ODTlEuvj7sF2FOErZRj1kO02qdRpQLA0J7godEk
         RWk5MrBZozsJCpb2rOcCn/t4LLHEAaXfvICPidoaZfbc/r/69+3OY0EP2Ey95Giskvwi
         jCqKP/Uj7dAnKb4N5A6NorDpl5cSeB1+QAwtQEIbbKO8qom9vf/UgzONaXemlW2sZI3/
         sDHQ==
X-Received: by 10.52.244.116 with SMTP id xf20mr8897483vdc.16.1377535775632;
 Mon, 26 Aug 2013 09:49:35 -0700 (PDT)
Received: by 10.58.49.197 with HTTP; Mon, 26 Aug 2013 09:49:15 -0700 (PDT)
In-Reply-To: <xmqqr4dgifp5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233002>

On Mon, Aug 26, 2013 at 12:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Phil Hord <phil.hord@gmail.com> writes:
>
>> On Mon, Aug 26, 2013 at 3:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>>>
>>>>> I think Phil meant that when "git grep" is asked to search within
>>>>> "HEAD:some/path", filenames tacked on at the end should be appended
>>>>> with a '/' separator instead of the usual ':' (e.g.,
>>>>> "HEAD:some/path/inner/path.c", not "HEAD:some/path:inner/path.c").
>>>>
>>>> Ah, OK.
>>>>
>>>> I am not sure if we have a proper hint in the revision parser
>>>> machinery, but it may not be too hard to teach rev-cmdline interface
>>>> to keep that kind of information (i.e. "This tree object name is a
>>>> result of parsing '<tree-ish>:path' syntax").
>>>
>>> Actually, having thought about this a bit more, I am no longer sure
>>> if this is even a good idea to begin with.
>>>
>>> An output line that begins with HEAD:some/path:inner/path.c from
>>> "git grep" is an answer to this question: find the given pattern in
>>> a tree-ish specified with "HEAD:some/path".
>>>
>>> On the other hand, HEAD:some/path/inner/path.c is an answer to a
>>> different question: find the pattern in a tree-ish specified with
>>> "HEAD".  The question may optionally be further qualified with "but
>>> limit the search to some/path".  Both the question and its answer
>>> are more intuitive than the former one.
>>
>> I disagree.  The man page says that git grep lists the filenames of
>> matching files.
>
> But you need to realize that the manual page gives a white lie in
> order to stay short enough to be readable.  It does give filenames
> when reading from the working tree, the index or a top-level tree
> object.  When given arbitrary tree object that is not top-level, it
> does give filenames relative to the given tree object, which is the
> answer HEAD:some/path:inner/path.c to the question "where in the
> tree HEAD:some/path do we have hits?".
>
>>> If the user asked the question of the former form, i.e.
>>>
>>>     $ git grep -e pattern HEAD:some/path
>>>
>>> there may be a reason why the user wanted to ask it in that
>>> (somewhat strange) way.  I am not 100% sure if it is a good idea to
>>> give an answer to a question different from what the user asked by
>>> internally rewriting the question to
>>>
>>>     $ git grep -e pattern HEAD -- some/path
>>
>> We are not rewriting the question at all.
>
> That statement is trapped in a narrow "implementor" mind. I know you
> are not rewriting the question in your implementation, but what do
> the end users see? It gives an answer to a question different from
> they asked; the observed behaviour is as if the question was
> rewritten before the machinery went to work.
>
> If your justification were "above says 'there may be a readon why
> the user wanted to ask it in that way', i.e. 'find in this tree
> object HEAD:some/path and report where hits appear', but the reason
> can only be from laziness and/or broken script and the user always
> wants the answer from within the top-level tree-ish", then that
> argument may make some sense. You need to justify why it is OK to
> lose information in the answer by rewriting the colon that separates
> the question ("in this tree object") and the answer ("at this path
> relative to the tree object given").
>
> Whether you rewrite the input or the output is not important; you
> are trying to give an answer to a different question, which is what
> I find questionable.

Ok, so if I can summarize what I am inferring from your objection:

 1. The (tree-path, found-path) pair is useful information to get back
from git-grep.

 2. A colon is used to delimit these pieces of information, just as a
colon is used to delimit the filename from the matched-line results.

 3. The fact that the colon is also the separator used in object refs
is mere coincidence; the colon was _not_ chosen because it
conveniently turns the results list into valid object references.  A
comma could have been instead, or even a \t.

Have I got that right?

If so, then I would like to point out to you the convenience I
accidentally encountered using this tool.  Perhaps you didn't realize
how helpful it was when you chose to use a colon there.

On the other hand, perhaps a colon is an unfortunate syntactic
collision which should be corrected in the future.

Phil
