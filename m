From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: use new Git::Repo API, and add optional caching
Date: Tue, 15 Jul 2008 03:16:23 +0200
Message-ID: <487BFA67.3020304@gmail.com>
References: <4876B223.4070707@gmail.com> <200807150114.44402.jnareb@gmail.com> <487BE7C4.2050207@gmail.com> <200807150252.52604.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 03:17:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIZAW-0007bi-3k
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 03:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940AbYGOBQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 21:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754975AbYGOBQ3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 21:16:29 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:46624 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284AbYGOBQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 21:16:28 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3037247fkq.5
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 18:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=rOHwsGhjj5sRbtBtn9V2bSTeUeQNu0cNi6WpgzAXREA=;
        b=GZfrquQ+acf8tZ4fYfCtaicRrOYU7p7fyrA54+cxxCkels8gh9psu8yKnXqVnGtj2R
         rX57w18+VxHharvZrPtFEQbllOqTfj+ZUR25uzNuuX0lRntiJVKJW1WAainG5Z9JnLEi
         1l1fydM2X0AihGYgtP+yHup9Zsid4mwA/rXLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=xsxL30wg6kWGRMaqhFpQOmyU4JfQNwQs8zvueP4niHFGzOZQYB4yAMg6n6CEkQq8Cn
         e+RZn8WcpX6cTkLiU99TRw+59EPZgkw917CZ5ffwnxOh2+JLF71v2FJ3v64XCv7dQin7
         Mcx59oFzsVKTzu2kzMY8IyFUfo/ZZLac8i/ps=
Received: by 10.187.225.12 with SMTP id c12mr2086761far.88.1216084586557;
        Mon, 14 Jul 2008 18:16:26 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.226.181])
        by mx.google.com with ESMTPS id g28sm13071964fkg.8.2008.07.14.18.16.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 18:16:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200807150252.52604.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88492>

Jakub Narebski wrote:
> On Tue, 15 July 2008, Lea Wiemann wrote:
>> # Transient cache entries (like get_sha1('HEAD')) are automatically
>> # invalidated when an mtime [...] changes.
> 
> Nice idea... for project pages.  I'm not so sure about projects_list
> page, if wouldn't be better to have expire time for *this* page.  You
> would have/have to stat a lot of files/directories to detect changes.

It doesn't seem to be too much of a performance issue (it takes ~500ms
to generate the project list on kernel.org), and project lists aren't
requested often enough to be a good optimization target.

I'll see how it performs when the OS's page cache is cold though; if
it's too slow then I might revisit the issue.

> BTW. some summary of the above should be IMHO in the commit message.

*nods*

> In this case you don't have any basis to set expires for transient views;
> on the other hand situation doesn't differ much from serving static
> files (wrt. cache validation) so perhaps no expires but no "no-cache"
> would be a good solution.

Gitweb provides a view on a live repository, so I don't think caching is
usually what you want (e.g. static pages really tend to change much less
frequently).  (And yes, my Opera *does* seem to cache those pages unless
you add no-cache.)

Really, I don't think the performance penalty of revalidation will be
significant enough to justify risking stale data.  IOW, it's pretty
fast.  Check out repo.or.cz's performance (and repo.or.cz doesn't even
use Last-Modified).

> P.S. is there any cache evision mechanism (to limit cache size)
> in gitweb cache, or just those implemented by caching backend?

For the $cache, it's in the caching backend, for the $large_cache, there
is no mechanism, so you need to clean up yourself.  See the patch. ;-)
