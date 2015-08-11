From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/17] add_to_alternates_file: don't add duplicate entries
Date: Tue, 11 Aug 2015 06:00:20 +0200
Message-ID: <55C97354.7080008@alum.mit.edu>
References: <20150810092731.GA9027@sigill.intra.peff.net> <20150810093446.GD30981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jim Hill <gjthill@gmail.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 06:01:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP0kJ-00080s-Hg
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 06:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbbHKEAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 00:00:46 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:45843 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751359AbbHKEAi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2015 00:00:38 -0400
X-AuditID: 1207440e-f79516d0000012b3-09-55c9735644ab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 3A.16.04787.65379C55; Tue, 11 Aug 2015 00:00:22 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0155.dip0.t-ipconnect.de [93.219.1.85])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7B40Lmo009293
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 11 Aug 2015 00:00:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <20150810093446.GD30981@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqBtWfDLUYMkKC4uuK91MFnOXfGa2
	+NHSw+zA7LFz1l12j2e9exg9Pm+SC2CO4rZJSiwpC85Mz9O3S+DOePT6JEvBRK6KrZ8+sDQw
	PmXvYuTgkBAwkVi83LCLkRPIFJO4cG89WxcjF4eQwGVGiZ3vLzNCOGeZJOb96mEGqeIV0JZY
	1dXECmKzCKhKnD3/CcxmE9CVWNTTzAQyVFQgSOL1y1yIckGJkzOfsIDYIgJGEjc+fGMDKWEW
	UJDYdN4XJCws4Cdx7NEysOlCAhkSm5p+gE3kFLCWuP7oKzuIzSygLvFn3iVmCFteYvvbOcwT
	GAVmIdkwC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbopaaUbmKEBC7f
	Dsb29TKHGAU4GJV4eAU8T4YKsSaWFVfmHmKU5GBSEuXlKAAK8SXlp1RmJBZnxBeV5qQWH2KU
	4GBWEuF95QSU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CyWpwcAjMODd3OpMU
	S15+XqqSBO+RQqAhgkWp6akVaZk5JQilTBycIIu4pESKU/NSUosSS0sy4kHRG18MjF+QFA/Q
	DU0g7bzFBYm5QFGI1lOMilLivOtAEgIgiYzSPLixsDT1ilEc6GNh3mMgVTzAFAfX/QpoMBPQ
	YLvAEyCDSxIRUlINjDwRHgHXfi1+wt/q2d/BY9PGpSG6NqB0s4RMt73N2TLz2hN71ppt91m0
	12+e3wQxzvlL255cuHXxpEfXeoOmtSdCDYrCJWM3BM/+xfNFt7fbc/fOPX3HjPyP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275671>

On 08/10/2015 11:34 AM, Jeff King wrote:
> The add_to_alternates_file function blindly uses
> hold_lock_file_for_append to copy the existing contents, and
> then adds the new line to it. This has two minor problems:
> 
>   1. We might add duplicate entries, which are ugly and
>      inefficient.
> 
>   2. We do not check that the file ends with a newline, in
>      which case we would bogusly append to the final line.
>      This is quite unlikely in practice, though, as we call
>      this function only from git-clone, so presumably we are
>      the only writers of the file (and we always add a
>      newline).
> 
> Instead of using hold_lock_file_for_append, let's copy the
> file line by line, which ensures all records are properly
> terminated. If we see an extra line, we can simply abort the
> update (there is no point in even copying the rest, as we
> know that it would be identical to the original).

Do we have reason to expect that a lot of people have alternates files
that already contain duplicate lines? You say that this function is only
called from `git clone`, so I guess the answer is "no".

But if I'm wrong, it might be friendly to de-dup the existing lines
while copying them.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
