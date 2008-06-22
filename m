From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Take care of errors reported from the server when upload command is started
Date: Sun, 22 Jun 2008 19:01:59 -0400
Message-ID: <20080622230159.GG11793@spearce.org>
References: <20080622013640.GA18629@spearce.org> <1214156797-29186-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 01:03:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAYaO-0008Go-R2
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 01:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbYFVXCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 19:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756010AbYFVXCH
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 19:02:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55010 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668AbYFVXCG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 19:02:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAYZE-0001J7-91; Sun, 22 Jun 2008 19:01:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BEF6A20FBAE; Sun, 22 Jun 2008 19:01:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1214156797-29186-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85813>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> @@ -44,4 +46,31 @@ class EclipseSshSessionFactory extends SshSessionFactory {
> +	@Override
> +	public OutputStream getErrorStream() {
...
> +					Activator.logError(s, new Throwable());

I'm not sure what value the Throwable gives us here; it may be some
call stack deep within JSch, isn't it?  Is it useful to include?

We may also want the log records in Eclipse to say which remote the
message came from, which means passing in the URIish as a parameter.

> @@ -77,6 +78,7 @@ class TransportGitSsh extends PackTransport {
>  	}
>  
>  	final SshSessionFactory sch;
> +	OutputStream errStream;

Could we avoid putting the error stream as an instance member
of the transport by instead using channel.getErrStream() in the
exception case below?
  
> @@ -179,7 +181,8 @@ class TransportGitSsh extends PackTransport {
>  			cmd.append(' ');
>  			sqAlways(cmd, path);
>  			channel.setCommand(cmd.toString());
> -			channel.setErrStream(System.err);
> +			errStream = SshSessionFactory.getInstance().getErrorStream();

Use sch rather than SshSessionFactory.getInstance().  We store it in the
transport so that once the transport instance is created it always goes
to the same SshSessionFactory for anything it needs, even if the caller
has changed the global SshSessionFactory away on us.

> @@ -198,7 +201,12 @@ class TransportGitSsh extends PackTransport {
>  			try {
>  				session = openSession();
>  				channel = exec(session, getOptionUploadPack());
> -				init(channel.getInputStream(), channel.getOutputStream());
> +
> +				if (channel.isConnected())
> +					init(channel.getInputStream(), channel.getOutputStream());
> +				else
> +					throw new TransportException(errStream.toString());

I think you can say channel.getErrStream() here and not need the
instance member.

-- 
Shawn.
