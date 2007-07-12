From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Thu, 12 Jul 2007 13:07:03 +0200
Message-ID: <200707121307.03612.jnareb@gmail.com>
References: <1183053733.6108.0.camel@mattlaptop2> <7vir8q4opc.fsf@assigned-by-dhcp.cox.net> <3bbc18d20707111815i1de3cb35sadfa316ddee7f3f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>, "Luben Tuikov" <ltuikov@yahoo.com>
To: "Matt McCutchen" <hashproduct@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 13:07:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8wVv-00085x-PQ
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 13:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761367AbXGLLHM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 07:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758970AbXGLLHL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 07:07:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:34647 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbXGLLHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 07:07:09 -0400
Received: by ug-out-1314.google.com with SMTP id j3so309993ugf
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 04:07:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cGjaxBktwsESGbSGTCbVp+MHRyIC9CAAiRaFefGoOAyZYdHQm6+xY5VpyNHnzaBFqw51hjACSBJ8O54LDuOH6om0hfaKpRuJhiXf3skwR2xyhJW+eSvv383nNipmObaGUght+U5IpATYfNrkr9hnIgKBsVQ/+muCtgONlah8wxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OXkieA+v8GAZjQV+/Mdtr4LhGi/uAG2lzAgj3leSVHjC7wFyYWSicgwHz/I8cqLwvPxshGxh9ZeUU1Jen4Yqu3gb84csudUxDew0hpBgy046Ic+tbtBNz+5+N6tb3lx+oK7pe9L071IXuZowD9oRVZSON6Ilrhk+hatJsjjGA9A=
Received: by 10.86.72.15 with SMTP id u15mr371041fga.1184238427906;
        Thu, 12 Jul 2007 04:07:07 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTP id f19sm12582fka.2007.07.12.04.07.05
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Jul 2007 04:07:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <3bbc18d20707111815i1de3cb35sadfa316ddee7f3f6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52267>

On Thu, 12 July 2007, Matt McCutchen wrote:
> On 7/11/07, Junio C Hamano <gitster@pobox.com> wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>> I'm not sure if we want to store whole 'application/x-gzip' or only
>>> 'x-gzip' part of mime type, and if we want to store compressor as
>>> '| gzip' or simply as 'gzip'.
> 
> Storing only 'x-gzip' assumes that all archive formats have MIME types
> beginning with 'application/'.  Even if this assumption is justified
> by the MIME specification, I felt it was inappropriate to code it into
> gitweb.  

Good argument. Besides, now we use it only in one place, but if we
would in the future use it in other place having full mimetype would
make it easier.

> The advantage of '| gzip' is that the lack of a compressor is 
> not a special case.  This is why I wrote %known_snapshot_formats the
> way I did, but of course you all are welcome to overrule me.

I wrote about this because I'm thinking about replacing the few 
pipelines we use in gitweb[*1*], including the snapshot one, with
the list form, which has the advantage of avoiding spawning the shell 
(performance) and not dealing with shell quoting of arguments (security 
and errors), like we did for simple calling of git commands to read 
from in the commit b9182987a80f7e820cbe1f8c7c4dc26f8586e8cd
  "gitweb: Use list for of open for running git commands, thorougly"

Thus I'd rather have list of extra commands and arguments instead of
pipe as a string, i.e. 'gzip' instead of '| gzip', and 'gzip', '-9'
instead of '| gzip -9'.

[*1*] We currently use pipelines for snapshots which need external 
compressor, like tgz and tbz2, and for pickaxe search.

>>> This would break not only existing _gitweb_ configuration (when
>>> gitweb admin installs new gitweb it isn't that hard to correct
>>> gitweb config), but also git _repositories_ config: gitweb.snapshot
>>> no longer work as it worked before, for example neither 'gzip'
>>> nor 'bzip2' values work anymore ('zip' doesn't stop working).
>>
>> I realized after seeing your other message on this patch that
>> this can be done while retaining backward compatibility, as you
>> suggested.  Matt, does Jakub's suggestion make sense to you?
> 
> It's not clear to me what the suggestion is: offer format names 'gzip'
> and 'bzip2' instead of 'tgz' and 'tbz2', or in addition to them, or
> what?  I prefer 'tgz' and 'tbz2' because they carry more information
> and are properly analogous to 'zip', so I don't want to offer 'gzip'
> and 'bzip2' instead of them.  Furthermore, I would like the user to
> see 'snapshot (tgz tbz2)' even if the repository owner wrote 'gzip
> bzip2', so just adding two rows to %known_snapshot_formats is
> insufficient.  Either an additional column could be added to
> %known_snapshot_formats for the display name, or 'gzip' and 'bzip2'
> could be specified as aliases in %known_snapshot_formats and
> feature_snapshot could be taught to resolve them.  I would prefer the
> second option; shall I implement it?

I also prefer the second option, perhaps as simple as 'gzip' => 'tbz'
and 'bzip2' => 'tbz2', and of course accompaning code to deal with this.

As to "display name" column: I'm not sure if for example 'tar.gz' 
instead of 'tgz' would be not easier to understand.

> It would be possible to make the gitweb site configuration
> backward-compatible too; here's one possible approach.  On startup,
> gitweb would check whether $feature{'snapshot'}{'default'} is a
> three-element list that appears to be in the old format.  If so, it
> would save the settings in $known_snapshot_formats{'default'} and then
> set $feature{'snapshot'}{'default'} = 'default' .  This is a hack; is
> it justified by the compatibility benefit?

If you implement 'gzip' and 'bzip2' as aliases, it could be as simple
as just taking last non-false element of array if the array has more
than one element. But I'm not sure if it is worth it.

But we should probably error out with some error message on 
incompatibile gitweb site configuration; I'm not sure...

-- 
Jakub Narebski
Poland
