From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH v2] diff: Add diff.orderfile configuration variable
Date: Fri, 6 Dec 2013 21:43:22 -0500
Message-ID: <CAJYzjmdg8v6-kZ+xtD9GT=vVTs7AEX_iEoroxdi4F4rjoTogWw@mail.gmail.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
	<1386312508-7421-1-git-send-email-naesten@gmail.com>
	<xmqqhaal3l3x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 07 03:43:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp7rb-00050w-Hc
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 03:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815Ab3LGCnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 21:43:23 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35373 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab3LGCnW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 21:43:22 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so1622542obc.20
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 18:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jcalCipe8eQbdlk2Jtfy+PSu9QELXpnRlmhQvN9gpvs=;
        b=TN63KtZx5Kc6UekyVyzZShQrhArKDJkrA2bLhHt3HHjpZUMwkFUxWzPZ+m6JDLLhTx
         PlABNQJja671yQjH/uthYokR7CW+6vZCTKYeMfUlAMH82lPryEw+zeHQwccnFzAPTAIU
         KeWGYNzzHQlgx4FmjFtcWvcr9Bbcx00IDoJHmNeK3clxdxazUZrOjsxm2u0A4M4gGJfW
         cYluVgeHlQPIclZ4tTV+SNYg18SrJVpyU+6a3W/sEHy0tRoX/5rE6bX78SEaj1W9Zust
         pPdQYnKymvAeCH8/wFSDvvG3oqVMW3DJMFu47Z/DNGl11KIdaoX8tXm8wrK6q9IGSJPK
         6oDg==
X-Received: by 10.60.62.172 with SMTP id z12mr4954700oer.4.1386384202364; Fri,
 06 Dec 2013 18:43:22 -0800 (PST)
Received: by 10.182.135.3 with HTTP; Fri, 6 Dec 2013 18:43:22 -0800 (PST)
In-Reply-To: <xmqqhaal3l3x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238969>

On Fri, Dec 6, 2013 at 1:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Bronson <naesten@gmail.com> writes:

> Thanks for reviving a stalled topic.

I was asking about such a feature in #git and jrnieder was nice enough
to point me at the stalled patch.

>> *I* even verified that the tests do fail properly when the feature is
>> sabotaged.
>
> Sabotaged in what way?

I commented out the "options->orderfile = diff_order_file_cfg;" line.

>> @@ -432,6 +432,8 @@ endif::git-format-patch[]
>>  -O<orderfile>::
>>       Output the patch in the order specified in the
>>       <orderfile>, which has one shell glob pattern per line.
>> +     This overrides the `diff.orderfile' configuration variable
>> +     ((see linkgit:git-config[1]).
>
> Double opening parenthesis?

Oops, and it looks like I messed up the quoting on diff.orderfile too ...

> If somebody has diff.orderfile configuration that points at a custom
> ordering, and wants to send out a patch (or show a diff) with the
> standard order, how would the "overriding" command line look like?
> Would it be "git diff -O/dev/null"?

It looks like that works ... and so do files that don't exist.  What
do you think should happen with -O file-that-does-not-exist, and how
do you suppose it should be tested?

After having fixed this, will /dev/null still work everywhere, or will
we want a new diff flag to unset the option?  (I see that "git diff
/dev/null some-file" works fine with msysgit, which doesn't seem to
actually be linked with MSYS, but I don't know *why* it works, and I
don't know what other non-POSIXoid ports exist.)

For the moment, I've added this to "for" loop (after some changes
based on some of your other suggestions):

    # I don't think this should just pretend the orderfile was empty?
    test_expect_failure "override with bogus orderfile ($i)" '
    test_might_fail git -c diff.orderfile=order_file_$i diff
-Obogus_file --name-only HEAD^..HEAD >actual_diff_filenames &&
    ! test_cmp expect_diff_filenames_none actual_diff_filenames
'

Does this look (modulo gmail's stupid indentation) anything like a
reasonable approach to testing that?  (Of course, you can't actually
test it because it depends on other changes I haven't posted yet ...)

Also, I'm starting to wonder if I shouldn't split this into two patches:

    1.  diff: Add tests for -O flag
    2.  diff: Add diff.orderfile configuration variable

(If so, I would obviously want to rewrite the above test to avoid the
configuration option.)

>> +     return $?
>> +}
>
> That return looks somewhat strange.  Does it even need to be there?

I'm certainly no great expert at shell functions, so I expect it
isn't.  I'm not really sure what possessed me to think it might be
needed.

>                 EOF
>                 cat >order_file_2 <<-\EOF &&

I'd kind of prefer to keep a blank line between one EOF and the next
cat, if that's okay with you.

>
> Quoting the EOF like the above will help the readers by signaling
> them that they do not have to wonder if there is some substitution
> going on in the here text.

Perhaps, but probably only after they've scrutinized their shell
manuals to figure out what the - and the \ are for.  (I had to check
two: dash(1) wasn't clear enough for me about the quoting ...)

>> +test_expect_success "no order (=tree object order)" '
>> +     git diff HEAD^..HEAD >patch &&
>> +     grep ^diff patch >actual_diff_headers &&
>> +     test_cmp expect_diff_headers_none actual_diff_headers
>> +'
>
> Instead of grepping, "git diff --name-only" would be far easier to
> check, no?

It certainly makes for less-cluttered expected output.  (I guess
jrnieder didn't know about that trick when he suggested using the
intermediate file?)

> Points to note:
>
>  * We eval the scriptlets inside test framework, so using $i as a
>    variable inside the single quotes will have the expected result.
>    You do not have to worry about extra quoting inside dq pair.

Hmm.  I'm obviously not used to things getting eval'd in the same
shell instance as my script ...

(Thanks for the review!)
