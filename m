From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why git-whatchanged shows a commit touching every file, but
 git-log doesn't?
Date: Thu, 31 Jan 2013 11:34:34 -0800
Message-ID: <20130131193434.GG27340@google.com>
References: <CAPKkNb49FUgLxZxHmQJoqccQ1XVcFYbYF8kYDp0+Y27cmi56fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Constantine A. Murenin" <mureninc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 20:35:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0zuY-0003ow-Ra
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 20:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab3AaTel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 14:34:41 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:49715 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928Ab3AaTej (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 14:34:39 -0500
Received: by mail-pb0-f42.google.com with SMTP id wz17so1768704pbc.15
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 11:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=cw+EJth3cJ/i6WP6sjj4QqEjQ0fWIMc1LDESBEeWe3s=;
        b=T+irjwTuH7g7KM9rTq1LBqUIkw4whtlFb39SNVSkDtP374z59eKUboquzvLxyeVfQs
         hhXKVE9IErfzMnILvfVnRYUQ9pvge/JeiSbBO9/zz13uhSec4wPNiCp2FXt8WvW5t3tB
         pjeuU55tB0DICn+K5Pc67jLUtWwH5ASESkAunaVEyY2wsfGLQwpe19LWbyYN9NiDMPrc
         fTqJDO24jdRjACHbPUpCfYEQzlOmbZzMqXleusFaNmem9Hua4+1qvIBg8KU8hOzipVr8
         YzLgpHebo7bFp1/Lk/+Ao9TNI4DGfPDWwVciYDFsRzmadYjeoWtwt11BiVPqd2+OVsOR
         aoyw==
X-Received: by 10.68.203.129 with SMTP id kq1mr25048997pbc.30.1359660879334;
        Thu, 31 Jan 2013 11:34:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ux4sm5832450pbc.25.2013.01.31.11.34.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 11:34:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPKkNb49FUgLxZxHmQJoqccQ1XVcFYbYF8kYDp0+Y27cmi56fg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215154>

Hi Constantine,

Constantine A. Murenin wrote:

> DragonFly BSD uses git as its SCM, with one single repository and
> branch for both the kernel and the whole userland.
>
> On 2011-11-26 (1322296064), someone did a commit that somehow touched
> every single file in the repository, even though most of the files
> were not modified one bit.

"gitk --simplify-by-decoration" might provide some insight.

In the dragonfly history, it seems that imports of a packages typically
proceed in two steps:

 1. First, the upstream code is imported as a new "initial commit"
    with no history:

	cd ~/src
	git init gcc-4.7.2-import
	cd gcc-4.7.2-import
	tar -xf /path/to/gcc-4.7.2
	mkdir contrib
	mv gcc-4.7.2 contrib/gcc-4.7
	git add .
	git commit -m 'Import gcc-4.7.2 to new vendor branch'

 2. Next, that code is incorporated into dragonfly.

	cd ~/src/dragonfly
	git fetch ../gcc-4.7.2-import master:refs/heads/vendor/GCC47
	git merge vendor/GCC47
	rm -fr ../gcc-4.7.2-import

Unfortunately in the commit you mentioned, someone made a mistake.
Instead of importing a single new upstream package, the author
imported the entire dragonfly tree as a new vendor branch.  Oops.

The effects might be counterintuitive:

 * tools like "git blame" and path-limited "git log" get a choice:
   when looking at the merge that pulled in a copy of dragonfly into
   the existing dragonfly codebase, either parent is an equally
   sensible from blame's point of view as an explanation of the origin
   of this code.  I think both prefer the first parent here, making them
   happen to produce the "right" result.

 * tools like "git show" that describe what change a commit made
   get a choice: when looking at a parentless commit, the diff that
   brings a project into existence may or may not be interesting,
   depending on the situation.

   See
   http://thread.gmane.org/gmane.comp.version-control.git/182571/focus=182577
   for more about that.

But at its heart, this is just an instance of "lie when creating your
history and history-mining tools will lie back to you." :)

Hoping that clarifies a little,
Jonathan
