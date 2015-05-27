From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/WIP PATCH 04/11] upload-pack-2: Implement the version 2 of upload-pack
Date: Tue, 26 May 2015 22:30:09 -0400
Message-ID: <CAPig+cQHQFrabqkXUaRHw7HU+URL4QBzzLZYko5GrRHFpYctng@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 04:30:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxR6m-0002ia-Te
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 04:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbbE0CaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 22:30:11 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35117 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbbE0CaK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 22:30:10 -0400
Received: by iesa3 with SMTP id a3so3623583ies.2
        for <git@vger.kernel.org>; Tue, 26 May 2015 19:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SQDhYa2rGfuYRueoHjzYt6LyZPOGRfY0/Jx3RZsyVpE=;
        b=d0+rIBry+yLGPAYKwMMfYQMufptWTtTHkpRNLBstIFAxK6U5kbI5NoQu6WBFpdNC02
         e1/ibql6CZbzAOpu8EV6vxsABgvVsQu3yd71VZ+ju++ktC6wtqX+rJ+FfrNsulTp1SdQ
         +bBc2ry+syoy5cUJMKPID8EqzTUtg8A7oA7Bf164KN91BSK/W5qur9BGayHX148lfvuG
         YiRMVChoeHOxE1Z0Os4tejRc24nhSJuAYly3ZUhvL0i73b5Xa2FaRJJWBqQrvWcoFlLL
         lj5rP2JFAozo8a4RfF7OsMDT48sff2QV8arr6ddrGg0yH3TETQPRDlQosQ9J+RiAMAYg
         mgSw==
X-Received: by 10.107.137.80 with SMTP id l77mr31413886iod.92.1432693809453;
 Tue, 26 May 2015 19:30:09 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 26 May 2015 19:30:09 -0700 (PDT)
In-Reply-To: <1432677675-5118-5-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: ZMFGHxJeoUru2C9V5vSZad7s6So
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270008>

On Tue, May 26, 2015 at 6:01 PM, Stefan Beller <sbeller@google.com> wrote:
> In upload-pack-2 we send each capability in its own packet.
> By reusing the advertise_capabilities and eventually setting it to
> NULL we will be able to reuse the methods for refs advertisement.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/upload-pack-2.c b/upload-pack-2.c
> new file mode 120000
> index 0000000..e30a871
> --- /dev/null
> +++ b/upload-pack-2.c
> @@ -716,10 +716,47 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
>                 strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
>  }
>
> -static const char *advertise_capabilities = "multi_ack thin-pack side-band"
> +static char *advertise_capabilities = "multi_ack thin-pack side-band"
>                 " side-band-64k ofs-delta shallow no-progress"
>                 " include-tag multi_ack_detailed";
>
> +/*
> + * Reads the next capability and puts it into dst as a null terminated string.
> + * Returns true if more capabilities can be read.
> + * */
> +static int next_capability(char *dst)
> +{
> +       int len = 0;
> +       if (!*advertise_capabilities) {
> +               /* make sure to not advertise capabilities afterwards */
> +               advertise_capabilities = NULL;

You set advertise_capabilities to NULL here but then unconditionally
dereference that NULL in the if-statement just above (if someone calls
next_capability() again). Seems fishy (and crashy) to me. Either don't
dereference the NULL or don't bother setting it to NULL (in which
case, you'll dereference and find '\0', which should serve the same
purpose).

> +               return 0;
> +       }
> +
> +       while (advertise_capabilities[len] != '\0' &&
> +              advertise_capabilities[len] != ' ')
> +               len ++;

Style: len++

> +       strncpy(dst, advertise_capabilities, len);
> +       dst[len] = '\0';
> +
> +       advertise_capabilities += len;
> +       if (*advertise_capabilities == ' ')
> +               advertise_capabilities++;

If for some reason, someone happens to add an extra space between
capabilities in advertise_capabilities, then the capability returned
by the next invocation of next_capability() be zero-length, which is
probably undesirable, and certainly not expected by the caller.
Skipping whitespace in a loop would be more robust.

> +       return 1;
> +}

I realize that this is RFC, but my overall reaction to
next_capability() in its current form is that it's ugly . A somewhat
cleaner approach would be to pass some state into next_capability()
and have it modify that state rather than the global
advertise_capabilities. The passed-in state could be as simple as a
'const char *' which initially points at the start of
advertise_capabilities and then gets advanced; until, finally, it
points at the '\0' at the end of advertise_capabilities.

> +static void send_capabilities(void)
> +{
> +       char buf[100];
> +
> +       while (next_capability(buf))
> +               packet_write(1, "capability:%s\n", buf);
> +
> +       packet_write(1, "agent:%s\n", git_user_agent_sanitized());
> +       packet_flush(1);
> +}
> +
>  static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
>  {
>
> @@ -794,6 +831,28 @@ static void upload_pack(void)
>         }
>  }
>
> +static void receive_capabilities(void)
> +{
> +       int done = 0;
> +       while (1) {
> +               char *line = packet_read_line(0, NULL);

If you declare this 'const char *', then it becomes much more obvious
that it's not your responsibility to free() the result (and,
tangentially, that you have no intention of modifying the content).

> +               if (!line)
> +                       break;
> +               if (starts_with(line, "capability:"))
> +                       parse_features(line + strlen("capability:"));

See skip_prefix().

> +       }
> +}
> +
> +static void upload_pack_version_2(void)
> +{
> +       send_capabilities();
> +       receive_capabilities();
> +
> +       /* The rest of the protocol stays the same, capabilities advertising
> +          is disabled though. */

    /*
     * This is a multi-line
     * comment.
     */

> +       upload_pack();
> +}
> +
>  static int upload_pack_config(const char *var, const char *value, void *unused)
>  {
>         if (!strcmp("uploadpack.allowtipsha1inwant", var))
> @@ -806,16 +865,24 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
>         return parse_hide_refs_config(var, value, "uploadpack");
>  }
>
> +static int endswith(const char *teststring, const char *ending)
> +{
> +       int slen = strlen(teststring);
> +       int elen = strlen(ending);

You may be confident today that no callers are supplying an 'ending'
which is longer than 'teststring', but someone may some day break that
assumption. At the very least, for robustness, add an assert() or
die() if 'elen' is greater than 'slen'.

> +       return !strcmp(teststring + slen - elen, ending);
> +}
> +
>  int main(int argc, char **argv)
>  {
>         char *dir;
> +       const char *cmd;
>         int i;
>         int strict = 0;
>
>         git_setup_gettext();
>
>         packet_trace_identity("upload-pack");
> -       git_extract_argv0_path(argv[0]);
> +       cmd = git_extract_argv0_path(argv[0]);
>         check_replace_refs = 0;
>
>         for (i = 1; i < argc; i++) {
> @@ -857,6 +924,10 @@ int main(int argc, char **argv)
>                 die("'%s' does not appear to be a git repository", dir);
>
>         git_config(upload_pack_config, NULL);
> -       upload_pack();
> +
> +       if (endswith(cmd, "-2"))
> +               upload_pack_version_2();
> +       else
> +               upload_pack();
>         return 0;
>  }
> --
> 2.4.1.345.gab207b6.dirty
