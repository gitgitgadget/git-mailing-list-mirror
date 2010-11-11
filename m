From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 12:55:48 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1011111241360.14365@iabervon.org>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com> <20101111103742.GA16422@burratino> <AANLkTinzotA4TSjMjjmW--gw7ST3dXMyHzPveGynaVmZ@mail.gmail.com> <20101111173253.GC16972@burratino>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1868994266-1289497737=:14365"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Carl Worth <cworth@cworth.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 19:02:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGbTp-0008Jt-Cv
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 19:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab0KKSCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 13:02:31 -0500
Received: from iabervon.org ([66.92.72.58]:46768 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753298Ab0KKSCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 13:02:30 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Nov 2010 13:02:30 EST
Received: (qmail 8581 invoked by uid 1000); 11 Nov 2010 17:55:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Nov 2010 17:55:48 -0000
In-Reply-To: <20101111173253.GC16972@burratino>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Content-ID: <alpine.LNX.2.00.1011111250190.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161281>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1868994266-1289497737=:14365
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.2.00.1011111250191.14365@iabervon.org>

On Thu, 11 Nov 2010, Jonathan Nieder wrote:

> On Thu, Nov 11, 2010 at 07:16:27PM +0700, Nguyen Thai Ngoc Duy wrote:
> > On Thu, Nov 11, 2010 at 5:37 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> 
> >> Most likely the clone is terminating when Python exits, perhaps due to
> >> SIGPIPE.  It doesn't look like a bug to me; I suspect you meant to use
> >> os.system(), which is synchronous, instead.
> [...]
> > If "git clone" is terminated before it completes, shouldn't it clean
> > the uncompleted repo?
> 
> Ah, so it should.
> 
>  trace: built-in: git clone jrn@localhost:/home/jrn/src/xz
>  trace: run_command: ssh jrn@localhost git-upload-pack '/home/jrn/src/xz'
>  trace: remove junk called
>  jrn@localhosts password: 
>  trace: run_command: index-pack --stdin -v --fix-thin --keep=fetch-pack 19314 on burratino
>  trace: exec: git index-pack --stdin -v --fix-thin --keep=fetch-pack 19314 on burratino
>  trace: built-in: git index-pack --stdin -v --fix-thin --keep=fetch-pack 19314 on burratino
>  remote: Counting objects: 7299, done.
>  remote: Compressing objects: 100% (1826/1826), done.
>  remote: Total 7299 (delta 5421), reused 7274 (delta 5401)
>  Receiving objects: 100% (7299/7299), 2.36 MiB | 4.43 MiB/s, done.
>  Resolving deltas: 100% (5421/5421), done.
>  trace: exited with status 0
>  trace: exited with status 0
>  trace: remove junk called
>  trace: remove_junk: pid != 0
> 
> Are there any downside to the following?
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 19ed640..af6b40a 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -667,6 +667,5 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	strbuf_release(&branch_top);
>  	strbuf_release(&key);
>  	strbuf_release(&value);
> -	junk_pid = 0;
>  	return err;
>  }

I believe that would cause it to remove the repository when it terminates, 
regardless of whether it completed or not. That line is after all of the 
clone's code. I'm a bit suspicious that it's not flushing some stdio 
buffer and relying on the C library doing it on an orderly exit.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1868994266-1289497737=:14365--
