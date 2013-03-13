From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Tag peeling peculiarities
Date: Wed, 13 Mar 2013 15:59:05 +0100
Message-ID: <51409439.5090001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 13 15:59:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFn9W-00089X-87
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 15:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932995Ab3CMO7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 10:59:11 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:47026 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932641Ab3CMO7K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Mar 2013 10:59:10 -0400
X-AuditID: 12074413-b7f226d000000902-ea-5140943decab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 16.2E.02306.D3490415; Wed, 13 Mar 2013 10:59:09 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2DEx6BT006658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 13 Mar 2013 10:59:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqGs7xSHQ4OB8HYuuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE74/aKGawFx+Uqdu87wN7AeFCqi5GTQ0LARGJp
	0xd2CFtM4sK99WxdjFwcQgKXGSXW9z1kgnCOM0ncnnWLCaSKV0Bb4vPzTjCbRUBV4t3JJ2Dd
	bAK6Eot6msHiogJhEi+X7GCDqBeUODnzCQuILQJUs+vZVbA4s4CaxKEljxhBbGEBJYlVK3ey
	Q8R1JN71PWCGsOUltr+dwzyBkW8WklGzkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5e
	apGuuV5uZoleakrpJkZI4AnvYNx1Uu4QowAHoxIP744Oh0Ah1sSy4srcQ4ySHExKory8k4FC
	fEn5KZUZicUZ8UWlOanFhxglOJiVRHiX5wLleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1Kz
	U1MLUotgsjIcHEoSvMEgQwWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBsRdfDIw+
	kBQP0F4zkHbe4oLEXKAoROspRl2O3e8evWAUYsnLz0uVEuf9OgmoSACkKKM0D24FLM28YhQH
	+liY1wRkFA8wRcFNegW0hAloSXqOPciSkkSElFQDY/0m8duR99JXXJuXc+jV1KPMhw+nOfwT
	8r2yZI1c/02/hZ7S++Rn22xQWZvwcVr19Nh6AdZLs7tXvMjaUs4847xykkDkUi+XyFzj2lOv
	cj+biK3W1tns7Wd552anruaG49f+bl54yGfDt1t/P3K0TumItuvL0I1e+GVyUAVH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218055>

I have been working on the pack-refs code [1] and noticed what looks
like a problem with the handling of peeled refs in the packed-refs file
and in the reference cache.  In particular, the peeled versions of tags
outside of refs/tags are *not* stored in packed-refs, but after the
packed-refs file is read it is assumed that such tags cannot be peeled.

It is clear that annotated tags want to live under refs/tags, but there
are some ways to create them in other places (see below).  It is not
clear to me whether the prohibition of tags outside of refs/tags should
be made more airtight or whether the peeling of tags outside of
refs/tags should be fixed.

Example:

~/tmp$ git init foo
Initialized empty Git repository in /home/mhagger/tmp/foo/.git/
~/tmp$ cd foo
~/tmp/foo$ git config user.name 'Lou User'
~/tmp/foo$ git config user.email 'luser@exaple.com'
~/tmp/foo$
~/tmp/foo$ git commit --allow-empty -m "Initial commit"
[master (root-commit) 7e80ddd] Initial commit
~/tmp/foo$ git tag -m footag footag
~/tmp/foo$
~/tmp/foo$ # This is prohibited:
~/tmp/foo$ git update-ref refs/heads/foobranch $(git rev-parse footag)
error: Trying to write non-commit object
d9cdc84dd156ff83799f5226794711fbb2c8273a to branch refs/heads/foobranch
fatal: Cannot update the ref 'refs/heads/foobranch'.
~/tmp/foo$
~/tmp/foo$ # But this is allowed:
~/tmp/foo$ git update-ref refs/remotes/foo/bar $(git rev-parse footag)
~/tmp/foo$
~/tmp/foo$ # So is this:
~/tmp/foo$ git update-ref refs/yak/foobranch $(git rev-parse footag)
~/tmp/foo$
~/tmp/foo$ # Before packing, all tags are available in peel versions:
~/tmp/foo$ git show-ref -d
7e80ddd68f0225a0ea221f7cddbacf050be5a265 refs/heads/master
d9cdc84dd156ff83799f5226794711fbb2c8273a refs/remotes/foo/bar
7e80ddd68f0225a0ea221f7cddbacf050be5a265 refs/remotes/foo/bar^{}
d9cdc84dd156ff83799f5226794711fbb2c8273a refs/tags/footag
7e80ddd68f0225a0ea221f7cddbacf050be5a265 refs/tags/footag^{}
d9cdc84dd156ff83799f5226794711fbb2c8273a refs/yak/foobranch
7e80ddd68f0225a0ea221f7cddbacf050be5a265 refs/yak/foobranch^{}
~/tmp/foo$
~/tmp/foo$ git pack-refs --all
~/tmp/foo$
~/tmp/foo$ # After packing, tags outside of refs/tags are not peeled any
more:
~/tmp/foo$ git show-ref -d
7e80ddd68f0225a0ea221f7cddbacf050be5a265 refs/heads/master
d9cdc84dd156ff83799f5226794711fbb2c8273a refs/remotes/foo/bar
d9cdc84dd156ff83799f5226794711fbb2c8273a refs/tags/footag
7e80ddd68f0225a0ea221f7cddbacf050be5a265 refs/tags/footag^{}
d9cdc84dd156ff83799f5226794711fbb2c8273a refs/yak/foobranch
~/tmp/foo$
~/tmp/foo$ # Peeling the tags via "tag^0" works even after packing:
~/tmp/foo$ git rev-parse refs/yak/foobranch^0
7e80ddd68f0225a0ea221f7cddbacf050be5a265
~/tmp/foo$
~/tmp/foo$ # Here is another way to create a tag outside of refs/tags:
~/tmp/foo$ cd ..
~/tmp$ git clone foo foo-clone
Cloning into 'foo-clone'...
done.
~/tmp$ cd foo-clone
~/tmp/foo-clone$ git config --add remote.origin.fetch
'+refs/tags/*:refs/remotes/origin/tags/*'
~/tmp/foo-clone$ git fetch
From /home/mhagger/tmp/foo
 * [new tag]         footag     -> origin/tags/footag
~/tmp/foo-clone$
~/tmp/foo-clone$ # Again, the tag outside of refs/tags are not peeled
correctly after packing:
~/tmp/foo-clone$ git pack-refs --all
~/tmp/foo-clone$ git show-ref -d
7e80ddd68f0225a0ea221f7cddbacf050be5a265 refs/heads/master
7e80ddd68f0225a0ea221f7cddbacf050be5a265 refs/remotes/origin/HEAD
7e80ddd68f0225a0ea221f7cddbacf050be5a265 refs/remotes/origin/master
d9cdc84dd156ff83799f5226794711fbb2c8273a refs/remotes/origin/tags/footag
d9cdc84dd156ff83799f5226794711fbb2c8273a refs/tags/footag
7e80ddd68f0225a0ea221f7cddbacf050be5a265 refs/tags/footag^{}

Michael

[1] I am trying to fix the problem that peeled refs are lost whenever a
packed reference is deleted.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
