From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 6/6] format-patch --notes: show notes after three-dashes
Date: Thu, 18 Oct 2012 22:35:25 +0100
Organization: OPDS
Message-ID: <C2D3CE0879B345FFAC2A6487760B5378@PhilipOakley>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com> <1350539128-21577-7-git-send-email-gitster@pobox.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 23:35:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOxkR-0003yv-0F
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 23:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106Ab2JRVfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 17:35:09 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:63970 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755799Ab2JRVfI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2012 17:35:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuMKAAl1gFBcGnoN/2dsb2JhbABFi1GzdAQBA4EFgQmCGwUBAQUIAQEdEREFCAEBLAIDBQIBAxQBDCUUAQQYAgYHFwYBBwsIAgECAwEMBIdnB71XjBI2AYRxYAOII4VEiRmPH4Jw
X-IronPort-AV: E=Sophos;i="4.80,609,1344207600"; 
   d="scan'208";a="396927093"
Received: from host-92-26-122-13.as13285.net (HELO PhilipOakley) ([92.26.122.13])
  by out1.ip05ir2.opaltelecom.net with SMTP; 18 Oct 2012 22:35:06 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208022>

From: "Junio C Hamano" <gitster@pobox.com>
> When inserting the note after the commit log message to format-patch
> output, add three dashes before the note.  Record the fact that we
> did so in the rev_info and omit showing duplicated three dashes in
> the usual codepath that is used when notes are not being shown.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Should this also include a documentation update to make this substantive 
benefit visible, whether that be in the format-patch man pages, the 
SubmittingPatches guide, in the git-notes description of 'A typical 
use...', or even in the user-manual?

Do you have a preference?

> ---
> log-tree.c              | 15 +++++++++++----
> revision.h              |  1 +
> t/t4014-format-patch.sh |  7 +++++--
> 3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index 4390b11..712a22b 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -677,8 +677,13 @@ void show_log(struct rev_info *opt)
>  append_signoff(&msgbuf, opt->add_signoff);
>
>  if ((ctx.fmt != CMIT_FMT_USERFORMAT) &&
> -     ctx.notes_message && *ctx.notes_message)
> +     ctx.notes_message && *ctx.notes_message) {
> + if (ctx.fmt == CMIT_FMT_EMAIL) {
> + strbuf_addstr(&msgbuf, "---\n");
> + opt->shown_dashes = 1;
> + }
>  strbuf_addstr(&msgbuf, ctx.notes_message);
> + }
>
>  if (opt->show_log_size) {
>  printf("log size %i\n", (int)msgbuf.len);
> @@ -710,6 +715,7 @@ void show_log(struct rev_info *opt)
>
> int log_tree_diff_flush(struct rev_info *opt)
> {
> + opt->shown_dashes = 0;
>  diffcore_std(&opt->diffopt);
>
>  if (diff_queue_is_empty()) {
> @@ -737,10 +743,11 @@ int log_tree_diff_flush(struct rev_info *opt)
>  opt->diffopt.output_prefix_data);
>  fwrite(msg->buf, msg->len, 1, stdout);
>  }
> - if ((pch & opt->diffopt.output_format) == pch) {
> - printf("---");
> + if (!opt->shown_dashes) {
> + if ((pch & opt->diffopt.output_format) == pch)
> + printf("---");
> + putchar('\n');
>  }
> - putchar('\n');
>  }
>  }
>  diff_flush(&opt->diffopt);
> diff --git a/revision.h b/revision.h
> index a95bd0b..059bfff 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -111,6 +111,7 @@ struct rev_info {
>
>  /* Format info */
>  unsigned int shown_one:1,
> + shown_dashes:1,
>  show_merge:1,
>  show_notes:1,
>  show_notes_given:1,
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index bea6381..9750ba6 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -623,9 +623,12 @@ test_expect_success 'format-patch --signoff' '
> test_expect_success 'format-patch --notes --signoff' '
>  git notes --ref test add -m "test message" HEAD &&
>  git format-patch -1 --signoff --stdout --notes=test >out &&
> - # Notes message must come after S-o-b
> + # Three dashes must come after S-o-b
>  ! sed "/^Signed-off-by: /q" out | grep "test message" &&
> - sed "1,/^Signed-off-by: /d" out | grep "test message"
> + sed "1,/^Signed-off-by: /d" out | grep "test message" &&
> + # Notes message must come after three dashes
> + ! sed "/^---$/q" out | grep "test message" &&
> + sed "1,/^---$/d" out | grep "test message"
> '
>
> echo "fatal: --name-only does not make sense" > expect.name-only
> -- 
> 1.8.0.rc3.112.gdb88a5e
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2013.0.2741 / Virus Database: 2614/5837 - Release Date: 
> 10/17/12
> 
