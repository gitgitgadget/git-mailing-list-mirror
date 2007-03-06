From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/5] restrict the patch filtering
Date: Tue, 6 Mar 2007 14:19:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703061406580.5963@woody.linux-foundation.org>
References: <1173218263315-git-send-email-dzickus@redhat.com>
 <11732182643385-git-send-email-dzickus@redhat.com>
 <117321826466-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 23:19:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOi0V-0008LI-HE
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 23:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbXCFWTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 17:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbXCFWTg
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 17:19:36 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33471 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030314AbXCFWTW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 17:19:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l26MJEq8023824
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Mar 2007 14:19:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l26MJDKn011108;
	Tue, 6 Mar 2007 14:19:14 -0800
In-Reply-To: <117321826466-git-send-email-dzickus@redhat.com>
X-Spam-Status: No, hits=-0.96 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41603>



On Tue, 6 Mar 2007, Don Zickus wrote:
>
> I have come across many emails that use long strings of '-'s as separators
> for ideas.  This patch below limits the separator to only 3 '-', with the
> intent that long string of '-'s will stay in the commit msg and not in the
> patch file.

Ack. I think this is better than what we have now. My only question is 
whether we should allow arbitrary whitespace after the "---", ie all of 
space/tab/newline. Your patch just does space/newline (and only _one_ 
space).

I think the space-only is probably fine - we don't allow tabs there in 
diffs, and the only reason I mention whitespace is that in an editor it's 
actually really hard to see spaces at the ends of lines, so I think it's 
bad form to behave differently for

	"---\n"

than for

	"--- \t \n"

when they both *look* the same in an editor.

> Signed-off-by: Don Zickus <dzickus@redhat.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

Although I'd be even happier with something like

	static inline int patchbreak(const char *line)
	{
		/* Beginning of a "diff -" header? */
		if (!memcmp("diff -", line, 6))
			return 1;

		/* CVS "Index: " line? */
		if (!memcmp("Index: ", line, 7))
			return 1;

		/*
		 * "--- <filename>" starts patches without headers
		 * "---<sp>*" is a manual separator
		 */
		if (!memcmp("---", line, 3)) {
			line += 3;
			/* space followed by a filename? */
			if (line[0] == ' ' && !isspace(line[1]))
				return 1;
			/* Just whitespace? */
			for (;;) {
				unsigned char c = *line++;
				if (c == '\n')
					return 1;
				if (!isspace(c))
					break;
			}
			return 0;
		}
		return 0;
	}

which is totally untested, of course.

		Linus
