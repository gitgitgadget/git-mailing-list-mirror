Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38864C48BE6
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 09:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1694060FEB
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 09:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbhFIJnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 05:43:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:50104 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233931AbhFIJng (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 05:43:36 -0400
Received: (qmail 2249 invoked by uid 109); 9 Jun 2021 09:35:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Jun 2021 09:35:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19542 invoked by uid 111); 9 Jun 2021 09:35:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Jun 2021 05:35:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Jun 2021 05:34:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 3/3] maintenance: add support for systemd timers on
 Linux
Message-ID: <YMCLQ5pOyg+SSKhD@coredump.intra.peff.net>
References: <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210608134000.663398-1-lenaic@lhuard.fr>
 <20210608134000.663398-4-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210608134000.663398-4-lenaic@lhuard.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 08, 2021 at 03:40:00PM +0200, Lénaïc Huard wrote:

> +static int systemd_timer_write_unit_templates(const char *exec_path)
> +{
> +	char *filename;
> +	FILE *file;
> +	const char *unit;
> +
> +	filename = xdg_config_home_systemd("git-maintenance@.timer");
> +	if (safe_create_leading_directories(filename)) {
> +		error(_("failed to create directories for '%s'"), filename);
> +		goto error;
> +	}
> +	file = fopen_or_warn(filename, "w");
> +	if (file == NULL)
> +		goto error;
> +	FREE_AND_NULL(filename);

Here we free the filename variable. But later...

> +	unit = "# This file was created and is maintained by Git.\n"
> +	       "# Any edits made in this file might be replaced in the future\n"
> +	       "# by a Git command.\n"
> +	       "\n"
> +	       "[Unit]\n"
> +	       "Description=Optimize Git repositories data\n"
> +	       "\n"
> +	       "[Timer]\n"
> +	       "OnCalendar=%i\n"
> +	       "Persistent=true\n"
> +	       "\n"
> +	       "[Install]\n"
> +	       "WantedBy=timers.target\n";
> +	if (fputs(unit, file) == EOF) {
> +		error(_("failed to write to '%s'"), filename);
> +		fclose(file);
> +		goto error;
> +	}
> +	if (fclose(file) == EOF) {
> +		error_errno(_("failed to flush '%s'"), filename);
> +		goto error;
> +	}

If we see an error we'll try to use it as part of the message. I think
the FREE_AND_NULL() can just be moved down here. And really just be
free(), since we then immediately reassign it:

> +	filename = xdg_config_home_systemd("git-maintenance@.service");
> +	file = fopen_or_warn(filename, "w");
> +	if (file == NULL)
> +		goto error;
> +	FREE_AND_NULL(filename);

And then this one has the same problem. We free here, but...

> +	unit = "# This file was created and is maintained by Git.\n"
> +	       "# Any edits made in this file might be replaced in the future\n"
> +	       "# by a Git command.\n"
> +	       "\n"
> +	       "[Unit]\n"
> +	       "Description=Optimize Git repositories data\n"
> +	       "\n"
> +	       "[Service]\n"
> +	       "Type=oneshot\n"
> +	       "ExecStart=\"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%i\n"
> +	       "LockPersonality=yes\n"
> +	       "MemoryDenyWriteExecute=yes\n"
> +	       "NoNewPrivileges=yes\n"
> +	       "RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6\n"
> +	       "RestrictNamespaces=yes\n"
> +	       "RestrictRealtime=yes\n"
> +	       "RestrictSUIDSGID=yes\n"
> +	       "SystemCallArchitectures=native\n"
> +	       "SystemCallFilter=@system-service\n";
> +	if (fprintf(file, unit, exec_path, exec_path) < 0) {
> +		error(_("failed to write to '%s'"), filename);
> +		fclose(file);
> +		goto error;
> +	}
> +	if (fclose(file) == EOF) {
> +		error_errno(_("failed to flush '%s'"), filename);
> +		goto error;
> +	}

...use it in the error messages. This one could also just be free()
before we return:

> +	return 0;
> +
> +error:
> +	free(filename);
> +	systemd_timer_delete_unit_templates();
> +	return -1;
> +}

And all of the jumps to the error label are fine, since it frees
the filename (and we don't have to worry about FREE_AND_NULL, since it
would always be valid during those jumps).

-Peff
