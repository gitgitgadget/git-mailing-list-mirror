From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: Remove backward goto in read_craft_line()
Date: Wed, 1 Dec 2010 14:31:32 -0600
Message-ID: <20101201203132.GB27845@burratino>
References: <1291230959-3894-1-git-send-email-ralf.thielow@googlemail.com>
 <20101201194441.GB27347@burratino>
 <7vaakputxs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 21:32:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNtLI-0000uN-IZ
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756978Ab0LAUbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:31:42 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61216 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756972Ab0LAUbl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:31:41 -0500
Received: by vws16 with SMTP id 16so652894vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 12:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NjVj/xDHxMiany0jeqnWBgt/C3OgtoP/GKV+Qj3wB+I=;
        b=gjUcvNVqS6gmp7G2JFuDqBlBEr5q3nJsZmxV8AfIte6DxbzrV3q2DFnkYfdRAzbh9F
         dDecCnnB5hIK/0ArCuSI0zf3hu/TFIvF+H5eu3aB5ouGWDlhhtubzckS+Cf38HX+JyMq
         1iATHzI3ipH5x0hfKf4IvFcqdJ6LdWzzGVGbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JFcpI7htSHviFAP2lgM8U7Otb2JS40mQmt+6M6pnRo9cg3QigdYxHDsqQwvx2hPybE
         anWPJOeknrNGCmEpyri8KZ8D85F8tBE6sWLcj0B2mQXPt3wpFF44rwQqhFiffiGetAUD
         vaXRFuEosKOImcE1gFiT0cL4J7V8aIJK0ySAM=
Received: by 10.220.190.130 with SMTP id di2mr791920vcb.234.1291235500248;
        Wed, 01 Dec 2010 12:31:40 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id u6sm168652vby.17.2010.12.01.12.31.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 12:31:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vaakputxs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162605>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> A space before the "bad_graft_data:" label would improve future
>> diff --show-c-function output.
>
> Hmm, I actually do not think we encourage that (nor we should).
> 
>     $ git grep -e '^ [a-z0-9]*:' -- '*.c' | wc -l
>     23
>     $ git grep -e '^[a-z0-9]*:' -- '*.c' | wc -l
>     42
> 
> If "--show-c-function" output is the problem, perhaps we should know a bit
> better about what C function header looks like?

Thanks for checking.  Yes, I think so.

	$ git grep --show-function strbuf_release -- http.c
	http.c=static int http_request(const char *url, void *result, int target, int options)
	http.c: strbuf_release(&buf);
	http.c=cleanup:
	http.c: strbuf_release(&tmpfile);
	http.c=int http_fetch_ref(const char *base, struct ref *ref)
	http.c: strbuf_release(&buffer);

The following gives me some joy.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/.gitattributes b/.gitattributes
index 5e98806..5888a53 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,3 +1,4 @@
 * whitespace=!indent,trail,space
 *.[ch] whitespace=indent,trail,space
+*.[ch] diff=cpp
 *.sh whitespace=indent,trail,space
