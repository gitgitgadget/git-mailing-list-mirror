Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64CC62018A
	for <e@80x24.org>; Fri, 24 Jun 2016 17:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbcFXRpU (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 13:45:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:55215 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbcFXRpT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 13:45:19 -0400
Received: from virtualbox ([87.193.220.130]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MCtql-1b7wZc0Q31-009jWO; Fri, 24 Jun 2016 19:45:07
 +0200
Date:	Fri, 24 Jun 2016 19:45:04 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] Refactor recv_sideband()
In-Reply-To: <20160624153121.GA2494@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1606241942220.12947@virtualbox>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160614210038.31465-1-lfleischer@lfos.de> <20160624153121.GA2494@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4fCCRhEEpy+AGR9fn1K+s/JCD+3BD+2gu0tXSS0PvH4AeMPUPeT
 8dHlEVM4FYvAQiR0ylqzo+fLlhazbRlWz3NQ18Np9kFz1IYqH5XbztNCnHvFSlCctOwJv7L
 2R8kD59pQSJmdLX5gmKlSa5Y9DAg1ZbsdlrkC30A1/Q2Wi9swO5PA7QTSYuzjjMv5yMpjPC
 d9o8YT5jaFudjD19985dw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:eso4kYeEmU0=:B/RzTTZVqRcCyV59mQ5cOq
 aKyC6u/Gm9O8dcDGWyl0ofWv7OatA5jeCiNzBtxiTaxEviBKdQn2o8DS+4MEi7VvGld6NIvmo
 +KA1g55G7P4fLLy8MJRhUazHWme4Se+Dq8duBBm/aRNyHP4e/U3aPb41OZxvV8SV0eb1fd9L8
 DB97xDHW222oDz67AqEKnc5FxNvoAJbSO12j33mO/yPtrPI0UE3CmjUC6lzZljuSVERv/L+TF
 7aPnI4rd675zoXTuUjirJ2y8GLFAttCaAkc58w6kp29ImWjRfzh3K6z6sgTPAq26+Fa5LqhPF
 e5bGSU+7EvHBkxKLCjrk4thBs6nrGXXoGc6i5erEc8LBX12ookjs/wxGtTju4mazQH0U6pQH6
 dxA01d/6k7HS60VqLZZk2cINZDOd2w3qQEqfh1n3qL8cugL1vmHiuxQQr+YmMfdDahnpBpzX4
 IjKjTYW9uVmt85lfbyW2gNDSe95ccaPjX1U6GXgGhrTMiW8nju6XuRBsHDBtX6xLDNoBRO5WK
 Ot2TLxdCFIFQblSPHdCAwGUTFIXbxDqK7qMoA/5BcNvSH5uBU+MmzmGBGZXUj4rZdd5liOK3s
 XrUCwlCsyrVYXHwj7DE5QxKOTLYuCctqBtuEpNjKnmugV0eSc7BybBiKdaqzaOXc5jtOZNYm1
 Kautlhn4sX+4JJP8zSptx73dKVq90mh/O1CYi0i9cSly946a6X7HFyVI/ztW2VgyfTLtmS8hx
 vbaJDd2kW83CigYmgAzGGqtvnxuDI5k6E8MaoQNabxsZZrbHhD26hgiuiZKy7iO27cHxrI95Y
 lYpnhdu
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Fri, 24 Jun 2016, Jeff King wrote:

> On Tue, Jun 14, 2016 at 11:00:38PM +0200, Lukas Fleischer wrote:
> 
> > Improve the readability of recv_sideband() significantly by replacing
> > fragile buffer manipulations with string buffers and more sophisticated
> > format strings. Note that each line is printed using a single write()
> > syscall to avoid garbled output when multiple processes write to stderr
> > in parallel, see 9ac13ec (atomic write for sideband remote messages,
> > 2006-10-11) for details.
> > 
> > Also, reorganize the overall control flow, remove some superfluous
> > variables and replace a custom implementation of strpbrk() with a call
> > to the standard C library function.
> 
> I happened to be looking at the color-printing code yesterday, and was
> reminded that on Windows, fprintf is responsible for converting ANSI
> codes into colors the terminal can show:

Thanks for remembering!

>   $ git grep -A2 IMPORTANT color.h
>   color.h: * IMPORTANT: Due to the way these color codes are emulated on Windows,
>   color.h- * write them only using printf(), fprintf(), and fputs(). In particular,
>   color.h- * do not use puts() or write().
> 
> Your patch converts some fprintf calls to write. What does this mean
> on Windows for:
> 
>   1. Remote servers which send ANSI codes and expect them to look
>      reasonable (this might be a losing proposition already, as the
>      server won't know anything about the user's terminal, or whether
>      output is going to a file).
> 
>   2. The use of ANSI_SUFFIX in this function, which uses a similar
>      escape code.

Wow, I did not even think that a remote server would send color codes,
what with the server being unable to query the local terminal via
isatty().

Do we *actually* send color via the sideband, like, ever?

Ciao,
Dscho
