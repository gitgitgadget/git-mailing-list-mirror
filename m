From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/8] Re: bug: git-bundle create foo --stdin -> segfault
Date: Sat, 26 Jun 2010 01:17:35 -0500
Message-ID: <20100626061735.GA15881@burratino>
References: <20100119002641.GA31434@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, 554682@bugs.debian.org,
	Adam Brewster <adambrewster@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jun 26 08:18:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSOiG-0006BS-NK
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 08:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab0FZGRu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 02:17:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65341 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0FZGRt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 02:17:49 -0400
Received: by iwn41 with SMTP id 41so2710248iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 23:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=L4Py/P314pd+rGuMHTX8QQnJ2Km/eQ5cdsz8KxZFAfk=;
        b=Av0tRSq/NcYhQbBoHmWf/iWrLKaXlfMkjPykFqYSmUQMrNFwlKdLV1WMvi2MH4RkBS
         GmJv7YNtr7TS4bNTyA0VfMrBT7pkz3kJlQdO68onB4MwS7secRUPFHjm2JF/W3PYZ5o6
         Pmi4M0O47yV+LXPBZGoCIzuDxLR+bgdB4JYyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OjVQw34QMhMxqiCqvSiendBBnXvjzkYe/4E+H9Yk67QltQkXi1V8HyDmnBjyUUo1/+
         MyIHeGBSuv6Sv+YVjn9tQbDeT5xjA+DNzFGkzxKz3CnFJHW/+mrPrGYREqMWdVBFVHwN
         NK3jjllryN6eA1NUEpvQhsunMivZAkCQk8fas=
Received: by 10.231.130.142 with SMTP id t14mr1806734ibs.155.1277533069207;
        Fri, 25 Jun 2010 23:17:49 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id u6sm50266678ibu.0.2010.06.25.23.17.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 23:17:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100119002641.GA31434@gnu.kitenet.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149728>

Joey Hess wrote:

> I noticed that git bundle --stdin actually attempts to read from stdi=
n
> past EOF.

Patch 5 below fixes that.  Sadly it is not the whole story and I had
to introduce a memory leak for all users of --stdin to make
=E2=80=98bundle --stdin=E2=80=99 actually work (patch 6).

In the case of bundle --stdin, I think the leak is unavoidable, while
in general, I suspect a parameter is needed to allow the caller to
indicate whether the leak is needed (analogous to save_commit_buffer).

The rest of the patches should be comparatively pleasant.

Patches 1, 3, and 4 give various parts of bundle creation their own
functions, to make the code easier to digest;

Patch 2 teaches the basis discovery code (which currently forks a
rev-list --boundary process) to use the revision walker directly, to
prepare for patch 5.

Patch 5 looked like it would be the main point of the series: it saves
the list of revs including those read from stdin and resets the
revision walker after the boundary is found.  This way, stdin is only
read once and the underlying logic of the revision walk does not need
to be changed significantly.

Even with patch 5, bundle --stdin still finds no revisions to read.
The problem: to write the table of contents, the name passed on the
command line for each ref is needed.  Unfortunately, names passed
through stdin are kept in a temporary buffer and then freed; the
random gibberish read instead does not look like a meaningful ref
name, so no valid toc entries are found.

Patch 6 fixes this, at the cost of a memory leak.  Suggestions for
avoiding the leak would of course be welcome.

Patch 7 adopts a similar =E2=80=9Cfix=E2=80=9D in a context where it is=
 not needed.
This is just for illustration.

Patch 8 is an unrelated enhancement that came along the way.

Thanks to Joey for the report and Johannes for suggestions for fixing
it.

Thoughts?  Tests to add?
Jonathan Nieder (8):
  bundle: split basis discovery into its own function
  bundle: use libified rev-list --boundary
  bundle: split body of list_prerequisites() loop into its own function
  bundle: split table of contents output into its own function
  bundle: reuse setup_revisions result
  revision: Keep ref names after reading them from stdin
  bundle: Keep names of basis refs after discovery
  bundle_create: Do not exit when given no revs to bundle

 bundle.c          |  172 ++++++++++++++++++++++++++++++++++-----------=
--------
 revision.c        |    2 +-
 t/t5704-bundle.sh |    4 +-
 3 files changed, 113 insertions(+), 65 deletions(-)
