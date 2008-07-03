From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [RFC/PATCH (WIP)] Git.pm: Add get_config() method and related
 subroutines
Date: Thu, 03 Jul 2008 22:30:03 +0200
Message-ID: <486D36CB.3090400@gmail.com>
References: <200807031824.55958.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 22:31:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEVSz-0001GU-LP
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 22:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbYGCUao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 16:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbYGCUao
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 16:30:44 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:37836 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbYGCUan (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 16:30:43 -0400
Received: by yw-out-2324.google.com with SMTP id 9so414394ywe.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 13:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=EGRpn9rTjYN8gh4IXcCw0OPtT0eianLN2jSmcZZWfmE=;
        b=V+Cx2wbPUJhXyOHu4yPYgC9hAch2Bs+ad6IVw1kpVOlrU77U1bMIyPw9ZASTi+Nv55
         IzHZHhtKGUtFkcOtV1MEt7D2DHLkUOrRdsmjSIhnkVplskZNEsgB/2kUPx7vmhzg9Uro
         216Cg4l7U0v0EfrGnGgxebwytfKBWoAmcwZoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=lmoRuvGeEk9LR5OA8k34axNbQ48Z8nm0XvkqgaVPwnjvvbrx1GZ4jD92hlR5ZFTHuJ
         CrQN3pLb1JucjBGmjAPXU5vlfUpD65rdIpaMyoKhVS4FwQoM2MNZX47S8ALL5EvUqvu5
         76kdbzIjAqdeQEL0w7dWs1eHYZB+CwQHOi/4s=
Received: by 10.115.73.20 with SMTP id a20mr1180151wal.32.1215117035929;
        Thu, 03 Jul 2008 13:30:35 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.221.215])
        by mx.google.com with ESMTPS id 28sm1177086fkx.1.2008.07.03.13.30.03
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Jul 2008 13:30:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200807031824.55958.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87316>

Jakub Narebski wrote:
> Add get_config([PREFIX]) method [...]
>
> I hope I am not repeating [Lea's] work.

No, you're not.  (You could've checked my repo at
<http://repo.or.cz/w/git/gitweb-caching.git> ;-).)

FWIW, I don't think it'll make much of a difference for gitweb, since
the 'git config -l' output is cached anyway, but it's good someone's
extracting this.  Do you have any user for that function besides gitweb?

>  * Should config_val_to_bool and config_val_to_int throw error or
>    just return 'undef' on invalid values?

I suspect that if you have, say, command line tools, throwing an error
is better UI behavior than silently ignoring the entry.  And developers
can always catch errors if they want to.

>  * Is "return wantarray ? %config : \%config;" DWIM-mery good style?

Gitweb uses it as well, and it seems reasonable IMVHO.

>  * Should ->get_config() use ->command_output_pipe, or simpler
>    ->command() method, reading whole config into array?

Does it make a difference?  If you're worried about performance, config
files are so short that it won't matter; use the easier path.

>  * What should ->get_config() method be named? ->get_config()
>    or perhaps ->config_hash(), or ->config_hashref()?

Regarding the method naming, how about making this an object oriented
interface?  Bless the hash, and allow calls like
$config_hash->get('key').  I'm not sure how to name the constructor, but
if you can wait a week or so, you could maybe integrate this into the
Git::Repo interface (under Git/Config.pm), so you'd end up with ...

    Git::Repo->new(directory => 'repo.git')->config->get('key')

... where config() transparently parses the config file if it hasn't
been read already.  (The Git.pm API admittedly seems a little messy --
I'll post about that later -- so adding it to Git::Repo might be better
indeed.)

>  * What should ->get_config() have as an optional parameter:
>    PREFIX (/^$prefix/o), or simply SECTION (/^(?:$section)\./o)?

Off the top of my head, I don't see much need for a prefix parameter, so
I'd go for 'section'.

I haven't been able to answer all of the questions, but I hope this helps.

-- Lea
