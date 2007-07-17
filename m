From: "Matt McCutchen" <hashproduct@gmail.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Tue, 17 Jul 2007 14:03:21 -0400
Message-ID: <3bbc18d20707171103q262eaa8amb319ca9f835dbf67@mail.gmail.com>
References: <1183053733.6108.0.camel@mattlaptop2>
	 <7vir8q4opc.fsf@assigned-by-dhcp.cox.net>
	 <3bbc18d20707111815i1de3cb35sadfa316ddee7f3f6@mail.gmail.com>
	 <200707121307.03612.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>, "Luben Tuikov" <ltuikov@yahoo.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 20:03:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IArOW-0002Rs-9X
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 20:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933593AbXGQSD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 14:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933632AbXGQSDZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 14:03:25 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:5123 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933593AbXGQSDW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 14:03:22 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1230400nze
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 11:03:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p6fcQZ4nTPK2mTCSreretJYYFe66/5H6Wj5ktYHQdfFIXILtOB/hnDeP9mhEDF0gQjDFbqUf3pJdmq6dr1S30WC/y34gNXnkSsj52ROKlaDBdm9Ytce+5pVpuIzlyqlX6aJVnDXGDBPCC5HaR6e/vkIHJECWRz7Vsbz6H8e/vD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IQn2R9YrJBWvdK5bzezvFaP5V8+BANwl0U6BlkLmZK0BW+kZsCmeiC6Ckaqnb3jAY2itFykE7DWurU1ycZ4B355ikxY+W56C/zmbVW+PNv36NDcsuuWkfXUB+uF3IxweAaJ/9QDRfyYH1GlWAj4dXWjWNpSgdyuqE+czERjC068=
Received: by 10.142.110.3 with SMTP id i3mr55412wfc.1184695401491;
        Tue, 17 Jul 2007 11:03:21 -0700 (PDT)
Received: by 10.143.30.9 with HTTP; Tue, 17 Jul 2007 11:03:21 -0700 (PDT)
In-Reply-To: <200707121307.03612.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52785>

On 7/12/07, Jakub Narebski <jnareb@gmail.com> wrote:
> > The advantage of '| gzip' is that the lack of a compressor is
> > not a special case.  This is why I wrote %known_snapshot_formats the
> > way I did, but of course you all are welcome to overrule me.
>
> I wrote about this because I'm thinking about replacing the few
> pipelines we use in gitweb[*1*], including the snapshot one, with
> the list form, which has the advantage of avoiding spawning the shell
> (performance) and not dealing with shell quoting of arguments (security
> and errors), like we did for simple calling of git commands to read
> from in the commit b9182987a80f7e820cbe1f8c7c4dc26f8586e8cd
>   "gitweb: Use list for of open for running git commands, thorougly"
>
> Thus I'd rather have list of extra commands and arguments instead of
> pipe as a string, i.e. 'gzip' instead of '| gzip', and 'gzip', '-9'
> instead of '| gzip -9'.
>
> [*1*] We currently use pipelines for snapshots which need external
> compressor, like tgz and tbz2, and for pickaxe search.

OK, I changed the extra commands to list form.  The field is now a
reference to the compressor argv like ['gzip'] or undef if there is no
compressor.

> I also prefer the second option, perhaps as simple as 'gzip' => 'tbz'
> and 'bzip2' => 'tbz2', and of course accompaning code to deal with this.
>
> As to "display name" column: I'm not sure if for example 'tar.gz'
> instead of 'tgz' would be not easier to understand.

I went ahead and added both aliases and display names (currently
'tar.gz', 'tar.bz2', and 'zip').  Aliases are resolved in
&feature_snapshot for repository configuration but not for side-wide
configuration because then aliases in side-wide configuration would be
resolved only if override is on, which would be weird.  For the same
reason, I changed the filtering out of unknown formats in
&feature_snapshot to apply only to repository configuration.

> > It would be possible to make the gitweb site configuration
> > backward-compatible too; here's one possible approach.  On startup,
> > gitweb would check whether $feature{'snapshot'}{'default'} is a
> > three-element list that appears to be in the old format.  If so, it
> > would save the settings in $known_snapshot_formats{'default'} and then
> > set $feature{'snapshot'}{'default'} = 'default' .  This is a hack; is
> > it justified by the compatibility benefit?
>
> If you implement 'gzip' and 'bzip2' as aliases, it could be as simple
> as just taking last non-false element of array if the array has more
> than one element.

No, because it must be possible for the site default to consist of
multiple formats.  It would be possible to take all elements that are
recognized as snapshot formats and ignore the others, but I would like
to be able to distinguish between "formats" that are part of a legacy
specification and completely bogus formats so that we can issue a
warning or error for the latter.

> But I'm not sure if it is worth it.

At this point I am leaning against backward compatibility for the site
configuration, and if I do implement it, I would just recognize the
three exact specifications that currently appear in feature_snapshot.
Recognizing other legacy specifications is iffy in the first place,
and handling them would require the hack I described.

I will send the revised patch soon.

Matt
