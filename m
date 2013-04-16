From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [Resend PATCH] t3903 (stash): add failing test for ref of form ^{/message}
Date: Tue, 16 Apr 2013 11:57:49 -0700
Message-ID: <CA+sFfMfkoBcoPvJSYBGUe46EbMfiC7q6tVZs6db2NHrEb2gb7Q@mail.gmail.com>
References: <1366135765-18437-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 20:57:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USB4m-0006ig-6f
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 20:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935056Ab3DPS5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 14:57:51 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:58537 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab3DPS5v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 14:57:51 -0400
Received: by mail-we0-f180.google.com with SMTP id r5so601346wey.25
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=TX8ZXT9zVsN3VrLYT921VJ71l5e/Jng2zsy/LpfbuoY=;
        b=rPzZvi0QErxfd2oHjrCgFSaEWbHjxnRtWgl+J3iHdf7KsFO6sGmb9l2cwANTaJWkzY
         VMXK1ARhldaJdrYbH+TDQ+3VUrGt2fFAkF5WWlQhqPmYJPgZf1VqP3ffAIsbhiqHZwT+
         etYct6jvlCc7/RA9n/LblUpsHIKSETbmU1t1IbRNq6AtAq9kcoXOJnP+T+e6riKGS39E
         TsuAs8yn62GBlL3nSR6LBGQZC6+ktx7kxygeLn6mft0lh3oH0cEAXjhT/mUcB7KEzQ89
         ejIoD568ZuDwK2GKAsD3ohcxshMtO9H1L6R06U0u0F6sLerfXHRLWW/TpL++Kz2sMnTL
         QOYQ==
X-Received: by 10.194.10.129 with SMTP id i1mr6257828wjb.21.1366138670051;
 Tue, 16 Apr 2013 11:57:50 -0700 (PDT)
Received: by 10.194.249.69 with HTTP; Tue, 16 Apr 2013 11:57:49 -0700 (PDT)
In-Reply-To: <1366135765-18437-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221450>

On Tue, Apr 16, 2013 at 11:09 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> While a 'git stash show stash^{/quuxery}' works just fine, a 'git
> stash pop stash^{/quuxery}' complains with: 'stash^{/quuxery} is not a
> stash reference'.

I don't think it is appropriate to use the ^{/<text>} notation with stashes.

The stash is implemented using the reflog.  The ^{/<text>} notation
searches the commit history, not the reflog.  So I think it will be
able to match the first entry in your stash stack, but not any of the
other ones.

Try inserting another stash (see below) on top of the one that
contains the string "quuxery" and I think you'll find that your 'git
stash show stash^{/quuxery}' no longer works.

An extension to the reflog dwimery that implements @{/<text>} could be
interesting though.

> This confusing behavior arises from the differences
> in logic that 'show' and 'pop' internally employ to validate the
> specified ref.  Document this bug by adding a failing testcase for it.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  So sorry about misspelling Junio's address in my previous email.
>  Please respond to this one instead.
>
>  So if you look at git-stash.sh:377, you'll notice that it's doing a
>  the shell substitution "${REV%@*}" to figure out whether the stash
>  ref is a valid ref.

> This hacky myopic design has to be done away
>  with immediately, and we should really compare the SHA-1 hex of the
>  specified ref with those in the stash reflog.

Just a bit of advice, maybe you should think about softening your tone
a bit hmm?  I find this last sentence to be somewhat repelling and
tend to refrain from responding to such.

>  The only reason I haven't written a fix yet is because I'm not sure
>  why you need this convoluted IS_STASH_LIKE and IS_STASH_REF logic in
>  the first place.  Can someone enlighten me as to what is going on?

>  t/t3903-stash.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 5dfbda7..04ba983 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -583,6 +583,15 @@ test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
>         git stash drop
>  '
>
> +test_expect_failure 'valid ref of the form stash^{/message}' '
> +       git stash clear &&
> +       echo bar > file &&
> +       git add file &&
> +       git stash save "quuxery" &&

            # Save another stash here

            echo bash >file
            git add file
            git stash save "something"

            # Now git stash show stash^{/quuxery} no longer works.

> +       git stash show stash^{/quuxery} &&
> +       git stash pop stash^{/quuxery}
> +'
> +
>  test_expect_success 'stash branch should not drop the stash if the branch exists' '
>         git stash clear &&
>         echo foo >file &&

-Brandon
