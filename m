From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Thu, 20 Mar 2014 14:54:12 +0100
Message-ID: <532AF304.7040301@gmail.com>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: szager@chromium.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 14:54:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQdQJ-000601-Rj
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 14:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757571AbaCTNyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 09:54:16 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36968 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870AbaCTNyO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 09:54:14 -0400
Received: by mail-wg0-f47.google.com with SMTP id x12so635137wgg.30
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=aBDDvKtAGn3uFNLsrPAS2frsH8YM5K630oLkFcGOoec=;
        b=b6ofFuNXBPor2bt+N3ARual4+sA+a2qN0BTHx9SdFgSxP0aConHJjWx4jF2c/rD77F
         HAWwkOxaIz5puGirKHakZuPzqvD7fFM/drmV4zvU+1DgE1FBztwVbW7GCbTp+A8697Rb
         W+NmvIT5xgLYD2VEXPJmeUyf66vVkAyMqValpBtdS7QSrXRkFhCJF+/kLw1H9AIRRtal
         nNGyzYMC1S1HnrZcKCx+wZPa6OM+QNmFF6frmBka4o5yplo5+3TECvc4Pg001Wjee/eJ
         tOFfSMXUG0ApEMpjGgqVuZhBCkE241s/MI57bsSR0elf7AoRGJpKL7+BZ/GSUTJkfYnI
         cCVQ==
X-Received: by 10.194.242.231 with SMTP id wt7mr7853720wjc.52.1395323653621;
        Thu, 20 Mar 2014 06:54:13 -0700 (PDT)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id t5sm5231284wjw.15.2014.03.20.06.54.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 06:54:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244550>

Am 19.03.2014 01:46, schrieb szager@chromium.org:
> This adds a Windows implementation of pread.  Note that it is NOT
> safe to intersperse calls to read() and pread() on a file
> descriptor.

This is a bad idea. You're basically fixing the multi-threaded issue twice, while at the same time breaking single-threaded read/pread interop on the mingw and msvc platform. Users of pread already have to take care that its not thread-safe on some platforms, now you're adding another breakage that has to be considered in future development.

The mingw_pread implementation in [1] is both thread-safe and allows mixing read/pread in single-threaded scenarios, why not use this instead?

[1] http://article.gmane.org/gmane.comp.version-control.git/242120

> 
> http://article.gmane.org/gmane.comp.version-control.git/196042
> 

Duy's patch alone enables multi-threaded index-pack on all platforms (including cygwin), so IMO this should be a separate patch.

> +	if (hand == INVALID_HANDLE_VALUE) {
> +		errno = EBADF;
> +		return -1;
> +	}

This check is redundant, ReadFile already ckecks for invalid handles and err_win_to_posix converts to EBADF.

> +
> +	LARGE_INTEGER offset_value;
> +	offset_value.QuadPart = offset;
> +
> +	DWORD bytes_read = 0;
> +	OVERLAPPED overlapped = {0};
> +	overlapped.Offset = offset_value.LowPart;
> +	overlapped.OffsetHigh = offset_value.HighPart;
> +	BOOL result = ReadFile(hand, buf, count, &bytes_read, &overlapped);
> +
> +	ssize_t ret = bytes_read;
> +
> +	if (!result && GetLastError() != ERROR_HANDLE_EOF)

According to MSDN docs, ReadFile never fails with ERROR_HANDLE_EOF, or is this another case where the documentation is wrong?

"When a synchronous read operation reaches the end of a file, ReadFile returns TRUE and sets *lpNumberOfBytesRead to zero."

Karsten
