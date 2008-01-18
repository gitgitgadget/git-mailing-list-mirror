From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Fri, 18 Jan 2008 17:37:35 +0100
Message-ID: <4790D5CF.8000602@gnu.org>
References: <4790BCED.4050207@gnu.org> <alpine.LSU.1.00.0801181545530.5731@racer.site> <4790CAF7.5010908@gnu.org> <alpine.LSU.1.00.0801181605020.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 17:38:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFuEj-0000VO-Sr
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 17:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760651AbYARQhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 11:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760875AbYARQhj
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 11:37:39 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:7628 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759044AbYARQhh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 11:37:37 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1085386fga.17
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 08:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=ld2HRTkbFQLps9S+Pp7iNSldVPzWWSHxUg1uorN0A/A=;
        b=ZUbC9aRlB0meq4rie7uwRXn3t8mdyLOvd8cLF/2xS/EEQYLFWAbA+MA2L9lFck49c1SQo8zAYlzPioS3+hGVFwfLUMlyL3VnZuS1rHvQpWKFvBb6pxfvsG2pK4Idp2ViftjTrR5TXqIwQn9CMEzOwlC+n63PF4BJ4hzUnioUH3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=DnCZgfCB4IhlYMOtWdRdR+GfRmfTa7k9iw8UHsNK4WcIoybK/LHaUipr/HsNHC3ip8utI+rFX0RIhSVsfJQQuKAtR9QFd14y/uwHeZ2fZvB9wXU4afkla7antxzWqZtjhzzb4VNCHDGkkTr1QwacczbQQ1ZzEzOzr6PMdCHE9Cs=
Received: by 10.86.28.5 with SMTP id b5mr3215198fgb.79.1200674255223;
        Fri, 18 Jan 2008 08:37:35 -0800 (PST)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id 3sm6041267fge.7.2008.01.18.08.37.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jan 2008 08:37:34 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <alpine.LSU.1.00.0801181605020.5731@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71037>


> In the message hook, just grep if the template was already added.  If it 
> was, just return.  If it was not, add it.

Ah, so you want me to always type ":q!" to exit and unnecessarily 
complicate the commit-msg hook.  Cunning, but no, thanks.

I'll make an example.  This is my prepare-commit-msg hook:

diff_collect_changelog ()
{
   git diff "$@" -- \
    `git diff "$@" --name-status -r | \
         awk '/ChangeLog/ { print substr ($0, 3) }'` | sed -n \
     -e '/^@@/,/^+/ {' \
     -e '  s/^ //p' \
     -e '  t' \
     -e '}' \
     -e '/^diff/,/^@@/ {' \
     -e '  s/^diff --git a\/\(.*\)\/ChangeLog[^ ]* b\/.*/\1:/p' \
     -e '  tdummy' \
     -e '  :dummy' \
     -e '  d' \
     -e '}' \
     -e 's/^+//p' \
     -e 't'
}

diff_collect_changelog --cached > /tmp/foo$$
cat "$GIT_COMMIT_MSG" >> /tmp/foo$$ && \
   mv /tmp/foo$$ "$GIT_COMMIT_MSG"
rm -f /tmp/foo$$

or something like that.  The alternative I see would be to start the vi 
editing session with "!!make_changelog --cached".  So I thought about 
having an hook that runs the command for me.  Do you have better ideas?

Paolo
