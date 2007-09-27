From: "Dan Nicholson" <dbn.lists@gmail.com>
Subject: Re: [PATCH] quiltimport: Skip non-existent patches
Date: Thu, 27 Sep 2007 15:20:46 -0700
Message-ID: <91705d080709271520r11546361hdbe5e028d415e961@mail.gmail.com>
References: <Pine.LNX.4.62.0709271154440.10467@pademelon.sonytel.be>
	 <1190925059-5233-1-git-send-email-dbn.lists@gmail.com>
	 <loom.20070927T203413-499@post.gmane.org>
	 <7v1wcju93a.fsf@gitster.siamese.dyndns.org>
	 <91705d080709271445k62f2867am99114eb0e98fc408@mail.gmail.com>
	 <7vejgjsr6k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 00:21:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib1j5-0003YK-Mt
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 00:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758457AbXI0WUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 18:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758376AbXI0WUt
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 18:20:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:54268 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756259AbXI0WUs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 18:20:48 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1171082wra
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 15:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=U0jt2Nvv7xhjZksggYs0PVJD2yWHxpVabnOkHssI8Wg=;
        b=ffSYaxehKF26oc5YoOKL+RGWnetP/Rua3sLLdeBsCVkYAyu3cLy4jN2Wf7UtWsMow30AKSp+A08CHjEMOSwmZEgNgeWeElahoO9tocDv6hvCJGdeed3bjx/sqVt1kATNr9It6/O/hUZP+Dx8RBn6qoq2vtIsVZT8pkx9bhb54eM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ms5HXBdjZE7rybXMFirw3VZQztUeAxhHzbjGR4+U+l8Ts7WElxnFU2ehzOT9+x+3hdpaYIvzN6dImjR1tGXvsuWWxeXGVzNqC/iAFqLtKKYUEukcYp+BBI/SjWiITPwp3HATp5IzVgwKZsLG+W6R/C5Y7NddMuKkL4H4Xt31n14=
Received: by 10.141.27.18 with SMTP id e18mr246967rvj.1190931646709;
        Thu, 27 Sep 2007 15:20:46 -0700 (PDT)
Received: by 10.143.8.3 with HTTP; Thu, 27 Sep 2007 15:20:46 -0700 (PDT)
In-Reply-To: <7vejgjsr6k.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59342>

On 9/27/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Dan Nicholson" <dbn.lists@gmail.com> writes:
>
> > When you run the command `quilt series', it just lists what's in the
> > series file (minus any comments). And when you run `quilt push' with a
> > non-existent patch, it says "Patch foo.patch does not exist; applied
> > empty patch"
> >
> > So, I think the consistent thing to do is what's in my patch: just
> > skip the patch with a message to the user. Maybe the message can be
> > tailored to match quilt's output. Actually, it would be best to also
> > skip on empty files since quiltimport will bomb in that case as well.
>
> Thanks for your helpful explanation.  So perhaps we can do this
> on top of yours to be safer and more consistent.
>
> ---
>
>  git-quiltimport.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-quiltimport.sh b/git-quiltimport.sh
> index 880c81d..627e023 100755
> --- a/git-quiltimport.sh
> +++ b/git-quiltimport.sh
> @@ -79,8 +79,8 @@ for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
>         git mailinfo "$tmp_msg" "$tmp_patch" \
>                 <"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3
>         test -s "$tmp_patch" || {
> -               echo "Patch is empty.  Was it split wrong?"
> -               exit 1
> +               echo "Patch is empty. Skipping."
> +               continue
>         }
>
>         # Parse the author information

That's seems fine. IIUC, mailinfo will only create an empty patch if
there's no actual patch content in the original mail/patch. In that
case, you probably do want to skip and not bomb. I'd changed my patch
to do 'if ! [ -s "$patch" ]' to catch an empty file, but this is
probably better. Hmm, checking `quilt push' on a patch with no actual
patch bombs. Here's the output:

$ quilt push
Applying patch foo.patch
patch: **** Only garbage was found in the patch input.
Patch foo.patch does not apply (enforce with -f)
$ echo $?
1
$ cat patches/foo.patch
Here's info about an empty patch.

So, it might be better to leave the original behavior there to match quilt.

--
Dan
