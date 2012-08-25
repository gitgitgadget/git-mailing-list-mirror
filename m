From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH 1/3] remote-testsvn.c: Avoid the getline() GNU extension function
Date: Sat, 25 Aug 2012 21:03:33 +0200
Message-ID: <k1b7ij$p8v$1@ger.gmane.org>
References: <503907B3.9040101@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 25 21:10:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5LkN-0003H7-2R
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 21:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757137Ab2HYTKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 15:10:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:57231 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313Ab2HYTKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 15:10:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1T5LkB-00036B-AM
	for git@vger.kernel.org; Sat, 25 Aug 2012 21:10:03 +0200
Received: from dsdf-4d0a03be.pool.mediaways.net ([77.10.3.190])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 25 Aug 2012 21:10:03 +0200
Received: from jojo by dsdf-4d0a03be.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 25 Aug 2012 21:10:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4d0a03be.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204281>

Ramsay Jones wrote:
> The getline() function is a GNU extension (you need to define
> _GNU_SOURCE before including stdio.h) and is, therefore, not
> portable. In particular, getline() is not available on MinGW.
>
> In order to support non-GNU systems, we replace the call to
> getline() with (almost) equivalent code using strbuf_getline().
> Note that, unlike getline(), strbuf_getline() removes the
> newline terminator from the returned string. This difference
> in semantics does not matter at this call-site. Also, we note
> that the original code was leaking the memory allocated to
> 'line' by getline().
>
> Signed-off-by: Ramsay Jones ramsay@ramsay1.demon.co.uk

Tested-by: Joachim Schmitz jojo@schmitz-digital.de

> ---
>
> Hi Florian,
>
> Could you please squash this into commit 0320cef0 ("remote-svn: add
> marks-file regeneration", 22-08-2012).
>
> ATB,
> Ramsay Jones
>
> remote-testsvn.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/remote-testsvn.c b/remote-testsvn.c
> index 09dc304..d0b81d5 100644
> --- a/remote-testsvn.c
> +++ b/remote-testsvn.c
> @@ -121,9 +121,8 @@ static void regenerate_marks(void)
>
> static void check_or_regenerate_marks(int latestrev) {
>  FILE *marksfile;
> - char *line = NULL;
> - size_t linelen = 0;
>  struct strbuf sb = STRBUF_INIT;
> + struct strbuf line = STRBUF_INIT;
>  int found = 0;
>
>  if (latestrev < 1)
> @@ -139,8 +138,8 @@ static void check_or_regenerate_marks(int
>  latestrev) { fclose(marksfile);
>  } else {
>  strbuf_addf(&sb, ":%d ", latestrev);
> - while (getline(&line, &linelen, marksfile) != -1) {
> - if (!prefixcmp(line, sb.buf)) {
> + while (strbuf_getline(&line, marksfile, '\n') != EOF) {
> + if (!prefixcmp(line.buf, sb.buf)) {
>  found++;
>  break;
>  }
> @@ -151,6 +150,7 @@ static void check_or_regenerate_marks(int
>  latestrev) { }
>  free_notes(NULL);
>  strbuf_release(&sb);
> + strbuf_release(&line);
> }
>
> static int cmd_import(const char *line)

I'd like to second this request, having the same problem on HP NonStop and 
this patch fixes it for me too.

Bye, Jojo 
