From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] run-command: introduce CHILD_PROCESS_INIT
Date: Sun, 17 Aug 2014 09:46:42 +0200
Message-ID: <53F05DE2.5080806@kdbg.org>
References: <53EFE15B.7030805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 17 09:47:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIvBB-0002QE-JB
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 09:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbaHQHqr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2014 03:46:47 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:38475 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750818AbaHQHqq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 03:46:46 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6F0DB130053;
	Sun, 17 Aug 2014 09:46:43 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6923419F366;
	Sun, 17 Aug 2014 09:46:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <53EFE15B.7030805@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255356>

Am 17.08.2014 00:55, schrieb Ren=C3=A9 Scharfe:
> Most struct child_process variables are cleared using memset right af=
ter
> declaration.  Provide a macro, CHILD_PROCESS_INIT, that can be used t=
o
> initialize them statically instead.  That's shorter, doesn't require =
a
> function call and is slightly more readable (especially given that we
> already have similar macros like STRBUF_INIT, ARGV_ARRAY_INIT etc.).

This is a step in the right direction, IMO. This way to initialize the
struct feels mucth better because it does not depend on that the bit
pattern of the NULL pointer is all zeros.

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  Documentation/technical/api-run-command.txt |  4 ++--
>  archive-tar.c                               |  3 +--
>  builtin/add.c                               |  3 +--
>  builtin/commit.c                            |  3 +--
>  builtin/help.c                              |  3 +--
>  builtin/merge.c                             |  3 +--
>  builtin/notes.c                             |  3 +--
>  builtin/remote-ext.c                        |  3 +--
>  builtin/repack.c                            |  3 +--
>  builtin/replace.c                           |  4 ++--
>  builtin/verify-pack.c                       |  3 +--
>  bundle.c                                    |  6 ++----
>  connected.c                                 |  3 +--
>  convert.c                                   |  3 +--
>  credential-cache.c                          |  3 +--
>  credential.c                                |  3 +--
>  daemon.c                                    |  8 +++-----
>  diff.c                                      |  3 +--
>  editor.c                                    |  3 +--
>  fetch-pack.c                                |  3 +--
>  gpg-interface.c                             |  6 ++----
>  http-backend.c                              |  3 +--
>  http.c                                      |  3 +--
>  imap-send.c                                 |  2 +-
>  prompt.c                                    |  3 +--
>  remote-curl.c                               |  3 +--
>  remote-testsvn.c                            |  3 +--
>  run-command.h                               |  2 ++
>  send-pack.c                                 |  3 +--
>  submodule.c                                 | 21 +++++++------------=
--
>  test-run-command.c                          |  4 +---
>  test-subprocess.c                           |  3 +--
>  transport.c                                 | 12 ++++--------
>  upload-pack.c                               |  3 +--
>  wt-status.c                                 |  3 +--
>  35 files changed, 51 insertions(+), 93 deletions(-)

You missed a few instances in builtin/receive-pack.c. Is this deliberat=
e?

Another one is in transport-helper.c::fetch_with_import() that is
currently initialized in get_importer(), and another one in
push_refs_with_export() that is initialized in get_exporter().

Should the static struct child_process variables in pager.c and
connect.c use the macro? It would just be for completeness, but does no=
t
change the correctness. I dunno.

> diff --git a/run-command.h b/run-command.h
> index ea73de3..95a8fb8 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -44,6 +44,8 @@ struct child_process {
>  	unsigned clean_on_exit:1;
>  };
> =20
> +#define CHILD_PROCESS_INIT { NULL }

I would have expected this to read

#define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT }

It does change the bit pattern of the initialized struct child_process
because ARGV_ARRAY_INIT uses a non-NULL address. But IMHO
ARGV_ARRAY_INIT should be used here as a defensive measure.

-- Hannes
