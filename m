From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 03/16] object_array: factor out slopbuf-freeing logic
Date: Wed, 08 Oct 2014 10:40:03 +0200
Message-ID: <5434F863.5080303@alum.mit.edu>
References: <20141003202045.GA15205@peff.net> <20141003202222.GC16293@peff.net> <5433CDC2.6000908@alum.mit.edu> <20141008073658.GC25250@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 08 10:40:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbmnO-0000yw-3Y
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 10:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbaJHIkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 04:40:23 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57329 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750737AbaJHIkT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Oct 2014 04:40:19 -0400
X-AuditID: 12074413-f79ed6d000002501-82-5434f865db83
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.E4.09473.568F4345; Wed,  8 Oct 2014 04:40:05 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1C78.dip0.t-ipconnect.de [93.219.28.120])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s988e49I029961
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 8 Oct 2014 04:40:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20141008073658.GC25250@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1E39YRJi8PWupUXXlW4mix8tPcwO
	TB7PevcwenzeJBfAFMVtk5RYUhacmZ6nb5fAnfFm10Omggbhijs9F9gaGA/zdzFyckgImEj0
	N39lhLDFJC7cW8/WxcjFISRwmVHi1K9jzCAJIYFzTBLzDxWC2LwC2hJnXzeygtgsAqoSb+81
	s4PYbAK6Eot6mplAbFGBAIkPnQ8YIeoFJU7OfMICYosIyEp8P7wRKM7BwSwgLtH/jwXEFBbw
	lDgwyQJi7URGif0N+8DGcwroScx984oNxGYWUJf4M+8SM4QtL9G8dTbzBEaBWUg2zEJSNgtJ
	2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuuZ6uZkleqkppZsYIWEqvINx10m5Q4wCHIxK
	PLwGzSYhQqyJZcWVuYcYJTmYlER5o74DhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwSp4AyvGm
	JFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHiLQIYKFqWmp1akZeaUIKSZ
	ODhBhnNJiRSn5qWkFiWWlmTEg+I0vhgYqSApHqC9DCDtvMUFiblAUYjWU4yKUuK8oiAJAZBE
	Rmke3FhY8nnFKA70pTBvK0gVDzBxwXW/AhrMBDR4Vb8xyOCSRISUVANjaiaH2berv3vXr2Dx
	Y7nw8UTmn878tXtNRJWuT1xYfH9JptPWVb1LYw+Y3N+y5ggTE1v5XpP1+iu/f7zgYlg0R3HB
	wv2JLj37Xh07XBce+EVL+kZ0A/N9s2TBnn1W7KW7z4R6Xv+vduLyJpFCiVmT9Odn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/2014 09:36 AM, Jeff King wrote:
> On Tue, Oct 07, 2014 at 01:25:54PM +0200, Michael Haggerty wrote:
> 
>>> +static void object_array_release_entry(struct object_array_entry *ent)
>>> +{
>>> +	if (ent->name != object_array_slopbuf)
>>> +		free(ent->name);
>>> +}
>>> +
>>
>> Would it be a little safer to set ent->name to NULL or to
>> object_array_slopbuf after freeing the memory, to prevent accidents?
> 
> I considered that, but what about the other parts of object_array_entry?
> Should we NULL the object context pointers, too?
> 
> The intent of this function is freeing memory, not clearing it for sane
> reuse.  I think I'd be more in favor of a comment clarifying that. It is
> a static function used only internally by the object-array code.

I guess the name reminded me of strbuf_release(), which returns the
strbuf to its newly-initialized state (contrary to what api-strbuf.txt
says, I just noticed). You're right that your function does no such
thing, so it is self-consistent for it not to set ent->name to NULL.

But maybe its name could be chosen better? Let's see if there is a
consensus naming policy for functions that free resources. I grepped for
short functions calling free() and visually inspected a bunch of them.

Functions *_release():

* strbuf_release(), range_set_release(), and diff_ranges_release()
completely reinitialize their arguments

* window_release() appears not to


Functions *_clear() and clear_*():

* All *_clear() functions that I looked at (e.g., argv_array_clear(),
clear_image(), credential_clear(), clear_exclude_list(),
signature_check_clear(), and clear_prio_queue()) completely reinitialize
their arguments


Functions *_free() and free_*():

* Almost all of these free their arguments plus anything that their
arguments point at.

* Confusingly, free_ref_list() and free_pathspec() don't free their
arguments, but rather only the things that their arguments points at.
(Perhaps they should be renamed.)


So while three out of four *_release() functions completely reinitialize
their arguments, there is one that doesn't. And I couldn't find enough
other functions that just free referenced memory without reinitializing
their whole argument to establish a naming pattern. So I guess your
function name is OK too.

So forget I said anything :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
