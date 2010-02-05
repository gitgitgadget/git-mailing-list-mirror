From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] push: Use sideband channel for hook messages
Date: Fri, 5 Feb 2010 07:32:52 -0800
Message-ID: <20100205153252.GC19255@spearce.org>
References: <20100205033748.GA19255@spearce.org> <4B6C07E3.5030705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 16:33:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdQBB-00081u-AT
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 16:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071Ab0BEPdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 10:33:01 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:62070 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab0BEPdB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 10:33:01 -0500
Received: by iwn27 with SMTP id 27so1030854iwn.5
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 07:33:00 -0800 (PST)
Received: by 10.231.148.134 with SMTP id p6mr2753562ibv.96.1265383976777;
        Fri, 05 Feb 2010 07:32:56 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm1146476iwn.11.2010.02.05.07.32.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Feb 2010 07:32:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B6C07E3.5030705@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139050>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Shawn O. Pearce schrieb:
> > Rather than sending hook messages over stderr, and losing them
> > entirely on git:// and smart HTTP transports,
> 
> I don't think "losing them entirely" is true for the git:// protocol:
> git-daemon writes receive-pack's stderr to the syslog.
> 
> The question is whether hook errors are intended for the remote side or
> for the repository owner. Generally, I'd say for the latter. But since
> your patch is about pushing, a repository owner must already trust the
> remote side, and then it can be argued that in this case errors can be
> sent to the remote.

I think everyone expects hook errors on the client.

Most people push over authenticated SSH, where hook messages come
back on stderr.  For these folks, if they wanted something in syslog,
they'd send it there directly from the hook.

I doubt there are many anonymous pushes allowed over git://.  But,
yea, sure, I could see someone setting up their server with an
update hook to only permit pushes to the refs/heads/mob branch and
logging access failures to syslog by echoing to stderr.  I think
these people are in the vast minority, and might not even want this
behavior by default.  Maybe I'm just a jerk, but if they want their
hooks to continue to echo to syslog rather than to the client,
they can build a patch on top of this to git daemon which passes
a flag down into receive-pack to disable the side band channel.

 
> > diff --git a/run-command.c b/run-command.c
> > index cf2d8f7..7d1fd88 100644
> > @@ -228,6 +231,8 @@ fail_pipe:
> >  
> >  	if (need_err)
> >  		close(fderr[1]);
> > +	else if (cmd->err)
> > +		close(cmd->err);
> 
> This requires similar adjustments in the Windows part.
> 
> Documentation/technical/api-runcommand.txt should be an update, too.

Ouch, good catch.  Will fix.

 
> > @@ -326,10 +331,19 @@ static unsigned __stdcall run_thread(void *data)
> >  int start_async(struct async *async)
> >  {
> >  	int pipe_out[2];
> > +	int proc_fd, call_fd;
> >  
> >  	if (pipe(pipe_out) < 0)
> >  		return error("cannot create pipe: %s", strerror(errno));
> > -	async->out = pipe_out[0];
> > +
> > +	if (async->is_reader) {
> > +		proc_fd = pipe_out[0];
> > +		call_fd = pipe_out[1];
> > +	} else {
> > +		call_fd = pipe_out[0];
> > +		proc_fd = pipe_out[1];
> > +	}
> > +	async->out = call_fd;
> 
> I don't particularly like this approach because it restricts the async
> procedures to a one-way communication.

Well, its always been one way.  With the async function writing to the
main application consumer.
 
> What would you think about passing both channels to the async callback,
> and the communicating parties must agree on which channel they communicate
> by closing the unused one? It would require slight changes to all current
> async users, though. (It also requires in the threaded case that we pass
> dup()s of the pipe channels.)

Yup, I could do that.  I feel like it might be over-engineering the
solution a bit.  But I'll respin the patch by splitting it apart,
and doing a bidirectional async here, since you asked nicely.

-- 
Shawn.
