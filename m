From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Fri, 22 Mar 2013 20:24:08 -0700
Message-ID: <CAJDDKr4658zFCZ8JpXUZUrS4URTb7zX0xGR4AeODDLOVjkzDGA@mail.gmail.com>
References: <20130322115352.GI2283@serenity.lan>
	<cover.1363980749.git.john@keeping.me.uk>
	<5fc134f6c4a88232c78240539084e9d35db3a6cb.1363980749.git.john@keeping.me.uk>
	<7v8v5f59n1.fsf@alter.siamese.dyndns.org>
	<20130322230516.GK2283@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Mar 23 04:24:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJF4R-0001xW-5i
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 04:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422743Ab3CWDYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 23:24:11 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:62041 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332Ab3CWDYK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 23:24:10 -0400
Received: by mail-wi0-f182.google.com with SMTP id hi18so5018310wib.3
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 20:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8mPQQi0dTyEypbOPxxE+dPAAyR0DH+S88rMfNLAJhfc=;
        b=d1EFSDacVgdpQXcxcH75khY0qt/7HSRer0fE/FIYwJs/qMZbcFa/FU1lrAPyGjAUTd
         1DfzsskF7shOokZHZdDP5x78+fwRnj/TUfKdSsAY1/spbFeJp++7bwdwIGvCeYVc6Vm8
         1pxX7oeOGsCxVKeOsCDMUVs5/bZwqQyJCQhaI6ApVc4n0Om9Bpx3CwgaA5+apwqoPGTS
         jfVCnkUkORQdilgu+CbBnW5yXiZJwOYLegstybQ258qmB9RLOBX/wIjV8HjCulo70QMZ
         ZUf7Ih7Exsp0sNIUtKuzBOFlNrJl8JYWJozj+JMh22vz58RpWaqX/PxJ6usK4pUfsfky
         N7iQ==
X-Received: by 10.180.84.8 with SMTP id u8mr14918522wiy.1.1364009048721; Fri,
 22 Mar 2013 20:24:08 -0700 (PDT)
Received: by 10.194.13.129 with HTTP; Fri, 22 Mar 2013 20:24:08 -0700 (PDT)
In-Reply-To: <20130322230516.GK2283@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218881>

On Fri, Mar 22, 2013 at 4:05 PM, John Keeping <john@keeping.me.uk> wrote:
> On Fri, Mar 22, 2013 at 03:53:38PM -0700, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>>
>> > When 'git difftool --dir-diff' is using --no-symlinks (either explicitly
>> > or implicitly because it's running on Windows), any working tree files
>> > that have been copied to the temporary directory are copied back after
>> > the difftool completes.  This includes untracked files in the working
>> > tree.
>>
>> Hmph.  Why do we populate the temporary directory with a copy of an
>> untracked path in the first place?  I thought the point of dir-diff
>> was to materialize only the relevant paths to two temporaries and
>> compare these temporaries with a tool that knows how to compare two
>> directories?
>>
>> Even if you had path F in HEAD that you are no longer tracking in
>> the working tree, a normal
>>
>>       $ git diff HEAD
>>
>> would report the path F to have been deleted, so I would imagine
>> that the preimage side of the temporary directory should get a copy
>> of HEAD:F at path F, while the postimage side of the temporary
>> directory should not even have anything at path F, when dir-diff
>> runs, no?
>>
>> Isn't that the real reason why the test fails?  The path 'output' is
>> not being tracked at any revision or in the index that is involved
>> in the test, is it?
>
> Actually it is, which is what I missed earlier.
>
> A couple of tests before this 'setup change in subdirectory' does 'git
> add .' which is far more general than it needs.  Perhaps this is a
> better change:
>
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index bba8a9d..561c993 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -314,7 +314,7 @@ test_expect_success PERL 'setup change in subdirectory' '
>         git commit -m "added sub/sub" &&
>         echo test >>file &&
>         echo test >>sub/sub &&
> -       git add . &&
> +       git add file sub/sub &&
>         git commit -m "modified both"
>  '
>
>
>> > During the tests, this means that the following sequence occurs:
>> >
>> > 1) the shell opens "output" to redirect the difftool output
>> > 2) difftool copies the empty "output" to the temporary directory
>> > 3) difftool runs "ls" which writes to "output"
>> > 4) difftool copies the empty "output" file back over the output of the
>> >    command
>> > 5) the output files doesn't contain the expected output, causing the
>> >    test to fail
>> >
>> > Avoid this by writing the output into .git/ which will not be copied or
>> > overwritten.
>>
>> It is a good idea to move these test output and expect test vectore
>> files to a different place to make it easier to distinguish them
>> from test input (e.g. "sub", "file", etc.) in general, but the
>> description of the original problem sounds like it is just working
>> around a bug to me.  What am I missing?
>
> I think there is a bug, as described in the paragraph below, and this
> test should be made independent of that.  In light of the above I think
> we can drop this patch and do this with that change instead.

I, too, was scratching my head when the Windows issue was first reported.

Thanks for clearing this up; fixing the blind "add ."
certainly seems like the way to go.
-- 
David
