From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 3/5] fast-import: clean up pack_data pointer in end_packfile
Date: Mon, 25 Aug 2014 10:16:52 -0700
Message-ID: <CAL=YDWmC9ncuH=fLR=8PWuB=kJeRP-O3K9MCKGaDfoxF6WWb8A@mail.gmail.com>
References: <20140823052334.GA17813@peff.net>
	<20140823052741.GC18075@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 19:16:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLxt4-00016g-2b
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 19:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932984AbaHYRQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 13:16:54 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:41938 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaHYRQx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 13:16:53 -0400
Received: by mail-vc0-f178.google.com with SMTP id la4so15790003vcb.9
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vM/ouew2Y3LkUy7/JDRjzq8om5rFvtiT8L3HO2okOqw=;
        b=lIEgr7AnGxV3YPDFxYEcjMj1QPYUTYmPcKlcDc7naMJnx/e8SIR+JglcTrsEFcxsuZ
         yKUHEPrD0IaqDNZzPUGX0zGO0IZM8BWTttlYLPia8RY0AJE76Ey/1AWypcDDSU0PH2pT
         8oAKUZjQAG7ceWRQs04tcN4qIiPFeiVP3u67xBqQ2z5UCa0zwHSY2RcrrVfJySVOKRvn
         Dgtuq24056b1FTET9HuUZrv0dR6gvQnGo5MsauV25Ehz/yVGY7YW9iJdo3k627kgL2iS
         Dy06VwpEPdCJXKBket8oL0d0zKehPslm1km0bvpNNIv3a2boua7e34AjrbMKPXYNKLu3
         Ygxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vM/ouew2Y3LkUy7/JDRjzq8om5rFvtiT8L3HO2okOqw=;
        b=E7sPc9scISCFgEhs08NXZjZSsYABDK7/SY/9bYqTZcouzxFvjQYxVgfOiN99bWPM31
         OUgyF8o7Bj5itxYoQnRivzx8JHpvEWtyXNIKB4DqL6zYQzzSfhV7xneYstSXPwUzOfzJ
         D1j/dGq/ZH5ImgHfuIq5BO2djPeuvyaw9Of9+wtAjQYGozvtKA6xW9HYjDKq0xCrZ4T7
         8gtGpSn5NIm3d8Q7r53L97ic25t8npyNlLgyMpDJtXcFgGCKqkONJfXMi3aTKBFyPp8F
         oL/dT6NEziVyExIS7RWE4dSxmm9vrM+sDVcAI3Nm+t3H0VnpkyIdsL5VX/ngW5L1xaTK
         4sXA==
X-Gm-Message-State: ALoCoQlr9ugSzaLGneGZX6h11/g2F8pu4pIEGXzJQzTHkMj9+zSUyS+dfTtlQL63RKG/Ffv+Tl6G
X-Received: by 10.52.30.2 with SMTP id o2mr16789735vdh.12.1408987012760; Mon,
 25 Aug 2014 10:16:52 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Mon, 25 Aug 2014 10:16:52 -0700 (PDT)
In-Reply-To: <20140823052741.GC18075@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255837>

Print an error before returning when pack_data is NULL ?

Otherwise, LGTM

On Fri, Aug 22, 2014 at 10:27 PM, Jeff King <peff@peff.net> wrote:
> We have a global pointer pack_data pointing to the current
> pack we have open. Inside end_packfile we have two new
> pointers, old_p and new_p. The latter points to pack_data,
> and the former points to the new "installed" version of the
> packfile we get when we hand the file off to the regular
> sha1_file machinery. When then free old_p.
>
> Presumably the extra old_p pointer was there so that we
> could overwrite pack_data with new_p and still free old_p,
> but we don't do that. We just leave pack_data pointing to
> bogus memory, and don't overwrite it until we call
> start_packfile again (if ever).
>
> This can cause problems for our die routine, which calls
> end_packfile to clean things up. If we die at the wrong
> moment, we can end up looking at invalid memory in
> pack_data left after the last end_packfile().
>
> Instead, let's make sure we set pack_data to NULL after we
> free it, and make calling endfile() again with a NULL
> pack_data a noop (there is nothing to end).
>
> We can further make things less confusing by dropping old_p
> entirely, and moving new_p closer to its point of use.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Noticed while running fast-import under valgrind to debug the next
> commit. :)
>
>  fast-import.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index d73f58c..f25a4ae 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -946,10 +946,12 @@ static void unkeep_all_packs(void)
>
>  static void end_packfile(void)
>  {
> -       struct packed_git *old_p = pack_data, *new_p;
> +       if (!pack_data)
> +               return;
>
>         clear_delta_base_cache();
>         if (object_count) {
> +               struct packed_git *new_p;
>                 unsigned char cur_pack_sha1[20];
>                 char *idx_name;
>                 int i;
> @@ -991,10 +993,11 @@ static void end_packfile(void)
>                 pack_id++;
>         }
>         else {
> -               close(old_p->pack_fd);
> -               unlink_or_warn(old_p->pack_name);
> +               close(pack_data->pack_fd);
> +               unlink_or_warn(pack_data->pack_name);
>         }
> -       free(old_p);
> +       free(pack_data);
> +       pack_data = NULL;
>
>         /* We can't carry a delta across packfiles. */
>         strbuf_release(&last_blob.data);
> --
> 2.1.0.346.ga0367b9
>
