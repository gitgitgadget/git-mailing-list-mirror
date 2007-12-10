From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Performance problem, long run of identical hashes
Date: Mon, 10 Dec 2007 11:20:40 -0500
Message-ID: <9e4733910712100820k1bd0959fsdfae92727826c6db@mail.gmail.com>
References: <9e4733910712100707i66e185bofe22805b8e0ba4d8@mail.gmail.com>
	 <alpine.LFD.0.99999.0712101037270.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 17:21:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1lNT-0007Sx-LC
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 17:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbXLJQUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 11:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbXLJQUq
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 11:20:46 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:14346 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbXLJQUq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 11:20:46 -0500
Received: by py-out-1112.google.com with SMTP id u77so304594pyb
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 08:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=u+VeRJVRd9Ag95QGkYH8Kppfnq500aV+EzoYdViSJvI=;
        b=M2F4v/4LnG2azmjUXv7vdcDT+pyPvGQ5aYGErDAxtf2D3F8tZAtJSWTbIhz0L/ZnnH5zR2+eihn2u6eK1iXQjBg2vw+Lx0pvGvT2VVQw7nPgem1EMnFyySTvRqOt/4Q3Of80eRLeYgsREfDbeKwwoY/Zf8zq/Vdmp5oDMkJ9ScM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KoazIjQ+eML1nlQ5zPYwPLHVY2P47f7hjTMFAVbxQ8JWaHXPpy/jOt42/1qQSU/ys0Iy9MLlGe5H7PObJcnWf4kApwDeFDdCjoDo7Ug66jP+STQeemas7V7Su1DudhPogZ1VmYvsj5M6bnfLQTCW6ZkfH3X/GCstAOjMoVeUx6c=
Received: by 10.114.95.1 with SMTP id s1mr6074806wab.1197303640164;
        Mon, 10 Dec 2007 08:20:40 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Mon, 10 Dec 2007 08:20:40 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712101037270.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67728>

On 12/10/07, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 10 Dec 2007, Jon Smirl wrote:
>
> > Running oprofile during my gcc repack shows this loop as the hottest
> > place in the code by far.
>
> Well, that is kind of expected.
>
> > I added some debug printfs which show that I
> > have a 100,000+ run of identical hash entries. Processing the 100,000
> > entries also causes RAM consumption to explode.
>
> That is impossible.  If you look at the code where those hash entries
> are created in create_delta_index(), you'll notice a hard limit of
> HASH_LIMIT (currently 64) is imposed on the number of identical hash
> entries.

On 12/10/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 12/9/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > +               if (victim) {
> > > +                       sub_size = victim->remaining / 2;
> > > +                       list = victim->list + victim->list_size - sub_size;
> > > +                       while (sub_size && list[0]->hash &&
> > > +                              list[0]->hash == list[-1]->hash) {
> > > +                               list++;
> >
> > I think you needed to copy sub_size to another variable for this loop
>
> Copying sub_size was wrong. I believe you are checking for deltas on
> the same file. It's probably that chain of 103,817 deltas that can't
> be broken up.

At the end of multi-threaded repack one thread ends up with 45 minutes
of work after all the other threads have exited. That's because it
hits this loop and can't spit the list any more.

If the lists can't be over 64 identical entries, why do I get caught
in this loop for 50,000+ iterations? If remove this loop the threads
are balanced right to the end.

-- 
Jon Smirl
jonsmirl@gmail.com


-- 
Jon Smirl
jonsmirl@gmail.com
