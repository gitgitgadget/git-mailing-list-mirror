From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 'commit -a' safety
Date: Sat, 24 Apr 2010 12:26:32 +0200
Message-ID: <201004241226.34884.jnareb@gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> <m3633hdw9u.fsf_-_@localhost.localdomain> <87fx2li36m.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sat Apr 24 12:27:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5cZm-0005C1-JJ
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 12:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720Ab0DXK0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 06:26:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:23168 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab0DXK0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 06:26:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so733431fgg.1
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2AwBIFAYQVzkSZTxlKGRK8zAiE8lF+D9Veyi5MK6gy4=;
        b=xrb/ARvWSXCfodTcjDe2wt12OqUW+ITKEPot/66efwytGohfJaRfHUp72tA9hjPBG5
         Iw9bcolzaJwieW/cWx7ee2xyRRviiKhMXgh4zvCdrhyAcGB/2YSfLGyYb7lTUdlbSsTu
         Yd1x0vCsAvxLY2QZtJnAAvFDhDd+8ABOqRJtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZAhJQTsVgHYo0UVkvpPFFhvffH6NGIKpIm+/RorTL6Ox7dcoXtTYk3/ElZVqpi5s3R
         9HXnrLFGzBu95nKcxTgS/k9urghuB6qgO7/q8GOcD64uFRgg9kUU4xkQm+sjomseRM3N
         GgyPNWNau62FHKfrGNGN+F/JezpfV3s3FYpJA=
Received: by 10.103.7.28 with SMTP id k28mr671231mui.25.1272104804434;
        Sat, 24 Apr 2010 03:26:44 -0700 (PDT)
Received: from [192.168.1.13] (abvk50.neoplus.adsl.tpnet.pl [83.8.208.50])
        by mx.google.com with ESMTPS id i7sm7886124mue.4.2010.04.24.03.26.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 03:26:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <87fx2li36m.fsf@catnip.gol.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145665>

On Sat, 24 April 2010, Miles Bader wrote:
> Jakub Narebski <jnareb@gmail.com> writes:

> > I'd like for 'git commit -a' to *fail* if there are staged changes for
> > tracked files, excluding added, removed and renamed files.  If you
> > have some staged changes you would get an error message:
> >
> >   $ git add tracked-file
> >   $ git commit -a
> >   fatal: There are staged changes to tracked files
> >   hint: To commit staged changes, use 'git commit'
> >   hint: To commit all changes, use 'git commit -f -a' 
> 
> That's bad because of the dual nature of "git add" -- someone may
> normally use "-a" most of the time to commit changes, but has really no
> choice other than git add to add a new file, So with this change, their
> normal (and reasonable) habits would suddenly result in failure.
> 
> I think it's sort of annoying that "git add" has such a dual meaning
> (instead of, for instance, having separate "add" and "stage" commands)
> -- it's one of the more confusing things about learning about git
> -- but oh well, it's unlikely to get changed at this point....

First, this is to be optional safety, by default turned off.  So if you
do not have problems with situation where you accidentally use 
'git commit -a' instead of 'git commit', committing not what you wanted
and prepared, you simply do not turn it on.


Second, to be more exact the safety would be triggered only if staged
change _differs_ from what is in working area.  Therefore

  $ git add file
  $ git commit -a

would not trigger this safety, while

  $ git add file
  $ edit file
  $ git commit -a
  fatal: There are staged changes

would trigger it.


Third, there is "git add -N" to mark file as tracked, but not add its
current context.

  $ git add -N file
  $ edit file
  $ git commit -a

should not trigger this safety.

-- 
Jakub Narebski
Poland
