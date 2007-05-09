From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Tue, 8 May 2007 23:46:57 -0700
Message-ID: <56b7f5510705082346m32d3c48dj987fd9b0a6118c10@mail.gmail.com>
References: <4640FBDE.1000609@gmail.com>
	 <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
	 <alpine.LFD.0.99.0705082010230.24220@xanadu.home>
	 <56b7f5510705081729t34a585c6y9ca9e2f9963d24a2@mail.gmail.com>
	 <alpine.LFD.0.99.0705082031370.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 09 08:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlfx1-0000OY-P3
	for gcvg-git@gmane.org; Wed, 09 May 2007 08:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966479AbXEIGq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 02:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966586AbXEIGq7
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 02:46:59 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:26803 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966479AbXEIGq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 02:46:58 -0400
Received: by nz-out-0506.google.com with SMTP id o1so91239nzf
        for <git@vger.kernel.org>; Tue, 08 May 2007 23:46:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QbEKDfAgLB9l4t7T5ikrFbt+SVTrjovYLiVYQbG8BFIY4vDcKrupvmMY91zO+HwqvvTZbWYBP6ZSDjtIgTfxQ+P+Hj6GOaYAOmkUYy04z4zeByAmM0Q4ZB2+iI4WQBU5cf1g96Fk9eOjUWeSwDTHs7FcjwaFea8iU6SZS6EADqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DcbGf2PpOBxXF9LXPlbklfQ+t4HmF7TwnrkX8882hrrAgBvDSxdnk1M32fLm0qp4Q9ogZuda9J3HWXV4OmYvbj8GF7bb1nmOGA/thwwvI58H2gHpqbQj0CXVfBc7lqkzYw2tUNB8LSeMptJicqfus8wl20WyosWvaNIuk3Q2rOk=
Received: by 10.114.148.1 with SMTP id v1mr91810wad.1178693217526;
        Tue, 08 May 2007 23:46:57 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Tue, 8 May 2007 23:46:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0705082031370.24220@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46669>

On 5/8/07, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 8 May 2007, Dana How wrote:
> > On 5/8/07, Nicolas Pitre <nico@cam.org> wrote:
> > > On Tue, 8 May 2007, Junio C Hamano wrote:
> > > If we want the fallback logic to work, at some point we must remember if
> > > the current value is the default or if it is the result of an explicit
> > > config option.
> > I can leave as-is, or use a magic value like -99 and
> > depend on it not colliding with values in zlib.h.
> And where would you set those variables to a sensible default in the
> absence of any config option?
This is why I used the _seen variables,
but they are not necessary -- see 3rd option below.

Unfortunately we agreed a day or two ago to use a config rule like
used_value = isset(var1) ? var1 : isset(var2) ? var2 : DEFAULT.
This doesn't interact well with each variable being processed
completely independently in git_config() and the callbacks it calls.
The isset() value is "out-of-band"; either store it in the _seen
variables, or some special value in used_value .

Which makes the most sense:
* Leave _seen as-is;
* Move pack.compression recognition into config.c which means
  the _seen variables would all be local to config.c;
* Use some special value, and if still present replace it with the default
  at the end of git_config() using extra code;
* Change the config rule to something simpler.

I like the 2nd and the 4th.  You didn't like the 4th.
Shall I change to the 2nd?

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
