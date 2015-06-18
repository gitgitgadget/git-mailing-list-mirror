From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v3 08/31] am: apply patch with git-apply
Date: Thu, 18 Jun 2015 14:23:16 -0700
Message-ID: <xmqqpp4sd83f.fsf@gitster.dls.corp.google.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-9-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 23:23:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5hHV-0003Ey-7c
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 23:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbbFRVXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 17:23:22 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33679 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbbFRVXT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 17:23:19 -0400
Received: by igbqq3 with SMTP id qq3so1719716igb.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sdUIi/qFs1LXrr06meH6httpsnEKXZfqpEkWfDAwSWw=;
        b=NHFHC4YAfBTSCbxZVgYPIy4QvGabIIf62FY1tZa6FyYrZS1AyFAApvwGlwtBcVfqeC
         xS7WbWMbHohQLeobFYiIs1ERQag1pioY7Nk3TIdi11gdEfNRQPL5PUw/A1HlBwcl7ATk
         oPrly7Y++0/lO77LyVhqwqyFVQfZpCjqz/nT++FtF7Vj7DtVb6WE42/60DxWIypz2IZj
         wowL7pQ4bLTCUIciUTURGeZffKKQFbI40fUZ+p8/DsEydB0Rz0HiZ5CnifaDsjOvCT3q
         WooTDWNzF/qQ3GTebP0ma5+AA8krEQnvB5LInf6oxvtG/sulGBxky9mKY0a9tCX3OUPR
         3nmg==
X-Received: by 10.50.50.210 with SMTP id e18mr186537igo.0.1434662598294;
        Thu, 18 Jun 2015 14:23:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id qh9sm314357igb.20.2015.06.18.14.23.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 14:23:17 -0700 (PDT)
In-Reply-To: <1434626743-8552-9-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Thu, 18 Jun 2015 19:25:20 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272076>

Paul Tan <pyokagan@gmail.com> writes:

> Implement applying the patch to the index using git-apply.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  builtin/am.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index d6434e4..296a5fc 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -27,6 +27,18 @@ static int is_empty_file(const char *filename)
>  	return !st.st_size;
>  }
>  
> +/**
> + * Returns the first line of msg
> + */
> +static const char *firstline(const char *msg)
> +{
> +	static struct strbuf sb = STRBUF_INIT;
> +
> +	strbuf_reset(&sb);
> +	strbuf_add(&sb, msg, strchrnul(msg, '\n') - msg);
> +	return sb.buf;
> +}

Hmm.  This is not wrong per-se but a more efficient way to do it may
be to have a helper function that returns a bytecount of the first
line of the msg, i.e. strchrnul(msg, '\n') - msg.  Then a caller can
do

	printf("Applying: %.*s", linelen(msg), msg);

instead of

	printf("Applying: %s", firstline(msg));

relying on that the firstline() copies the contents to a static
strbuf that does not have to be freed.

> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	cp.git_cmd = 1;
> +
> +	argv_array_push(&cp.args, "apply");
> +
> +	argv_array_push(&cp.args, "--index");
> +
> +	argv_array_push(&cp.args, am_path(state, "patch"));

You seem to like blank lines a lot ;-)  While it is a good tool to
separate different groups while grouping related things together,
these three argv-push calls are intimately related, and reads better
without blanks in between.

Looks nicely done so far...
