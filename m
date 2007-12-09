From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Sun, 9 Dec 2007 13:25:04 -0500
Message-ID: <9e4733910712091025s27c3d698yba78eed4306cd3ec@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
	 <7vodd0vnhv.fsf@gitster.siamese.dyndns.org>
	 <7vprxgs36w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 19:25:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1QqF-00053P-Q7
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 19:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbXLISZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 13:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbXLISZH
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 13:25:07 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:36128 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbXLISZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 13:25:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2832275wah
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 10:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OCnJdzGAY2pFlLVVnwVmJo4enOAMqrI/7V8beww+82w=;
        b=le4AGGPYUnhobJH6sacInn22bpz3N2vwSgR7IhLj4HCCfXeuODD0UNuEKamMFoeJchnqyFA8HdhvBByViFMKX65hr7XwtY2AoeedTWTuW9UgIvpJlcvA3e0Gl2P8vSHZb1jL30pr2giBgU1e1ZD98oppZoAougFocNoE9t4yBV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I2WKR12KZSmrTLaUiWUNybBMvv4gSLEvLwXQkH23R0QB7JHCCa6ah9ajXhpBAdzsa5AAk0c0Ft0fTo+wRVP1/31lOy++D/0GnBsnzbN9F8CslR2N0hn0ArsLZyXOztWCt49CILxojzxxYZs5lkog7v3KBT9+FmkJHk03asaDaw8=
Received: by 10.114.27.20 with SMTP id a20mr5763889waa.1197224704225;
        Sun, 09 Dec 2007 10:25:04 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Sun, 9 Dec 2007 10:25:04 -0800 (PST)
In-Reply-To: <7vprxgs36w.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67646>

On 12/9/07, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Nicolas Pitre <nico@cam.org> writes:
> >
> >> On Fri, 7 Dec 2007, Jon Smirl wrote:
> >>
> >>> Starting with a 2GB pack of the same data my process size only grew to
> >>> 3GB with 2GB of mmaps.
> >>
> >> Which is quite reasonable, even if the same issue might still be there.
> >>
> >> So the problem seems to be related to the pack access code and not the
> >> repack code.  And it must have something to do with the number of deltas
> >> being replayed.  And because the repack is attempting delta compression
> >> roughly from newest to oldest, and because old objects are typically in
> >> a deeper delta chain, then this might explain the logarithmic slowdown.
> >>
> >> So something must be wrong with the delta cache in sha1_file.c somehow.
> >
> > I was reaching the same conclusion but haven't managed to spot anything
> > blatantly wrong in that area.  Will need to dig more.
>
> Does this problem have correlation with the use of threads?  Do you see
> the same bloat with or without THREADED_DELTA_SEARCH defined?
>

Something else seems to be wrong.

With threading turned off,  5000 CPU seconds and 13% done.
With threading turned on, threads = 1, 5000 CPU seconds, 13%
With threading turned on, threads = 2, 180 CPU seconds, 13%
With threading turned on, threads = 4, 150 CPU seconds, 13%

This can't be right, four cores are not 40x one core. So maybe the
observed logarithmic slow down is because the percent complete is
being reported wrong in the threaded case. If that's the case we may
be looking in the wrong place for problems.

The times are only approximate, I'm using the CPU for other things.

-- 
Jon Smirl
jonsmirl@gmail.com
