From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 3/3] gitweb: Fill project details lazily when caching
Date: Tue, 18 Mar 2008 10:12:09 +0100
Message-ID: <200803181012.11273.jnareb@gmail.com>
References: <1205766570-13550-1-git-send-email-jnareb@gmail.com> <1205766570-13550-4-git-send-email-jnareb@gmail.com> <20080318031406.GH10335@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "J.H." <warthog19@eaglescrag.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Mar 18 10:13:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbXtD-0004cX-6s
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 10:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbYCRJMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 05:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbYCRJMg
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 05:12:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:7262 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbYCRJMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 05:12:25 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2215392fgb.17
        for <git@vger.kernel.org>; Tue, 18 Mar 2008 02:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=3kaD0z1GwjDEmIzxu+1Zt91+RN9BbUHHvF7Shd8/XSc=;
        b=uFD9sg0xVYl8C6CNNDaBM0uYMvCH7EdtgQLxKM6HVENvZLONFWr+Az/z3PwyIO8PQxp2QKg+yE7voe75DDhoXGpDycoyvyH0y0SdP65Qvg3NJIf7v3TrFb2m8fdM4clh1xbuvZ3edHDxhw2Scj7dF2klqIw1txq5XDQVQLlzTwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pHvc6Krxr4Gc+2213KO27gyqBiUgY6VplcJpQ1M6opodD1xOj4YwacjYZO7hQJ2iePjeEDFfp5OdUhoz3yFC11SKip+JfdxIf6viGLrU/bBGi2ikIgwKyfW1GwlHHrrUQ0Vpz2a8oEdp/w4Ko9lZU2qW4CNm7z5dwc316+KfdDI=
Received: by 10.86.96.18 with SMTP id t18mr14374360fgb.13.1205831543676;
        Tue, 18 Mar 2008 02:12:23 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.213.235])
        by mx.google.com with ESMTPS id e20sm23224577fga.1.2008.03.18.02.12.20
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Mar 2008 02:12:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080318031406.GH10335@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77495>

On Tue, 18 March 2008, Petr Baudis wrote:
> On Mon, Mar 17, 2008 at 04:09:30PM +0100, Jakub Narebski wrote:
>>
>> If caching is turned on project details can be filled in already from
>> the cache.  When refreshing project info details for all project (when
>> cache is stale and has to be refreshed) generate projects info only if
>> modification time (as returned by lstat()) of projects repository
>> gitdir changed.
>> 
>> This way we can avoid hitting repository refs, object database and
>> repository config at the cost of additional lstat.
>> 
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>> ---
>> This is an idea for further improvement of 'projects list caching'.
>> Could you please: 
>> 
>>  1.) comment if it is a good idea, or why it works, or why it
>>      couldn't work :),  
> 
> The idea is nice, but I'm surely missing something obvious again - why
> do you use lstat() as opposed to stat()?

Because in my home installation of gitweb (for tests) I have 
/home/local/scm/git.git symlinked to /home/jnareb/git/.git
And I want to follow changes in repository; link itself doesn't
change.

> And more importantly, the mtime 
> of projects repository unfortunately does not reflect almost any
> changes per se; you would need to check mtime of description file,
> config file and the refs instead.

Well, I had hopes that because git uses "write to temporary file, rename
temporary file to final name" to have atomic file writes any change in
git repository would be reflected in mtime of topdir / GIT_DIR. I have
checked it superficially... by doing a fetch, and a commit. But while
both fetch and commit manipulate files in top dir (FETCH_HEAD, ORIG_HEAD,
COMMIT_EDITMSG) it is not the case for push, unfortunately. If all
pushes would result in pack transfer, it would be enough to watch for
GIT_DIR/objects/pack/ directory.

I think that nothing short of inotify or equivalent would work: it is
just too many files/directories to watch for changes... I hope I am
mistaken here...

-- 
Jakub Narebski
Poland
