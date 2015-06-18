From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v3 06/31] am: detect mbox patches
Date: Thu, 18 Jun 2015 14:02:10 -0700
Message-ID: <xmqqy4jgd92l.fsf@gitster.dls.corp.google.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-7-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 23:02:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5gx0-0000W9-2X
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 23:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbbFRVCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 17:02:14 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35562 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbbFRVCN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 17:02:13 -0400
Received: by igbzc4 with SMTP id zc4so690968igb.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 14:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=J5+xtQW5tnApqOSmPSvwkle1SJOObqNfb54lMirvOmI=;
        b=FZvMrop6lwkKu+eALUb7F4EKDLm7d7pdX6h0g0wA6fwyzCnZJ7wtpvOg+ZexEBWtWD
         COpb48tSrDyb1Vpar+jlVThmyvnla4ka87WCEpMz3/pXDXizH6/QkADE8lC9SW04LsfZ
         R9JrN+4DRtojvTS72JUPd7zwW6raQ44rshmYuZgUgngAHy+OWKQmfrh1RsjDJahwmHUi
         1rMwyy/1WO2x3Odi5UWvFjRs+1gn5vG+gPGXcTxbs6O+CaTBx8HEqiJVWqUlfJtvCeCa
         G9tukOV/4joHglpNc+pkc/ZiAXp2KgViCrXyvQmBDXv+/ndyk050T+JWIK7DioCJU/HF
         OpBw==
X-Received: by 10.43.162.136 with SMTP id mk8mr7944752icc.28.1434661332268;
        Thu, 18 Jun 2015 14:02:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id p39sm5671911ioi.5.2015.06.18.14.02.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 14:02:11 -0700 (PDT)
In-Reply-To: <1434626743-8552-7-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Thu, 18 Jun 2015 19:25:18 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272074>

Paul Tan <pyokagan@gmail.com> writes:

> +static int is_email(const char *filename)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	FILE *fp = xfopen(filename, "r");
> +	int ret = 1;
> +
> +	while (!strbuf_getline(&sb, fp, '\n')) {
> +		const char *x;
> +
> +		strbuf_rtrim(&sb);

Is this a good thing?  strbuf_getline() already has stripped the LF
at the end, so you'd be treating a line with only whitespaces as if
it is a truly empty line.

I know the series is about literal translation and the script may
lose the distinction between the two, but I do not think you need
(or want) to be literally same for things like this.

Same comment applies to other uses of "trim" in this patch.

> @@ -177,6 +267,14 @@ static int split_patches(struct am_state *state, enum patch_format patch_format,
>  static void am_setup(struct am_state *state, enum patch_format patch_format,
>  		struct string_list *paths)
>  {
> +	if (!patch_format)
> +		patch_format = detect_patch_format(paths);
> +
> +	if (!patch_format) {
> +		fprintf_ln(stderr, _("Patch format detection failed."));
> +		exit(128);
> +	}
> +
>  	if (mkdir(state->dir.buf, 0777) < 0 && errno != EEXIST)
>  		die_errno(_("failed to create directory '%s'"), state->dir.buf);

I really like the way this keeps building incrementally ;-)
The series is an enjoyable read.
