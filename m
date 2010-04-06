From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Initialize notes trees if %N is used and no --show-notes given
Date: Tue, 6 Apr 2010 11:27:01 +0200
Message-ID: <201004061127.01471.trast@student.ethz.ch>
References: <20100405115548.GA19971@macbook.lan.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Tue Apr 06 11:27:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz53v-00071J-6R
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 11:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab0DFJ1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 05:27:05 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:1981 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab0DFJ1E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 05:27:04 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 6 Apr
 2010 11:27:01 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 6 Apr
 2010 11:27:01 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100405115548.GA19971@macbook.lan.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144122>

[A Cc would have been nice, I nearly missed this but it's clearly my
bug.]

Johannes Gilger wrote:
> this bug bit me when I used 'git log --format="%N"' without adding
> --show-notes, which caused git to fail an assertion:
>  Assertion failed: (display_notes_trees), function format_display_notes, file notes.c, line 1186.
[...]
> diff --git a/notes.c b/notes.c
> index e425e19..83f39ae 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -1183,6 +1183,8 @@ void format_display_notes(const unsigned char *object_sha1,
>  			  struct strbuf *sb, const char *output_encoding, int flags)
>  {
>  	int i;
> +	if (!display_notes_trees)
> +		init_display_notes(NULL);
>  	assert(display_notes_trees);

Thanks for the report.  Unfortunately this returns to the
silently-initialize-with-NULL case that was I explicitly asked to
avoid.

I see three options:
- %N could simply expand to nothing if notes are disabled
- %N could silently initialize as above
- your patch

though for your patch, I'd also remove the assert() since it's
basically there to enforce the requirement of initializing them; the
trees list can never be NULL after init_display_notes().

Currently I think the first option would be the best, since
(notionally; we still don't have all the bits AFAIK) the built-in
formats can then be written with a %N at the right place, without
having to worry about the other command line options.  I haven't had
enough coffee to think about any possible ill side effects, though.


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
