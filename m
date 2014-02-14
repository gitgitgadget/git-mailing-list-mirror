From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] notes: Disallow reusing non-blob as a note object
Date: Fri, 14 Feb 2014 10:19:22 -0500
Message-ID: <CAPig+cSQ12Ga4kEnNrspzru2F3p0jWb2i=1GRX84k0am5AA6Bw@mail.gmail.com>
References: <CALKQrgdnGhc-y3WMf+zej4M+O4NMhLKusE-N6dX_xKVViZmQzA@mail.gmail.com>
	<1392198856-3908-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Joachim Breitner <mail@joachim-breitner.de>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Feb 14 16:19:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEKY3-0000Xp-JL
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 16:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbaBNPTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 10:19:23 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:44651 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbaBNPTX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 10:19:23 -0500
Received: by mail-yh0-f52.google.com with SMTP id a41so11636212yho.39
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 07:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=f0Rtkix4PCRkAG0JRT7HQA8rAKKzKFzUB4RiISXC0Ak=;
        b=amRc5kBERYz9vgHf1pqhIc3+1Od+zREKbqR21A8cq7sbIeiLM52mBg+3cSULw8L9OX
         AmF/MgXUA+GG1+Uyaq+E+FyXqh0txiLgTo3Fz0YTSt7znD+Cke/T5JHpoDTmsN8/Fw7+
         WI4xho8k1ivFkBV2UrRbsISMyZxSKsp5zsHfHt6PFzcz6tgCJWkaovH1FbTK47hMT4Qm
         b3aF6IG8fP+BwsNC/U0DkjTWJzLTpi+P/5/Z7Q8ibzpYVohMFFAToLIW6jbKI99jcyC2
         V3AJbpGZolVe9AL3VBsoDEJXm4Mw4ndZJqWsH8VLoBSnh6cy25oOhRzXgPDuWrtcj24v
         y3BA==
X-Received: by 10.236.231.36 with SMTP id k34mr377601yhq.149.1392391162225;
 Fri, 14 Feb 2014 07:19:22 -0800 (PST)
Received: by 10.170.189.143 with HTTP; Fri, 14 Feb 2014 07:19:22 -0800 (PST)
In-Reply-To: <1392198856-3908-1-git-send-email-johan@herland.net>
X-Google-Sender-Auth: MNaBuB2q9HYBajPeNVMZ0IgsKYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242103>

On Wed, Feb 12, 2014 at 4:54 AM, Johan Herland <johan@herland.net> wrote:
> Currently "git notes add -C $object" will read the raw bytes from $object,
> and then copy those bytes into the note object, which is hardcoded to be
> of type blob. This means that if the given $object is a non-blob (e.g.
> tree or commit), the raw bytes from that object is copied into a blob
> object. This is probably not useful, and certainly not what any sane
> user would expect. So disallow it, by erroring out if the $object passed
> to the -C option is not a blob.
>
> The fix also applies to the -c option (in which the user is prompted to
> edit/verify the note contents in a text editor), and also when -c/-C is
> passed to "git notes append" (which appends the $object contents to an
> existing note object). In both cases, passing a non-blob $object does not
> make sense.
>
> Also add a couple of tests demonstrating expected behavior.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  builtin/notes.c  |  6 +++++-
>  t/t3301-notes.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 2b24d05..bb89930 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -269,7 +269,11 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
>                 die(_("Failed to resolve '%s' as a valid ref."), arg);
>         if (!(buf = read_sha1_file(object, &type, &len)) || !len) {
>                 free(buf);
> -               die(_("Failed to read object '%s'."), arg);;
> +               die(_("Failed to read object '%s'."), arg);
> +       }
> +       if (type != OBJ_BLOB) {
> +               free(buf);
> +               die(_("Cannot read note data from non-blob object '%s'."), arg);

The way this diagnostic is worded, it sound as if the 'read' failed
rather than that the user specified an incorrect object type. Perhaps
"Object is not a blob '%s'" or "Expected blob but '%s' has type '%s'"
or something along those lines?

>         }
>         strbuf_add(&(msg->buf), buf, len);
>         free(buf);
