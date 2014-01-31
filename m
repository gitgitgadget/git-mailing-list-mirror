From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 06/17] trailer: parse trailers from input file
Date: Fri, 31 Jan 2014 11:45:46 -0500
Message-ID: <CAPig+cQu0ZPYH9xq6jvw3+FgsMy4T8jTP+2NMnS6qtdAqbcCiQ@mail.gmail.com>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.62053.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jan 31 17:53:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9HL1-00051r-6X
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 17:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbaAaQxC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 11:53:02 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:59895 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932236AbaAaQxA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 11:53:00 -0500
Received: by mail-yk0-f177.google.com with SMTP id 19so25062015ykq.8
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 08:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=crHDVqK8nD2uGOg9/ZZtlRkJ2/1XwUt6BrhHpCmPHOU=;
        b=yCTVwqmhRjs1YXmqNALJZxe5Vr5yq8eGd8w0f2mzQmgYXp8UL2eoZvxUPq8VHntvTH
         nclfo8QoYPafE6NPRcppGcOagZGIPW+Vl8vIUGfm9C+XpiYcq0CubeJ5QSwbeNIMRdTD
         l6bTb3FC+zjB704v9OCfwQtG6icz2vHNIFTZrc8bmrOfUk8FzguiQyiIjpwVsBrHv08L
         8EobvRp2XJtnzfprh9S5SWjxvi7zyBDAg7rzSIPIORN9GSqJO6eqli+XkZpYIYuY2ZWq
         Cc0B1XojQXYX3eVxxVCL88tb0PqVv6QZb95/tMRYmI9Y5JppmBDv6RiUl6c7e98RyAKb
         vNxA==
X-Received: by 10.236.120.17 with SMTP id o17mr1516746yhh.121.1391186746912;
 Fri, 31 Jan 2014 08:45:46 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Fri, 31 Jan 2014 08:45:46 -0800 (PST)
In-Reply-To: <20140130064921.7504.62053.chriscool@tuxfamily.org>
X-Google-Sender-Auth: ME9fUESpzCHgupsJTdr2rNqA1LU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241304>

On Thu, Jan 30, 2014 at 1:49 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> This patch reads trailers from an input file, parses
> them and puts the result into a doubly linked list.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  trailer.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/trailer.c b/trailer.c
> index f48fd94..084b3e1 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -439,3 +439,65 @@ static struct trailer_item *process_command_line_args(int argc, const char **arg
> +static void process_input_file(const char *infile,
> +                              struct trailer_item **infile_tok_first,
> +                              struct trailer_item **infile_tok_last)
> +{
> +       struct strbuf **lines = read_input_file(infile);
> +       int start = find_trailer_start(lines);
> +       int i;
> +
> +       /* Print non trailer lines as is */
> +       for (i = 0; lines[i] && i < start; i++) {
> +               printf("%s", lines[i]->buf);
> +       }
> +
> +       /* Parse trailer lines */
> +       for (i = start; lines[i]; i++) {
> +               struct trailer_item *new = create_trailer_item(lines[i]->buf);
> +               add_trailer_item(infile_tok_first, infile_tok_last, new);

Leaking 'lines'. Perhaps you want to invoke strbuf_list_free() here.

> +       }
> +}
> --
> 1.8.5.2.201.gacc5987
