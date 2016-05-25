From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/2] http.c: implement the GIT_TRACE_CURL environment variable
Date: Tue, 24 May 2016 17:50:30 -0700
Message-ID: <CAPc5daXZU2oDHJnuwvaCO_C8VRFPNLiT_qei2NoDgHRFKVnZ=w@mail.gmail.com>
References: <20160523134403.43880-1-gitter.spiros@gmail.com> <20160523134403.43880-2-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 02:50:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5N2I-0004BG-MW
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 02:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbcEYAuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 20:50:51 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35190 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbcEYAuu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 20:50:50 -0400
Received: by mail-yw0-f194.google.com with SMTP id n16so4658549ywd.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 17:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UHcr9udz+TJoRjyhYMCkht98mhVZFjjs1DvT/iSYUFk=;
        b=jnadPQM2gElDmpYPvFVFiD++ydSm5GUrNdNhWaSlAddWqs60isx8Fkm7Q5ylRvRCxz
         xQFMmclJ6Qx2UCo7WxzKWai0LcRk3iJLmpLHhVNrI1avWaVp919aQlQXv7BwSI+zpYOm
         PGm0gMBJQLtmus1+ct4aTmYxvyG7sdujHTjb2SkfpJWPip4QvLzOWQhlLFD81lD+APeg
         hLttGiiu73ymMd223VP3nNEdNj9wfQQVrlFS6KXVn43H7HMscY8K9OGxTf0GdqQiottU
         WXzmXNh4jlrG5opvlLar663uOPpghLLeDHqac/YDywvxP4vFQo2ed2N25QQ4Q6ZFQ2AR
         MHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UHcr9udz+TJoRjyhYMCkht98mhVZFjjs1DvT/iSYUFk=;
        b=L/7rK7420EaMeX2ZDukR7E6yO1xbKain5qw88ao395rUeHMokhNASw8wlQZM34BZa7
         RDw19J6BQ0xTcqjy4RmUrTWnVsZaYc/J01Pi/q9+tHZBv6tWKh+DC/RiKuwWp/eI2XtD
         5bZlH4imd0KUhFLSIF9qHXBhFdiTqsmlc/I0Cr4gCx2jMlghObc/50rl41NTH1RkXeQI
         TTL1zw6gHnMmghTyeCqZnredkqNWRG2EG5ygVgAV5piSiNxmmGb54kPjoQfMFK+g5bqQ
         EWJ4OLqgVp8WbuSYjH1mUf0iuvSRqDrGagl4jkw7Ps7wgQLLMPI17o/Bg8tyGe6PL7Y9
         cLWQ==
X-Gm-Message-State: ALyK8tJufYFD6zMIk2XUikopH39n1m4YcKYn5QzyMeCZLhyRRPR50l+N4Redryqz9xaBlqKoqPQfXZNcw5yHbg==
X-Received: by 10.129.146.206 with SMTP id j197mr763717ywg.73.1464137449458;
 Tue, 24 May 2016 17:50:49 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Tue, 24 May 2016 17:50:30 -0700 (PDT)
In-Reply-To: <20160523134403.43880-2-gitter.spiros@gmail.com>
X-Google-Sender-Auth: 8BBD585MrQxRhv4-r9ow7SM9ZZo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295547>

On Mon, May 23, 2016 at 6:44 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> +static void curl_dump_header(const char *text, unsigned char *ptr, size_t size, int hide_sensitive_header)
> +{
> +       struct strbuf out = STRBUF_INIT;
> +       const char *sensitive_header;

This variable now has become unused, so I'll remove it while queuing.

Thanks.

> +       struct strbuf **headers, **header;
> +
> +       strbuf_addf(&out, "%s, %10.10ld bytes (0x%8.8lx)\n",
> +               text, (long)size, (long)size);
> +       trace_strbuf(&trace_curl, &out);
> +       strbuf_reset(&out);
> +       strbuf_add(&out, ptr, size);
> +       headers = strbuf_split_max(&out, '\n', 0);
> +
> +       for (header = headers; *header; header++) {
> +               if (hide_sensitive_header)
> +                       redact_sensitive_header(*header);
> +               strbuf_insert((*header), 0, text, strlen(text));
> +               strbuf_insert((*header), strlen(text), ": ", 2);
> +               strbuf_rtrim((*header));
> +               strbuf_addch((*header), '\n');
> +               trace_strbuf(&trace_curl, (*header));
> +       }
> +       strbuf_list_free(headers);
> +       strbuf_release(&out);
> +}
