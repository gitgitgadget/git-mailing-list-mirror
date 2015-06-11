From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: optionally save packs to disk
Date: Thu, 11 Jun 2015 12:33:17 -0700
Message-ID: <xmqq8ubqf3b6.fsf@gitster.dls.corp.google.com>
References: <1434044676-2942-1-git-send-email-augie@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Augie Fackler <augie@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 21:33:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z38EJ-0000SS-1V
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 21:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbbFKTd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 15:33:28 -0400
Received: from mail-ie0-f194.google.com ([209.85.223.194]:36489 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbbFKTd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 15:33:27 -0400
Received: by ierx19 with SMTP id x19so4559889ier.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 12:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=uytpT9/uQMAN+xFyWiUym5iETnooKwNRKT2YbXHO1DU=;
        b=Po6ut0ousX+Qe2e3hBQEEsSPs5D6zozl0TtFaxWv1ybpMYsMVvmRcXoegRqaCPXFgc
         X7B/cw3nvvIwW2BM46c5WA6aeNlF3cEh+Dm+5KTMQ9OC7xplPRxrhNbuy+HmIiGq3C4K
         qt5CLMPNL7qBo/2v7oc4XNBQIizgDAK/s4KbNuyva2oFAFP8hD1mbELQF/fHJk73SMjl
         3A8dHwv2CNL8blR5klubyQA6rDactuAcdEeDKwG+N7J41F7qjFvE0HX17Psr0Blw/BUF
         zAluZGBgUJl3oOA8gVbn7UtFLN8sRkqUD6I+8g+o53Dfn8d4LPkzZCAEyhFiFVNsjBMU
         LO4g==
X-Received: by 10.107.128.134 with SMTP id k6mr7123961ioi.7.1434051199280;
        Thu, 11 Jun 2015 12:33:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac40:153c:ed59:12ce])
        by mx.google.com with ESMTPSA id f15sm987845iof.36.2015.06.11.12.33.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jun 2015 12:33:18 -0700 (PDT)
In-Reply-To: <1434044676-2942-1-git-send-email-augie@google.com> (Augie
	Fackler's message of "Thu, 11 Jun 2015 13:44:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271456>

Augie Fackler <augie@google.com> writes:

> @@ -708,9 +708,8 @@ static int get_pack(struct fetch_pack_args *args,
>  	cmd.argv = argv;
>  	av = argv;
>  	*hdr_arg = 0;
> +	struct pack_header header;

decl-after-stmt here...

>  	if (!args->keep_pack && unpack_limit) {
> -		struct pack_header header;
> -
>  		if (read_pack_header(demux.out, &header))
>  			die("protocol error: bad pack header");
>  		snprintf(hdr_arg, sizeof(hdr_arg),
> @@ -762,7 +761,44 @@ static int get_pack(struct fetch_pack_args *args,
>  		*av++ = "--strict";
>  	*av++ = NULL;
>  
> -	cmd.in = demux.out;
> +	savepath = getenv("GIT_SAVE_FETCHED_PACK_TO");
> +	if (savepath) {
> +		struct child_process cmd2 = CHILD_PROCESS_INIT;
> +		const char *argv2[22];
> +		int pipefds[2];
> +		int e;
> +		const char **av2;

Have a blank after decl block before the first statement here.

> +		cmd2.argv = argv2;
> +		av2 = argv2;
