From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use the best available exec path only
Date: Sun, 11 Nov 2007 20:50:40 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711112047170.4362@racer.site>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com>
 <Pine.LNX.4.64.0711111557370.4362@racer.site>
 <FCFF59B3-D3F1-4BEB-B3C3-D07DD5D5D8EF@silverinsanity.com>
 <7v3avcefg9.fsf@gitster.siamese.dyndns.org> <20071111203318.GA32671@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 21:51:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrJlu-0002j1-12
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 21:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbXKKUuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 15:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754406AbXKKUuy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 15:50:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:33277 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754504AbXKKUux (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 15:50:53 -0500
Received: (qmail invoked by alias); 11 Nov 2007 20:50:52 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp012) with SMTP; 11 Nov 2007 21:50:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jnIdU+z1jCI77Ii6kT01pqVrn7jIvv44pla10Ro
	Q6nrdLJea6BHmD
X-X-Sender: gene099@racer.site
In-Reply-To: <20071111203318.GA32671@atjola.homenet>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64511>

Hi,

On Sun, 11 Nov 2007, Bj?rn Steinbrink wrote:

> On 2007.11.11 11:43:02 -0800, Junio C Hamano wrote:
> > Brian Gernhardt <benji@silverinsanity.com> writes:
> > 
> > > I'm sorry, I should have been more clear.  I was referring to the 
> > > GIT_EXEC_PATH build variable, not the environment variable.  The git 
> > > wrapper always adds the path determined during build to the front of 
> > > PATH.  When I was changing my build script, this got set to "/usr/ 
> > > local/bin" (I usually use /usr/local/stow/git, instead).  Since I 
> > > have a /usr/local/bin/vim, PATH for git-commit.sh during the test 
> > > was:
> > >
> > > - my git build directory
> > > - /usr/local/bin (containing a symlink vi -> vim)
> > > - the t/trash directory, added by the test via `PATH=".:$PATH"`
> > > (containing the test vi script)
> > > - my normal path
> > 
> > Maybe that is what is broken.  t/test-lib.sh makes the environment 
> > variable point at the build directory, and that should override the 
> > path that is compiled in, shouldn't it?
> 
> Maybe you prefer this patch then? "make test" survived up to 9101/25, 
> but that fails with the current master anyway and I didn't bother to run 
> the remaining tests manually, so it seems to be fine. Might break some 
> weird setups that rely on being able to set multiple additional paths 
> though (not that I think that that is a good idea to begin with).
> 
> Bj?rn
> ---
> Instead of adding all possible exec paths to PATH, only add the best
> one, following the same rules that --exec-path, without arguments, uses
> to figure out which path to display.
> 
> Signed-off-by: Bj?rn Steinbrink <B.Steinbrink@gmx.de>
> ---

For easy application by the maintainer, please make the commit message the 
first part, then have a single "---", and then the quoted mail.

> diff --git a/exec_cmd.c b/exec_cmd.c
> index 2d0a758..9c376ad 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -48,9 +48,7 @@ void setup_path(const char *cmd_path)
>  
>  	strbuf_init(&new_path, 0);
>  
> -	add_path(&new_path, argv_exec_path);
> -	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
> -	add_path(&new_path, builtin_exec_path);
> +	add_path(&new_path, git_exec_path());
>  	add_path(&new_path, cmd_path);

I wonder why cmd_path is still there, then.  (I'd have expected something 
like

	add_path(&new_path, cmd_path ? cmd_path : git_exec_path());

In related news, IMO cmd_path should be made absolute if it is not already 
the case.

Ciao,
Dscho
