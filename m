From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] Fix segfault in fast-export
Date: Mon, 18 Jan 2010 18:44:38 +0100
Message-ID: <20100118174437.GB9576@book.hvoigt.net>
References: <20100107035839.GM8510@samus.subfocal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Mueller <mmueller@vigilantsw.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 18:44:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWvej-0001v9-V8
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 18:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247Ab0ARRom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 12:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347Ab0ARRom
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 12:44:42 -0500
Received: from darksea.de ([83.133.111.250]:59797 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751767Ab0ARRol (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 12:44:41 -0500
Received: (qmail 26078 invoked from network); 18 Jan 2010 18:44:36 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 18 Jan 2010 18:44:36 +0100
Content-Disposition: inline
In-Reply-To: <20100107035839.GM8510@samus.subfocal.net>
X-OfflineIMAP-x1461505331-72656d6f74655f68766f696774-447261667473: 126375425
	7-0431222265208-v6.2.0
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137394>

Hi,

if want your change included in git you probably want to CC: Junio and
inline your patch so its easier to comment. Please see the file
Documentation/SubmittingPatches for tips on how to do it with your
mailer.

cheers Heiko

P.S.: and include a commit message in your patch

On Wed, Jan 06, 2010 at 10:58:39PM -0500, Mike Mueller wrote:
> Hi all,
> 
> I'm working on a C++ static analyzer (Vigilant Sentry), and git
> is one of my test subjects.  In git-1.6.6, I found a crash in the
> fast-export command:
> 
> The problem is in builtin-fast-export.c, function export_marks:
> 
>     f = fopen(file, "w");
>     if (!f)
>         error("Unable to open marks file %s for writing.", file);
>    
>     for (i = 0; i < idnums.size; i++) {
>         if (deco->base && deco->base->type == 1) {
>             mark = ptr_to_mark(deco->decoration);
>             if (fprintf(f, ":%"PRIu32" %s\n", mark,
>                 sha1_to_hex(deco->base->sha1)) < 0) {
>                 e = 1;
>                 break;
>             }
>         }
>         deco++;
>     }
>    
>     e |= ferror(f);
>     e |= fclose(f);
> 
> If fopen() fails, the error message is printed, but the function
> doesn't exit.  The subsequent calls to fprintf and/or ferror will
> fail because f is NULL.  A simple way to reproduce is to export
> to a path you don't have write access to:
>    
>     $ git fast-export --export-marks=/foo
>     error: Unable to open marks file /foo for writing.
>     Segmentation fault (core dumped)
> 
> I've attached a trivial patch that calls die_errno instead of
> error, so the program exits if f is NULL.
> 
> Regards,
> Mike
> 
> -- 
> Mike Mueller
> mmueller@vigilantsw.com
> 
> http://www.vigilantsw.com/

> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> index b0a4029..963e89b 100644
> --- a/builtin-fast-export.c
> +++ b/builtin-fast-export.c
> @@ -503,7 +503,7 @@ static void export_marks(char *file)
>  
>  	f = fopen(file, "w");
>  	if (!f)
> -		error("Unable to open marks file %s for writing.", file);
> +		die_errno("Unable to open marks file %s for writing", file);
>  
>  	for (i = 0; i < idnums.size; i++) {
>  		if (deco->base && deco->base->type == 1) {
