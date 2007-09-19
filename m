From: Edgar Toernig <froese@gmx.de>
Subject: Re: [PATCH 1/5] strbuf API additions and enhancements.
Date: Wed, 19 Sep 2007 14:46:04 +0200
Message-ID: <20070919144604.7deca4f7.froese@gmx.de>
References: <20070918223947.GB4535@artemis.corp>
	<20070918224119.17650344AB3@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 14:46:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXywb-0008UX-TJ
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 14:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbXISMqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 08:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbXISMqI
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 08:46:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:51748 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751499AbXISMqH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 08:46:07 -0400
Received: (qmail invoked by alias); 19 Sep 2007 12:46:05 -0000
Received: from p509034A8.dip0.t-ipconnect.de (EHLO dialup) [80.144.52.168]
  by mail.gmx.net (mp044) with SMTP; 19 Sep 2007 14:46:05 +0200
X-Authenticated: #271361
X-Provags-ID: V01U2FsdGVkX1/2lmJaEB/2Ftkc7im/iFeynchSMv1ncIhaR0oAfe
	/RxO3h8P2wdWE2
In-Reply-To: <20070918224119.17650344AB3@madism.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58709>

Pierre Habouzit wrote:
>
> +void strbuf_addvf(struct strbuf *sb, const char *fmt, va_list ap)
> +{
> +	int len;
> +
> +	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
> +	if (len < 0) {
> +		len = 0;
> +	}
> +	if (len > strbuf_avail(sb)) {
> +		strbuf_grow(sb, len);
> +		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
> +		if (len > strbuf_avail(sb)) {
> +			die("this should not happen, your snprintf is broken");
> +		}
> +	}
> +	strbuf_setlen(sb, sb->len + len);
> +}

The second vsnprintf won't work as the first one consumed all args
from va_list ap.  You need to va_copy the ap.  But iirc va_copy poses
compatibility issues.  Unless va_copy is made available somehow,
I would suggest to let the caller know that the buffer was too small
(but isn't any more) and it has to call the function again:

int strbuf_addvf(struct strbuf *sb, const char *fmt, va_list ap)
{
	int len;

	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
	if (len < 0)
		return 0;
	if (len > strbuf_avail(sb)) {
		strbuf_grow(sb, len);
		return -1;
	}
	strbuf_setlen(sb, sb->len + len);
	return 0;
}

The caller:

	do {
		va_start(ap, fmt);
		again = strbuf_addvf(sb, fmt, ap);
		va_end(ap);
	} while (again);

va_copy would be nicer though...

Ciao, ET.
