From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: allow inaccessible configuration under $HOME
Date: Fri, 12 Apr 2013 15:37:55 -0400
Message-ID: <20130412193755.GA5329@sigill.intra.peff.net>
References: <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
 <20130412043501.GA12942@sigill.intra.peff.net>
 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
 <20130412112636.GC20178@odin.tremily.us>
 <20130412144855.GA17968@sigill.intra.peff.net>
 <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
 <20130412161600.GA20492@sigill.intra.peff.net>
 <20130412170505.GA2383@sigill.intra.peff.net>
 <20130412191433.GR27070@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 21:38:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQjnO-0008DR-QK
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 21:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878Ab3DLTh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 15:37:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43110 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754493Ab3DLTh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 15:37:58 -0400
Received: (qmail 29555 invoked by uid 107); 12 Apr 2013 19:39:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Apr 2013 15:39:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Apr 2013 15:37:55 -0400
Content-Disposition: inline
In-Reply-To: <20130412191433.GR27070@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221019>

On Fri, Apr 12, 2013 at 12:14:33PM -0700, Jonathan Nieder wrote:

> One unexpected downside to the changes v1.7.12.1~2^2~4 (config: warn
> on inaccessible files, 2012-08-21) and v1.8.1.1~22^2~2 (config: treat
> user and xdg config permission problems as errors, 2012-10-13) is that
> they often trip when git is being run as a server.  The appropriate
> daemon (sshd, inetd, git-daemon, etc) starts as "root", creates a
> listening socket, and then drops privileges, meaning that when git
> commands are invoked they cannot access $HOME and die with
> 
>  fatal: unable to access '/root/.config/git/config': Permission denied
> 
> The intent was always to prevent important configuration (think
> "[transfer] fsckobjects") from being ignored when the configuration is
> unintentionally unreadable (for example with ENOMEM due to a DoS
> attack).  But that is not worth breaking these cases of
> drop-privileges-without-resetting-HOME that were working fine before.
> 
> Treat user and xdg configuration that is inaccessible due to
> permissions (EACCES) as though no user configuration was provided at
> all.

I kind of wonder if we are doing anything with the check at this point.
I suppose ENOMEM and EIO are the only interesting things left at this
point. The resulting code would be much nicer if the patch were just:

  -access_or_die(...);
  +access(...);

but I guess those conditions are still worth checking for, especially if
we think an attacker could trigger ENOMEM intentionally. To be honest, I
am not sure how possible that is, but it is not that hard to do so.

> An alternative approach would be to check if $HOME is readable, but
> that would not solve the problem in cases where the user who dropped
> privileges had a globally readable HOME with only .config or
> .gitconfig being private.

Yeah, although I wonder if those are signs of a misconfiguration that
should be brought to the user's attention (~/.gitconfig I feel more
confident about; less so about $HOME/.config, which might be locked down
for reasons unrelated to git).

> > Given how tight the exception is, I almost wonder if we should drop the
> > environment variable completely, and just never complain about this case
> > (in other words, just make it a loosening of 96b9e0e3).
> 
> Yeah, I think that would be better.
> 
> How about this?  (Still needs tests.)

I think it's probably OK. Like all of the proposed solutions, it is a
bit of compromise about what is worth mentioning to the user and what is
not. But we cannot have our cake and eat it, too, so I'd be fine with
this.

I agree a test would be nice for whatever solution we choose (both to
check that we fail when we should, and do not when we should not).

> -	if (xdg_config && !access_or_die(xdg_config, R_OK)) {
> +	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK)) {

I know you are trying to be flexible with the flag, but I wonder if the
resulting code would read better if we just added a new
"access_or_die_lenient" helper, which would embody the wisdom of
ignoring EACCES, or anything else that comes up later. It seems like all
callers would want either the vanilla form or the lenient form.

I do not feel too strongly about it, though.

> -int access_or_warn(const char *path, int mode)
> +int access_or_warn(const char *path, int mode, unsigned flag)
>  {
>  	int ret = access(path, mode);
> -	if (ret && errno != ENOENT && errno != ENOTDIR)
> +	if (ret && errno != ENOENT && errno != ENOTDIR &&
> +	    (!(flag & ACCESS_EACCES_OK) || errno != EACCES))
>  		warn_on_inaccessible(path);
>  	return ret;
>  }
>  
> -int access_or_die(const char *path, int mode)
> +int access_or_die(const char *path, int mode, unsigned flag)
>  {
>  	int ret = access(path, mode);
> -	if (ret && errno != ENOENT && errno != ENOTDIR)
> +	if (ret && errno != ENOENT && errno != ENOTDIR &&
> +	    (!(flag & ACCESS_EACCES_OK) || errno != EACCES))
>  		die_errno(_("unable to access '%s'"), path);
>  	return ret;
>  }

Now that these conditions are getting more complex, we should perhaps
combine them, like:

  static int access_error_is_ok(int err, int flag)
  {
          return err == ENOENT || errno == ENOTDIR ||
                  (flag & ACCESS_EACCES_OK && err == EACCES);
  }

-Peff
