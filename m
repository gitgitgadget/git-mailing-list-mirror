From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 4/6] Add QuotedString class to handle C-style quoting rules
Date: Thu, 11 Dec 2008 00:22:03 +0100
Message-ID: <200812110022.03719.robin.rosenberg@dewire.com>
References: <1228946751-12708-1-git-send-email-spearce@spearce.org> <1228946751-12708-4-git-send-email-spearce@spearce.org> <1228946751-12708-5-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:23:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAYP4-0006qn-SS
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 00:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109AbYLJXWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 18:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755160AbYLJXWJ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 18:22:09 -0500
Received: from mail.dewire.com ([83.140.172.130]:7894 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756080AbYLJXWH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 18:22:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 15F3D147E53C;
	Thu, 11 Dec 2008 00:22:05 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q--wJsYPjEBx; Thu, 11 Dec 2008 00:22:04 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 6D79F147E530;
	Thu, 11 Dec 2008 00:22:04 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <1228946751-12708-5-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102739>

onsdag 10 december 2008 23:05:49 skrev Shawn O. Pearce:
> Git patch files can contain file names which are quoted using the
> C language quoting rules.  In order to correctly create or parse

Should we maybe call this Git-style since we really do not care
about C (which version btw?).

> QuotedString itself is an abstract API so callers can be passed a
> quoting style based on the context of where their output will be
> used, and multiple styles could be supported.  This may be useful
> if jgit ever grows a "git for-each-ref" style of output where Perl,
> Python, Tcl and Bourne style quoting might be necessary.
> 
> References through the singleton QuotedString.C should be able to
> bypass the virtual function table, as the specific type is mentioned
> in the field declaration and that type is final.  A good JIT should
> be able to remove the abstraction costs when the caller has hardcoded
> the quoting style.
Making two interfaces is better. We may share the implementation initially,
but parsing file names in Git patches and parsing C strings are different
operations.

> +	public void testQuote_OctalAll() {
> +		assertQuote("\1", "\\001");
> +		assertQuote("~", "\\176");
> +		assertQuote("\u00ff", "\\303\\277"); // \u00ff in UTF-8
> +	}
What do we do with non-UTF8 names? I think we should
follow the logic we use when parsing commits and paths
in other places.
> +
> +	public void testDequote_UnknownEscapeQ() {
> +		assertDequote("\\q", "\\q");
> +	}
Would Git generate this style in a name? 

> +			quote[' '] = 0;
> +			quote['+'] = 0;
> +			quote[','] = 0;
> +			quote['-'] = 0;
> +			quote['.'] = 0;
> +			quote['/'] = 0;
> +			quote['='] = 0;
> +			quote['_'] = 0;
> +			quote['^'] = 0;
> +
> +			quote['\u0007'] = 'a';
> +			quote['\b'] = 'b';
\e = esc

> +				default:
> +					// Any other code is taken literally.
> +					//
> +					r[rPtr++] = '\\';
> +					r[rPtr++] = in[inPtr - 1];
> +					continue;
> +				}
> +			}
> +
> +			return decode(Constants.CHARSET, r, 0, rPtr);

Importing methods really obscures things. Please qualify with class name
of RawparseUtils here instead. 

-- robin
