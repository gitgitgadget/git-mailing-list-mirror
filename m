From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Harden parse_commit and parse_commits
Date: Thu, 9 Feb 2012 21:14:40 +0100
Message-ID: <201202092114.40832.jnareb@gmail.com>
References: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com> <201202081604.17187.jnareb@gmail.com> <CA+EqV8xiLYo8XE--c1QfuXdhentUFpHqfPYXHt72eCpEA_hCNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: rajesh boyapati <boyapatisrajesh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 21:14:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvaOC-0006WB-Ar
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 21:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757301Ab2BIUOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 15:14:38 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51766 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab2BIUOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 15:14:38 -0500
Received: by eekc14 with SMTP id c14so716042eek.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 12:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=gXxBuHAK9K9Rbi0wPzQoWXzRukafGWGB3nyG+wv9Z0U=;
        b=fC5mu7KT8YzBiGKka9X5hyEfWmWK7+RxGXUEbiZQkvoHV1Qc7fhBl5uHw1BKXHeyil
         P9qYcfP2cV7OrwGoyB3RhgwGeaLIx48g8+BunFoqZpE+0OkIfWeoCeBPXdNBgM98Zz9y
         7zIlRwcEjGuDN9qWNIr2GFPBiiZMo5qUNxckQ=
Received: by 10.14.96.197 with SMTP id r45mr1110446eef.9.1328818476656;
        Thu, 09 Feb 2012 12:14:36 -0800 (PST)
Received: from [192.168.1.13] (abvq91.neoplus.adsl.tpnet.pl. [83.8.214.91])
        by mx.google.com with ESMTPS id a58sm13248011eeb.8.2012.02.09.12.14.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 12:14:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CA+EqV8xiLYo8XE--c1QfuXdhentUFpHqfPYXHt72eCpEA_hCNQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190318>

Please do not remove git@vger.kernel.org (git mailing list) from Cc,
i.e. please use "Reply to all" instead of just "Reply to author".

On Wed, 8 Feb 2012, rajesh boyapati wrote:
> 2012/2/8 Jakub Narebski <jnareb@gmail.com>
 
[...]
> > Does the following patch help, and does it fix the issue?
> >
> > (Nb. you can try to simply change filename, and apply it with fuzz
> > against index.cgi file).
> > -- >8 -- ----- ----- ----- ----- ----- -- >8 --
> > From: Jakub Narebski <jnareb@gmail.com>
> > Subject: [PATCH] gitweb: Harden parse_commit and parse_commits
[...]
> When I applied the above patch and also the patch from your previous
> e-mail, I am getting this error
> >>>>>>>>>>>>>
> [2012-02-08 14:09:58,396] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad revision
> 'HEAD'
> [2012-02-08 14:10:06,732] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad revision
> 'HEAD'
> [2012-02-08 14:10:11,404] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad revision
> 'HEAD'
> [2012-02-08 14:10:15,270] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: Not a valid
> object name HEAD
> <<<<<<<<<<<<<<
> With these patches, the previous errors at line numbers are gone.

Thanks for information.


This final issue will be a bit harder to fix.  This error message

  fatal: bad revision 'HEAD'

comes from git (I think from "git rev-list" command), and not from gitweb.
It is printed on STDERR of git command.  What has to be done to fix it is
to capture stderr of a process, or silence it.

Unfortunately it is not that easy.  We use list form of open, which avoids
using a shell interpreter to run command, and is safer wrt. shell escaping.

The only place where gitweb cares about redirecting standard error from git
command is git_object().  It is a bit hacky, and might be not entirely safe.
To fix this issue we would have to do the same in parse_commit*() as in
git_object(), or provide some kind of wrapper like IPC::Run provides
for redirecting stderr of called command.

Note that this issue was not considered very important, because this message
doesn't goes into web server logs when running gitweb via mod_cgi with
Apache... and probably also with other web servers.  Gerrit (or rather
whatever it uses for serving CGI scripts) might be exception here.

-- 
Jakub Narebski
Poland
