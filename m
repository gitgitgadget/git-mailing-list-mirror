From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Efficiency of initial clone from server
Date: Mon, 12 Feb 2007 00:17:19 -0500
Message-ID: <9e4733910702112117o53630946ja50572c7c7f2b2c1@mail.gmail.com>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	 <20070211225326.GC31488@spearce.org>
	 <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
	 <Pine.LNX.4.64.0702112022430.1757@xanadu.home>
	 <7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
	 <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
	 <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
	 <20070212051108.GB699@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, "Nicolas Pitre" <nico@cam.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 06:17:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGTZC-0008Em-WA
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 06:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932991AbXBLFRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 00:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932992AbXBLFRW
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 00:17:22 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:40511 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991AbXBLFRV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 00:17:21 -0500
Received: by wr-out-0506.google.com with SMTP id i21so1558177wra
        for <git@vger.kernel.org>; Sun, 11 Feb 2007 21:17:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bayzncplY7zvd3/A+e9LtHDfRC/Nmq1e+u2nbJVVCvqOGwjJFOpkfSUa3u4GX59Lygl4tFFFxJc2TS2nKeXGlctZFIbQIfQ003rVtHDPzcnH2Vvxxxqko8FfpqxxKh2U1YNi+C/0+11HzFQ3SWZ3kys09CbtsNEd34DTvOx1U0Y=
Received: by 10.114.171.1 with SMTP id t1mr5545299wae.1171257439971;
        Sun, 11 Feb 2007 21:17:19 -0800 (PST)
Received: by 10.114.195.13 with HTTP; Sun, 11 Feb 2007 21:17:19 -0800 (PST)
In-Reply-To: <20070212051108.GB699@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39366>

On 2/12/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > But pack to the original point, can't the server check and see if it
> > has write access so that it can keep the fully packed tree? I've just
> > caused kernel.org to needlessly repack the wireless-dev tree a dozen
> > times playing with this clone command. If it didn't have to keep
> > repacking for the clone, clone would be a lot faster.
>
> We probably could.
>
> I have actually been thinking about another problem that is
> somewhat related.  We cannot put more than 4 GiB of data into a
> single packfile, due to the current index size limitation, or more
> than 2^32-1 objects into one packfile, due to the header nr_objects
> field size.
>
> Right now we are sending a single packfile down to the client,
> even if the remote server end has the repository broken down into
> a couple of packfiles (such as "really old historical stuff" and
> "active stuff from this year").  If we could send more than one
> packfile to the client in a single stream, we could still keep the
> file size limitations.
>
> We can also avoid this huge repack case on the server.  Because it
> could just send all of the packfiles that it already has, followed
> by whatever is loose which wasn't in a prior packfile.  And no
> write access required.
>
> Of course, we still could do the optimization of caching the
> packfile, but I'm not sure how well that would work on kernel.org,
> as I understand the trees are owned by the devs which created them
> while the git daemon is probably not running as their UNIX user.

I didn't want to cache the packfile, instead I wanted to repack the
repository and then copy the resulting pack file down the wire. A
clone would just be a trigger to make sure everything in the repo was
packed (maybe into multiple packs) before starting to send anything.
Doing it this way means that everyone benefits from the packing.


>
> --
> Shawn.
>


-- 
Jon Smirl
jonsmirl@gmail.com
