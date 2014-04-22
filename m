From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Project idea: strbuf allocation modes
Date: Tue, 22 Apr 2014 11:09:20 +0200
Message-ID: <535631C0.2020100@alum.mit.edu>
References: <vpqr457omgs.fsf@anie.imag.fr> <53512DB6.1070600@alum.mit.edu> <vpqr44psuzf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 22 11:10:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcWhp-0000Tb-88
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 11:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbaDVJJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 05:09:27 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:65410 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753024AbaDVJJX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2014 05:09:23 -0400
X-AuditID: 1207440d-f79d86d0000043db-80-535631c224db
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 4B.10.17371.2C136535; Tue, 22 Apr 2014 05:09:22 -0400 (EDT)
Received: from [192.168.69.130] (p4FC975D0.dip0.t-ipconnect.de [79.201.117.208])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3M99K6j008337
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 22 Apr 2014 05:09:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <vpqr44psuzf.fsf@anie.imag.fr>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqHvIMCzYYMNvfouuK91MFpc+r2d1
	YPKY+OU4q8fnTXIBTFHcNkmJJWXBmel5+nYJ3Bk/39UUrBavmHk7tYHxn2AXIweHhICJxJVL
	YV2MnECmmMSFe+vZuhi5OIQELjNKnH37kR3CucAkcbd3AStIFa+AtsSup9+YQWwWAVWJ9/dW
	MIHYbAK6Eot6mplAhooKBEn8OasIUS4ocXLmExaQsIiAvsTPyWwgYWYBWYmZ55+wg4SFBYwk
	5p70AwkLCWRKnD29AKyEE2jRi0d3mCCuFJfoaQyC6NSReNf3gBnClpfY/nYO8wRGwVlIds1C
	UjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpGermZJXqpKaWbGCFBy7uD8f86mUOM
	AhyMSjy8kgahwUKsiWXFlbmHGCU5mJREeZ0NwoKF+JLyUyozEosz4otKc1KLDzFKcDArifCy
	6gLleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvBNAhgoWpaanVqRl
	5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDoja+GBi3ICkeoL1BIO28xQWJuUBRiNZTjLocFxpW
	tDAJseTl56VKifMKgRQJgBRllObBrYClqFeM4kAfC/PmgFTxANMb3KRXQEuYgJY82RICsqQk
	ESEl1cDYazBFjCNOeOH3fzqml46kSy65PP3MM46o3s/3bq1rynwwrdTs7qWle6KOau1bcL4/
	1HXyvzWT3vVrxt/r+tDP77Px2raO4mhuBSO2L1csDr1pVZkb82eiesd683n3F+fP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246720>

On 04/22/2014 09:07 AM, Matthieu Moy wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>     STRBUF_OWNS_MEMORY
>>
>>         The memory pointed to by buf is owned by this strbuf.  If this
>>         bit is not set, then the memory should never be freed, and
>>         (among other things) strbuf_detach() must always call xstrcpy().
> 
> I just foresee a small difficulty from the caller side:
> 
>             char path_buf[PATH_MAX];
>             char *detached;
> 
>             struct strbuf path;
> 
>             strbuf_wrap_preallocated(&path, path_buf, 0, sizeof(path));
>             ...
>             detached = strbuf_detach(&path);
> 
> the wrapping/unwrapping of path_buf magically turned a stack-allocated
> buffer into a heap-allocated one. And the initial goal of avoiding
> malloc() is defeated. So, essentially, one should avoir using
> strbuf_wrap_preallocated with strbuf_detach, right?

Correct; it wouldn't bring any performance advantages.  But
strbuf_detach() should be implemented for such strbufs for completeness
so that after the strbuf is instantiated, users don't have to know its
allocation mode.

>                                                      But I agree with
> Junio that if the API is properly used, everything should work. I'm just
> worried that we will add a bit more complexity to the API, and I'm not
> sure we can actually expect noticeable improvements in terms of
> performance (i.e. do we actually use strbuf for performance-critical
> stuff?).

The whole point of the change is to *allow* strbuf to be used in
performance-critical stuff.

> In your proposal, would STRBUF_OWNS_MEMORY be a constant, or a flag that
> change when the internal buffer needs reallocation? My understanding is
> that it should change (if STRBUF_FIXED_MEMORY is not set), and the
> strbuf wrapping a preallocated buffer would become a "normal" strbuf
> when its internal buffer grows.

Correct.  STRBUF_OWNS_MEMORY itself is of course a constant like 0x02 (a
mask to set/clear a bit in the flags) but the corresponding flags bit
would sometimes be changed internal to the strbuf implementation.  For
example, if the buffer is grown past its original size (when
STRBUF_FIXED_MEMORY is not set) the bit would be set.

After strbuf_detach(), there would be no automatic way to re-attach such
a strbuf to its original heap-allocated memory.  So in this situation
the buffer would have to be pointed at strbuf_slopbuf again, and the
STRBUF_OWNS_MEMORY bit would be cleared again.

> If so, your "strbuf_detach() must always call xstrcpy()" is to be
> understood as "if STRBUF_OWNS_MEMORY is still set when strbuf_detach()
> is called, then it must always call xstrcpy()", right?

Exactly.


How does the size of this project compare to what you are looking for
for your Ensimag students?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
