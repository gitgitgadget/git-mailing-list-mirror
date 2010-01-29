From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: support user-supplied completion scripts for
	user's git commands
Date: Fri, 29 Jan 2010 12:04:31 -0800
Message-ID: <20100129200431.GE22101@spearce.org>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com> <20100129151127.GA21821@spearce.org> <7v4om4kdt3.fsf@alter.siamese.dyndns.org> <20100129175950.GE21821@spearce.org> <7vockciyb8.fsf@alter.siamese.dyndns.org> <20100129190642.GA31303@neumann> <20100129191326.GD22101@spearce.org> <20100129200033.GA32636@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Rhodes Clymer <david@zettazebra.com>,
	git@vger.kernel.org
To: SZEDER G?bor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jan 29 21:04:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nax57-00016E-Gx
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 21:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689Ab0A2UEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 15:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754677Ab0A2UEg
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 15:04:36 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63965 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab0A2UEf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 15:04:35 -0500
Received: by vws12 with SMTP id 12so658017vws.19
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 12:04:34 -0800 (PST)
Received: by 10.220.123.215 with SMTP id q23mr1169709vcr.119.1264795474822;
        Fri, 29 Jan 2010 12:04:34 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 41sm30141919vws.5.2010.01.29.12.04.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 12:04:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100129200033.GA32636@neumann>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138344>

SZEDER G?bor <szeder@ira.uka.de> wrote:
> 
> _git_lgm () {
>         _git_log
> }
> 
> Unfortunately, it doesn't work at all.
> 
> In _git() first we have 'lgm' in $command, which is ok, but then comes
> this alias handling thing
> 
>         local expansion=$(__git_aliased_command "$command")
>         [ "$expansion" ] && command="$expansion"
> 
> which writes '!sh' into $command, and that doesn't look quite right

__git_aliased_command is returning the first word out of the alias.
I think we need to change this block here to:

  case "$expansion" of
  \!*) : leave command as alias ;;
  '')  : leave command alone ;;
  *)   command="$expansion" ;;
  esac

Or something like that.  Because an alias whose value starts with
! is a shell command to be executed, so we want to use _git_$command
for completion, but other aliases are builtin commands and we should
use their first word token (what __git_aliased_command returns)
as the name of the completion function.

I think.  :-)

-- 
Shawn.
