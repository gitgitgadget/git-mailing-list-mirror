From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in
 pack directory
Date: Thu, 13 Aug 2015 14:46:10 -0400
Message-ID: <CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
References: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
	<1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 20:46:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxW5-0006HU-1Z
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 20:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbbHMSqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 14:46:12 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:34431 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbbHMSqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 14:46:11 -0400
Received: by ykdt205 with SMTP id t205so49374251ykd.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FpdeAhdCdLBnOTlwRTnRih1RL++DeFszkEcqwjZXENU=;
        b=xy5aUvG8v7SlLLiZ2744WJPwHJ+hcSasq0OvAlXear3ROYnvn3KrO3Ra3vGY6b9dCY
         oBO7/egTFYZZ2vGM33R3sy133pJsuTVyn+rXg9IO4wlMfBiUoSWm8TYTUlUpUMl/EaDA
         sz/amC6ltfLrVn3FtT3D5lZ22pgWf+miULRW38uplsiA4wiTnuxyqGR5zksDyZX4o5mP
         sT21fBrxW3LcU6GEVSKmfR5CtN6M2Desh41ATHdk93EfrIlZifIedw6qsOSlvt8lOI2Z
         zRV7P1+MYV+cQb8jXudVRc8MWACoFjEfxSIecrQV/NV4xbHnNe40ovAJOX+QpcsJc+0D
         V3DA==
X-Received: by 10.170.233.10 with SMTP id z10mr40271463ykf.71.1439491570626;
 Thu, 13 Aug 2015 11:46:10 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Thu, 13 Aug 2015 11:46:10 -0700 (PDT)
In-Reply-To: <1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
X-Google-Sender-Auth: TRyOWHbY8swG40z4FRBdnQSEbaU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275874>

On Thu, Aug 13, 2015 at 2:02 PM, Doug Kelly <dougk.ff7@gmail.com> wrote:
> From: Junio C Hamano <gitster@pobox.com>
>
> The hook to report "garbage" files in $GIT_OBJECT_DIRECTORY/pack/
> could be generic but is too specific to count-object's needs.
>
> Move the part to produce human-readable messages to count-objects,
> and refine the interface to callback with the "bits" with values
> defined in the cache.h header file, so that other callers (e.g.
> prune) can later use the same mechanism to enumerate different
> kinds of garbage files and do something intelligent about them,
> other than reporting in textual messages.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Since you're forwarding Junio's patch, you'd also want to sign-off
(following his).

> ---
> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> index ad0c799..4c3198e 100644
> --- a/builtin/count-objects.c
> +++ b/builtin/count-objects.c
> @@ -15,9 +15,31 @@ static int verbose;
>  static unsigned long loose, packed, packed_loose;
>  static off_t loose_size;
>
> -static void real_report_garbage(const char *desc, const char *path)
> +const char *bits_to_msg(unsigned seen_bits)

If you don't expect other callers outside this file, then this should
be declared 'static'. If you do expect future external callers, then
this should be declared in a public header file (but renamed to be
more meaningful).

> +{
> +       switch (seen_bits) {
> +       case 0:
> +               return "no corresponding .idx or .pack";
> +       case PACKDIR_FILE_GARBAGE:
> +               return "garbage found";
> +       case PACKDIR_FILE_PACK:
> +               return "no corresponding .idx";
> +       case PACKDIR_FILE_IDX:
> +               return "no corresponding .pack";
> +       case PACKDIR_FILE_PACK|PACKDIR_FILE_IDX:
> +       default:
> +               return NULL;
> +       }
> +}
