From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Mon, 26 Aug 2013 07:44:09 -0400
Message-ID: <CABURp0oGMTEgX3TKKEMAOxe6T0=uij+bAyc+5u0x_UHwEPo3CQ@mail.gmail.com>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
 <CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
 <xmqqa9k6moif.fsf@gitster.dls.corp.google.com> <20130825042314.GE2882@elie.Belkin>
 <xmqqk3jal4t7.fsf@gitster.dls.corp.google.com> <xmqqfvtwkjp8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 13:44:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDvDm-00039z-RW
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 13:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370Ab3HZLob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 07:44:31 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:65196 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab3HZLoa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 07:44:30 -0400
Received: by mail-ve0-f180.google.com with SMTP id pb11so1937843veb.39
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 04:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XB3MASaHaLae9aqpxAz/PE36Abmk00/qdhuvQt/95PU=;
        b=tN3kY6k009ziE+XHW7oOD3YKdKrgLU9sGih7mpYdcAEDJfAf2rv2xHyKL64f7zYqBu
         owlGobw1vQhZZfsq2CW1GtR20cTU6XfNquqIphpl2GB/T0m5zAGrk/DBQTeCn4eDdZh/
         etArWEJZ7jOAN61Oh0Oxzi6sLfsPqaCiLwVX87kFlehHoKyMOE1qGU9UlGupBVEp+vDw
         GdW/jXnw1BnuzcnuXPHjKq/MDYQQ2etQCHY/MGVZpdEwt6YxprZDjVT3f5YysrM1OmIz
         G/jos4GpEiH5y4tC1p0frp7vk4jEPmi00nTryHCwQ5vycsDdV/9JPFxmSxJ6zKKz34qn
         6THA==
X-Received: by 10.220.237.208 with SMTP id kp16mr14502695vcb.4.1377517469474;
 Mon, 26 Aug 2013 04:44:29 -0700 (PDT)
Received: by 10.58.49.197 with HTTP; Mon, 26 Aug 2013 04:44:09 -0700 (PDT)
In-Reply-To: <xmqqfvtwkjp8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232990>

On Mon, Aug 26, 2013 at 3:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> I think Phil meant that when "git grep" is asked to search within
>>> "HEAD:some/path", filenames tacked on at the end should be appended
>>> with a '/' separator instead of the usual ':' (e.g.,
>>> "HEAD:some/path/inner/path.c", not "HEAD:some/path:inner/path.c").
>>
>> Ah, OK.
>>
>> I am not sure if we have a proper hint in the revision parser
>> machinery, but it may not be too hard to teach rev-cmdline interface
>> to keep that kind of information (i.e. "This tree object name is a
>> result of parsing '<tree-ish>:path' syntax").
>
> Actually, having thought about this a bit more, I am no longer sure
> if this is even a good idea to begin with.
>
> An output line that begins with HEAD:some/path:inner/path.c from
> "git grep" is an answer to this question: find the given pattern in
> a tree-ish specified with "HEAD:some/path".
>
> On the other hand, HEAD:some/path/inner/path.c is an answer to a
> different question: find the pattern in a tree-ish specified with
> "HEAD".  The question may optionally be further qualified with "but
> limit the search to some/path".  Both the question and its answer
> are more intuitive than the former one.

I disagree.  The man page says that git grep lists the filenames of
matching files.  And it usually does.  When told to search in a
different branch, the filename is helpfully shown in a form that other
git commands recognize, namely $branch:$path. This is useful for
scripts that want to do something with the resulting file names.

But when a path included in the query with the branch, the output is
useless to my scripts or finger memory without some cleanup first.
The aim of this patch is to fix that so the cleanup is not necessary.

   $ git grep -l setup_check HEAD Documentation
   HEAD:Documentation/technical/api-gitattributes.txt

   $ git grep -l setup_check HEAD:Documentation
   HEAD:Documentation:technical/api-gitattributes.txt

The path in the first example is meaningful.  The path in the second
example is erroneous.


> And we have a nice way to ask that question directly, i.e.
>
>     $ git grep -e pattern HEAD some/path
>
> which can be extended naturally to more than one path, e.g.
>
>     $ git grep -e pattern HEAD some/path another/hierarchy
>
> without having to repeat HEAD: part again for each path.

Yes, but that's not always what I want. Sometimes I want to search on
different trees. When doing so, why should I be crippled with broken
output?

    $ git grep -e pattern origin/master:some/path origin/next:another/hierarchy
    origin/master:some/path:sub/dir/foo.txt
    origin/next:another/hierarchy:path/frotz.c

I would prefer to have real paths I can pass to 'git show', ones with
just one meaningful colon rather than two vague ones:

    origin/master:some/path/sub/dir/foo.txt
    origin/next:another/hierarchy/path/frotz.c

> If the user asked the question of the former form, i.e.
>
>     $ git grep -e pattern HEAD:some/path
>
> there may be a reason why the user wanted to ask it in that
> (somewhat strange) way.  I am not 100% sure if it is a good idea to
> give an answer to a question different from what the user asked by
> internally rewriting the question to
>
>     $ git grep -e pattern HEAD -- some/path

We are not rewriting the question at all.

The current code assumes the user gave only an object name and is
trying to help by prefixing that name on the matched path using the
colon as a separator, as would be the norm.  But that is the wrong
separator in some cases, specifically when the tree reference includes
a path.

Phil
