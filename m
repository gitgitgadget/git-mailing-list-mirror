From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/6] notes: read copied notes with strbuf_getline()
Date: Sun, 21 Feb 2016 21:41:44 -0500
Message-ID: <CAPig+cReRiwHBJiatWJ=Gc+k+dtcMhdwFn4K57yHAjE3d_fzwQ@mail.gmail.com>
References: <56CA5DBB.8040006@moritzneeb.de>
	<56CA6160.7010908@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 22 03:41:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXgRZ-00034i-J1
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 03:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbcBVClq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 21:41:46 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36009 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbcBVClp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 21:41:45 -0500
Received: by mail-vk0-f46.google.com with SMTP id c3so117914759vkb.3
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 18:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SNW5m8yjtPNoWLMPBzCMhru5XtBCUht0v14uVaO3qdo=;
        b=CGVawUMj6DvYgRqQviXqOFpvOzvLkl8wFDG+SwICFatj36a4ZmmuydBUdZlwXSrAvC
         /qjQ6+iVqaX+YG2yKGxmeZsodG7TAZCyHUzkWELWO+9a2Z9WyBytqqTTRHjcRGRoXRko
         aXDGcNoSE8qjmIX5HEg6WX5p5dOLGD9rDh1BwyxuQnM+/Hip40P3DMW+WYgjPh3MkWkS
         DWn98Edu5VuxJkkAC2eCEkK4+RafKWCUUYG9yekBwyrCFyqgvizgim+AiucFuwU4oxIi
         Q3vTyCDclQ7uWXap6+ClHaCkWyhGzzB2ks0KlxxY5r22xzT3zRk4KGDjNAXaEPnzJ+gL
         wIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SNW5m8yjtPNoWLMPBzCMhru5XtBCUht0v14uVaO3qdo=;
        b=HykN0iOnc+zMuTWYUlE5b4K9pYqfm8P+4hqgI/CSyWQxJs7dfbeXMc8KOa9y87F4Yu
         9Bs/uwaWH2orjcOb5pn4a8Zs1hisco+AWQa9GYBN3yHSIPzamSopTGhDOMnI+JkTfDOo
         s0rgcyc+6SL3z9up4nZWImcWUDn3L0Xf094+IvDuxHG9qBRsJ6ysEECeo1utdqvDEkOK
         91nY5cabn9cr7TbjpOKdq8gRUJu88tGfwVDPxrKygo7ygM+dMuolQMYxWLoEDXEGrQCe
         x7pw7/OyX+JPBlcn1aLHJqGWTFsuqemdd+VsPgYK4jwgrkPqpoy6x82dBo9r7KxdzV+w
         4t2w==
X-Gm-Message-State: AG10YOTSc0a49AKRLCJJdLf/xjTJmu5lXo3pAE22FqlFzpS4Ti1I3koma6A1j9t9zLbjtKbfl8HHGaqYY+qx/w==
X-Received: by 10.31.41.14 with SMTP id p14mr21381503vkp.151.1456108904803;
 Sun, 21 Feb 2016 18:41:44 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 18:41:44 -0800 (PST)
In-Reply-To: <56CA6160.7010908@moritzneeb.de>
X-Google-Sender-Auth: MSrpxT7CFOYWsTCM43rx34DkUww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286868>

On Sun, Feb 21, 2016 at 8:16 PM, Moritz Neeb <lists@moritzneeb.de> wrote:
> The notes are copied from stdin. They should only contain SHA1s... Not
> spaces. CR could be there, because the file/the data from stdin could
> have been written via an editor that adds them.
>
> The notes that are copied from stdin are trimmed with strbuf_rtrim() after
> splitting by ' '. There is thus no logic expecting CR, so strbuf_getline_lf()
> can be replaced by its CRLF counterpart.
>
> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
> ---
> diff --git a/builtin/notes.c b/builtin/notes.c
> @@ -290,7 +290,7 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
>                 t = &default_notes_tree;
>         }
>  -      while (strbuf_getline_lf(&buf, stdin) != EOF) {
> +       while (strbuf_getline(&buf, stdin) != EOF) {
>                 unsigned char from_obj[20], to_obj[20];
>                 struct strbuf **split;
>                 int err;
> @@ -299,7 +299,6 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
>                 if (!split[0] || !split[1])
>                         die(_("Malformed input line: '%s'."), buf.buf);
>                 strbuf_rtrim(split[0]);
> -               strbuf_rtrim(split[1]);

Given the commit message, I understand that this rtrim is effectively
redundant, thus can be dropped, however, I'm not sure that doing so
improves the code since the reader now has to think extra hard to
understand the asymmetry of only trimming split[0] (and that
understanding may require blaming this code in order to consult the
commit message).

A deeper issue not touched upon by the commit message (but which
should be) is that that strbuf_split() leaves the "terminator" (space,
in this case) on the component strings, and that is why split[0] must
be rtrim'd. Rather than dropping only one of the rtrim's, a cleaner
approach might be to convert the code to use string_list_split() which
doesn't have the "odd" behavior of leaving the terminator on the split
strings, in which case both rtrim's could be retired. This, of course,
would be done as a separate preparatory patch.

>                 if (get_sha1(split[0]->buf, from_obj))
>                         die(_("Failed to resolve '%s' as a valid ref."), split[0]->buf);
>                 if (get_sha1(split[1]->buf, to_obj))
> --
> 2.7.1.345.gc14003e
