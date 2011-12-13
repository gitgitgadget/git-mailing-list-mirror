From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Tue, 13 Dec 2011 23:13:06 +0100
Message-ID: <4EE7CDF2.3040408@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu> <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu> <7v7h21xps9.fsf@alter.siamese.dyndns.org> <4EE6E61F.8080405@alum.mit.edu> <7vk461vuy9.fsf@alter.siamese.dyndns.org> <4EE7A387.3070400@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Tue Dec 13 23:13:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaabJ-0005Cl-1h
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 23:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab1LMWNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 17:13:24 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:55809 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895Ab1LMWNY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 17:13:24 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBDMD6Uu017106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 13 Dec 2011 23:13:06 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <4EE7A387.3070400@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187067>

On 12/13/2011 08:12 PM, Michael Haggerty wrote:
> On 12/13/2011 07:37 AM, Junio C Hamano wrote:
>> Another possibility is to keep the extra_ref interface in refs.c, without
>> any of your changes (i.e. keep it just as a flat list, with the original
>> interface to append to it without any dedup and other fancy features) and
>> also keep the special casing of it in for_each_ref(). AFAIK, that is the
>> only iterator that should care about the extra refs. Thinking about it a
>> bit more, removal of add_extra_ref() API may be unnecessarily complex with
>> no real gain. For example, extra refs added in builtin/clone.c is used by
>> builtin/fetch-pack.c, meaning that the codepath that discovers and
>> remembers these extra history anchor points and the codepath that uses
>> them while walking the history are not localized and we would need some
>> sort of "extra ref API" anyway. I am leaning towards this option.
> 
> In a few minutes I will post a series of patches that store extra_refs
> in a linked list separate from the reference caches, and iterates over
> them only from for_each_ref().  I could rebase my ref-api-D changes on
> top of this patch series in such a way that the extra refs are kept in
> non-hierarchical storage.  But I leave for vacation on Thursday so it is
> quite likely that I won't be able to get it finished before I return in
> the new year.

I forgot to mention that I think it would be better to separate the
handling of extra refs even more than do the patches

    [PATCH 0/6] Handle extra_refs separately from ref_caches

Namely, we should figure out what code wants to set extra refs and or
wants to include extra refs in its iteration over references.  The
setters don't have to be changed, but the readers should be.  After the
above patch series, the readers call for_each_ref(), which always calls
do_for_each_extra_ref().  The call to do_for_each_extra_ref() should be
taken out of for_each_ref() and called directly by any readers who want
to support extra_refs.  Other readers should only call for_each_ref().
(do_for_each_extra_ref(), probably under a different name, would have to
become public.)  That way, for_each_ref() could ignore the extra refs
entirely, and other callers of for_each_ref() wouldn't risk getting
extra refs by accident.

Today I spent some time trying to figure out what callers of
for_each_ref() could possible want to deal with extra refs, but I got
lost in the deep call trees and undocumented function declarations.  At
the top it is pretty clear that all such code paths start in cmd_clone()
or cmd_receive_pack().  But there are so many calls to the
for_each_ref*() family of functions that I wasn't able to determine
exactly which should allow for extra refs and which shouldn't.  (I even
wonder whether extra refs might be used inadvertently in some places
where they aren't wanted, for example in one of the myriad calls to
setup_revisions().)  If somebody could put his finger on the
for_each_ref() callers who want to support extra refs, that would be
very helpful.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
