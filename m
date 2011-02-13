From: Jeff King <peff@peff.net>
Subject: Re: a bug about format-patch of multibyte characters comment
Date: Sun, 13 Feb 2011 02:53:37 -0500
Message-ID: <20110213075337.GA12112@sigill.intra.peff.net>
References: <4D565D3B.7060808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: xiaozhu <xiaozhu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 08:53:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoWm7-0005Ef-JB
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 08:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab1BMHxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 02:53:39 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38629 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752973Ab1BMHxi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 02:53:38 -0500
Received: (qmail 9269 invoked by uid 111); 13 Feb 2011 07:53:37 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 13 Feb 2011 07:53:37 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Feb 2011 02:53:37 -0500
Content-Disposition: inline
In-Reply-To: <4D565D3B.7060808@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166642>

On Sat, Feb 12, 2011 at 07:13:15PM +0900, xiaozhu wrote:

> I commit a fix to my repository with comment like following:
> -----------------------------------------------------
> XXXXXXXXXXXX
> YYYYYY
> -----------------------------------------------------
> 
> two lines of multibyte language comment.

OK.

> then I use format-patch to export this fix, I get a patch file like following:
> 
> ------------------------------------------------------------------------------
> From d3532c3263a02a2367a3aa5c9cc3f0bd738b79b1 Mon Sep 17 00:00:00 2001
> From: xz <xz>
> Date: Fri, 11 Feb 2011 21:30:35 +0900
> Subject: [PATCH] =?UTF-8?q?=E6=97=A5=E6=9C=AC=E8=AA=9E=E3=81=8C=E5=A4=A7=E4=B8=88=E5=A4=AB
> =20=E6=94=B9=E8=A1=8C=E3=81=99=E3=82=8B?=

Yeah, this is wrong. There should be a whitespace indentation in a
multi-line header, or the whole thing should be on one line. The newline
in your commit subject is apparently leaking through, and it should be
qp-encoded.

> const char *format_subject(struct strbuf *sb, const char *msg,
> 			   const char *line_separator)
> {
> 	int first = 1;
> 
> 	for (;;) {
> 		const char *line = msg;
> 		int linelen = get_one_line(line);
> 
> 		msg += linelen;
> 		
> 		if (!linelen || is_empty_line(line, &linelen))
> 			break;
> 
> 		if (!sb)cat
> 			continue;
> 		strbuf_grow(sb, linelen + 2);
> 		if (!first)
> 			strbuf_addstr(sb, line_separator);
> 		strbuf_add(sb, line, linelen);
> 		first = 0;
> 	}
> 	return msg;
> }
> 
> At first I want to know: Does this function means that always add the first line
> of comment to the argument sb, then return the rest? Is there any other thing that I
> didn't considered?

No. It adds all lines in the first paragraph into sb. Which, if you
follow the usual git convention, is a single line. But we also see
commits imported from other version control systems where that
convention is not as prevalent. In practice, using the whole first
paragraph seems to make the most sense as a subject.

> At last, if what I think is correct, I plan to fix it as following:
> 
> const char *format_subject(struct strbuf *sb, const char *msg,
> 			   const char *line_separator)
> {
> 	int first = 1;
> 
> 	//for (;;) {
> 		const char *line = msg;
> 		int linelen = get_one_line(line);
> 
> 		msg += linelen;
> 		
> 		if (!linelen || is_empty_line(line, &linelen)) return msg;
> 			//break;
> 
> 		if (!sb) return msg;
> 			//continue;
> 		strbuf_grow(sb, linelen + 2);
> 		if (!first)
> 			strbuf_addstr(sb, line_separator);
> 		strbuf_add(sb, line, linelen);
> 		first = 0;
> 	//}
> 	return msg;
> }

No, that's not right. It breaks the use-whole-paragraph feature. The
right fix is to encode the embedded newline in the subject properly.

-Peff
