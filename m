From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [PATCH] Make git prune remove temporary packs that look like write failures
Date: Wed, 6 Feb 2008 19:10:36 +0000
Message-ID: <e1dab3980802061110p2c1dad1ep8a46eeda93839bb9@mail.gmail.com>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>
	 <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Steven Tweed" <d.s.tweed@reading.ac.uk>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:11:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMpfv-00045W-M3
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 20:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972AbYBFTKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 14:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754894AbYBFTKl
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 14:10:41 -0500
Received: from ti-out-0910.google.com ([209.85.142.186]:15520 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbYBFTKk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 14:10:40 -0500
Received: by ti-out-0910.google.com with SMTP id 28so302654tif.23
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 11:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sAGkt5iVg9pArLsikHukYUD8j6Z0Y56rJY/WSl1sWTc=;
        b=QQjDVl4Ca6CJ4woP9rkUQRJBuomJxqHOO0B2V9yNJM5CusqwFguRbbSL5FmwDn8+7+7Z0yQDyewY+u1KlAodiJu1B4qXm688cfMOve/LSg/5u8mIhZ6IFpfc1uBhJsjU0WOCV5OuJ3CF/nISJzdp6oYuzokqFxRZcbozLElQVTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H/LgCKP+1G4g37NeFKF8K4wYLAs2jxyr/tWH4qtMdKMMfIK24PRangJt4FW+Yg9Utme+T6V5mT23a6DuAlMhNK+5Fn+LY+eub/HxLY7zSHK3rdSrHvWH/uEVZjhnhEojTQyjDl7Ibi//7mo1udlc+C9dT4CRgqc0x15brZa5oCw=
Received: by 10.150.139.15 with SMTP id m15mr4352288ybd.99.1202325036201;
        Wed, 06 Feb 2008 11:10:36 -0800 (PST)
Received: by 10.150.149.2 with HTTP; Wed, 6 Feb 2008 11:10:36 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72827>

On Feb 5, 2008 7:02 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 5 Feb 2008, David Steven Tweed wrote:
>
> > @@ -115,5 +139,6 @@ int cmd_prune(int argc, const char **argv, const char
> > *prefix)
> >
> >       sync();
> >       prune_packed_objects(show_only);
> > +     remove_temporary_files();
>
> Maybe you could implement the "show_only" mode for
> remove_temporary_files() as well?  Otherwise the -n option would not be
> respected.
>
> Also you should consider honoring the --expire option as well.

I guess the -n ought to be honoured. However, unless I'm missing
something, the case of expiring objects is different. The primary
reason is that objects can get orphaned by "semantic" decisions
(delete this branch, rewind, etc) so they contain valid content that
you might want to later rescue (using low-level command like git cat
if necessary). In contrast, the only way to get a temporary pack when
the repository is quiescent is resulting from a _write error_ and thus
is a corrupt entity which it would take a great deal of work to
extract any valid data from. (To be honest, I wouldn't be bothering to
delete them if it weren't for the fact that they can be quite big
files, and once you've got one from out-of-space you're more likely to
get another in future because you've got even less space.) So it's not
obvious that the same conditions should apply as to valid objects.

Does it really make sense to apply expire to these?

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
