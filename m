From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH 4/4] replace: add --edit option
Date: Thu, 6 Mar 2014 20:57:58 -0500
Message-ID: <CAPig+cQi+7md4P2OXJDDcs7VMkMEsUHaEz5wsaDOyu4ppk2uAg@mail.gmail.com>
References: <20140306174803.GA30486@sigill.intra.peff.net>
	<20140306175117.GD30691@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 07 02:58:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLk32-0007jU-CO
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 02:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbaCGB57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 20:57:59 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:43410 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbaCGB56 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 20:57:58 -0500
Received: by mail-yk0-f178.google.com with SMTP id 79so9006135ykr.9
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 17:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BdrKfLkzjqKEFUTaqA8UJjW5O5vI9qOc2ryzfn3FmXQ=;
        b=L7GDlaG7jTqe+h6CdM0arjzDxOR9dJZlQMwMHlQazTsy+5vx0jtJ3HpseR+Na8U6yi
         IQHyD8mn/+h4ADSAI3HbAHGGdfqid90fflnOnghQqKgU6x+6ApnbqzyrU25LbNKrq5C+
         6H04Z31DJl3fIBcbM+mvZVHA/ze7fQKcIvwWowwmYSufLBdcyJKfNdpkLPb/9j3NSgLZ
         8XQJiT5JEPCov2RBTrhv8q/3QFI4OSP3NXlFiUx15IG6nsevGmlTvTlEvLHHoJCWKMla
         UywpP+yDTHjfte/zLq5qEmrKD+wWewb8tkhQ0U+G6EVd1UUHaHdlEwRYz0YWfYkigt0W
         +AEA==
X-Received: by 10.236.148.72 with SMTP id u48mr82925yhj.126.1394157478078;
 Thu, 06 Mar 2014 17:57:58 -0800 (PST)
Received: by 10.170.180.134 with HTTP; Thu, 6 Mar 2014 17:57:58 -0800 (PST)
In-Reply-To: <20140306175117.GD30691@sigill.intra.peff.net>
X-Google-Sender-Auth: XMnitZ1lNVpxxhJioejHcmow23A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243584>

On Thu, Mar 6, 2014 at 12:51 PM, Jeff King <peff@peff.net> wrote:
> This allows you to run:
>
>     git replace --edit SHA1
>
> to get dumped in an editor with the contents of the object
> for SHA1. The result is then read back in and used as a
> "replace" object for SHA1. The writing/reading is
> type-aware, so you get to edit "ls-tree" output rather than
> the binary tree format.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/replace.c b/builtin/replace.c
> index a090302..3ed5f75 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -176,6 +177,105 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
>         return replace_object_sha1(object_ref, object, replace_ref, repl, force);
>  }
>
> +/*
> + * Read a previously-exported (and possibly edited) object back from "filename",
> + * interpreting it as "type", and writing the result to the object database.
> + * The sha1 of the written object is returned via sha1.
> + */
> +static void import_object(unsigned char *sha1, enum object_type type,
> +                         const char *filename)
> +{
> +       int fd;
> +
> +       fd = open(filename, O_RDONLY);
> +       if (fd < 0)
> +               die_errno("unable to open %s for reading", filename);
> +
> +       if (type == OBJ_TREE) {
> +               const char *argv[] = { "mktree", NULL };
> +               struct child_process cmd = { argv };
> +               struct strbuf result = STRBUF_INIT;
> +
> +               cmd.argv = argv;
> +               cmd.git_cmd = 1;
> +               cmd.in = fd;
> +               cmd.out = -1;
> +
> +               if (start_command(&cmd))
> +                       die("unable to spawn mktree");
> +
> +               if (strbuf_read(&result, cmd.out, 41) < 0)
> +                       die_errno("unable to read from mktree");
> +               close(cmd.out);
> +
> +               if (finish_command(&cmd))
> +                       die("mktree reported failure");
> +               if (get_sha1_hex(result.buf, sha1) < 0)
> +                       die("mktree did not return an object name");

strbuf_release(&result);

> +       } else {
> +               struct stat st;
> +               int flags = HASH_FORMAT_CHECK | HASH_WRITE_OBJECT;
> +
> +               if (fstat(fd, &st) < 0)
> +                       die_errno("unable to fstat %s", filename);
> +               if (index_fd(sha1, fd, &st, type, NULL, flags) < 0)
> +                       die("unable to write object to database");
> +               /* index_fd close()s fd for us */
> +       }
> +
> +       /*
> +        * No need to close(fd) here; both run-command and index-fd
> +        * will have done it for us.
> +        */
> +}
> --
> 1.8.5.2.500.g8060133
