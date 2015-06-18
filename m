From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v3 04/31] am: implement patch queue mechanism
Date: Thu, 18 Jun 2015 13:43:47 -0700
Message-ID: <xmqq7fr0eoho.fsf@gitster.dls.corp.google.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 22:44:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5gfF-0000SC-4S
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbbFRUnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:43:51 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38157 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbbFRUnu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:43:50 -0400
Received: by igblz2 with SMTP id lz2so301994igb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yl9yliZ8ecNqJmOjbo6YUXLkc+hPkQYacQadc7T5EM4=;
        b=JZ21z9dqr8ZO6lOrw9LrCjBKAaSUFTriCpgJygRL8vbbwmIqjLd86vZqauA9w831hR
         A9KQ5fBTy7LN0i5gpXnXtBd1nuqiqqTdFxdlL3iOafDC4KmkuTjzITEj8lrZFlJhL4/I
         J/QOXBLYU4XMQJJjdKazrKi7px76OUtYBOAqpVQlnYZuUI3f/BvMXC6sJOCdsu/5tk/z
         JTKOKKibUiur+NerGV7UcBWDaRA2O+vVujDqRrvdVn27LskPrnr8nsWw17AcZE2bN1m0
         FG98YaYXW0DQJFortjvQlxJkplCBQuhffYbI7or8r96OyAna61UaKkBmhGjQtnmqBF6c
         O0rw==
X-Received: by 10.107.137.42 with SMTP id l42mr17214173iod.60.1434660229588;
        Thu, 18 Jun 2015 13:43:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id 69sm5647048ioz.10.2015.06.18.13.43.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 13:43:48 -0700 (PDT)
In-Reply-To: <1434626743-8552-5-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Thu, 18 Jun 2015 19:25:16 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272070>

Paul Tan <pyokagan@gmail.com> writes:

> diff --git a/builtin/am.c b/builtin/am.c
> index dbc8836..af68c51 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -6,6 +6,158 @@
>  #include "cache.h"
>  #include "builtin.h"
>  #include "exec_cmd.h"
> +#include "parse-options.h"
> +#include "dir.h"
> +
> +struct am_state {
> +	/* state directory path */
> +	struct strbuf dir;

Is this a temporary variable you will append "/patch", etc. to form
a different string to use for fopen() etc., or do you use separate
strbufs for things like that and this is only used to initialize
them?

 - If the former then "dir" is a misnomer.

 - If the latter, then it probably does not have to be a strbuf;
   rather, it should probably be a "const char *".  Unless you pass
   this directly to functions that take a strbuf, such as
   remove_dir_recursively(), that is.

> +/**
> + * Release memory allocated by an am_state.
> + */

Everybody else in this file seems to say "Initializes", "Returns",
"Reads", etc.  While I personally prefer to use imperative
(i.e. give command to this function to "release memory allocated"),
you would want to be consistent throughout the file; "Releases
memory" would make it so.

> +/**
> + * Setup a new am session for applying patches
> + */
> +static void am_setup(struct am_state *state)
> +{
> +	if (mkdir(state->dir.buf, 0777) < 0 && errno != EEXIST)
> +		die_errno(_("failed to create directory '%s'"), state->dir.buf);
> +
> +	write_file(am_path(state, "next"), 1, "%d", state->cur);
> +
> +	write_file(am_path(state, "last"), 1, "%d", state->last);

These two lines are closely related pair; drop the blank in between.

I am tno sure if write_file() is an appropriate thing to use,
though.  What happens when you get interrupted after opening the
file but before you manage to write and close?  Shouldn't we be
doing the usual "write to temp, close and then rename to final"
dance?  This comment applies to all the other use of write_file().
