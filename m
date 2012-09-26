From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC PATCH] add t3420-rebase-topology
Date: Wed, 26 Sep 2012 10:07:57 -0700
Message-ID: <CANiSa6i+A6fkWpkPMXiBRdT48LaSfPe2yki+AmWFAKYg02p=+g@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<50582873.603@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Chris Webb <chris@arachsys.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 26 19:08:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGv5l-000111-Gn
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 19:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757275Ab2IZRH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 13:07:59 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56734 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756512Ab2IZRH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 13:07:58 -0400
Received: by ieak13 with SMTP id k13so2024645iea.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 10:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zvI8BfBYPI/yKCpnrBEbGdEZLbqlDHBdiWm+G05eRwk=;
        b=KjdCwVymG/Lw/AD8xWSycU1ADFzW3vAptufDXIIqGNm9W+O5g7fEKKxiGsnCX2TuRZ
         WblV5UtRVh64fGEbNsEGv7WmGN82k5GaIlT8j3iUllLcc434Jp4PFmx62lh/dQHR9DH4
         ooRiXNeMx5z8y77DasuXrk8KVeU+/KK31qscNcEy70bVOcRU929Q9Kv/SYioNRF3Mzb6
         HHLEmEwsjG6iWuVHqkH5liLMs5RbOdXjYbNp7FM8anFYkoPJvjIphGDN+hDIf/sRPL+G
         HJeyKyWiK+JHhLTu2tHlNh4Q6NZCt6rqtTtij5wPq9IQcnVrI2ayy84M0qisqO5ntQTP
         dBQA==
Received: by 10.50.7.212 with SMTP id l20mr1093476iga.43.1348679277398; Wed,
 26 Sep 2012 10:07:57 -0700 (PDT)
Received: by 10.64.103.5 with HTTP; Wed, 26 Sep 2012 10:07:57 -0700 (PDT)
In-Reply-To: <50582873.603@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206423>

[+Chris Webb regarding "git rebase --root"]

First of all, thanks for a meticulous review!

On Tue, Sep 18, 2012 at 12:53 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 9/18/2012 8:31, schrieb Martin von Zweigbergk:
>
> Since here and in the following tests the test cases and test descriptions
> vary in the same way, wouldn't it make sense to factor the description out
> as well?

Definitely. I just couldn't think of a good way of doing it, so thanks
for great and concrete suggestions!

> (Watch your quoting, though.)

Switched to putting the test body in double quotes as you suggested in
your examples and used single quotes for strings within the test body.

>> +run () {
>> +echo '
>> +     reset &&
>> +     git rebase '"$@"' --keep-empty p h &&
>> +     test_range p.. "f g h"
>> +'
>> +}
>> +test_expect_success 'rebase --keep-empty keeps empty even if already in upstream' "$(run)"
>> +test_expect_failure 'rebase -m --keep-empty keeps empty even if already in upstream' "$(run -m)"
>> +test_expect_failure 'rebase -i --keep-empty keeps empty even if already in upstream' "$(run -i)"
>> +test_expect_failure 'rebase -p --keep-empty keeps empty even if already in upstream' "$(run -p)"
>
> "is in upstream" is decided by the patch text. If an empty commit is
> already in upstream, this adds another one with the same or a different
> commit message and authorship information. Dubious, but since it is
> opt-in, it should be OK.

Yes, it is a little dubious. See
http://thread.gmane.org/gmane.comp.version-control.git/203097/focus=203159
and Junio's answer, which I think makes sense.

>> +run () {
>> +echo '
>> +     reset &&
>> +     git rebase '"$@"' j w &&
>> +     test_range j.. "E n H" || test_range j.. "n H E"
>> +'
>
> Chaining tests with || is dangerous: you do not know whether the first
> failed because the condition is not satisfied or because of some other
> failure.

Good point. Thanks.

> Why is this needed in the first place? Shouldn't the history be
> deterministic, provided that the commit timestamps are all distinct?

It may be deterministic, but it's not specified, I think, so I didn't
want to depend on the order. Thinking more about it, though, I think
it's good to protect the current behavior from patches that change the
order of the parents. Although it may not be incorrect to change the
order, it would at least protect against accidental changes.

It turns out that "rebase -i" goes through the commits in
--topo-order, while the others use default order, I think. Which
flavor should pass the test case and which should fail (and be fixed)?
I would personally prefer to say that "rebase -i" is correct in using
--topo-order and that the others should be fixed. Again, it's not
specified, but I would hate to have them behave differently.

>> +run () {
>> +echo '
>> +     reset &&
>> +     git rebase '"$@"' --root c &&
>> +     ! same_revision HEAD c &&
>> +     test_range c "a b c"
>> +'
>> +}
>> +test_expect_success 'rebase --root is not a no-op' "$(run)"
>> +test_expect_success 'rebase -m --root is not a no-op' "$(run -m)"
>> +test_expect_success 'rebase -i --root is not a no-op' "$(run -i)"
>> +test_expect_success 'rebase -p --root is not a no-op' "$(run -p)"
>
> Why? Is it more like "--root implies --force"?

It doesn't currently exactly imply --force, but the effect is the
same. Also see my reply to Junio's email in this thread.

Maybe Chris has some thoughts on this?

>> +run () {
>> +echo '
>> +     reset &&
>> +     git rebase '"$@"' --root --onto e y &&
>> +     test_range e.. "x y"
>> +'
>> +}
>> +test_expect_success 'rebase --root --onto' "$(run)"
>> +test_expect_failure 'rebase -m --root --onto' "$(run -m)"
>> +test_expect_success 'rebase -i --root --onto' "$(run -i)"
>> +test_expect_success 'rebase -p --root --onto' "$(run -p)"
>
> Where does this rebase start? Ah, --root stands in for the "upstream"
> argument, hence, y is the tip to rebase. Right? Then it makes sense.

Thanks for pointing that out. I changed the order to "git rebase
--onto e --root y". I hope that makes it clearer.

>> +test_expect_success 'rebase -p re-creates merge from upstream' '
>> +     reset &&
>> +     git rebase -p k w &&
>> +     same_revision HEAD^ H &&
>> +     same_revision HEAD^2 k
>> +'
>
> IMO, this tests the wrong thing. You have this history:
>
>  ---j-------E---k
>      \       \
>       n---H---w
>
> where E is the second parent of w. What does it mean to rebase w onto k?
> IMO, it is a meaningless operation, and the outcome is irrelevant.
>
> It would make sense to test that this history results after the upstream
> at H moved forward:
>
>  ---j-------E---k
>      \       \
>       n---H   \
>            \   \
>             z---w'
>
> That is, w began a topic by mergeing the sidebranch E; then upstream
> advanced to z, and now you rebase the topic to the new upstream.

Fair enough. Changed accordingly.

>> +test_expect_success 'rebase -p re-creates internal merge' '
>> +     reset &&
>> +     git rebase -p c w &&
>> +     test_revisions "f j n E H w" HEAD~4 HEAD~3 HEAD~2 HEAD^2 HEAD^ HEAD
>
> You must also test for c; otherwise the test would succeed if rebase did
> nothing at all.
>
> This comment applies to all other tests as well, even the "regular" rebase
> tests above. (But I noticed only when I read this test.)

I did this only in one or two places thinking that that would be
enough to make sure that rebase is not normally a no-op. But I think
you are right that we should check it most of the time. It turns out
that doing this caught a case where the rebase did do something and
the right patches were in "c.." (or whatever it was; I forgot which
test case), but the new base was not "c".

> After this plethora of tests, can we get rid of some or many from other
> test scripts? (t34* tests are the ones that take the longest on Windows to
> run.)

I was afraid that this file would be the slowest of all and it might
very well be :-(. But, yes, it does replace a few test cases. I will
send out an updated version of the patch later. That version should
delete a few existing test cases as well.

I am having trouble finding enough time to get the patch into shape,
but I didn't want to put off this reply for any longer.

Martin
