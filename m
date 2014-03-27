From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] patch-id: make it stable against hunk reordering
Date: Thu, 27 Mar 2014 19:57:46 +0200
Message-ID: <20140327175746.GA3853@redhat.com>
References: <1395912239-29663-1-git-send-email-mst@redhat.com>
 <xmqqvbuzefy6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 18:57:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTEYa-00018Y-TX
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 18:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827AbaC0R5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 13:57:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46701 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756701AbaC0R5b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 13:57:31 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2RHvO1G032654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 27 Mar 2014 13:57:25 -0400
Received: from redhat.com (vpn1-7-130.ams2.redhat.com [10.36.7.130])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s2RHvLsw018163;
	Thu, 27 Mar 2014 13:57:22 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbuzefy6.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245301>

On Thu, Mar 27, 2014 at 09:58:41AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Patch id changes if you reorder hunks in a diff.
> 
> If you reorder hunks, the patch should no longer apply [*1*], so a
> feature to make patch-id stable across such move would have no
> practical use ;-), but I am guessing you meant something else.
> 
> Perhaps this is about using "-O <orderfile>" option, even though you
> happened to have implemented the id mixing at per-hunk level?
> 
> 
> [Footnote]
> 
> *1* It has been a long time since I looked at the code, and I do not
> know offhand if "git apply" has such a bug not to diagnose a hunk
> for a file for an earlier part that comes later in its input stream
> after seeing another hunk for the same file as a bug. If it does
> not, perhaps we should.

I started to remove that code, but then I recalled why I did it like
this.  There is a good reason.  Yes, you can't simply reorder hunks just
like this.  But you can get the same effect by prefixing the header:



--- x.txt	2014-03-27 19:31:18.166115449 +0200
+++ y.txt	2014-03-27 19:31:46.731116998 +0200
@@ -30,8 +31,6 @@ a
 a
 a
 a
-a
-b
 b
 b
 b
@@ -60,6 +59,7 @@ b
 b
 b
 b
+Y
 b
 b
 b
--- x.txt	2014-03-27 19:31:18.166115449 +0200
+++ y.txt	2014-03-27 19:31:46.731116998 +0200
@@ -11,6 +11,7 @@ a
 a
 a
 a
+X
 a
 a
 a


Is equivalent to 

--- x.txt	2014-03-27 19:31:18.166115449 +0200
+++ y.txt	2014-03-27 19:31:46.731116998 +0200
@@ -30,8 +31,6 @@ a
 a
 a
 a
-a
-b
 b
 b
 b
@@ -60,6 +59,7 @@ b
 b
 b
 b
+Y
 b
 b
 b
--- x.txt	2014-03-27 19:31:18.166115449 +0200
+++ y.txt	2014-03-27 19:31:46.731116998 +0200
@@ -11,6 +11,7 @@ a
 a
 a
 a
+X
 a
 a
 a


And this works fine with regular tools like patch
so I think it should work for git too, anything else
would be surprising.


-- 
MST
