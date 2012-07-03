From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: [PATCH] push: don't guess at qualifying remote refs on deletion
Date: Tue, 3 Jul 2012 14:34:59 -0400
Message-ID: <CAKON4Oy0YBVTAhZPU=1B=yYY4t2O_uRWDW1zOMaC5iCb=kRQ2w@mail.gmail.com>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
	<7vsjd9wkek.fsf@alter.siamese.dyndns.org>
	<CAKON4OxBo7XiF5c60oyEUMR1xCh16n5BZCz-mmcUc0V9X7D32A@mail.gmail.com>
	<20120703180439.GC3294@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 20:35:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm7wJ-0006iH-Kk
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 20:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab2GCSfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 14:35:01 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63590 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab2GCSfA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 14:35:00 -0400
Received: by vbbff1 with SMTP id ff1so4433125vbb.19
        for <git@vger.kernel.org>; Tue, 03 Jul 2012 11:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ceKbDq3GNChei39377q/aAFSr0Krixb22D7439t/L24=;
        b=Sn7PA2lPclpJCWC8FvqhqpooZ5vtkNYJ6eZVEpQt8qBYFxUvegmN1X99bi0SgCTwvm
         ta5eR8UrQaM2676XK4cAtNWymJj4x2JmUJyFWVUOwAAMpaG2LiPSfpiA6DqOa+wrYLig
         I9QKdANM5MasSfvH8U2lMfsipMEjz60c+BBDX3qM2WRJCKYTdr9Mwttidj3DKBdhwxZV
         qj27p5jrtufI1EKoNdR7lrVf1g2iubuRQb8cbj81fhIiJHMr9fJWfASRVdAlnRhvyYUR
         oVKT5SvAUH5PQfURzJK8AAZNOmZ2Xs51aijyuZlUi8ASaCwBJ2DTiZT2o8pBpMMS5NJG
         sJog==
Received: by 10.52.176.66 with SMTP id cg2mr7258049vdc.121.1341340499495; Tue,
 03 Jul 2012 11:34:59 -0700 (PDT)
Received: by 10.52.65.143 with HTTP; Tue, 3 Jul 2012 11:34:59 -0700 (PDT)
In-Reply-To: <20120703180439.GC3294@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200928>

On Tue, Jul 3, 2012 at 2:04 PM, Jeff King <peff@peff.net> wrote:
> When we try to push a ref and the right-hand side of the
> refspec does not find a match, we try to create it. If it is
> not fully qualified, we try to guess where it would go in
> the refs hierarchy based on the left-hand source side. If
> the source side is not a ref, then we give up and give a
> long explanatory message.
>
> For deletions, however, this doesn't make any sense. We
> would never want to create on the remote side, and if an
> unqualified ref can't be matched, it is simply an error. The
> current code handles this already because the left-hand side
> is empty, and therefore does not give us a hint as to where
> the right-hand side should go, and we properly error out.
> Unfortunately, the error message is the long "we tried to
> qualify this, but the source side didn't let us guess"
> message, which is quite confusing.
>
> Instead, we can just be more succinct and say "we can't
> delete this because we couldn't find it". So before:
>
>   $ git push origin :bogus
>   error: unable to push to unqualified destination: bogus
>   The destination refspec neither matches an existing ref on the remote nor
>   begins with refs/, and we are unable to guess a prefix based on the source ref.
>   error: failed to push some refs to '$URL'
>
> and now:
>
>   $ git push origin :bogus
>   error: unable to delete 'bogus': remote ref does not exist
>   error: failed to push some refs to '$URL'

This error return would have made my mistake obvious.

Might want to add a paragraph to the doc saying this is how you delete
remote branches since it is not an obvious solution. I found it via
Google and a question asked on stackoverflow.com

> It is tempting to also catch a fully-qualified ref like
> "refs/heads/bogus" and generate the same error message.
> However, that currently does not error out at all, and
> instead gets sent to the remote side, which typically
> generates a warning:
>
>   $ git push origin:refs/heads/bogus
>   remote: warning: Deleting a non-existent ref.
>   To $URL
>    - [deleted]         bogus
>
> While it would be nice to catch this error early, a
> client-side error would mean aborting the push entirely and
> changing push's exit code. For example, right now you can
> do:
>
>   $ git push origin refs/heads/foo refs/heads/bar
>
> and end up in a state where "foo" and "bar" are deleted,
> whether both of them currently exist or not (and see an
> error only if we actually failed to contact the server).
> Generating an error would cause a regression for this use
> case.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> On Tue, Jul 03, 2012 at 07:42:07AM -0400, jonsmirl@gmail.com wrote:
>
>> I have the branch name wrong. It is fl.stgit not fl.stg.
>> But the error message sent me off in the wrong direction looking for an answer.
>
> I think this would help. I used "remote ref does not exist"
> because that is the simplest explanation for the user.
> However, given that we will try to push a fully qualified
> ref that does not exist, a more accurate message might
> "destination refspec did not match" or something similar.  I
> prefer the former, though, as it less arcane.
>
>  remote.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/remote.c b/remote.c
> index 6833538..04fd9ea 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1100,6 +1100,9 @@ static int match_explicit(struct ref *src, struct ref *dst,
>         case 0:
>                 if (!memcmp(dst_value, "refs/", 5))
>                         matched_dst = make_linked_ref(dst_value, dst_tail);
> +               else if (is_null_sha1(matched_src->new_sha1))
> +                       error("unable to delete '%s': remote ref does not exist",
> +                             dst_value);
>                 else if ((dst_guess = guess_ref(dst_value, matched_src)))
>                         matched_dst = make_linked_ref(dst_guess, dst_tail);
>                 else
> --
> 1.7.11.rc1.21.g3c8d91e
>



-- 
Jon Smirl
jonsmirl@gmail.com
