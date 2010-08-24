From: Johan Herland <johan@herland.net>
Subject: Re: [feature request] git: tags instead of commit IDs in blame output
Date: Tue, 24 Aug 2010 16:53:49 +0200
Message-ID: <201008241653.50225.johan@herland.net>
References: <20100821095352.604a2b85@hyperion.delvare> <201008211210.23280.johan@herland.net> <20100824145426.38b1fb15@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
X-From: git-owner@vger.kernel.org Tue Aug 24 17:02:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onv0i-0005tl-6i
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 17:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab0HXPBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 11:01:54 -0400
Received: from smtp.opera.com ([213.236.208.81]:34105 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470Ab0HXPBx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 11:01:53 -0400
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2010 11:01:53 EDT
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o7OErofx006860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 24 Aug 2010 14:53:50 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20100824145426.38b1fb15@hyperion.delvare>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154316>

On Tuesday 24 August 2010, Jean Delvare wrote:
> On Sat, 21 Aug 2010 12:10:22 +0200, Johan Herland wrote:
> > To me, it seems what you want to do is convert the commit ID in
> > front of every blame-line into the result of running 'git name-rev'
> > (or 'git describe') on that line.
> >
> > To that effect something like this should work:
> >
> >   git blame <file> |
> >   while read sha1 rest
> >   do
> >       tag=$(git name-rev --tags --name-only $sha1) &&
> >       echo "$tag $rest"
> >   done
> >
> > Of course, if you're doing this at a bigger scale, you want to wrap
> > this in a script that (1) caches commitID -> tag mappings, and that
> > (2) runs 'git name-rev in its --stdin mode'.
>
> Thanks for the very valuable suggestion. Obviously, the fact that the
> above command took over an hour to complete on a 1000-line file as
> kind of an issue ;) I did suspect this performance issue originally,
> which is why I thought it would be better if git itself would
> implement the feature.

Yes, everything would be easier and faster if git itself implemented it. 
Aka. infinite feature creep... This obviously does not scale.

Instead, Git tries to provide the building blocks that you can string 
together to produce the exact result you're looking for.

> That being said... git name-rev's --stdin 
> option seems to be doing all the hard caching work already:
>
> git blame -l <file> | git name-rev --tags --name-only --stdin
>
> does almost what I want, and is reasonably fast (13 seconds for the
> same file.)

I did the same experiment on a much larger file (~19000 lines), and got:

  27.94s git blame -l <file>

  28.31s git blame -l <file> | git name-rev --tags --name-only --stdin

which suggests that the git name-rev process only adds ~1% to the total 
runtime.

> I'll need to do some reformatting work to extract the tag 
> from the symbolic names (which in turn should almost fix the
> alignment),

...only if all the tag names happen to have the same length.

> but this is nothing a few lines of shell scripting can't do.

I don't see why you need to remove the suffix from the tag name. You're 
simply removing information that could be used to look up the exact 
commit resposible for each line. And it's not like the tag name is 
completely unreadable unless you remove the suffix...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
