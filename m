From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 00:07:45 -0400
Message-ID: <9e4733910608132107j7bca0271g360de3447febbf51@mail.gmail.com>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com>
	 <20060814035603.GB18667@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 06:07:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCTjz-0001Nu-NZ
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 06:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWHNEHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 00:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWHNEHr
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 00:07:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:28819 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751840AbWHNEHr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 00:07:47 -0400
Received: by nf-out-0910.google.com with SMTP id a4so1592411nfc
        for <git@vger.kernel.org>; Sun, 13 Aug 2006 21:07:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cjgR8FPClYItShR+7t78a3REDXQy5L0QMvn1yF5j/Y6rlCqmXd4DoI1x3868KDpBs9hfzJTJzc2GRPLeiRuGrm5yuIclbeRdYL+Eb8dfggAhiK17XxppmtIZIGqoHCwjK5+W5l5tkJQWhs8TOpqH5jvyj5PlWPGFAEudhJhLPqI=
Received: by 10.78.147.3 with SMTP id u3mr2803668hud;
        Sun, 13 Aug 2006 21:07:46 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Sun, 13 Aug 2006 21:07:45 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060814035603.GB18667@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25315>

On 8/13/06, Shawn Pearce <spearce@spearce.org> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > From what I remember from long ago most compression schemes build
> > dictionaries as a way of achieving significant compression. If so,
> > since we zlib compress each entry in a pack individually, are there
> > many copies of very similar dictionaries in the pack?
>
> Yes, possibly.  Every object in the pack has its own dictionary.
>
> But I'm not sure if there would be any savings from sharing
> dictionaries.  One problem is you probably don't want a single
> massive dictionary for the entire pack as it could be very large,
> plus updating it with additions would likely require recompressing
> every entry.  Typically once an entry in the pack has been compressed
> GIT won't recompress it.

The zlib doc says to put your most common strings into the fixed
dictionary. If a string isn't in the fixed dictionary it will get
handled with an internal dictionary entry.  By default zlib runs with
an empty fixed dictionary and handles everything with the internal
dictionary.

Since we are encoding C many strings will always be present (if,
static, define, const, char, include, int, void, while, continue,
etc).  Do you have any tools to identify the top 500 strings in C
code? The fixed dictionary would get hardcoded into the git apps.

A fixed dictionary could conceivably take 5-10% off the size of each entry.

> However whenever possible deltas get used between objects.
> This allows an object to copy content from another object, with
> copy commands typically taking just a couple of bytes to copy a
> whole range of bytes from the other object.  This works pretty
> well when the current revision of a file is stored with just zlib
> compression and older revisions copy their content from the current
> revision using the delta format.
>
> I should note that delta compression works on trees, commits and
> tags too, however it gets the most benefit out of trees when only
> a fraction of the files in the tree are modified.  Commits and tags
> are harder to delta as they tend to be mostly different.
>
> My fast-import computes deltas in the order you are feeding
> it objects, so each blob is deltafied against the prior object.
> Since you are feeding them in reverse RCS order (newest to oldest)
> you are probably getting a reasonably good delta compression.
>
> --
> Shawn.
>


-- 
Jon Smirl
jonsmirl@gmail.com
