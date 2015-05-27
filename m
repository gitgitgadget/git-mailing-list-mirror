From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/WIP PATCH 06/11] remote.h: add get_remote_capabilities, request_capabilities
Date: Tue, 26 May 2015 23:25:05 -0400
Message-ID: <CAPig+cRfJKAQ8Q5PF1VfTAGA1njXAshC0RbnMv9cEp4bH_MN7A@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 05:25:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxRxv-0001Lz-MH
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 05:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbbE0DZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 23:25:07 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:32875 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbbE0DZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 23:25:05 -0400
Received: by igbpi8 with SMTP id pi8so76301002igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 20:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=V0Q58gl9j6riAr/IWucqPV1y6YmITbS6JPs3650BW/s=;
        b=xG4yzM0lWm8oRy8RqgACg/xYf0BXFkKuFImq7h3TXrvzYmjpRDLO/6P8m2ljgn9/bA
         9oEGSrTPVAl7wgNdf/B5In53aO7eE9igmIwuo00aqL/hFezytq06fjQgRR2hvrKGPh90
         GfFipwDML/OgKu2R+eGSH9geF6pPdMmde4R8xHTfQUnfTepSUlkTUc7cUCqjW8bdD9X1
         /ge7D2ErQJfVAkRRqiUSEGL8gJ4l8zmb5NdwtcC/ZaSm7PDK2pbrwNyZU/z6OBzP0tTh
         L7nLVFKlLjKgPpKCYqPnVg8adBs+DZslQiYEndqt6AVijLVWJoieKqaECkLQfvinVBa8
         kS/w==
X-Received: by 10.107.31.134 with SMTP id f128mr39018296iof.19.1432697105137;
 Tue, 26 May 2015 20:25:05 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 26 May 2015 20:25:05 -0700 (PDT)
In-Reply-To: <1432677675-5118-7-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: hCd69cmaZ0yuEpPop7LqzRXy7CI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270009>

On Tue, May 26, 2015 at 6:01 PM, Stefan Beller <sbeller@google.com> wrote:
> Instead of calling get_remote_heads as a first command during the
> protocol exchange, we need to have fine grained control over the
> capability negotiation in version 2 of the protocol.
>
> Introduce get_remote_capabilities, which will just listen to
> capabilities of the remote and request_capabilities which will
> tell the selection of capabilities to the remote.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/connect.c b/connect.c
> index c0144d8..bb17618 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -105,8 +105,54 @@ static void annotate_refs_with_symref_info(struct ref *ref)
>         string_list_clear(&symref, 0);
>  }
>
> +void get_remote_capabilities(int in, char *src_buf, size_t src_len)
> +{
> +       struct strbuf capabilities_string = STRBUF_INIT;
> +       for (;;) {
> +               int len;
> +               char *line = packet_buffer;
> +               const char *arg;
> +
> +               len = packet_read(in, &src_buf, &src_len,
> +                                 packet_buffer, sizeof(packet_buffer),
> +                                 PACKET_READ_GENTLE_ON_EOF |
> +                                 PACKET_READ_CHOMP_NEWLINE);
> +               if (len < 0)
> +                       die_initial_contact(0);
> +
> +               if (!len)
> +                       break;
> +
> +               if (len > 4 && skip_prefix(line, "ERR ", &arg))

The 'len > 4' check is needed because there's no guarantee that 'line'
is NUL-terminated. Correct?

> +                       die("remote error: %s", arg);
> +
> +               if (starts_with(line, "capability:")) {
> +                       strbuf_addstr(&capabilities_string, line + strlen("capability:"));

skip_prefix() maybe?

> +                       strbuf_addch(&capabilities_string, ' ');
> +               }
> +       }
> +       free(server_capabilities);
> +       server_capabilities = xmalloc(capabilities_string.len + 1);
> +       server_capabilities = strbuf_detach(&capabilities_string, NULL);

So, you're allocating a buffer for server_capabilities and then
immediately throwing away (leaking) that buffer. Seems fishy.

> +       strbuf_release(&capabilities_string);

Not outright incorrect, but you've just detached capabilities_string's
buffer, so releasing it doesn't buy anything.

> +}
> +
> +int request_capabilities(int out)
> +{
> +       fprintf(stderr, "request_capabilities\n");
> +       // todo: send our capabilities
> +       packet_write(out, "capability:foo");
> +       packet_flush(out);
> +}
> +
>  /*
> - * Read all the refs from the other end
> + * Read all the refs from the other end,
> + * in is a file descriptor input stream
> + * src_buf and src_len may be an alternative way to specify the input.

The bit about src_buf and src_len conveys little or nothing. After
reading it, I'm as clueless to their purpose as I would be if they
were undocumented.

> + * list is the output of refs
> + * extra_have is a list to store information learned about sha1 the other side has.
> + * shallow_points

'shallow_points' what?

>   */
>  struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>                               struct ref **list, unsigned int flags,
> diff --git a/remote.h b/remote.h
> index 04e2310..7381ddf 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -146,6 +146,9 @@ int check_ref_type(const struct ref *ref, int flags);
>  void free_refs(struct ref *ref);
>
>  struct sha1_array;
> +
> +extern void get_remote_capabilities(int in, char *src_buf, size_t src_len);
> +extern int request_capabilities(int out);
>  extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>                                      struct ref **list, unsigned int flags,
>                                      struct sha1_array *extra_have,
> --
> 2.4.1.345.gab207b6.dirty
