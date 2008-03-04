From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix git init --shared=all on FreeBSD 4.11
Date: Tue, 4 Mar 2008 08:25:19 +0100
Message-ID: <20080304072519.GA3070@steel.home>
References: <20080303234406.GA28158@steel.home> <7v1w6rfhyn.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 08:26:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWRXE-00088s-22
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 08:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbYCDHZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 02:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756193AbYCDHZW
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 02:25:22 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:40193 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbYCDHZV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 02:25:21 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSg3Lc=
Received: from tigra.home (Fa8a4.f.strato-dslnet.de [195.4.168.164])
	by post.webmailer.de (fruni mo33) (RZmta 16.8)
	with ESMTP id c072bbk247L9Vv ; Tue, 4 Mar 2008 08:25:19 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A6234277BD;
	Tue,  4 Mar 2008 08:25:19 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 179BF56D24; Tue,  4 Mar 2008 08:25:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v1w6rfhyn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76041>

Junio C Hamano, Tue, Mar 04, 2008 01:31:12 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > At least FreeBSD 4.11p2 does not allow changing SUID/GUID bits to
> > a non-root user.
> 
> Sorry, but I do not understand this change.
> 

Now that I look at it again, I admint I don't understand what I was
thinking either. I see the problem in t1301-shared-repo.sh: it fails
to chmod(042775, ".git/refs") with EPERM.

Will re-investigate.

> > diff --git a/path.c b/path.c
> > index af27161..4865e98 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -265,6 +265,7 @@ int adjust_shared_perm(const char *path)
> >  		return 0;
> >  	if (lstat(path, &st) < 0)
> >  		return -1;
> > +	st.st_mode &= 07777 & ~(S_ISUID|S_ISGID);
> >  	mode = st.st_mode;
> 
> If the thing is a directory, we say later in the code that we want to see
> S_ISGID set, like this:
> 
> 	...
> 	if (S_ISDIR(mode))
> 		mode |= S_ISGID;
> 	if ((mode & st.st_mode) != mode && chmod(path, mode) < 0)
> 		return -2;
> 	return 0;
> 
> and then we compare with st.st_mode so that we do not chmod() what's
> already good  Your change means we will always try to chmod all the
> directories, and your explanation suggests that such a chmod to do g+s on
> directories would also fail (and your patch does not fix it -- we actively
> try to make sure directories have g+s set).

The change is very bogus. Dunno how it happened...

> 	Side note. the wording in your message, "does not allow changing",
> 	is very unclear.  Do you mean "non-root cannot do u+s,g+s"?  Or do
> 	you mean "non-root cannot do u+s,g+s, non-root cannot do u-s,g-s
> 	either"?

chmod(2), as it was, just fails. It seemed like the ordinary users
could not do g+s (which is what the function is actually supposed to
do).

> I do not mind a change to make sure we do u-s,g-s on regular files, but I
> do not think it is necessary, and I am curious why you had files with such
> perm bits to begin with.

It is a directory. The bit 02000 is S_ISGID on FreeBSD too. It just
does not work (now I am just observing, no coding).

