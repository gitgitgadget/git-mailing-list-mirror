From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 3/4] mingw: move common functionality to win32.h
Date: Sat, 27 Sep 2008 20:34:04 +0200
Message-ID: <200809272034.04931.johannes.sixt@telecom.at>
References: <20080927084301.GB21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Marcus Griep <marcus@griep.us>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 20:35:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjedV-000238-A5
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 20:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbYI0SeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 14:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbYI0SeL
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 14:34:11 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:46640 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbYI0SeK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 14:34:10 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 8E61913A28D;
	Sat, 27 Sep 2008 20:34:05 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 46A1E280CD;
	Sat, 27 Sep 2008 20:34:05 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080927084301.GB21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96916>

On Samstag, 27. September 2008, Dmitry Potapov wrote:
> +static inline int get_file_attr(const char *fname,
> WIN32_FILE_ATTRIBUTE_DATA *fdata) +{
> +	if (GetFileAttributesExA(fname, GetFileExInfoStandard, fdata))
> +		return 0;
> +
> +	switch (GetLastError()) {
> +	case ERROR_ACCESS_DENIED:
> +	case ERROR_SHARING_VIOLATION:
> +	case ERROR_LOCK_VIOLATION:
> +	case ERROR_SHARING_BUFFER_EXCEEDED:
> +		return EACCES;
> +	case ERROR_BUFFER_OVERFLOW:
> +		return ENAMETOOLONG;
> +	case ERROR_NOT_ENOUGH_MEMORY:
> +		return ENOMEM;
> +	default:
> +		return ENOENT;
> +	}
> +}

I've long wished for a function that translates Win32 error codes to errno 
codes. It would be useful in a number of other places, too.

Here you introduce a new function get_file_attr() that is nothing but 
GetFileAttributesExA() followed by such an error code translation.

I suggest that we leave the original call to GetFileAttributesExA() alone and 
have a function win32_to_errno(void) that is just the switch statement above.

-- Hannes
