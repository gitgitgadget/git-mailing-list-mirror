From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2 2/4] gitignore: read from index if .gitignore is
  assume-unchanged
Date: Tue, 11 Aug 2009 10:12:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908111009010.4638@intel-tinevez-2-302>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com>  <1249917562-5931-2-git-send-email-pclouds@gmail.com> <1249917562-5931-3-git-send-email-pclouds@gmail.com>  <alpine.DEB.1.00.0908101826250.8324@intel-tinevez-2-302>
 <fcaeb9bf0908101857x7a44d3dfge20e45d24daee9bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1760020217-1249978325=:4638"
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqGy-0000RC-KC
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbZHKMMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbZHKMMG
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:12:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:50690 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752389AbZHKMME (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:12:04 -0400
Received: (qmail invoked by alias); 11 Aug 2009 08:12:05 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp034) with SMTP; 11 Aug 2009 10:12:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+WVP5teL2WILS+V5riea+rgY5OgTzQasHR7rlOg7
	za2aO/6F0mPcJi
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <fcaeb9bf0908101857x7a44d3dfge20e45d24daee9bf@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125527>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1760020217-1249978325=:4638
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 11 Aug 2009, Nguyen Thai Ngoc Duy wrote:

> 2009/8/10 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> > On Mon, 10 Aug 2009, Nguyễn Thái Ngọc Duy wrote:
> >
> >> @@ -212,27 +237,31 @@ static int add_excludes_from_file_1(const char *fname,
> >>
> >> [...]
> >>
> >>       if (buf_p)
> >>               *buf_p = buf;
> >> -     buf[size++] = '\n';
> >>       entry = buf;
> >> -     for (i = 0; i < size; i++) {
> >> -             if (buf[i] == '\n') {
> >> +     for (i = 0; i <= size; i++) {
> >> +             if (i == size || buf[i] == '\n') {
> >>                       if (entry != buf + i && entry[0] != '#') {
> >>                               buf[i - (i && buf[i-1] == '\r')] = 0;
> >>                               add_exclude(entry, base, baselen, which);
> >
> > Should this change not rather be a separate one?
> 
> You meant a separate patch?

Yes, sorry, I meant exactly that.

> It is tied to this patch, because if bus is read from read_index_data, 
> it does not have extra space for '\n' at the end.

But you could separate it out as a patch that just avoids writing to buf.  
IMHO this would make following the patch series easier.

> >> @@ -241,17 +270,12 @@ static int add_excludes_from_file_1(const char *fname,
> >>               }
> >>       }
> >>       return 0;
> >> -
> >> - err:
> >> -     if (0 <= fd)
> >> -             close(fd);
> >> -     return -1;
> >>  }
> >>
> >>  void add_excludes_from_file(struct dir_struct *dir, const char *fname)
> >>  {
> >>       if (add_excludes_from_file_1(fname, "", 0, NULL,
> >> -                                  &dir->exclude_list[EXC_FILE]) < 0)
> >> +                                  &dir->exclude_list[EXC_FILE], 0) < 0)
> >
> > Could you mention in the commit message why this function does not 
> > want to check the index (I _guess_ it is because this code path only 
> > tries to read .git/info/exclude, but it would be better to be sure).
> 
> To retain old behaviour. But I have to check its callers. Maybe we
> want to check the index too.

Yes, it would be good to illustrate in the commit message which code paths 
want to check the index, and why.

> >> @@ -85,6 +85,26 @@ test_expect_success \
> >>         >output &&
> >>       test_cmp expect output'
> >>
> >> +test_expect_success 'setup sparse gitignore' '
> >> +     git add .gitignore one/.gitignore one/two/.gitignore &&
> >> +     git update-index --assume-unchanged .gitignore one/.gitignore one/two/.gitignore &&
> >> +     rm .gitignore one/.gitignore one/two/.gitignore
> >> +'
> >
> > You're probably less sloppy than me; I'd have defined a variable like
> > this:
> >
> >        ignores=".gitignore one/.gitignore one/two/.gitignore"
> >
> > and used it for the three calls, just to make sure that I do not fsck
> > anything up there due to fat fingers.
> 
> I have slim ones :-)

Oh, don't get me wrong: my fingers are slim enough to play piano, and even 
to write pretty fast on my EeePC 701.

But darn, there are days when they feel as if they were thick like a 
brick.

Ciao,
Dscho

--8323329-1760020217-1249978325=:4638--
