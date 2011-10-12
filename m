From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 2/7] invalidate_ref_cache(): take the submodule as
 parameter
Date: Thu, 13 Oct 2011 00:07:13 +0200
Message-ID: <4E960F91.5020103@alum.mit.edu>
References: <7vty7ggzum.fsf@alter.siamese.dyndns.org> <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu> <1318445067-19279-3-git-send-email-mhagger@alum.mit.edu> <7vwrca81c7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 00:07:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE6xe-0005gQ-1r
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 00:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab1JLWHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 18:07:32 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:52202 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab1JLWHb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 18:07:31 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9CM7E5i004206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Oct 2011 00:07:14 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vwrca81c7.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183422>

On 10/12/2011 09:19 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Instead of invalidating the ref cache on an all-or-nothing basis,
>> allow the cache for individual submodules to be invalidated.
> 
> That "allow" does not seem to describe what this patch does. It disallows
> the wholesale invalidation and forces the caller to invalidate ref cache
> individually.
> 
> Probably that is what all the existing callers want, but I would have
> expected that an existing feature would be kept, perhaps like this
> instead:
> 
> 	if (!submodule) {
> 		struct ref_cache *c;
>                 for (c = ref_cache; c; c = c->next)
>                 	clear_ref_cache(c);
> 	} else {
> 		clear_ref_cache(get_ref_cache(submodule);
> 	}
> 
> Not a major "vetoing" objection, just a comment.

Indeed, it is currently not possible for code outside of refs.c to
implement "forget everything" using the "forget one" function (because
there is no API for getting the list of caches that are currently in
memory).

A "forget everything" function might be useful for code that delegates
to a subprocess, if it does not know what submodules the subprocess has
tinkered with.  Heiko, does that apply to the future submodule code?

Your specific suggestion would not work because currently
submodule==NULL signifies the main module.  However, it would be easy to
add the few-line function when/if it is needed.


I guess the bigger issue for me is whether the whole submodule cache
thing is going to continue to be needed.  I really am too ignorant of
how submodules work to be able to judge.  From Heiko's recent email it
sounds like things might be moving in the direction of "top-level git
doesn't need to know much about submodules because it delegates to
subprocesses".  He also said that submodule references are not modified
by the top-level git process, meaning that it might be sensible for the
submodule reference cache to be less capable than the main module
reference cache.

But if things move in the other direction (submodules handled by the
top-level git process), let alone if git is libified, then it seems
inevitable that there will someday be a "submodule" object that keeps
track of its own ref cache, with the submodule objects rather than the
submodule reference caches looked up by submodule name.

Given that I'm still very new to the codebase, I'm mostly making
"peephole changes" and so I'm happy to get your feedback about how this
fits into the grand scheme of things.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
