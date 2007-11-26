From: "Dana How" <danahow@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 12:36:27 -0800
Message-ID: <56b7f5510711261236n732d56dci6335541391e1e137@mail.gmail.com>
References: <200711252248.27904.jnareb@gmail.com>
	 <56b7f5510711261118m7a402beah5d9cb75c1ad10b43@mail.gmail.com>
	 <200711262117.56326.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Nicolas Pitre" <nico@cam.org>,
	danahow@gmail.com
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:37:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwkhr-0004Kp-69
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 21:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbXKZUgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 15:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754818AbXKZUgd
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 15:36:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:23738 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204AbXKZUgc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 15:36:32 -0500
Received: by nf-out-0910.google.com with SMTP id g13so871396nfb
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 12:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=30Ggb2ct2l+lratzMXsHTNJr73zc9/WoWHbUuXxI1b0=;
        b=OIfP3Tpswum0FplzNbPiGmVuzQ+FgS9R3fb15Er40zdnUyQwO3FAxTL5cXw2eXARfc0EJPntS8po0ibSHIqzm21Vrn1cC2NWs8oeaiamXhfikTlIU3KrO1/niFqYzm9fG/FChN6Q3mi8Q/Q0UPs+2909Vn5zUIaHFNnzHMov/f0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WdNinIcUhivyvYhwMaCCqn4HYFYCDccafmdPVugpwKh1SktMJRalVQUURqAF1f0MHUiPbCLa+6mPQV/mlQUPJ0rKC1KcmCG6AKPtuvaMF4jQizf3PTA6iigdhVZ+027gATdAam5tRt43ts8+H7IYxbX9beKavu8mNWQSG1KYqV4=
Received: by 10.78.137.7 with SMTP id k7mr3485754hud.1196109388065;
        Mon, 26 Nov 2007 12:36:28 -0800 (PST)
Received: by 10.78.177.20 with HTTP; Mon, 26 Nov 2007 12:36:27 -0800 (PST)
In-Reply-To: <200711262117.56326.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66116>

On Nov 26, 2007 12:17 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 26 Nov 2007, Dana How wrote:
> > On Nov 25, 2007 1:48 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > > If you would write git from scratch now, from the beginning, without
> > > concerns for backwards compatibility, what would you change, or what
> > > would you want to have changed?
> >
> > Currently data can be quickly copied from pack to pack,
> > but data cannot be quickly copied blob->pack or pack->blob
> > (there was an alternate blob format that supported this,
> >  but it was deprecated).  Using the pack format for blobs
> > would fix this.  It would also mean blobs wouldn't need to
> > be uncompressed to get the blob type or size I believe.
>
> Could you do some benchmark for repository with your large objects
> as loose objects created with and without core.legacyHeaders (created
> with git pre 1.5.3), and as single blob packs, perhaps kept, with
> _undocumented_ (except for RelNotes) gitattribute delta unset for
> those files?
First of all,  this is a very reasonable request and what I should be doing.
Unfortunately,  I only have the cycles at the moment to point out this
issue,  which appears to be a problem from my perspective.

Currently,
a user who wants to publish some (large) files does the following:
git add (calls deflate)
git commit
git push (builds a pack to stdout, calling inflate and deflate on each blob).

So if the blob and pack formats were more similar (different blob format,
big blobs are singleton packs, etc) the zlib calls in git push go away.
The deflate call could be sped up by using 1 for compression level,
but it still takes time.

Another "solution" is to make each workgroup member's .git/objects
be a symlink to a tree with a lot of sticky bits and do some scripting.
(This means "git push" doesn't push any data and only alters stuff
 in .git/refs/heads on the server.)
I'm not entirely enthusiastic about this,  and when I mentioned it a while
ago it did cause some retching...

> From Documentation/RelNotes-1.5.3:
>
>   - We used to have core.legacyheaders configuration, when
>     set to false, allowed git to write loose objects in a format
>     that mimicks the format used by objects stored in packs.  It
>     turns out that this was not so useful.  Although we will
>     continue to read objects written in that format, we do not
>     honor that configuration anymore and create loose objects in
>     the legacy/traditional format.
>
>   - "pack-objects" honors "delta" attribute set in
>     .gitattributes.  It does not attempt to deltify blobs that
>     come from paths with delta attribute set to false.
>
>   - diff-delta code that is used for packing has been improved
>     to work better on big files.
>
> The last part is thanks to your comments, complaints and efforts, Dana.
Yes,  there have been some very useful improvements recently.

However,  I didn't actually push for the first "-" you list;
I was pushing for the "mimic" option even then
but some argument was presented to me against it,
to which I had no counter-argument until I understood git better later.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
