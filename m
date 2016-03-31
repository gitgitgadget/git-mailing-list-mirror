From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCHv2 3/4] bundle: don't leak an fd in case of early return
Date: Thu, 31 Mar 2016 20:00:42 +0100
Organization: OPDS
Message-ID: <9C112693D94545DC917C90299E52A719@PhilipOakley>
References: <1459357518-14913-1-git-send-email-sbeller@google.com> <1459357518-14913-4-git-send-email-sbeller@google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Stefan Beller" <sbeller@google.com>
To: "Stefan Beller" <sbeller@google.com>, <sunshine@sunshineco.com>,
	<peff@peff.net>, <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:00:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alhpq-0001F9-Dh
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 21:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758205AbcCaTAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 15:00:45 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:28302 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758039AbcCaTAn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 15:00:43 -0400
Received: from PhilipOakley ([2.96.204.202])
	by smtp.talktalk.net with SMTP
	id lhpgaqPRXEnBtlhpgaPPbo; Thu, 31 Mar 2016 20:00:42 +0100
X-Originating-IP: [2.96.204.202]
X-Spam: 0
X-OAuthority: v=2.1 cv=YNU/sUyx c=1 sm=1 tr=0 a=nBDDDTVn/lToA/VoCIgfnQ==:117
 a=nBDDDTVn/lToA/VoCIgfnQ==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=8nJEP1OIZ-IA:10 a=1XWaLZrsAAAA:8 a=PKzvZo6CAAAA:8
 a=VwQbUJbxAAAA:8 a=mqGYI0lc6r5IGZj92mAA:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfHFamV+Pvq59brHP4d8WCJh2AUwaxgClWUZ1JXZXZFW0H9+UtHkAHK+VkQ1QC1nYPFJooutpPL5emEuZxBoACrnoESNjqjCmHq98IALHp9TsTWYxfuHC
 9VRtLOdVBqa4RrHJo5sey8Wi8IRaKkVodxxzGlEXTKiPJhMX+NgF1NCY2LS9FJCgK7SBqzejR3Xmfq7nWhb1cB2HLF7SP9R6fn7QdH9x1xVNwdB0Xcy/lOhk
 93SUXN0Cfl+sZ3EFq7gY4S0qgWLI+PUWyJDkjvWq2Kwl9zq4mfoXWgiNBcffnHleNOwVnmYxjwVX2MhOqDuLmA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290448>

From: "Stefan Beller" <sbeller@google.com>
> In successful operation `write_pack_data` will close the `bundle_fd`,
> but when we exit early, we need to take care of the file descriptor
> as well as the lock file ourselves. The lock file may be deleted at the
> end of running the program, but we are in library code, so we should
> not rely on that.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Stefan Beller <sbeller@google.com>

Has this been tested on Windows? I had a similar problem very recently
https://groups.google.com/forum/#!msg/git-for-windows/6LPxf9xZKhI/-s7XD18yCwAJ
where a bad rev-list-arg would cause the `bundle create` to die, and, on 
windows, leave the incomplete bundle file locked.

dscho suggested one possible solution for that, but I haven't had any time 
to try any patches.

> ---
> bundle.c | 23 +++++++++++++++++------
> 1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index 506ac49..fbc8593 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -407,6 +407,7 @@ int create_bundle(struct bundle_header *header, const 
> char *path,
>  int bundle_to_stdout;
>  int ref_count = 0;
>  struct rev_info revs;
> + int ret = -1;
>
>  bundle_to_stdout = !strcmp(path, "-");
>  if (bundle_to_stdout)
> @@ -435,30 +436,40 @@ int create_bundle(struct bundle_header *header, 
> const char *path,
>
>  /* write prerequisites */
>  if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
> - return -1;
> + goto err;
>
>  argc = setup_revisions(argc, argv, &revs, NULL);
>
> - if (argc > 1)
> - return error(_("unrecognized argument: %s"), argv[1]);
> + if (argc > 1) {
> + ret = error(_("unrecognized argument: %s"), argv[1]);
> + goto err;
> + }
>
>  object_array_remove_duplicates(&revs.pending);
>
>  ref_count = write_bundle_refs(bundle_fd, &revs);
>  if (!ref_count)
>  die(_("Refusing to create empty bundle."));
> - else if (ref_count < 0)
> - return -1;
> + else if (ref_count < 0) {
> + if (!bundle_to_stdout)
> + close(bundle_fd);
> + goto err;
> + }
>
>  /* write pack */
>  if (write_pack_data(bundle_fd, &revs))
> - return -1;
> + goto err;
>
>  if (!bundle_to_stdout) {
>  if (commit_lock_file(&lock))
>  die_errno(_("cannot create '%s'"), path);
>  }
>  return 0;
> +err:
> + if (!bundle_to_stdout)
> + close(bundle_fd);
> + rollback_lock_file(&lock);
> + return ret;
> }
>
> int unbundle(struct bundle_header *header, int bundle_fd, int flags)
> -- 
> 2.8.0.2.gb331331
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
