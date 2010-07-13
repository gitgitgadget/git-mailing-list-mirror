From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH 1/2] lib-rebase.sh: fake-editor.sh: Allow checking of 
	commit header(s) in $GIT_EDITOR
Date: Tue, 13 Jul 2010 08:36:59 +0800
Message-ID: <AANLkTin03Ea2fIBQiSDpIqRYLYjWRe9U62nZpfczbfST@mail.gmail.com>
References: <1278764821-32647-1-git-send-email-ayiehere@gmail.com>
	<7v7hl1fd0n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 02:37:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYTV2-0000kI-B0
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 02:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310Ab0GMAhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 20:37:05 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39923 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab0GMAhD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 20:37:03 -0400
Received: by wyf23 with SMTP id 23so3808274wyf.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 17:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=YRm5zzR8/A7hS9HsX3KLqM7S8EvASkbp+si29/VE70E=;
        b=J1+ZE9Ay1ij2j3yQBcjsf41/37AG0ZokJQ98eDI1hWMNPw5rc/B+6jWNYSiMbNb+Rc
         rD/vtBQ6Z5Uca1fTQX3lNFlDBGk3tfrfnykkvT+tJzGEsS0tkQt/eCgYCin5MRSyrxgc
         6Ei3RN5XKgLmnkrYJZF2L4K/KKNRHPy4htmy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KSAO0CJGz2Qq9lsfkN9+49ZJzRv4fjkWfD/RHtbWu2rIibjs+Jt5h+E1jns2aM3vHY
         2p9f9emU2yJ3iJUZ9OSYeB9z9NEXbidJWbM/bTu97le32NJyaGAhh1I+sxS7ICh2t8yX
         M246oYUIoYRnOEkWN+ZhO9OseHToIs7i9EbbQ=
Received: by 10.216.131.161 with SMTP id m33mr9352463wei.13.1278981419743; 
	Mon, 12 Jul 2010 17:36:59 -0700 (PDT)
Received: by 10.216.163.142 with HTTP; Mon, 12 Jul 2010 17:36:59 -0700 (PDT)
In-Reply-To: <7v7hl1fd0n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150858>

On Mon, Jul 12, 2010 at 2:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nazri Ramliy <ayiehere@gmail.com> writes:
>
>> +test -z "$EXPECT_HEADER" ||
>> +     (
>> +             grep '^pick' < "$1" | cut -d' ' -f3- > commit_headers.$$ &&
>
> Sending output from grep to cut does not sound very cool; wouldn't a
> single "sed" invocation more appropriate?

If I were to use a single "sed" invocation here's how it's going to look like:

	sed -e "s/^pick [0-9a-f]\+//" < "$1" > commit_headers.$$

But doing so reminds me of this:

On Sat, Jul 10, 2010 at 6:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nazri Ramliy <ayiehere@gmail.com> writes:
>
>> +                     sed -i "s/^\([a-z]\+\) [0-9a-f]\+ /\1 $REPLACE_COMMIT_ID /" \
>
> This is not portable. Escaping an ERE element with a backslash does not
> make it suitable for use in BRE that sed uses.

Aren't we back to square one? Or am I missing something?

>> +             diff "$EXPECT_HEADER" commit_headers.$$ > /dev/null
>
> Is "test_cmp" inappropriate here for some reason?

It seems appropriate, but this will require a ". ./test-lib.sh" from inside
lib-rebase.sh, which fails because at that point we are already in the trash
directory for the test, the solution is to do a ". $TEST_DIRECTORY/test-lib.sh"
instead but that gives more errors due to test-lib.sh assumes that it is always
being "sourced" when $CWD is $TEST_DIRECTORY, i think.

>
>> +     ) ||
>
> Do you need a subshell for this, or just a grouping {} sufficient?

Yes a grouping {} is sufficient.

Note: The only user of the feature that this patch provides is my patch to
t3404-rebase-interactive.sh
(1278896663-3922-2-git-send-email-ayiehere@gmail.com),
the rationale of which is discussed in 7vbpadfd4r.fsf@alter.siamese.dyndns.org.

I'll send a reply to that one in a bit.


nazri.
