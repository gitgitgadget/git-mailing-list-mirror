From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 19/19] signed push: fortify against replay attacks
Date: Sat, 23 Aug 2014 23:29:57 -0400
Message-ID: <CAPig+cR=V+1VhHDU5pd0W-9oSwzULZsVPybGRz7WXrmKrO4+xA@mail.gmail.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
	<1408739424-31429-20-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 05:30:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLOVR-0001BI-Pp
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 05:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbaHXD37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 23:29:59 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:65203 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbaHXD35 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 23:29:57 -0400
Received: by mail-yk0-f181.google.com with SMTP id q200so9551947ykb.40
        for <git@vger.kernel.org>; Sat, 23 Aug 2014 20:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=f9U9QRvUvsg/ZazHn89KjpcotQnwBcb0nsRNdQYj3so=;
        b=F/s6yvFKOiiTGggd5CwGbOuk4evFK5Qwpq5SdcSbS8QCSmCTPrNrP379ds0c3MQHir
         3m+XGptBTqppaGwhHKUNI/Bkuhto94n1U7gocevEPUXZs5cMjG2m7a0KNxDVnMaXH4XC
         wpvdSDjZRYiEcPx3b3vuk/mKU61rdz+8gPKD/Bpc2tidZncNnRGqvfgPB80EfsVvmaAK
         SVwglJEk1t+8ruHSo+UeJedYZfGAfx+O4rEz5V3LLSlumcLGgngfGWNQaAalAw4s0V2V
         4+TzaWsq4VD4KJHSksjDS9PQ2n3KRjrR/ugfauSJ785kR7GMyzZDttsUdrl6lgPje+js
         3e4w==
X-Received: by 10.236.83.103 with SMTP id p67mr21691457yhe.89.1408850997170;
 Sat, 23 Aug 2014 20:29:57 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Sat, 23 Aug 2014 20:29:57 -0700 (PDT)
In-Reply-To: <1408739424-31429-20-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: LeTMU1bs1pnkY4DVYYb9et5CHGU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255772>

On Fri, Aug 22, 2014 at 4:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> In order to prevent a valid push certificate for pushing into an
> repository from getting replayed to push to an unrelated one, send a
> nonce string from the receive-pack process and have the signer
> include it in the push certificate.  The original nonce is exported
> as GIT_PUSH_CERT_NONCE for the hooks to examine and match against
> the value on the "nonce" header in the certificate to notice a replay.
>
> Because the built-in nonce generation may not be suitable for all
> situations, allow the server to invoke receive-pack with pregenerated
> nonce from the command line argument.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 991e417..8ad4d9b 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1226,12 +1232,28 @@ static int delete_only(struct command *commands)
>         return 1;
>  }
>
> +static char *prepare_push_cert_nonce(const char *sitename, const char *dir)
> +{
> +       struct strbuf buf = STRBUF_INIT;
> +       unsigned char sha1[20];
> +
> +       if (!sitename) {
> +               static char buf[1024];

Potentially confusing 'buf' shadows 'buf' in outer scope.

> +               gethostname(buf, sizeof(buf));
> +               sitename = buf;
> +       }
> +       strbuf_addf(&buf, "%s:%s:%lu", sitename, dir, time(NULL));
> +       hash_sha1_file(buf.buf, buf.len, "blob", sha1);

strbuf_release(&buf);

> +       return xstrdup(sha1_to_hex(sha1));
> +}
> +
>  int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  {
>         int advertise_refs = 0;
>         int stateless_rpc = 0;
>         int i;
>         const char *dir = NULL;
> +       const char *sitename = NULL;
>         struct command *commands;
>         struct sha1_array shallow = SHA1_ARRAY_INIT;
>         struct sha1_array ref = SHA1_ARRAY_INIT;
> @@ -1261,6 +1283,13 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>                                 fix_thin = 0;
>                                 continue;
>                         }
> +                       if (skip_prefix(arg, "--sitename=", &sitename)) {
> +                               continue;
> +                       }
> +                       if (skip_prefix(arg, "--push-cert-nonce=", &push_cert_nonce)) {
> +                               push_cert_nonce = xstrdup(push_cert_nonce);
> +                               continue;
> +                       }
>
>                         usage(receive_pack_usage);
>                 }
> @@ -1277,6 +1306,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>                 die("'%s' does not appear to be a git repository", dir);
>
>         git_config(receive_pack_config, NULL);
> +       if (!push_cert_nonce)
> +               push_cert_nonce = prepare_push_cert_nonce(sitename, dir);
>
>         if (0 <= transfer_unpack_limit)
>                 unpack_limit = transfer_unpack_limit;
> @@ -1321,5 +1352,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>                 packet_flush(1);
>         sha1_array_clear(&shallow);
>         sha1_array_clear(&ref);
> +       free((void *)push_cert_nonce);
>         return 0;
>  }
> diff --git a/send-pack.c b/send-pack.c
> index 61f321d..349393a 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -228,7 +228,8 @@ static const char *next_line(const char *line, size_t len)
>  static int generate_push_cert(struct strbuf *req_buf,
>                               const struct ref *remote_refs,
>                               struct send_pack_args *args,
> -                             const char *cap_string)
> +                             const char *cap_string,
> +                             const char *push_cert_nonce)
>  {
>         const struct ref *ref;
>         char stamp[60];
> @@ -240,6 +241,8 @@ static int generate_push_cert(struct strbuf *req_buf,
>         datestamp(stamp, sizeof(stamp));
>         strbuf_addf(&cert, "certificate version 0.1\n");
>         strbuf_addf(&cert, "pusher %s %s\n", signing_key, stamp);
> +       if (push_cert_nonce[0])
> +               strbuf_addf(&cert, "nonce %s\n", push_cert_nonce);
>         strbuf_addstr(&cert, "\n");
>
>         for (ref = remote_refs; ref; ref = ref->next) {
> @@ -290,6 +293,8 @@ int send_pack(struct send_pack_args *args,
>         unsigned cmds_sent = 0;
>         int ret;
>         struct async demux;
> +       const char *push_cert_nonce = NULL;
> +
>
>         /* Does the other end support the reporting? */
>         if (server_supports("report-status"))
> @@ -306,8 +311,14 @@ int send_pack(struct send_pack_args *args,
>                 agent_supported = 1;
>         if (server_supports("no-thin"))
>                 args->use_thin_pack = 0;
> -       if (args->push_cert && !server_supports("push-cert"))
> -               die(_("the receiving end does not support --signed push"));
> +       if (args->push_cert) {
> +               int len;
> +
> +               push_cert_nonce = server_feature_value("push-cert", &len);
> +               if (!push_cert_nonce)
> +                       die(_("the receiving end does not support --signed push"));
> +               push_cert_nonce = xmemdupz(push_cert_nonce, len);
> +       }
>
>         if (!remote_refs) {
>                 fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
> @@ -338,7 +349,7 @@ int send_pack(struct send_pack_args *args,
>
>         if (!args->dry_run && args->push_cert)
>                 cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
> -                                              cap_buf.buf);
> +                                              cap_buf.buf, push_cert_nonce);
>
>         /*
>          * Clear the status for each ref and see if we need to send
> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
> index 659bca0..6db59ce 100755
> --- a/t/t5534-push-signed.sh
> +++ b/t/t5534-push-signed.sh
> @@ -58,17 +58,22 @@ test_expect_success GPG 'signed push sends push certificate' '
>         SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
>         KEY=${GIT_PUSH_CERT_KEY-nokey}
>         STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
> +       NONCE=${GIT_PUSH_CERT_NONCE-nononce}
>         E_O_F
>
>         EOF
>
> -       cat >expect <<-\EOF &&
> -       SIGNER=C O Mitter <committer@example.com>
> -       KEY=13B6F51ECDDE430D
> -       STATUS=G
> -       EOF
> -
>         git push --signed dst noop ff +noff &&
> +
> +       (
> +               cat <<-\EOF &&
> +               SIGNER=C O Mitter <committer@example.com>
> +               KEY=13B6F51ECDDE430D
> +               STATUS=G
> +               EOF
> +               sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
> +       ) >expect &&
> +
>         grep "$(git rev-parse noop ff) refs/heads/ff" dst/push-cert &&
>         grep "$(git rev-parse noop noff) refs/heads/noff" dst/push-cert &&
>         test_cmp expect dst/push-cert-status
> --
> 2.1.0-304-g950f846
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
