From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: don't show Done with --quiet --porcelain
Date: Tue, 01 Sep 2015 10:13:20 -0700
Message-ID: <xmqqvbburrkf.fsf@gitster.mtv.corp.google.com>
References: <CA+WR+g7frN4uV12dxahxZbr-5az7sj3zx2oN-Z3rKH0_Y8jqqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, "Larry D'Anna" <larry@elder-gods.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Josh Rabinowitz <joshr@joshr.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 19:13:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWp7h-0000EK-AT
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 19:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbbIARNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 13:13:25 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35257 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbbIARNY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 13:13:24 -0400
Received: by pacfv12 with SMTP id fv12so1824309pac.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=suj4Ir1a27Kb0XbkJvsRiZ6IFAYkpPI96uhwWYtaWJM=;
        b=TJWp7gimI68CDKZZkvc2PYQNHkCEPavpi6oJsuUp7srt/mkiXWddzd9KZSphWK5aQu
         lROEMxO2/L8qXQ66ohShvy1JvwrV9lWaHx3iCA3nZesD4NKaLDtzLjEG6F5tqCTGtExK
         89ILkmxGJFI7Zt6JX2cLhFVMW+jmcv5NJdZsBIQuLy95THHScpJPiwNwhq+KG6MYkgnM
         6Sjt9+S5wzmwG0uts3+ObkknKhpVFOY+44oHR7BQqdrL4oI8xmC06N0xyfj63MZOmmWL
         yjNeY2djL8iJegkFBGXsUR7Hw8gkpGozY7g0VUv/P7YCQP0ViLA8guxeOSKvrQlRfMie
         fVSQ==
X-Received: by 10.68.189.161 with SMTP id gj1mr49065917pbc.4.1441127602122;
        Tue, 01 Sep 2015 10:13:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id p3sm18818787pdf.3.2015.09.01.10.13.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 10:13:21 -0700 (PDT)
In-Reply-To: <CA+WR+g7frN4uV12dxahxZbr-5az7sj3zx2oN-Z3rKH0_Y8jqqg@mail.gmail.com>
	(Josh Rabinowitz's message of "Mon, 31 Aug 2015 12:40:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276994>

Josh Rabinowitz <joshr@joshr.com> writes:

> Change so 'git push --porcelain --quiet' emits no text when there
> is no error.  This makes the --quiet option here more consistent with
> other git commands.
>
> Signed-off-by: josh rabinowitz <joshr@joshr.com>
> ---

The rationale given in 77555854 (git-push: make git push --porcelain
print "Done", 2010-02-26) does not apply when "--quiet" is in use,
because we do give the rejection notice to the standard output even
under "--quiet", so the calling script can tell between the case
where we couldn't reach the remote side (i.e. no rejection notice)
and the case where we reached them and they rejected (i.e. they will
tell us why the push was rejected) when "git push" reports a failure
with its exit status.

For that matter, I am not sure if this "Done" introduced by 77555854
is really needed even when "--quiet" is not in effect.

In either case, saying "Done" after talking to the remote end
already is an established part of the output meant for Porcelain
when "--porcelain" option is in use.  So I do not think changing it
is a good idea.  Existing scripts that read from "--porcelain" output
would be expecting the line to be there.

>  transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/transport.c b/transport.c
> index 40692f8..0021b3f 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1209,7 +1209,7 @@ int transport_push(struct transport *transport,
>                 transport_update_tracking_ref(transport->remote, ref, verbose);
>         }
>
> -       if (porcelain && !push_ret)
> +       if (!quiet && porcelain && !push_ret)
>             puts("Done");
>         else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
>             fprintf(stderr, "Everything up-to-date\n");
> --
> 2.3.2 (Apple Git-55)
