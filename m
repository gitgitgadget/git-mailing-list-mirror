From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/GSoC/RFC] fetch: git fetch --deepen
Date: Sat, 14 Mar 2015 17:56:31 +0700
Message-ID: <CACsJy8AAsAO6gjWg0nsdiOXFEsZ4583pH9mkUx1Js3Yop5KHHQ@mail.gmail.com>
References: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dongcan Jiang <dongcan.jiang@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 11:57:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWjkj-00070H-BJ
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 11:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbbCNK5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 06:57:05 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33491 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbbCNK5D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 06:57:03 -0400
Received: by iecvj10 with SMTP id vj10so133913609iec.0
        for <git@vger.kernel.org>; Sat, 14 Mar 2015 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DK7YH3mivKCU5uy9iG6LN1iaj1RapUzm/rkGKLYIakI=;
        b=eoOOiyQ+JVCF0NtiGUIzfb8tT9nnn6znJs9QF+4+OhJbYnY696T825TkdgKIE+h6ce
         ugRJnaXryJQpQZGRJjygCZATjOGC+uwZtI+1JKFanWDnyRI4Lntm49we+j6OfSscwEGv
         sj8LAejWRntedXAlhKYjKv3WgoM0nM4RtmoVvvqp7mOMJNmgPjKtaF5Dpdh7x0ZZM/LM
         FTxOgGSItmhhLgDMoEptys4Pq9rmuUjbINIBzfBah0n5mk5bLNCiNEah3oxPBgF3gF88
         86eus6mM91iT8pjHSti1Nvk9fbBNlnbAVQF3UypfZj5mIr30BlQ9X1swsMKv/pAxsYdL
         msZQ==
X-Received: by 10.42.110.10 with SMTP id n10mr64403418icp.65.1426330621580;
 Sat, 14 Mar 2015 03:57:01 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Sat, 14 Mar 2015 03:56:31 -0700 (PDT)
In-Reply-To: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265443>

On Fri, Mar 13, 2015 at 8:04 PM, Dongcan Jiang <dongcan.jiang@gmail.com> wrote:
> @@ -317,7 +318,7 @@ static int find_common(struct fetch_pack_args *args,
>         if (is_repository_shallow())
>                 write_shallow_commits(&req_buf, 1, NULL);
>         if (args->depth > 0)
> -               packet_buf_write(&req_buf, "deepen %d", args->depth);
> +               packet_buf_write(&req_buf, "depth %d", args->depth);
>         packet_buf_flush(&req_buf);
>         state_len = req_buf.len;

Junio already questioned about your replacing starts_with("deepen "..)
with starts_with("depth "..), this is part of that question. If you
run "make test" you should find some breakages, or we need to improve
our test suite.

I think you just need to keep the old "if (args->depth > 0) send
"depth" unchanged and add two new statements that check
args->depth_deepen and sends "depth ". BTW, I think "deepen-more" or
"deepen-relative" would be better than "depth" (*), which is a noun.
But that's a minor point at this stage.

And because --depth and --deepen are mutually exclusive, you need to
make sure that the user must not specify that. The "user" includes the
"client" from the server perspective, we need to make sure that
upload-pack barf if some client sends both "deepen" and "depth".

(*) I was about to suggest you use "deepen" for both --depth and
--deepen: --depth sends "deepen NUM" while --deepen sends "deepen
+NUM". The protocol as described in pack-protocol.txt may allow this
extension. Unfortunately the current implementation is too relaxed. We
use strtol() to parse "NUM" and it would accept the leading "+"
instead of barfing out. So old clients would mistakes --deepen as
--depth, not good. And it even accepts base 8 and 16!! We should fix
this.
-- 
Duy
