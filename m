From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] upload-pack: Prepare to extend allow-tip-sha1-in-want
Date: Tue, 12 May 2015 17:37:54 -0400
Message-ID: <CAPig+cQ8Ndf791b0g+UGZcVsP75Nsd9TQBiUgXv9fhuE+9P4-w@mail.gmail.com>
References: <xmqqy4l1sblq.fsf@gitster.dls.corp.google.com>
	<1431465265-18486-1-git-send-email-fredrik.medley@gmail.com>
	<1431465265-18486-2-git-send-email-fredrik.medley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 23:38:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsHsG-0004Sq-16
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbbELVh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:37:56 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35805 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771AbbELVhz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:37:55 -0400
Received: by igbyr2 with SMTP id yr2so121501676igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=krVrKNkWnEqwMqWILh2AR0/M9GDL4qXCZltb8HcuefE=;
        b=RU2wlXOn+LdF2v2hij7Ws+Mm5pfgvKj6IX+NXy35Nw8oSp7A4YtmTC67Q2T2a5xMSL
         HjJzuOpsasGquVJyWsKiJ/qvnMRQ5Os1wTNaE7IMMPRjQz1PQEkRJD5An+uOvCGpKY1Q
         UqyHpbMt0vhku4aa+Z6IKKsCxDOzHz4vjkj1kVJWapaE7aXcTpiOl9M7rPzHKzs+h9qa
         ejC3rAPdeIgJ3hB02D/KTZrYRCbXFkf8WBKj+WLKurDbr5Px/YMqrzCsACmvv7EqPq2P
         U4VQXQ7ae6YAAaZa4nGlsYYCeM3NR8XxoITaI//hiv8UjWGlNr/YsEyGfN9rPiVMDhHb
         8/1A==
X-Received: by 10.50.85.43 with SMTP id e11mr23763890igz.15.1431466674675;
 Tue, 12 May 2015 14:37:54 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 12 May 2015 14:37:54 -0700 (PDT)
In-Reply-To: <1431465265-18486-2-git-send-email-fredrik.medley@gmail.com>
X-Google-Sender-Auth: C0XC-McDz2-aMcGtTnW7mZKjMvE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268893>

On Tue, May 12, 2015 at 5:14 PM, Fredrik Medley
<fredrik.medley@gmail.com> wrote:
> Rename the allow_tip_sha1_in_want variable to
> allow_request_with_bare_object_name to allow for future extensions, e.g.
> allowing non-tip sha1.

'allow_request_with_bare_object_name' is quite a mouthful. Does it
need to be this long?

Regarding the commit message: Isn't this preparatory step really about
changing the variable from a simple boolean to a "flag"-style so that
it can hold bits for multiple options? Perhaps the commit message
should mention something about that?

Missing sign-off.

More below.

> ---
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 48526aa..77174f9 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -43,7 +43,10 @@ static int marked;
>  #define MAX_IN_VAIN 256
>
>  static struct prio_queue rev_list = { compare_commits_by_commit_date };
> -static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want;
> +static int non_common_revs, multi_ack, use_sideband;
> +/* Allow specifying sha1 if it is a ref tip. */
> +#define ALLOW_TIP      01
> +static int allow_request_with_bare_object_name;
>
>  static void rev_list_push(struct commit *commit, int mark)
>  {
> @@ -542,7 +545,7 @@ static void filter_refs(struct fetch_pack_args *args,
>         }
>
>         /* Append unmatched requests to the list */
> -       if (allow_tip_sha1_in_want) {
> +       if (allow_request_with_bare_object_name & ALLOW_TIP) {

Some compilers are going to warn about this (warning: did you mean
"&&" rather than "&"?). Wrap it in an extra set of parentheses to
avoid the warning.

>                 for (i = 0; i < nr_sought; i++) {
>                         unsigned char sha1[20];
>
> @@ -821,7 +824,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>         if (server_supports("allow-tip-sha1-in-want")) {
>                 if (args->verbose)
>                         fprintf(stderr, "Server supports allow-tip-sha1-in-want\n");
> -               allow_tip_sha1_in_want = 1;
> +               allow_request_with_bare_object_name |= ALLOW_TIP;
>         }
>         if (!server_supports("thin-pack"))
>                 args->use_thin_pack = 0;
> diff --git a/upload-pack.c b/upload-pack.c
> index aa84576..708a502 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -35,7 +35,9 @@ static int multi_ack;
>  static int no_done;
>  static int use_thin_pack, use_ofs_delta, use_include_tag;
>  static int no_progress, daemon_mode;
> -static int allow_tip_sha1_in_want;
> +/* Allow specifying sha1 if it is a ref tip. */
> +#define ALLOW_TIP      01
> +static int allow_request_with_bare_object_name;
>  static int shallow_nr;
>  static struct object_array have_obj;
>  static struct object_array want_obj;
> @@ -442,8 +444,8 @@ static int get_common_commits(void)
>
>  static int is_our_ref(struct object *o)
>  {
> -       return o->flags &
> -               ((allow_tip_sha1_in_want ? HIDDEN_REF : 0) | OUR_REF);
> +       int allow_hidden_ref = (allow_request_with_bare_object_name & ALLOW_TIP);
> +       return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
>  }
>
>  static void check_non_tip(void)
> @@ -727,7 +729,8 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
>                 packet_write(1, "%s %s%c%s%s%s%s agent=%s\n",
>                              sha1_to_hex(sha1), refname_nons,
>                              0, capabilities,
> -                            allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
> +                            (allow_request_with_bare_object_name & ALLOW_TIP) ?
> +                                    " allow-tip-sha1-in-want" : "",
>                              stateless_rpc ? " no-done" : "",
>                              symref_info.buf,
>                              git_user_agent_sanitized());
> @@ -787,9 +790,10 @@ static void upload_pack(void)
>
>  static int upload_pack_config(const char *var, const char *value, void *unused)
>  {
> -       if (!strcmp("uploadpack.allowtipsha1inwant", var))
> -               allow_tip_sha1_in_want = git_config_bool(var, value);
> -       else if (!strcmp("uploadpack.keepalive", var)) {
> +       if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
> +               if (git_config_bool(var, value))
> +                       allow_request_with_bare_object_name |= ALLOW_TIP;
> +       } else if (!strcmp("uploadpack.keepalive", var)) {
>                 keepalive = git_config_int(var, value);
>                 if (!keepalive)
>                         keepalive = -1;
> --
> 1.9.1
