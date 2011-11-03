From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 2/7] invalidate_ref_cache(): take the submodule as
 parameter
Date: Thu, 03 Nov 2011 11:23:28 +0100
Message-ID: <4EB26BA0.9030609@alum.mit.edu>
References: <7vty7ggzum.fsf@alter.siamese.dyndns.org> <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu> <1318445067-19279-3-git-send-email-mhagger@alum.mit.edu> <7vwrca81c7.fsf@alter.siamese.dyndns.org> <4E960F91.5020103@alum.mit.edu> <7vmxczmrb0.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Thu Nov 03 11:23:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLuSj-000401-Sg
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 11:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021Ab1KCKXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 06:23:52 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40470 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1KCKXw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 06:23:52 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pA3ANSJS027784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 3 Nov 2011 11:23:29 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vmxczmrb0.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184712>

On 10/17/2011 08:00 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> On 10/12/2011 09:19 PM, Junio C Hamano wrote:
>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>>  ...
>>> Probably that is what all the existing callers want, but I would have
>>> expected that an existing feature would be kept, perhaps like this
>>> instead:
>>>
>>> 	if (!submodule) {
>>> 		struct ref_cache *c;
>>>                 for (c = ref_cache; c; c = c->next)
>>>                 	clear_ref_cache(c);
>>> 	} else {
>>> 		clear_ref_cache(get_ref_cache(submodule);
>>> 	}
>> ...
>> Your specific suggestion would not work because currently
>> submodule==NULL signifies the main module.  However, it would be easy to
>> add the few-line function when/if it is needed.
> 
> I think "submodule==NULL" is probably a mistake; "" would make more sense
> given that you are storing the string in name[FLEX_ARRAY] field.

Sorry I didn't respond to this earlier.

The public API convention (which predates my changes) is that "char
*submodule" arguments either point at the relative path to the submodule
or are NULL to denote the main module.  But since these are stored
internally in a name[FLEX_ARRAY] field, I have been using "" internally
to denote the main module.  I believe that everything is done correctly,
but I admit that the use of different conventions internally and
externally is a potential source of programming errors.

If this is viewed as something that needs changing, the easiest thing
would probably be to add a "const char *submodule" in the ref_cache data
structure that either contains NULL or points at the name field, and to
consistently use the convention that the main module must always be
denoted by NULL.  The space overhead would be negligible because the
number of ref_cache objects is limited to the number of submodules plus 1.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
