From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Project idea: strbuf allocation modes
Date: Tue, 22 Apr 2014 09:07:16 +0200
Message-ID: <vpqr44psuzf.fsf@anie.imag.fr>
References: <vpqr457omgs.fsf@anie.imag.fr> <53512DB6.1070600@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 22 09:10:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcUqD-0005At-5x
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 09:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462AbaDVHJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 03:09:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44892 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbaDVHHY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 03:07:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s3M77FDv027162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Apr 2014 09:07:15 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3M77GKM000428;
	Tue, 22 Apr 2014 09:07:16 +0200
In-Reply-To: <53512DB6.1070600@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 18 Apr 2014 15:50:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 22 Apr 2014 09:07:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3M77FDv027162
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1398755237.69901@6HQRZYGi3zKSvwSR9MlcCQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246707>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>     STRBUF_OWNS_MEMORY
>
>         The memory pointed to by buf is owned by this strbuf.  If this
>         bit is not set, then the memory should never be freed, and
>         (among other things) strbuf_detach() must always call xstrcpy().

I just foresee a small difficulty from the caller side:

            char path_buf[PATH_MAX];
            char *detached;

            struct strbuf path;

            strbuf_wrap_preallocated(&path, path_buf, 0, sizeof(path));
            ...
            detached = strbuf_detach(&path);

the wrapping/unwrapping of path_buf magically turned a stack-allocated
buffer into a heap-allocated one. And the initial goal of avoiding
malloc() is defeated. So, essentially, one should avoir using
strbuf_wrap_preallocated with strbuf_detach, right? But I agree with
Junio that if the API is properly used, everything should work. I'm just
worried that we will add a bit more complexity to the API, and I'm not
sure we can actually expect noticeable improvements in terms of
performance (i.e. do we actually use strbuf for performance-critical
stuff?).

In your proposal, would STRBUF_OWNS_MEMORY be a constant, or a flag that
change when the internal buffer needs reallocation? My understanding is
that it should change (if STRBUF_FIXED_MEMORY is not set), and the
strbuf wrapping a preallocated buffer would become a "normal" strbuf
when its internal buffer grows.

If so, your "strbuf_detach() must always call xstrcpy()" is to be
understood as "if STRBUF_OWNS_MEMORY is still set when strbuf_detach()
is called, then it must always call xstrcpy()", right?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
