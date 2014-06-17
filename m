From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH 1/5] hashmap: add enum for hashmap free_entries option
Date: Tue, 17 Jun 2014 21:04:25 +0200
Message-ID: <20140617190425.GB2982@sandbox-ub>
References: <20140605060425.GA23874@sandbox-ub>
 <20140605060640.GB23874@sandbox-ub>
 <5391FFC3.5010001@gmail.com>
 <20140610101744.GA23370@t2784.greatnet.de>
 <53981D6A.3090604@gmail.com>
 <xmqqegyu54cl.fsf@gitster.dls.corp.google.com>
 <539FFCAB.4060908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 21:05:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwyhH-0002b8-D4
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 21:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933329AbaFQTF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 15:05:27 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:34080 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbaFQTF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 15:05:26 -0400
Received: from [77.21.74.130] (helo=sandbox-ub)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WwygF-0008LS-Ot; Tue, 17 Jun 2014 21:04:28 +0200
Content-Disposition: inline
In-Reply-To: <539FFCAB.4060908@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251936>

On Tue, Jun 17, 2014 at 10:30:35AM +0200, Karsten Blees wrote:
> Am 12.06.2014 21:12, schrieb Junio C Hamano:
> > Karsten Blees <karsten.blees@gmail.com> writes:
> > 
> >> Am 10.06.2014 12:17, schrieb Heiko Voigt:
> >>> The intention of Jonathans critique here[1] was that you do not see what
> >>> this parameter does on the callsite. I.e.:
> >>>
> >>> 	hashmap_free(&map, 1);
> >>>
> >>> compared to
> >>>
> >>> 	hashmap_free(&map, HASHMAP_FREE_ENTRIES);
> >>>
> >>> A boolean basically transfers the same information and would not help
> >>> the reader here.
> >>>
> >>> Cheers Heiko
> >>>
> >>> [1] http://article.gmane.org/gmane.comp.version-control.git/243917
> >>>
> >>
> >> There are languages where you can have e.g. 'hashmap_free(...,
> >> free_entries: true)'. In C, however, you do not see what a
> >> parameter does at the call site. This is a general language
> >> feature, reducing redundancy and keeping it short and concise. IMO
> >> there's no reason to treat boolean parameters differently.
> > 
> > But given that you are writing in C, is any of that relevant?  We do
> > want to keep our call-sites readable and understandable, 
> 
> But in C, readable and understandable are opposite goals.
> 'Understandable' entails long, redundant identifiers, automatically
> decreasing readability. The compiler doesn't care about either, so
> we could just as well keep the C part short and use plain English
> for understandability:
> 
>   /* free maps, except file entries (owned by istate->cache) */
>   hashmap_free(&istate->name_hash, 0);
>   hashmap_free(&istate->dir_hash, 1);
> 
> Note that this not only explains what we're doing, but also why.
> 
> > and 1 or
> > true would not help, unless (1) you are the one who wrote the
> > function and know that 1 means free the entries, or (2) the API is
> > so widely used and everybody knows what 1 means free the entries.
> > 
> 
> or (3) you need to check the function declaration or documentation
> anyway, to understand what the non-boolean parameters do.
> 
> E.g. consider this (from remote.c:1186):
> 
>   dst_value = resolve_ref_unsafe(matched_src->name, sha1, 1, &flag);
> 
> vs.
> 
>   dst_value = resolve_ref_unsafe(matched_src->name, sha1,
>                                  RESOLVE_REF_UNSAFE_FOR_READING,
>                                  &flag);
> 
> That's three lines vs. one, "RESOLVE_REF_UNSAFE_" is completely
> redundant with the function name, "FOR_READING" isn't particularly
> enlightening either, and you still don't know what the other three
> parameters do. IMO this would be much better:
> 
>   /* fully resolve matched symref to resolved ref name and sha1 */
>   dst_value = resolve_ref_unsafe(matched_src->name, sha1, 1, &flag);
> 
> So veterans highly familiar with the code can stick to the C part
> without being distracted by unnecessary line breaks and
> SHOUTED_IDENTIFIERS, while everyone else may find the explanation
> helpful.
> 
> 
> As I said, using enums for hashmap_free isn't a problem on its own.
> However, the accepted solution for booleans in the git code base
> seems to be to use just an int and 0/1.
> 
> For consistency, we could of course change string_list*,
> resolve_ref*, index_file_exists etc. as well.
> 
> ...and in turn 'extern int ignore_case' (because it gets passed to
> index_file_exists)?
> 
> ...and in turn all other boolean config variables?
> 
> I don't think this would be an improvement, though.

If this is such a controversial change for you I will drop this patch in
the next round. I think it would make the callsite more readable without
adding much clutter but I am fine with it either way.
