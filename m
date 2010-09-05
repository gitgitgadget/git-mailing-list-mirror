From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/3] fast-import: give importers access to the object
 store
Date: Sat, 4 Sep 2010 22:15:28 -0500
Message-ID: <20100905031528.GA2344@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 05:17:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os5jT-0000a1-Lw
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 05:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511Ab0IEDRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 23:17:23 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43240 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab0IEDRW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 23:17:22 -0400
Received: by iwn5 with SMTP id 5so2955574iwn.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 20:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QsC9ITesSCi+zlCsYMkktpWBGDJuVz5WRJ6Y0n4CoE4=;
        b=fzD8uzyey5GY+7fnftBcoOjz6PqDAo8m8euWz9LO7KKkvvReyxqwH0GPS+BB0fH5Ry
         LtefYPtoMXz9o894xycT/EBBT5scSTzgL/kR37EPgzJBxqeoWFDBy7g69HeiK/uDXLve
         GFIlVwhDBwgU6M9+jgtb+m4xlSYxEvEZv+B6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rS0k2p3yr86gjc3wbVzLI3h/0FMIk0FfRPcBt94/pdLcOr6nFRtwxk1EBVzaKLjtAL
         xjQIv5kj+NjDkINnPwBVMCErXcwbUkxpaU/RIRs2D4YVy9CBV+JEs2oeBvn/cNW2ikA6
         oKirdlg0OE+VkZdizxrxQkF17YpYPM382qpes=
Received: by 10.231.171.7 with SMTP id f7mr3765899ibz.72.1283656641977;
        Sat, 04 Sep 2010 20:17:21 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id z6sm4039946ibc.0.2010.09.04.20.17.21
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 20:17:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817170216.GA14491@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155417>

Hi Ram,

Ramkumar Ramachandra wrote:

> I'm resurrecting this thread. We need to finish this feature before we
> can finish the dumpfilev3 support in svn-dump-fast-export.

Ok.

To recap, because fast-import does not write a pack index until the
checkpoint, frontends cannot necessarily read back what they have
written immediately.  The obvious application to allowing that is as a
sanity check, but more important to us is that it allows the lazy
frontend to forget previous revisions even if they are required for
later "file/directory copy" operations in the import.  The frontend
can be secure in the knowledge that the backend remembers everything
now.

It works like this:

frontend:
	feature report-fd=3
	commit refs/heads/master
	... revision 1 ...

importer:
	abc7856cba76bca87a65bca76bca8bca98bca78bca76

frontend:
	commit refs/heads/master
	... revision 2 ...

importer:
	fcdafecfdacba667cd5a4da6dca5fa68ca897dc65178

...

frontend:
	commit refs/heads/master
	... revision 50 ...

	cat abc7856cba76bca87a65bca76bca8bca98bca78

importer:
	c78a67d9987da089cd89ac879dacd897acd879acd76
	commit abc7856cba76bca87a65bca76bca8bca98bca78bca76 274819
	tree <... tree name ...>
	author <... author name ...>
	...

I suspect that these patches are not in their final form.
In particular, the interface is kind of klunky: to name a
blob by path, you have to supply a *tree* which contains that
blob as well as the pathname.  So retrieving, say,
v1.7.1:Documentation/git-fast-import.txt, would require
three round-trips: one to dereference the tag, one to dereference
the commit, and then one to finally retrieve the blob.

Another possible concern is that this is very much git specific.
Other fast-import backends are just not going to be able to do
it with the same format.  Is there a convention for naming
options like that?

Still, I hope it is useful to start with.  Thoughts?  Ideas?
Improvements?

Jonathan Nieder (3):
  t9300 (fast-import): style tweaks
  Teach fast-import to print the id of each imported commit
  fast-import: Let importers retrieve the objects being written

 Documentation/git-fast-import.txt |   45 +
 fast-import.c                     |  126 ++
 t/t9300-fast-import.sh            | 3371 ++++++++++++++++++++-----------------
 3 files changed, 1960 insertions(+), 1582 deletions(-)

-- 
1.7.2.3
