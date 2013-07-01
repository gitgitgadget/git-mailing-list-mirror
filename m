From: =?UTF-8?Q?Jens_Lindstr=C3=B6m?= <jl@opera.com>
Subject: Re: [PATCH] clone: Skip pack-*.keep files when cloning locally
Date: Mon, 1 Jul 2013 12:24:03 +0200
Message-ID: <CAEef6WzAg8-QMH1c4v=1tm7TPgfeE3W3K+ue-eYgRL3pyYo6Vg@mail.gmail.com>
References: <1372430538-19216-1-git-send-email-jl@opera.com>
	<7vvc4ynkrx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 12:24:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtbHG-0004TX-SG
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 12:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab3GAKYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 06:24:06 -0400
Received: from mail-qe0-f49.google.com ([209.85.128.49]:65108 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947Ab3GAKYF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 06:24:05 -0400
Received: by mail-qe0-f49.google.com with SMTP id cz11so1567209qeb.22
        for <git@vger.kernel.org>; Mon, 01 Jul 2013 03:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=p7mvAF7RGtvit47nKBkkhgcKQEICNSEhVyAvkfG5nO8=;
        b=IqK8Z2bKWr4fH9L1zmbh1Txx/COQALAatHkEiJYUQaoo8AbobMeobbNphIDag1dixs
         f8jL2pHwbLfbxnnKKmlfhqfkuZn0Nci1/DX2ARw+TdLpO45uRyKnZ8ka5XoD6M/wKDZ3
         uHYhQQGPGVsDDQHIClTKSY5OEMGkmeQsixOAe7EyrynYtC12uDF89pVeWjJHmTm0msJS
         h0Q75xSR3X7iyZn3Ld6DNHCzcmtjmiS5VjsJ6Yjx5wGCDJ0w/vCj0+y1ZlYLJz66m1hv
         3wqr3TrZCO9US9ZoEQkr3g46yFnZo3B+zsiMlmvI34+LHmLiRqGqtzdCu1KbTgFkHe3/
         nqVQ==
X-Received: by 10.224.69.66 with SMTP id y2mr31488962qai.61.1372674243847;
 Mon, 01 Jul 2013 03:24:03 -0700 (PDT)
Received: by 10.49.15.162 with HTTP; Mon, 1 Jul 2013 03:24:03 -0700 (PDT)
In-Reply-To: <7vvc4ynkrx.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQl7snMaQA7DF/kee4uvbDN1lyYsE+KOus3J26i2PLhGAi0HcnlzBkY2K/ipMz7NzJTW6oEf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229299>

On Fri, Jun 28, 2013 at 8:38 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> The pack-*.keep files are temporary, and serve no purpose in the
>> clone.
>
> They are not temporary, actually. A user can deliberatey create a
> "keep" marker after packing with a good set of parameters, so that
> the resulting pack will be kept, instead of letting a later repack
> (with faster set of parameters) remove and replace it with less
> optimal results.

Ah, I see.  Was (obviously) not aware of that.  It would perhaps be a
good idea to be able to differentiate between such permanent keep
files and the temporary ones created by built-in commands.

Also, even if some keep files are permanent in the source repository,
is it always a good idea to copy them over to the clone?  This would
only happen for some types of clones, anyway.


On Fri, Jun 28, 2013 at 10:38 PM, Junio C Hamano <gitster@pobox.com> wrote:

> That is, something like this, perhaps?

Comments:

With this patch, it still fails with --local, when the link() call
fails.  This seems a bit odd, in particular in the cases where --local
is implied.  IOW, one would not expect that adding --local would
change behavior, but here adding it causes the operation to fail.

Also, since failing to link() once implicitly enables --no-hardlinks,
it would copy the rest of the repository without trying to use link(),
which might make the whole operation much more expensive.

Applying the exception for inaccessible .keep files for link() as well
would seem a better solution to me.
