From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 06/18] rerere: drop want_sp parameter from is_cmarker()
Date: Sat, 18 Jul 2015 09:24:04 +0100
Organization: OPDS
Message-ID: <3AAC96959AB14E61B7711B914D963B7F@PhilipOakley>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com> <1437171880-21590-1-git-send-email-gitster@pobox.com> <1437171880-21590-7-git-send-email-gitster@pobox.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 18 10:24:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGNPn-0001RC-NN
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 10:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbbGRIYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 04:24:05 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:8141 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751080AbbGRIYC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2015 04:24:02 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BzEQDMC6pVPJkpBlxbgxNUaYc+tXcfCoVtBAEDAYEzTQEBAQEBAQcBAQEBQAE/QQODWgUBAQEBAgEIAQEdERYIAQEmBgIDBQIBAxUMJRQBBBgCBgcDFAYBBwsIAgECAwEMBIgFDAm/QI9Hi0yIJIEUBYxwh2IBgQqDZIk7jBmKZYEJcoIoPTEBgkoBAQE
X-IPAS-Result: A2BzEQDMC6pVPJkpBlxbgxNUaYc+tXcfCoVtBAEDAYEzTQEBAQEBAQcBAQEBQAE/QQODWgUBAQEBAgEIAQEdERYIAQEmBgIDBQIBAxUMJRQBBBgCBgcDFAYBBwsIAgECAwEMBIgFDAm/QI9Hi0yIJIEUBYxwh2IBgQqDZIk7jBmKZYEJcoIoPTEBgkoBAQE
X-IronPort-AV: E=Sophos;i="5.15,499,1432594800"; 
   d="scan'208";a="614366874"
Received: from host-92-6-41-153.as43234.net (HELO PhilipOakley) ([92.6.41.153])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 18 Jul 2015 09:23:59 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274157>

From: "Junio C Hamano" <gitster@pobox.com>
> As the nature of the conflict marker line determies if there should

"should be a"?
i.e. s/a /be a /    below

> a SP and label after it, the caller shouldn't have to pass the
> parameter redundantly.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> rerere.c | 27 ++++++++++++++++++++++-----
> 1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/rerere.c b/rerere.c
> index 304df02..4c45f55 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -148,8 +148,25 @@ static int rerere_file_getline(struct strbuf *sb, 
> struct rerere_io *io_)
>  return strbuf_getwholeline(sb, io->input, '\n');
> }
>
> -static int is_cmarker(char *buf, int marker_char, int marker_size, 
> int want_sp)
> +/*
> + * Require the exact number of conflict marker letters, no more, no
> + * less, followed by SP or any whitespace
> + * (including LF).
> + */
> +static int is_cmarker(char *buf, int marker_char, int marker_size)
> {
> + int want_sp;
> +
> + /*
> + * The beginning of our version and the end of their version
> + * always are labeled like "<<<<< ours" or ">>>>> theirs",
> + * hence we set want_sp for them.  Note that the version from
> + * the common ancestor in diff3-style output is not always
> + * labelled (e.g. "||||| common" is often seen but "|||||"
> + * alone is also valid), so we do not set want_sp.
> + */
> + want_sp = (marker_char == '<') || (marker_char == '>');
> +
>  while (marker_size--)
>  if (*buf++ != marker_char)
>  return 0;
> @@ -172,19 +189,19 @@ static int handle_path(unsigned char *sha1, 
> struct rerere_io *io, int marker_siz
>  git_SHA1_Init(&ctx);
>
>  while (!io->getline(&buf, io)) {
> - if (is_cmarker(buf.buf, '<', marker_size, 1)) {
> + if (is_cmarker(buf.buf, '<', marker_size)) {
>  if (hunk != RR_CONTEXT)
>  goto bad;
>  hunk = RR_SIDE_1;
> - } else if (is_cmarker(buf.buf, '|', marker_size, 0)) {
> + } else if (is_cmarker(buf.buf, '|', marker_size)) {
>  if (hunk != RR_SIDE_1)
>  goto bad;
>  hunk = RR_ORIGINAL;
> - } else if (is_cmarker(buf.buf, '=', marker_size, 0)) {
> + } else if (is_cmarker(buf.buf, '=', marker_size)) {
>  if (hunk != RR_SIDE_1 && hunk != RR_ORIGINAL)
>  goto bad;
>  hunk = RR_SIDE_2;
> - } else if (is_cmarker(buf.buf, '>', marker_size, 1)) {
> + } else if (is_cmarker(buf.buf, '>', marker_size)) {
>  if (hunk != RR_SIDE_2)
>  goto bad;
>  if (strbuf_cmp(&one, &two) > 0)
> -- 
> 2.5.0-rc2-340-g0cccc16
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
