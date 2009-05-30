From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v5 2/3] path: add a find_basename() portability function
Date: Sat, 30 May 2009 15:14:14 -0700
Message-ID: <20090530221413.GA10850@gmail.com>
References: <1243649890-4522-1-git-send-email-davvid@gmail.com> <1243649890-4522-2-git-send-email-davvid@gmail.com> <20090530140519.GA22905@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 31 00:14:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAWp4-0000oy-JD
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 00:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbZE3WOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 18:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbZE3WO3
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 18:14:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:55971 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbZE3WO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 18:14:28 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2069444rvb.1
        for <git@vger.kernel.org>; Sat, 30 May 2009 15:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=sj9CsUlD9/kck3GlGpNuP6ZFJ9HCjDcnzJ6bogfeguY=;
        b=cO4qlOZfrk18/3w7BLwLjKlRe/c/YB70VaRqsK/sqO2YTNh1CCo3tJ8MO0JtcapVUr
         GqSnDZbway2oEiNNnuIqnP//ktwEEvWIOhIHHpUoDostJHjMxtQYhBjCLMqKRBVAa220
         xGegVT3wODnzKA3J0FgZPDgojXCLwFla+iI1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ogKIvPAjKqat0R1VEieelNmwPVsJZ98qSZu3veGd+j0VabApZ60ZbW447TkfqcpcSq
         b+Pa5ZN+NGHkPuUhxba6ugBQm4pXrR4VSUAiASZuTQwNcwjI8LrHsYcVE7ifbzaaDT7q
         pkFUFuBboFyH4kl1Ht0gT6QoaWm5fLO3IUjNA=
Received: by 10.140.139.4 with SMTP id m4mr3538293rvd.292.1243721670490;
        Sat, 30 May 2009 15:14:30 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id k35sm4057743waf.22.2009.05.30.15.14.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 May 2009 15:14:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090530140519.GA22905@sigill.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120367>

On Sat, May 30, 2009 at 10:05:19AM -0400, Jeff King wrote:
> On Fri, May 29, 2009 at 07:18:09PM -0700, David Aguilar wrote:
> 
> > +/* return the basename of a path */
> > +const char *find_basename(const char *path)
> > +{
> > +	const char *basename = path + strlen(path) - 1;
> > +	while(*basename && basename > path) {
> > +		basename--;
> > +		if (is_dir_sep(*basename)) {
> > +			basename++;
> > +			break;
> > +		}
> > +	}
> > +	return basename;
> > +}
> 
> Hmm. Is there any point to the *basename condition in the loop? By using
> strlen, you are not going to go past any NULs, and you are already
> checking that you don't go past the beginning of the string.
> 
> Speaking of which, how does this handle an input of ""? It seems that it
> would return a pointer to one character before the string. Given your
> loop, you need to special-case when *path is NUL.
> 
> Also, how should trailing dir_seps be handled? basename() will actually
> return "" if given "foo/". Your implementation, when given "/foo/bar/"
> will return "bar/" (and it must keep the trailing bit since we are
> neither reallocating nor munging the input string). But given
> "/foo/bar//", it will return simply "/". I could see an argument for
> either "bar//" or "", but I think behaving differently for trailing "/"
> versus trailing "//" doesn't make sense.
> 
> -Peff

You know.. going with the compat/basename.c solution is probably
a better idea now that you've pointed out all these issues.
Then we can just use the system's basename() when available and
use our compat/basename.c otherwise (is it only for Windows?).

Here's basename() from libiberty.

It drops constness (likely to keep in line with the standard)
and has some #defines that I'll have to translate into git
equivalents (e.g. IS_DIR_SEPARATOR -> is_dir_sep).

Do we have a cross-platform ISALPHA thing (just thinking out
loud -- I can check).  I'm under the impression that going with
something like this should get us in a better place.

What do you think?


char *basename (const char *name)
{
	const char *base;
#if defined (HAVE_DOS_BASED_FILE_SYSTEM)
	/* Skip over the disk name in MSDOS pathnames. */
	if (ISALPHA (name[0]) && name[1] == ':') 
		name += 2;
#endif

	for (base = name; *name; name++) {
		if (IS_DIR_SEPARATOR (*name)) {
			base = name + 1;
		}
	}
	return (char *) base;
}

-- 
		David
