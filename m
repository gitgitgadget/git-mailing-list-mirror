From: Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH v2] Refactor recv_sideband()
Date: Tue, 14 Jun 2016 23:11:50 +0200
Message-ID: <146593870041.31940.11755632439224630423@typhoon.lan>
References: <20160613195224.13398-1-lfleischer@lfos.de>
 <20160614210038.31465-1-lfleischer@lfos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 23:12:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCvd1-0008G0-4M
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 23:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbcFNVMC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 17:12:02 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:39536 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121AbcFNVMA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 17:12:00 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 249df298
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
	Tue, 14 Jun 2016 23:11:56 +0200 (CEST)
In-Reply-To: <20160614210038.31465-1-lfleischer@lfos.de>
User-Agent: alot/0.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297329>

On Tue, 14 Jun 2016 at 23:00:38, Lukas Fleischer wrote:
> Improve the readability of recv_sideband() significantly by replacing
> fragile buffer manipulations with string buffers and more sophisticated
> format strings. Note that each line is printed using a single write()
> syscall to avoid garbled output when multiple processes write to stderr
> in parallel, see 9ac13ec (atomic write for sideband remote messages,
> 2006-10-11) for details.
> 
> Also, reorganize the overall control flow, remove some superfluous
> variables and replace a custom implementation of strpbrk() with a call
> to the standard C library function.
> 
> Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
> ---
> Now uses a single write() invocation per line. Thanks to Nicolas and
> Junio for bringing 9ac13ec to my attention.
> 
>  sideband.c | 97 +++++++++++++++++++++-----------------------------------------
>  1 file changed, 33 insertions(+), 64 deletions(-)
> 
> diff --git a/sideband.c b/sideband.c
> index fde8adc..8340a1b 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -13,103 +13,72 @@
> [...]
> +       struct strbuf outbuf = STRBUF_INIT;
> [...]
> +                               strbuf_reset(&outbuf);
> +                               strbuf_addf(&outbuf, "%s", PREFIX);
> [...]
> +                               /* Incomplete line, skip the next prefix. */
> +                               strbuf_reset(&outbuf);

Missing strbuf_release() at the end of the function, I guess. I will
wait for further comments and send v3 tomorrow.

Lukas
