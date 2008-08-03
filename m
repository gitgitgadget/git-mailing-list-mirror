From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Sun, 03 Aug 2008 04:38:45 -0700
Message-ID: <489598C5.6060508@zytor.com>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 03 13:39:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPbvu-0003ll-Qs
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 13:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbYHCLi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 07:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753754AbYHCLi3
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 07:38:29 -0400
Received: from terminus.zytor.com ([198.137.202.10]:43761 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbYHCLi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 07:38:29 -0400
Received: from [10.71.1.72] ([12.197.88.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m73BcR56022542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Aug 2008 04:38:27 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <1217748317-70096-2-git-send-email-spearce@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/7920/Sun Aug  3 01:44:32 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91229>

Shawn O. Pearce wrote:
> +#define hex(a) (hexchar[(a) & 15])
> +static void chunked_write(const char *fmt, ...)
> +{
> +	static const char hexchar[] = "0123456789abcdef";
> +	va_list args;
> +	unsigned n;
> +
> +	va_start(args, fmt);
> +	n = vsnprintf(buffer + 6, sizeof(buffer) - 8, fmt, args);
> +	va_end(args);
> +	if (n >= sizeof(buffer) - 8)
> +		die("protocol error: impossibly long line");
> +
> +	if (can_chunk) {
> +		unsigned len = n + 4, b = 4;
> +
> +		buffer[4] = '\r';
> +		buffer[5] = '\n';
> +		buffer[n + 6] = '\r';
> +		buffer[n + 7] = '\n';
> +
> +		while (n > 0) {
> +			buffer[--b] = hex(n);
> +			n >>= 4;
> +			len++;
> +		}
> +
> +		safe_write(1, buffer + b, len);
> +	} else
> +		safe_write(1, buffer + 6, n);
> +}

Maybe I am slightly confused, but I thought handling HTTP chunking for 
HTTP/1.1+ clients was usually done by Apache above the level of the CGI 
script?

	-hpa
